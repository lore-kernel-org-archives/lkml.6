Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6CCC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A45520895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:47:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A45520895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730779AbeG0LIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:08:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51434 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729560AbeG0LIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:08:12 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4BB32AF8;
        Fri, 27 Jul 2018 09:47:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 4.17 12/66] clk: meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL
Date:   Fri, 27 Jul 2018 11:45:05 +0200
Message-Id: <20180727093810.473928139@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neil Armstrong <narmstrong@baylibre.com>

commit c987ac6f1f088663b6dad39281071aeb31d450a8 upstream.

On Amlogic Meson GXBB & GXL platforms, the SCPI Cortex-M4 Co-Processor
seems to be dependent on the FCLK_DIV2 to be operationnal.

The issue occurred since v4.17-rc1 by freezing the kernel boot when
the 'schedutil' cpufreq governor was selected as default :

  [   12.071837] scpi_protocol scpi: SCP Protocol 0.0 Firmware 0.0.0 version
  domain-0 init dvfs: 4
  [   12.087757] hctosys: unable to open rtc device (rtc0)
  [   12.087907] cfg80211: Loading compiled-in X.509 certificates for regulatory database
  [   12.102241] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'

But when disabling the MMC driver, the boot finished but cpufreq failed to
change the CPU frequency :

  [   12.153045] cpufreq: __target_index: Failed to change cpu frequency: -5

A bisect between v4.16 and v4.16-rc1 gave
05f814402d61 ("clk: meson: add fdiv clock gates") to be the first bad commit.
This commit added support for the missing clock gates before the fixed PLL
fixed dividers (FCLK_DIVx) and the clock framework basically disabled
all the unused fixed dividers, thus disabled a critical clock path for
the SCPI Co-Processor.

This patch simply sets the FCLK_DIV2 gate as critical to ensure
nobody can disable it.

Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
[few corrections in the commit description]
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/meson/gxbb.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -511,6 +511,7 @@ static struct clk_regmap gxbb_fclk_div2
 		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "fclk_div2_div" },
 		.num_parents = 1,
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 


