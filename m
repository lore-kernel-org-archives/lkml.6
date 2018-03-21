Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754082AbeCUWrI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 18:47:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753691AbeCUWrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 18:47:01 -0400
Subject: Re: [PATCH v6 05/12] integrity: Introduce
 integrity_keyring_from_id()
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
Date: Wed, 21 Mar 2018 18:46:51 -0400
In-Reply-To: <20180316203837.10174-6-bauerman@linux.vnet.ibm.com>
References: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
         <20180316203837.10174-6-bauerman@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032122-0040-0000-0000-00000443ED90
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032122-0041-0000-0000-000020E7134C
Message-Id: <1521672411.3848.219.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-21_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803210259
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-16 at 17:38 -0300, Thiago Jung Bauermann wrote:
> IMA will need to obtain the keyring used to verify file signatures so that
> it can verify the module-style signature appended to files.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

> ---
>  security/integrity/digsig.c    | 28 +++++++++++++++++++++-------
>  security/integrity/integrity.h |  6 ++++++
>  2 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
> index 6f9e4ce568cd..e641a67b9fc7 100644
> --- a/security/integrity/digsig.c
> +++ b/security/integrity/digsig.c
> @@ -48,11 +48,10 @@ static bool init_keyring __initdata;
>  #define restrict_link_to_ima restrict_link_by_builtin_trusted
>  #endif
> 
> -int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
> -			    const char *digest, int digestlen)
> +struct key *integrity_keyring_from_id(const unsigned int id)
>  {
> -	if (id >= INTEGRITY_KEYRING_MAX || siglen < 2)
> -		return -EINVAL;
> +	if (id >= INTEGRITY_KEYRING_MAX)
> +		return ERR_PTR(-EINVAL);
> 
>  	if (!keyring[id]) {
>  		keyring[id] =
> @@ -61,17 +60,32 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
>  			int err = PTR_ERR(keyring[id]);
>  			pr_err("no %s keyring: %d\n", keyring_name[id], err);
>  			keyring[id] = NULL;
> -			return err;
> +			return ERR_PTR(err);
>  		}
>  	}
> 
> +	return keyring[id];
> +}
> +
> +int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
> +			    const char *digest, int digestlen)
> +{
> +	struct key *keyring;
> +
> +	if (siglen < 2)
> +		return -EINVAL;
> +
> +	keyring = integrity_keyring_from_id(id);
> +	if (IS_ERR(keyring))
> +		return PTR_ERR(keyring);
> +
>  	switch (sig[1]) {
>  	case 1:
>  		/* v1 API expect signature without xattr type */
> -		return digsig_verify(keyring[id], sig + 1, siglen - 1,
> +		return digsig_verify(keyring, sig + 1, siglen - 1,
>  				     digest, digestlen);
>  	case 2:
> -		return asymmetric_verify(keyring[id], sig, siglen,
> +		return asymmetric_verify(keyring, sig, siglen,
>  					 digest, digestlen);
>  	}
> 
> diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
> index 79799a0d9195..2d245f44ca26 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -150,6 +150,7 @@ int integrity_kernel_read(struct file *file, loff_t offset,
> 
>  #ifdef CONFIG_INTEGRITY_SIGNATURE
> 
> +struct key *integrity_keyring_from_id(const unsigned int id);
>  int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
>  			    const char *digest, int digestlen);
> 
> @@ -157,6 +158,11 @@ int __init integrity_init_keyring(const unsigned int id);
>  int __init integrity_load_x509(const unsigned int id, const char *path);
>  #else
> 
> +static inline struct key *integrity_keyring_from_id(const unsigned int id)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
>  static inline int integrity_digsig_verify(const unsigned int id,
>  					  const char *sig, int siglen,
>  					  const char *digest, int digestlen)
> 
