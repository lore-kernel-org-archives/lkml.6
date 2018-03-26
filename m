Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCZM46 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 08:56:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33186 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751196AbeCZM4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 08:56:55 -0400
Subject: Re: [PATCH v6 11/12] ima: Implement support for module-style
 appended signatures
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Date: Mon, 26 Mar 2018 08:56:43 -0400
In-Reply-To: <20180316203837.10174-12-bauerman@linux.vnet.ibm.com>
References: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
         <20180316203837.10174-12-bauerman@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18032612-0040-0000-0000-00000445828C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032612-0041-0000-0000-000020E988EE
Message-Id: <1522069003.3541.64.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-26_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803260139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-16 at 17:38 -0300, Thiago Jung Bauermann wrote:
> This patch actually implements the appraise_type=imasig|modsig option,
> allowing IMA to read and verify modsig signatures.
> 
> In case both are present in the same file, IMA will first check whether the
> key used by the xattr signature is present in the kernel keyring. If not,
> it will try the appended signature.

Yes, this sounds right.

> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  security/integrity/ima/ima.h          | 11 +++++++-
>  security/integrity/ima/ima_appraise.c | 53 +++++++++++++++++++++++++++++++----
>  security/integrity/ima/ima_main.c     | 21 +++++++++++---
>  3 files changed, 74 insertions(+), 11 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 49aef56dc96d..c11ccb7c5bfb 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -157,7 +157,8 @@ void ima_init_template_list(void);
> 
>  static inline bool is_ima_sig(const struct evm_ima_xattr_data *xattr_value)
>  {
> -	return xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG;
> +	return xattr_value && (xattr_value->type == EVM_IMA_XATTR_DIGSIG ||
> +			       xattr_value->type == IMA_MODSIG);
>  }
> 
>  /*
> @@ -253,6 +254,8 @@ enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
>  					   enum ima_hooks func);
>  enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
>  				 int xattr_len);
> +bool ima_xattr_sig_known_key(const struct evm_ima_xattr_data *xattr_value,
> +			     int xattr_len);
>  int ima_read_xattr(struct dentry *dentry,
>  		   struct evm_ima_xattr_data **xattr_value);
> 
> @@ -291,6 +294,12 @@ ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value, int xattr_len)
>  	return ima_hash_algo;
>  }
> 
> +static inline bool ima_xattr_sig_known_key(const struct evm_ima_xattr_data
> +					   *xattr_value, int xattr_len)
> +{
> +	return false;
> +}
> +
>  static inline int ima_read_xattr(struct dentry *dentry,
>  				 struct evm_ima_xattr_data **xattr_value)
>  {
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 01172eab297b..84e0fd5a19c8 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -189,6 +189,22 @@ enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
>  	return ima_hash_algo;
>  }
> 
> +bool ima_xattr_sig_known_key(const struct evm_ima_xattr_data *xattr_value,
> +			     int xattr_len)
> +{
> +	struct key *keyring;
> +
> +	if (xattr_value->type != EVM_IMA_XATTR_DIGSIG)
> +		return false;
> +
> +	keyring = integrity_keyring_from_id(INTEGRITY_KEYRING_IMA);
> +	if (IS_ERR(keyring))
> +		return false;
> +
> +	return asymmetric_sig_has_known_key(keyring, (const char *) xattr_value,
> +					    xattr_len);
> +}
> +
>  int ima_read_xattr(struct dentry *dentry,
>  		   struct evm_ima_xattr_data **xattr_value)
>  {
> @@ -221,8 +237,12 @@ int ima_appraise_measurement(enum ima_hooks func,
>  	struct inode *inode = d_backing_inode(dentry);
>  	enum integrity_status status = INTEGRITY_UNKNOWN;
>  	int rc = xattr_len, hash_start = 0;
> +	size_t xattr_contents_len;
> +	void *xattr_contents;
> 
> -	if (!(inode->i_opflags & IOP_XATTR))
> +	/* If not appraising a modsig, we need an xattr. */
> +	if ((xattr_value == NULL || xattr_value->type != IMA_MODSIG) &&
> +	    !(inode->i_opflags & IOP_XATTR))
>  		return INTEGRITY_UNKNOWN;
> 
>  	if (rc <= 0) {
> @@ -241,13 +261,29 @@ int ima_appraise_measurement(enum ima_hooks func,
>  		goto out;
>  	}
> 
> -	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_value, rc, iint);
> +	/*
> +	 * If it's a modsig, we don't have the xattr contents to pass to
> +	 * evm_verifyxattr().
> +	 */
> +	if (xattr_value->type == IMA_MODSIG) {
> +		xattr_contents = NULL;
> +		xattr_contents_len = 0;
> +	} else {
> +		xattr_contents = xattr_value;
> +		xattr_contents_len = xattr_len;
> +	}
> +
> +	status = evm_verifyxattr(dentry, XATTR_NAME_IMA, xattr_contents,
> +				 xattr_contents_len, iint);
>  	switch (status) {
>  	case INTEGRITY_PASS:
>  	case INTEGRITY_PASS_IMMUTABLE:
>  	case INTEGRITY_UNKNOWN:
>  		break;
>  	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
> +		/* It's fine not to have xattrs when using a modsig. */
> +		if (xattr_value->type == IMA_MODSIG)
> +			break;
>  	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
>  		cause = "missing-HMAC";
>  		goto out;
> @@ -288,11 +324,16 @@ int ima_appraise_measurement(enum ima_hooks func,
>  		status = INTEGRITY_PASS;
>  		break;
>  	case EVM_IMA_XATTR_DIGSIG:
> +	case IMA_MODSIG:
>  		set_bit(IMA_DIGSIG, &iint->atomic_flags);
> -		rc = integrity_digsig_verify(INTEGRITY_KEYRING_IMA,
> -					     (const char *)xattr_value, rc,
> -					     iint->ima_hash->digest,
> -					     iint->ima_hash->length);
> +		if (xattr_value->type == EVM_IMA_XATTR_DIGSIG)
> +			rc = integrity_digsig_verify(INTEGRITY_KEYRING_IMA,
> +						     (const char *)xattr_value,
> +						     rc, iint->ima_hash->digest,
> +						     iint->ima_hash->length);
> +		else
> +			rc = ima_modsig_verify(INTEGRITY_KEYRING_IMA,
> +					       xattr_value);
>  		if (rc == -EOPNOTSUPP) {
>  			status = INTEGRITY_UNKNOWN;
>  		} else if (rc) {
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 5d122daf5c8a..1b11c10f09df 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -183,7 +183,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  	struct evm_ima_xattr_data *xattr_value = NULL;
>  	int xattr_len = 0;
>  	bool violation_check;
> -	enum hash_algo hash_algo;
> +	enum hash_algo hash_algo = HASH_ALGO__LAST;
> 
>  	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
>  		return 0;
> @@ -277,11 +277,24 @@ static int process_measurement(struct file *file, const struct cred *cred,
> 
>  	template_desc = ima_template_desc_current();
>  	if ((action & IMA_APPRAISE_SUBMASK) ||
> -		    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0)
> +	    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0) {
>  		/* read 'security.ima' */
>  		xattr_len = ima_read_xattr(file_dentry(file), &xattr_value);
> +		if (iint->flags & IMA_MODSIG_ALLOWED &&
> +		    (xattr_len <= 0 || !ima_xattr_sig_known_key(xattr_value,
> +								xattr_len))) {
> +			/*
> +			 * Even if we end up using a modsig, hash_algo should
> +			 * come from the xattr (or even the default hash algo).
> +			 */
> +			hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
> +			ima_read_modsig(func, buf, size, &xattr_value,
> +					&xattr_len);
> +		}
> +	}
> 
> -	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
> +	if (hash_algo == HASH_ALGO__LAST)
> +		hash_algo = ima_get_hash_algo(xattr_value, xattr_len);

Previous versions needed to calculate the file hash based on the
modsig hash algorithm.  With the introduction of the digest signature
template field ('d-sig'), the file digest field ('d-ng') is always
calculated based on either the xattr hash algorithm, if one exists, or
the IMA default hash algorithm.

Mimi

> 
>  	rc = ima_collect_measurement(iint, file, buf, size, hash_algo);
>  	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
> @@ -309,7 +322,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  	     !(iint->flags & IMA_NEW_FILE))
>  		rc = -EACCES;
>  	mutex_unlock(&iint->mutex);
> -	kfree(xattr_value);
> +	ima_free_xattr_data(xattr_value);
>  out:
>  	if (pathbuf)
>  		__putname(pathbuf);
> 
