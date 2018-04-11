Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/gceEkE1y7MeIQBxwYggaDwRD6rMGG34+65NCOGEfuSvy4uiNJNoUnLAY3p2W+SlVziX70
ARC-Seal: i=1; a=rsa-sha256; t=1523473234; cv=none;
        d=google.com; s=arc-20160816;
        b=gzXX30uDKySbQ1lxptugKE6dmA+aiWf03JUBbT0lgerTZPxRgOy4Y8VTVKysgNPd0j
         mobk+O9lSbHsOBtY6TQk1bSYUBkKSEx724DqV6fEy98R96mKRt6ENGS0s9eV5u+u0hr+
         B9O5WVGk6Qf1Swb7RbbjLE2drxNG94wPQndayP14zzYY6W73iyACSRTHIK4UsAImVoDp
         cc+hk5Cjll4WpW0g2dgT3S2VCBIEi3f+v+eTPfOiVkAZEkqZCC18CcFm2Zf4bbe8Jh49
         ZuF69MNo3a/BbVpyjAG6wVAHabsuy6RLKQf6bhE2B9fUeT15A57mzyztBtuCXQ8PPtVQ
         PjXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aXvN0yBYFfYk4R4pJbCBIMFbVZRG53monce3wZ/T6IQ=;
        b=P825qgrQkOCpQxizTE8CAJHPPVNcIAi62Ibr0w79IpgBk1js2tdew1qaJMMvlIOByC
         3S2EmlONRGcRHkJ/vZqxdtArJdh++Q+RXmg4Lx/anSIhZ33aLXTa8d3PS9O7vTod2Src
         crMLffVGNhF4gqPDvE1kfzNUrAxDioDuy0EiDac0wT4pmHiBx246Xcb9Fr8CGRWME0h0
         AVIPZbPGD2Z5TIbTKckj6KOpI3+DBG8HGd5Jv74eoxJDyqVTjsADpgN8JWe0g0M16BFG
         iXY381Uv5rQtZfUY/C/57RMJgc7Jp9yFnokg3b7vd3NAop9dBeDlgvcmoK7MUl5Dntuh
         4Q+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 172/310] clk: scpi: fix return type of __scpi_dvfs_round_rate
Date: Wed, 11 Apr 2018 20:35:11 +0200
Message-Id: <20180411183630.035784398@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476689574373473?=
X-GMAIL-MSGID: =?utf-8?q?1597477470044733799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudeep Holla <sudeep.holla@arm.com>


[ Upstream commit 7374aec95636ca39409545eba4ef5ff3125c2346 ]

The frequencies above the maximum value of signed integer(i.e. 2^31 -1)
will overflow with the current code.

This patch fixes the return type of __scpi_dvfs_round_rate from 'int'
to 'unsigned long'.

Fixes: cd52c2a4b5c4 ("clk: add support for clocks provided by SCP(System Control Processor)")
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-scpi.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -71,15 +71,15 @@ static const struct clk_ops scpi_clk_ops
 };
 
 /* find closest match to given frequency in OPP table */
-static int __scpi_dvfs_round_rate(struct scpi_clk *clk, unsigned long rate)
+static long __scpi_dvfs_round_rate(struct scpi_clk *clk, unsigned long rate)
 {
 	int idx;
-	u32 fmin = 0, fmax = ~0, ftmp;
+	unsigned long fmin = 0, fmax = ~0, ftmp;
 	const struct scpi_opp *opp = clk->info->opps;
 
 	for (idx = 0; idx < clk->info->count; idx++, opp++) {
 		ftmp = opp->freq;
-		if (ftmp >= (u32)rate) {
+		if (ftmp >= rate) {
 			if (ftmp <= fmax)
 				fmax = ftmp;
 			break;
