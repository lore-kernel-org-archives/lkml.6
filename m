Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48B4liit1nGUXi1MQWQOh/X6jQG/def4YefJJCEqcgGFclV2b5Bn9tSAd8tZn4H+vw0vuzO
ARC-Seal: i=1; a=rsa-sha256; t=1522168243; cv=none;
        d=google.com; s=arc-20160816;
        b=kgkBmQI6aG95lkoxMSdkfdLR1vrC7V3iSJMulNlhmZukc0W/6/ZPX3EMtN/BoJPqwF
         tqKDwY2iM4jokUd4Vmr8CyZcfx2YQ3KgulGRbJJvDr5wY1uPUPydQB+7AUi5PU8XA1aA
         i2lh23NI49ZhMtqEfHemVISnd7D1tFDqPneSL10/3W59W6dRFN4gieU6aZT/edWRWXzn
         IHjv9cHS7pSqgv6Nof7XIswOriNBq9Q0OhJTbN6Z6IfEMB8C97y+f8TENMA1gVuhVuKm
         J+k6b2pMWqaq2goWNN/ggX9zbc5a5MJ6ypeDFw5zNTI9KBM6X2GiVtFHb9sPlZ4z5f8R
         d8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cX6KD/9Jpj3M1vZKYc7lFdyz6zSzQSa728ABF6JM6eE=;
        b=q7c/zJxpfbYSrk02/wkCT5rU3KocvJjCL4vpnjFqWSYP/89wSTBkXGie6GpECtoNwM
         nY66kE7clY7sPks1AdVfB/JhDUneb2JgoukpS/bVKgvt7BqF27qzl+Y3C1r9+QgTMQK3
         cMQ9yINtD7okWpryT2j3GS9+qQjfYVYuyYc5IVqTO7p0HT/FHAOTonNkUqQ8cUpQnVKx
         59KCbFQACVRE8qOgoNYYROHQgB2o1WsILdGqz1DC726NxXPERY1W+VfY4EJi2AZwjdSH
         BRXUV1xWbO8XZx89m6MM2riB2+KM6jEVzTMsqCKAL6QltUAHZHhIlGuTLyzouMuLOhe1
         Qheg==
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
Subject: [PATCH 4.9 10/67] clk: bcm2835: Fix ana->maskX definitions
Date: Tue, 27 Mar 2018 18:27:02 +0200
Message-Id: <20180327162727.253246272@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109088454985754?=
X-GMAIL-MSGID: =?utf-8?q?1596109088454985754?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -401,17 +401,17 @@ struct bcm2835_pll_ana_bits {
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
