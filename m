Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521806579-2-2766971995262659106
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521806579; b=G7+uebMKkfHmBlupsevyVOaFf7bpzUTOkeLDLR9UyIwGGfi
    jAYLv64cyYydKsi8MQTPYZfIQEGuclMBqtJ36HCz4N4VVvO9FOWRVABfhwXHsZpC
    j3DgW0wUV9mrQOmM8MkUPWlMdcp8g8iUtN5jmJznwdPTVVnA29csdxlaGtZYJT2F
    yqdVlZXLh6wUv6kdnmRL6JARQIuJS38uFliZI6TYIyRQz04zObRWjTegswumE3kW
    wJHJQOx9EXq+7ELB6HYgTde3bt/4GjO2Lf25p/JmdJgjE++VnordXzM28akeqGsS
    tRY4HROt4cnTkWNCglqrawyZ9cACIMWUC/Kv6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806579; bh=oRxSjYWptTCDa5aGcNaJakLO9E
    cCJBFf8QfIUIIHUOo=; b=ilHTQwx8lY3AsWXWS2A6NXQ08MCIfTiDO8JcGcNGz5
    Z3CUSrUq+kt3jZFTwpugo+5ynXcR0isEjHn8jmHPvbxQphtwYABtcyMabm4UQsp1
    xKFXcekpwCrX8+LMfhKUN0HAE/NW9OOGdkoWXVwibzXA+3a86pnCrVxTmBsfejCg
    qZqZ4mPMPeeUI6Xa7/6h39YSPGvO19wM1YJ/nkP9QOoCPq42xXWH710cRx84ADxa
    C+/IewtSSfmiH3dDVX8+BbzzSNq2J2NgI+A0nV4fAI29AqGcXRmCrIF5cgwwkR9x
    9yhgLkGmS/AduxYU5a45f3aUie+oN8ljCI+Fi8w594ag==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753431AbeCWJ75 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:59:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36322 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753444AbeCWJ7z (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:59:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 72/84] clk: axi-clkgen: Correctly handle nocount bit in recalc_rate()
Date: Fri, 23 Mar 2018 10:54:26 +0100
Message-Id: <20180323095422.823267169@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lars-Peter Clausen <lars@metafoo.de>


[ Upstream commit 063578dc5f407f67d149133818efabe457daafda ]

If the nocount bit is set the divider is bypassed and the settings for the
divider count should be ignored and a divider value of 1 should be assumed.
Handle this correctly in the driver recalc_rate() callback.

While the driver sets up the part so that the read back dividers values
yield the correct result the power-on reset settings of the part might not
reflect this and hence calling e.g. clk_get_rate() without prior calls to
clk_set_rate() will yield the wrong result.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-axi-clkgen.c |   29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -40,6 +40,10 @@
 #define MMCM_REG_FILTER1	0x4e
 #define MMCM_REG_FILTER2	0x4f
 
+#define MMCM_CLKOUT_NOCOUNT	BIT(6)
+
+#define MMCM_CLK_DIV_NOCOUNT	BIT(12)
+
 struct axi_clkgen {
 	void __iomem *base;
 	struct clk_hw clk_hw;
@@ -315,12 +319,27 @@ static unsigned long axi_clkgen_recalc_r
 	unsigned int reg;
 	unsigned long long tmp;
 
-	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLKOUT0_1, &reg);
-	dout = (reg & 0x3f) + ((reg >> 6) & 0x3f);
+	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLKOUT0_2, &reg);
+	if (reg & MMCM_CLKOUT_NOCOUNT) {
+		dout = 1;
+	} else {
+		axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLKOUT0_1, &reg);
+		dout = (reg & 0x3f) + ((reg >> 6) & 0x3f);
+	}
+
 	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_DIV, &reg);
-	d = (reg & 0x3f) + ((reg >> 6) & 0x3f);
-	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_FB1, &reg);
-	m = (reg & 0x3f) + ((reg >> 6) & 0x3f);
+	if (reg & MMCM_CLK_DIV_NOCOUNT)
+		d = 1;
+	else
+		d = (reg & 0x3f) + ((reg >> 6) & 0x3f);
+
+	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_FB2, &reg);
+	if (reg & MMCM_CLKOUT_NOCOUNT) {
+		m = 1;
+	} else {
+		axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_FB1, &reg);
+		m = (reg & 0x3f) + ((reg >> 6) & 0x3f);
+	}
 
 	if (d == 0 || dout == 0)
 		return 0;
