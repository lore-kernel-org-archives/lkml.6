Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49mADFgM7rIQL10VIDKDyMhRm7aO4280sg5nztQD27lXJE/cHdGSXmdlq+NDGfzGWKO9Fy6
ARC-Seal: i=1; a=rsa-sha256; t=1522168770; cv=none;
        d=google.com; s=arc-20160816;
        b=zSaAMroH0HNFCceJBw+C1bqxMTyP4EzJ0eOR/juZbTY+hc3Ld1RrW4xrf94ND8hmVm
         v4I/3jw36mBW00FQgVWqMueVMb3wvBlsSocGPJKKGFF17pPjEKKtk1LKkdNCfcnmSSra
         tlWHENhFQ/f4V6Vrk51sakebOqhqrgorOSrIog0ZYtb2VqURaWI/GxSbxI31NkY6ilWZ
         5Kc/rdmUD4/RouYk445myxIIWO9j8gfvUbagXhkC2b5jwpYHAoIP9DCvufbe4o2+L8ft
         BwxbR/oWjH+G5jutnXFgv0nmnHzztKfNgiKlSmQxumCCVw8wy8Xcs8d9PzNBHNsYm+HQ
         f5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kw9ubnZdmgoAH8N2J5VSq4A5m2UhFMQ3Dy6ZuZg7JkE=;
        b=Mu+lQU8tBRUr0FKIGfuvkPvXePTQc1CcbVPl1E8A0lw9iHxzjGqEGFoRdh2y49yoUv
         H0CTYuwS6NedLd+A0hgTCQpvS2dHeyvinheldxPJyX5x6r/c8n5ZucpS18GrvAsnuD+z
         Z0si59mQWFSQgJ6iTe+2ufJ95KDWyyYUsJrQH/OlCRvn3CiMN7GaOq9VJ5zzrcySWOfP
         yHg0zxwqx3jhrs4TX68fZaIkOPnuFvsfqwjR0UPW+vQ1EJZxEaV13/c8BI9wxtSmoInj
         feOyE0JzMKT/QT/Xbldub7jr9Eta1Q43acqfobPPWttQlhKpYeV5uVBoR4x3FyZOP/v2
         ggow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Boris Brezillon <boris.brezillon@bootlin.com>,
	Eric Anholt <eric@anholt.net>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 4.15 025/105] clk: bcm2835: Fix ana->maskX definitions
Date: Tue, 27 Mar 2018 18:27:05 +0200
Message-Id: <20180327162758.942471054@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109088454985754?=
X-GMAIL-MSGID: =?utf-8?q?1596109640238859097?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@bootlin.com>

commit 49012d1bf5f78782d398adb984a080a88ba42965 upstream.

ana->maskX values are already '~'-ed in bcm2835_pll_set_rate(). Remove
the '~' in the definition to fix ANA setup.

Note that this commit fixes a long standing bug preventing one from
using an HDMI display if it's plugged after the FW has booted Linux.
This is because PLLH is used by the HDMI encoder to generate the pixel
clock.

Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/bcm/clk-bcm2835.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -449,17 +449,17 @@ struct bcm2835_pll_ana_bits {
 static const struct bcm2835_pll_ana_bits bcm2835_ana_default = {
 	.mask0 = 0,
 	.set0 = 0,
-	.mask1 = (u32)~(A2W_PLL_KI_MASK | A2W_PLL_KP_MASK),
+	.mask1 = A2W_PLL_KI_MASK | A2W_PLL_KP_MASK,
 	.set1 = (2 << A2W_PLL_KI_SHIFT) | (8 << A2W_PLL_KP_SHIFT),
-	.mask3 = (u32)~A2W_PLL_KA_MASK,
+	.mask3 = A2W_PLL_KA_MASK,
 	.set3 = (2 << A2W_PLL_KA_SHIFT),
 	.fb_prediv_mask = BIT(14),
 };
 
 static const struct bcm2835_pll_ana_bits bcm2835_ana_pllh = {
-	.mask0 = (u32)~(A2W_PLLH_KA_MASK | A2W_PLLH_KI_LOW_MASK),
+	.mask0 = A2W_PLLH_KA_MASK | A2W_PLLH_KI_LOW_MASK,
 	.set0 = (2 << A2W_PLLH_KA_SHIFT) | (2 << A2W_PLLH_KI_LOW_SHIFT),
-	.mask1 = (u32)~(A2W_PLLH_KI_HIGH_MASK | A2W_PLLH_KP_MASK),
+	.mask1 = A2W_PLLH_KI_HIGH_MASK | A2W_PLLH_KP_MASK,
 	.set1 = (6 << A2W_PLLH_KP_SHIFT),
 	.mask3 = 0,
 	.set3 = 0,
