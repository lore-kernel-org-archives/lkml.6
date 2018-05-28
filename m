Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754993AbeE1Nyb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:54:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51822 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939261AbeE1NyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 09:54:10 -0400
Date: Mon, 28 May 2018 16:53:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Ivan Safonov <insafonov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Santha Meena Ramamoorthy <santhameena13@gmail.com>,
        Janani Sankara Babu <jananis37@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging:r8188eu: Use lib80211 to encrypt (WEP) tx frames
Message-ID: <20180528135351.5y66u4puldawfic5@mwanda>
References: <20180528061821.26948-1-insafonov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528061821.26948-1-insafonov@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8906 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805280168
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 09:18:21AM +0300, Ivan Safonov wrote:
> Put data to skb, decrypt with lib80211_crypt_wep, and place back to tx buffer.
> 
> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_security.c | 72 ++++++++++++++++-----------
>  1 file changed, 43 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
> index bfe0b217e679..80d7569a3108 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_security.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_security.c
> @@ -139,17 +139,11 @@ static __le32 getcrc32(u8 *buf, int len)
>  	Need to consider the fragment  situation
>  */
>  void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
> -{	/*  exclude ICV */
> -
> -	unsigned char	crc[4];
> -	struct arc4context	 mycontext;
> -
> +{
>  	int	curfragnum, length;
> -	u32	keylength;
>  
> -	u8	*pframe, *payload, *iv;    /* wepkey */
> -	u8	wepkey[16];
> -	u8   hw_hdr_offset = 0;
> +	u8 *pframe;
> +	u8 hw_hdr_offset = 0;
>  	struct	pkt_attrib	 *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
>  	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
>  	struct	xmit_priv		*pxmitpriv = &padapter->xmitpriv;
> @@ -165,33 +159,53 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
>  
>  	/* start to encrypt each fragment */
>  	if ((pattrib->encrypt == _WEP40_) || (pattrib->encrypt == _WEP104_)) {
> -		keylength = psecuritypriv->dot11DefKeylen[psecuritypriv->dot11PrivacyKeyIndex];
> +		const int keyindex = psecuritypriv->dot11PrivacyKeyIndex;
> +		void *crypto_private;
> +		struct sk_buff *skb;
> +		struct lib80211_crypto_ops *crypto_ops = try_then_request_module(lib80211_get_crypto_ops("WEP"), "lib80211_crypt_wep");
> +
> +		if (!crypto_ops)
> +			goto exit;
> +
> +		crypto_private = crypto_ops->init(keyindex);
> +		if (!crypto_private)
> +			goto exit;
> +
> +		if (crypto_ops->set_key(psecuritypriv->dot11DefKey[keyindex].skey,
> +					psecuritypriv->dot11DefKeylen[keyindex], NULL, crypto_private) < 0)
> +			goto exit;
>  
>  		for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
> -			iv = pframe+pattrib->hdrlen;
> -			memcpy(&wepkey[0], iv, 3);
> -			memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength);
> -			payload = pframe+pattrib->iv_len+pattrib->hdrlen;
> +			if (curfragnum + 1 == pattrib->nr_frags)
> +				length = pattrib->last_txcmdsz;
> +			else
> +				length = pxmitpriv->frag_len;
> +			skb = dev_alloc_skb(length);
> +			if (!skb)
> +				goto exit;
>  
> -			if ((curfragnum+1) == pattrib->nr_frags) {	/* the last fragment */
> -				length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
> +			skb_put_data(skb, pframe, length);
>  
> -				*((__le32 *)crc) = getcrc32(payload, length);
> +			memmove(skb->data + 4, skb->data, pattrib->hdrlen);
> +			skb_pull(skb, 4);
> +			skb_trim(skb, skb->len - 4);
>  
> -				arcfour_init(&mycontext, wepkey, 3+keylength);
> -				arcfour_encrypt(&mycontext, payload, payload, length);
> -				arcfour_encrypt(&mycontext, payload+length, crc, 4);
> -			} else {
> -				length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
> -				*((__le32 *)crc) = getcrc32(payload, length);
> -				arcfour_init(&mycontext, wepkey, 3+keylength);
> -				arcfour_encrypt(&mycontext, payload, payload, length);
> -				arcfour_encrypt(&mycontext, payload+length, crc, 4);
> -
> -				pframe += pxmitpriv->frag_len;
> -				pframe = (u8 *)round_up((size_t)(pframe), 4);
> +			if (crypto_ops->encrypt_mpdu(skb, pattrib->hdrlen, crypto_private)) {
> +				kfree_skb(skb);
> +				goto exit;
>  			}
> +
> +			memcpy(pframe, skb->data, skb->len);
> +
> +			pframe += skb->len;
> +			pframe = (u8 *)round_up((size_t)(pframe), 4);
> +
> +			kfree_skb(skb);
>  		}
> +
> +exit:
> +		if (crypto_ops && crypto_private)
> +			crypto_ops->deinit(crypto_private);

One label style error handling is always bugggy.  I'm surprised GCC
doesn't catch that crypto_private can be uninitialized...

Flip the if ((pattrib->encrypt == _WEP40_) || (pattrib->encrypt == _WEP104_)) {
tests so it's:

	if (pattrib->encrypt != _WEP40_ && pattrib->encrypt != _WEP104_)
		return;

The use normal error handling style:

	kfree_skb(skb);
	return;

err_free_skb:
	kfree_skb(skb);
err_deinit:
	crypto_ops->deinit(crypto_private);
}

regards,
dan carpenter
