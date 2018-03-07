Return-Path: <kernel-hardening-return-12213-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtrzDHqWxdLAKB5mH/0ncm61sY3ujFjO5sxl8AS1FAK05lwjNRETAbrzHiq/JY9aeQsWO5r
ARC-Seal: i=1; a=rsa-sha256; t=1520457976; cv=none;
        d=google.com; s=arc-20160816;
        b=h0qqEPnBjwanGMqzgV3Kan8vFi8VAGbE+B7ODvOOYFdk3BrZ3DmFhSP3532Mw5mVXc
         ouAGkvOF00jwrcmGb63m/QcngsvLXZkhcHMevyzHi4iBWxqBg/oPuWy/noWSCM5YCTAm
         xR/LbLRhdI20EkCIzuNs+oz5mA9rE3ly8EcxpeDs8naN3FqIN2IPkOvpWdRtrzcONc/s
         wmMwtP7S/uUZhv4ECwCYIAP3rI1NfjQwDfqd/IWv6W+WDucq6mxSPOAiNWTXCPLTdo0U
         uasX+xGhIjGLDDkeygpJywv1LlmXx06PmREsUaWnon22Ts/YDfeH2aefXg3BGA/HOwBe
         gXDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=JWKxbolXDV+D3bGvNGvc+WWEC6sQGh7+nzTc4X5nQrM=;
        b=S0LKdP/naITpp+ec3wWnFal39xS06q1SXX5UGzRTxmsNtzTu1B+RnKryQ90iYP9BvX
         ZpGcA03OJ+Nph7g8kMRBCIthgDjTfDkTw9gvOHQWYiNtRH3mgbcNpFcJqGAaMIH3hb/Y
         GS5YOQQjqZMGEu3HBOKamg5Is37wIwWZQ0IYfzBGntfrGgDin4qXu2ms6pCZlgNEmodo
         QQo3AFPvXgnQI5gtQMNor6AANZl/UBEnPn3C2h/3LeXULv4B9JfmCxZAVZQpHjFa6pG6
         eR51ljPmPnuTVk2HqCLNxB7xp2y543DOpqRa0HPFvbyev8SetK58zROM0gfXm0MtVb+x
         032w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=dHylESBw;
       spf=pass (google.com: domain of kernel-hardening-return-12213-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12213-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=dHylESBw;
       spf=pass (google.com: domain of kernel-hardening-return-12213-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12213-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 7 Mar 2018 13:25:55 -0800
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <ynorov@caviumnetworks.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH] test_bitmap: Do not accidentally use stack VLA
Message-ID: <20180307212555.GA17927@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594315743525049563?=
X-GMAIL-MSGID: =?utf-8?q?1594315743525049563?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This avoids an accidental stack VLA (since the compiler thinks the value
of "len" can change, even when marked "const"). This just replaces it
with a #define so it will DTRT.

Seen with -Wvla. Fixed as part of the directive to remove all VLAs from
the kernel: https://lkml.org/lkml/2018/3/7/621

Cc: Yury Norov <ynorov@caviumnetworks.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/test_bitmap.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index b3f235baa05d..756f20ad03db 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -292,15 +292,17 @@ static void __init test_bitmap_parselist(void)
 	}
 }
 
+#define EXP_BYTES	(sizeof(exp) * 8)
+
 static void __init test_bitmap_arr32(void)
 {
-	unsigned int nbits, next_bit, len = sizeof(exp) * 8;
+	unsigned int nbits, next_bit;
 	u32 arr[sizeof(exp) / 4];
-	DECLARE_BITMAP(bmap2, len);
+	DECLARE_BITMAP(bmap2, EXP_BYTES);
 
 	memset(arr, 0xa5, sizeof(arr));
 
-	for (nbits = 0; nbits < len; ++nbits) {
+	for (nbits = 0; nbits < EXP_BYTES; ++nbits) {
 		bitmap_to_arr32(arr, exp, nbits);
 		bitmap_from_arr32(bmap2, arr, nbits);
 		expect_eq_bitmap(bmap2, exp, nbits);
@@ -312,7 +314,7 @@ static void __init test_bitmap_arr32(void)
 				" tail is not safely cleared: %d\n",
 				nbits, next_bit);
 
-		if (nbits < len - 32)
+		if (nbits < EXP_BYTES - 32)
 			expect_eq_uint(arr[DIV_ROUND_UP(nbits, 32)],
 								0xa5a5a5a5);
 	}
-- 
2.7.4


-- 
Kees Cook
Pixel Security
