Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751217AbeFCQPX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 12:15:23 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40146 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750789AbeFCQPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 12:15:22 -0400
X-Google-Smtp-Source: ADUXVKIujWA50jIo8u6cQChQCs6hUQ56W1goLPyfF16DMLHvt/g4WzkULvoW8vmgsJCFy2+Gx+JcWQ==
Subject: Re: [PATCH] staging:r8188eu: Use lib80211 to encrypt (WEP) tx frames
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Santha Meena Ramamoorthy <santhameena13@gmail.com>,
        Janani Sankara Babu <jananis37@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20180528061821.26948-1-insafonov@gmail.com>
 <20180528135351.5y66u4puldawfic5@mwanda>
From: Ivan Safonov <insafonov@gmail.com>
Message-ID: <3e3851f2-7b51-3ab3-5663-ce7147ef8114@gmail.com>
Date: Sun, 3 Jun 2018 19:16:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180528135351.5y66u4puldawfic5@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28/2018 04:53 PM, Dan Carpenter wrote:
> On Mon, May 28, 2018 at 09:18:21AM +0300, Ivan Safonov wrote:
>> Put data to skb, decrypt with lib80211_crypt_wep, and place back to tx buffer.
>>
>> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
>> ---
>>   drivers/staging/rtl8188eu/core/rtw_security.c | 72 ++++++++++++++++-----------
>>   1 file changed, 43 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/staging/rtl8188eu/core/rtw_security.c b/drivers/staging/rtl8188eu/core/rtw_security.c
>> index bfe0b217e679..80d7569a3108 100644
>> --- a/drivers/staging/rtl8188eu/core/rtw_security.c
>> +++ b/drivers/staging/rtl8188eu/core/rtw_security.c
>> @@ -139,17 +139,11 @@ static __le32 getcrc32(u8 *buf, int len)
>>   	Need to consider the fragment  situation
>>   */
>>   void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
>> -{	/*  exclude ICV */
>> -
>> -	unsigned char	crc[4];
>> -	struct arc4context	 mycontext;
>> -
>> +{
>>   	int	curfragnum, length;
>> -	u32	keylength;
>>   
>> -	u8	*pframe, *payload, *iv;    /* wepkey */
>> -	u8	wepkey[16];
>> -	u8   hw_hdr_offset = 0;
>> +	u8 *pframe;
>> +	u8 hw_hdr_offset = 0;
>>   	struct	pkt_attrib	 *pattrib = &((struct xmit_frame *)pxmitframe)->attrib;
>>   	struct	security_priv	*psecuritypriv = &padapter->securitypriv;
>>   	struct	xmit_priv		*pxmitpriv = &padapter->xmitpriv;
>> @@ -165,33 +159,53 @@ void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
>>   
>>   	/* start to encrypt each fragment */
>>   	if ((pattrib->encrypt == _WEP40_) || (pattrib->encrypt == _WEP104_)) {
>> -		keylength = psecuritypriv->dot11DefKeylen[psecuritypriv->dot11PrivacyKeyIndex];
>> +		const int keyindex = psecuritypriv->dot11PrivacyKeyIndex;
>> +		void *crypto_private;
>> +		struct sk_buff *skb;
>> +		struct lib80211_crypto_ops *crypto_ops = try_then_request_module(lib80211_get_crypto_ops("WEP"), "lib80211_crypt_wep");
>> +
>> +		if (!crypto_ops)
>> +			goto exit;
>> +
>> +		crypto_private = crypto_ops->init(keyindex);
>> +		if (!crypto_private)
>> +			goto exit;
>> +
>> +		if (crypto_ops->set_key(psecuritypriv->dot11DefKey[keyindex].skey,
>> +					psecuritypriv->dot11DefKeylen[keyindex], NULL, crypto_private) < 0)
>> +			goto exit;
>>   
>>   		for (curfragnum = 0; curfragnum < pattrib->nr_frags; curfragnum++) {
>> -			iv = pframe+pattrib->hdrlen;
>> -			memcpy(&wepkey[0], iv, 3);
>> -			memcpy(&wepkey[3], &psecuritypriv->dot11DefKey[psecuritypriv->dot11PrivacyKeyIndex].skey[0], keylength);
>> -			payload = pframe+pattrib->iv_len+pattrib->hdrlen;
>> +			if (curfragnum + 1 == pattrib->nr_frags)
>> +				length = pattrib->last_txcmdsz;
>> +			else
>> +				length = pxmitpriv->frag_len;
>> +			skb = dev_alloc_skb(length);
>> +			if (!skb)
>> +				goto exit;
>>   
>> -			if ((curfragnum+1) == pattrib->nr_frags) {	/* the last fragment */
>> -				length = pattrib->last_txcmdsz-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
>> +			skb_put_data(skb, pframe, length);
>>   
>> -				*((__le32 *)crc) = getcrc32(payload, length);
>> +			memmove(skb->data + 4, skb->data, pattrib->hdrlen);
>> +			skb_pull(skb, 4);
>> +			skb_trim(skb, skb->len - 4);
>>   
>> -				arcfour_init(&mycontext, wepkey, 3+keylength);
>> -				arcfour_encrypt(&mycontext, payload, payload, length);
>> -				arcfour_encrypt(&mycontext, payload+length, crc, 4);
>> -			} else {
>> -				length = pxmitpriv->frag_len-pattrib->hdrlen-pattrib->iv_len-pattrib->icv_len;
>> -				*((__le32 *)crc) = getcrc32(payload, length);
>> -				arcfour_init(&mycontext, wepkey, 3+keylength);
>> -				arcfour_encrypt(&mycontext, payload, payload, length);
>> -				arcfour_encrypt(&mycontext, payload+length, crc, 4);
>> -
>> -				pframe += pxmitpriv->frag_len;
>> -				pframe = (u8 *)round_up((size_t)(pframe), 4);
>> +			if (crypto_ops->encrypt_mpdu(skb, pattrib->hdrlen, crypto_private)) {
>> +				kfree_skb(skb);
>> +				goto exit;
>>   			}
>> +
>> +			memcpy(pframe, skb->data, skb->len);
>> +
>> +			pframe += skb->len;
>> +			pframe = (u8 *)round_up((size_t)(pframe), 4);
>> +
>> +			kfree_skb(skb);
>>   		}
>> +
>> +exit:
>> +		if (crypto_ops && crypto_private)
>> +			crypto_ops->deinit(crypto_private);
> 
> One label style error handling is always bugggy.  I'm surprised GCC
> doesn't catch that crypto_private can be uninitialized...

This is not a compiler defect. The code

if (a && b) {
	...
}

is equal to

if (a) {
	if (b) {
		...
	}
}

> 
> Flip the if ((pattrib->encrypt == _WEP40_) || (pattrib->encrypt == _WEP104_)) {
> tests so it's:
> 
> 	if (pattrib->encrypt != _WEP40_ && pattrib->encrypt != _WEP104_)
> 		return;

The check is superfluous inside this function, it should be
(somewhen) around rtw_wep_encrypt().

> 
> The use normal error handling style:
> 
> 	kfree_skb(skb);
> 	return;
> 
> err_free_skb:
> 	kfree_skb(skb);
> err_deinit:
> 	crypto_ops->deinit(crypto_private);
> }
> 

rtw_(wep|aes|tkip)_(en|de)crypt still need to be rewritten, so I'll 
leave this patch as is. In the following patches I'll take your comments 
into account, they really simplify reading the code.

> regards,
> dan carpenter
> 

Ivan Safonov.
