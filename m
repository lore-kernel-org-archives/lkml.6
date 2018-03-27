Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+rIn1/d7uCXbG2kV7Yk5MgCQcXeJWNfOWQyXKwM/R8ThpT101hGhUFcGmMD2HUeUwwyXsH
ARC-Seal: i=1; a=rsa-sha256; t=1522168582; cv=none;
        d=google.com; s=arc-20160816;
        b=AkbVi5A/GurxyZpLFBjlOEpRzXqZgsU4LA0DFvVvX0WR09+BsKnRaX+vA0hvLLU4+V
         6+9aDUPvcO2l8FZ3VejvjSfMjbPoMy7j7xW8u3BOoAR7tSPGneqTv81Qu0z37OiGTExJ
         /fntMBz/7Kb+6QGbSQID2/8nMjsYm/IFnBYSrEz90vvq7rnluGOK7HGJ2QfBSs6SAo6O
         /07ru+DTVgF1R0MIhM2j2JoQcUvoChlaJJC6OkCKuNOYVoB5HEhugIw7wpqeriVzPSFM
         UhJF0YKp76/sSbHrT/FLWnWWvytPH4bm5/irGj4sjhfXaHsmMa6plWxgI68e6tA3olw9
         f/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dVp5EIHLioBRt+rKg0gvhDaK+I8nhfe1h6RGTGHOSrM=;
        b=YqFKFnkQF398O9k2bAmdhdiLu1GC+5V7Z8tLJScWdDHHerfGrpK7CFMHEiY4CT+GiA
         TFb5DaeMaCxeDsM1qPrHI+x+AVXtEHGFgSEZNQrgWpU958cOfO4FH9TBvbOiMmT3msbW
         ayYoEKDUfM5GMsDpUgqxMxkVIwGEu0EqfkyQB+4eqziLnTB8x9hBLZhmwpH135+fWthl
         fnKAEqm5Hy8wNNbycfhsisLmo9iXNGloU2C9wEm6zIikdOd6KvtSmy+n3QdjJNs/jpyJ
         XKArP984UPqo4f94NKSwsvVSdeIK/zJkqnKpamxjraYxLM+RU+kfW4yhwROf/qSNgGtc
         Po6g==
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
Subject: [PATCH 4.14 025/101] clk: bcm2835: Fix ana->maskX definitions
Date: Tue, 27 Mar 2018 18:26:57 +0200
Message-Id: <20180327162751.530321867@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109088454985754?=
X-GMAIL-MSGID: =?utf-8?q?1596109443920592407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -479,17 +479,17 @@ struct bcm2835_pll_ana_bits {
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
