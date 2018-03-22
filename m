Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeCVXIM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 19:08:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751734AbeCVXIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 19:08:09 -0400
Subject: Re: [PATCH v6 03/12] PKCS#7: Introduce pkcs7_get_digest()
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
Date: Thu, 22 Mar 2018 19:07:58 -0400
In-Reply-To: <20180316203837.10174-4-bauerman@linux.vnet.ibm.com>
References: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
         <20180316203837.10174-4-bauerman@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032223-0040-0000-0000-000004445D51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032223-0041-0000-0000-000020E787EA
Message-Id: <1521760078.3848.301.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-22_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803220258
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-16 at 17:38 -0300, Thiago Jung Bauermann wrote:
> IMA will need to access the digest of the PKCS7 message (as calculated by
> the kernel) before the signature is verified, so introduce
> pkcs7_get_digest() for that purpose.
> 
> Also, modify pkcs7_digest() to detect when the digest was already
> calculated so that it doesn't have to do redundant work. Verifying that
> sinfo->sig->digest isn't NULL is sufficient because both places which
> allocate sinfo->sig (pkcs7_parse_message() and pkcs7_note_signed_info())
> use kzalloc() so sig->digest is always initialized to zero.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>

Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

> ---
>  crypto/asymmetric_keys/pkcs7_verify.c | 25 +++++++++++++++++++++++++
>  include/crypto/pkcs7.h                |  3 +++
>  2 files changed, 28 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
> index 39e6de0c2761..bd02360f8be5 100644
> --- a/crypto/asymmetric_keys/pkcs7_verify.c
> +++ b/crypto/asymmetric_keys/pkcs7_verify.c
> @@ -33,6 +33,10 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
> 
>  	kenter(",%u,%s", sinfo->index, sinfo->sig->hash_algo);
> 
> +	/* The digest was calculated already. */
> +	if (sig->digest)
> +		return 0;
> +
>  	if (!sinfo->sig->hash_algo)
>  		return -ENOPKG;
> 
> @@ -122,6 +126,27 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
>  	return ret;
>  }
> 
> +int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf, u8 *len)
> +{
> +	struct pkcs7_signed_info *sinfo = pkcs7->signed_infos;
> +	int ret;
> +
> +	/*
> +	 * This function doesn't support messages with more than one signature.
> +	 */
> +	if (sinfo == NULL || sinfo->next != NULL)
> +		return -EBADMSG;
> +
> +	ret = pkcs7_digest(pkcs7, sinfo);
> +	if (ret)
> +		return ret;
> +
> +	*buf = sinfo->sig->digest;
> +	*len = sinfo->sig->digest_size;
> +
> +	return 0;
> +}
> +
>  /*
>   * Find the key (X.509 certificate) to use to verify a PKCS#7 message.  PKCS#7
>   * uses the issuer's name and the issuing certificate serial number for
> diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
> index 6f51d0cb6d12..cfaea9c37f4a 100644
> --- a/include/crypto/pkcs7.h
> +++ b/include/crypto/pkcs7.h
> @@ -46,4 +46,7 @@ extern int pkcs7_verify(struct pkcs7_message *pkcs7,
>  extern int pkcs7_supply_detached_data(struct pkcs7_message *pkcs7,
>  				      const void *data, size_t datalen);
> 
> +extern int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf,
> +			    u8 *len);
> +
>  #endif /* _CRYPTO_PKCS7_H */
> 
