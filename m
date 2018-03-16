Return-Path: <gustavo@embeddedor.com>
X-Google-Smtp-Source: AG47ELuqM3Lc0zlppzksBbZ3mAOBYIKDrPBK+os69Old7ggoeLLi0G8OYhTaCvpggdzpPFN8xxZN
ARC-Seal: i=1; a=rsa-sha256; t=1521206470; cv=none;
        d=google.com; s=arc-20160816;
        b=Bo5LoNKn+fHfOBN1vs8i3/bsPpYf/V1cyCYyUEPn1UylbS5k9sHUedbJwhXz8EtWH1
         +nykdSF/qBtkZtu2wKVvGqvONuUA0I4Zr+1SaQIvFohrfadXCjwYJSTWSMFpWPKka8lD
         tF9bFFEEEsU/kHyGpTtwcK1F7+QtTYFRQWlY1NjKfrLubwOQg1sDHV85dgOk6JW++wLR
         s5cPtF76wfSZDp/MeOTQoQVdssZ3u1ZFmwjDT6vxAkp5A6n94b6COyp89SXD4xUzTxuk
         NpA4PpzccXQrTY1/o2FBBqevp4odCevdPaSHrAqgvxEYBWLph2Sjc/ZMsG/b7pXfiLNB
         MW7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=XO3q63s51qyvYJy8k8KnSKGZNjm+p+S+2W1AeUx/qPE=;
        b=coBYyOwtdOV9zxKslP8RDtbQnUByCs1PqFLAnGHJcYfjm1jM1XgZbExKlZf2soo57b
         G+lXlA8+fW3x4zWPnPPXNOdotU45ADCGZcALnJ4VMhW3cgerupEdmUNwqpESWvLWQPDn
         H8lOU9UQP8YWdiyrPdTMtH2xX8RK3FnTwgrPvrCZSlzpq+/VUdjb42UrFoJgkNAExng3
         0Jr4BACAEqNxETpZsE/k9l88E1fAiFPwLi9ULRn4GDQEzOUNhETPe/ho+iemn4HyKLLF
         5CJDgqnp5i7QUmE7ge2KzAwyrlVrPQXKYKU2/GWsmJRT6J5rTl/qKw4dSsBeTndTVu8o
         x82A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.148.194 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gustavo@embeddedor.com designates 192.185.148.194 as permitted sender) smtp.mailfrom=gustavo@embeddedor.com
Date: Fri, 16 Mar 2018 08:21:08 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] USB: wusbcore: crypto: Remove VLA usage
Message-ID: <20180316132108.GA23487@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1ewpID-000F68-Jx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:42260
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595099374713659126?=
X-GMAIL-MSGID: =?utf-8?q?1595100596094126409?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation to enabling -Wvla, remove VLA and replace it
with dynamic memory allocation instead.

The use of stack Variable Length Arrays needs to be avoided, as they
can be a vector for stack exhaustion, which can be both a runtime bug
or a security flaw. Also, in general, as code evolves it is easy to
lose track of how big a VLA can get. Thus, we can end up having runtime
failures that are hard to debug.

Also, fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Notice that in this particular case, an alternative to kzalloc is kcalloc,
in which case the code would look as follows instead:

iv = kcalloc(crypto_skcipher_ivsize(tfm_cbc), sizeof(*iv), GFP_KERNEL);

but if the data type of _iv_ never changes, or the type size is always one
byte, kzalloc is good enough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Fix a memory leak in previous patch.

 drivers/usb/wusbcore/crypto.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/wusbcore/crypto.c b/drivers/usb/wusbcore/crypto.c
index 4c00be2d..aff50eb 100644
--- a/drivers/usb/wusbcore/crypto.c
+++ b/drivers/usb/wusbcore/crypto.c
@@ -202,7 +202,7 @@ static int wusb_ccm_mac(struct crypto_skcipher *tfm_cbc,
 	struct scatterlist sg[4], sg_dst;
 	void *dst_buf;
 	size_t dst_size;
-	u8 iv[crypto_skcipher_ivsize(tfm_cbc)];
+	u8 *iv;
 	size_t zero_padding;
 
 	/*
@@ -224,7 +224,9 @@ static int wusb_ccm_mac(struct crypto_skcipher *tfm_cbc,
 	if (!dst_buf)
 		goto error_dst_buf;
 
-	memset(iv, 0, sizeof(iv));
+	iv = kzalloc(crypto_skcipher_ivsize(tfm_cbc), GFP_KERNEL);
+	if (!iv)
+		goto error_iv;
 
 	/* Setup B0 */
 	scratch->b0.flags = 0x59;	/* Format B0 */
@@ -276,6 +278,8 @@ static int wusb_ccm_mac(struct crypto_skcipher *tfm_cbc,
 	bytewise_xor(mic, &scratch->ax, iv, 8);
 	result = 8;
 error_cbc_crypt:
+	kfree(iv);
+error_iv:
 	kfree(dst_buf);
 error_dst_buf:
 	return result;
-- 
2.7.4
