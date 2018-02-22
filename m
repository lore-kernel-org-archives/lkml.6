Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-171462-1519306535-2-6440700295392866086
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519306534; b=nWV9R8BUSceSX0xfOlYOiytYvvol8lMuU1OA51smaNu28SB
    e2t8WJyI/yxRbHgCMr5AV49hmLIrhAVM9nAqdMS/veY8qUPdlYSKjv80So5NWIv2
    rT8+cug8IeHEJCczHNFgZSxl8NqBsn796+yyo3ktdrXe7mlY0zlwbIPdG+AVlcQv
    GlQ5K47ZhBelQP0Spu5Wysx1+zKYJyztQbfC5tBdQ9ZUKa8zvt25zIa9el0K5MnF
    uKgWO5XegmIy8hx0dsPDfVNlrBKBW+4UUQ36ZHNwlFsLuVCKDrf84xpmOy2B/0on
    mMsZQVPuaC8i+P6S0GJzkg3Qr/W0s7FOFJv2ILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519306534; bh=o6uKbdZqkk79JsDi1t7BjyKsyO
    lR7I3EDO7pv2ghUEc=; b=wN5AfgYFoUTXcv0Uz0LVDZx4BiVwzmGHE2tC8kCMaK
    dAL5fCjrd8zIRQzO9VDZVX3f1idoOWNmVx4SLVy0FaLe9mYe9qSchQ4qm4cCp8Eg
    Zc24jR9nHXrC4ReRGpxu2J3qlTbjWQ7pcVn3NoELbp4U+ex75vIxHRDum+BQIRUE
    ChFaGHDKcSSSy4P0zfEKme0nnJkp1hwxFYact69h3+RGRYhfdXp5qm2dYQ+8dtJE
    LBArWlPnaILQd4tQ1/Cr3mZGRdz8XuPaVgDGM6HsYMWwgKztdENxZpt1oynLTUq7
    oQxtER0qyzZDCPj2a9imSUAxwHMb/AME14CSSk6lqQIA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932395AbeBVNfT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 08:35:19 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:40050 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753844AbeBVNfS (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 08:35:18 -0500
From: Evgeniy Didin <Evgeniy.Didin@synopsys.com>
To: linux-mmc@vger.kernel.org
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Douglas Anderson <dianders@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        stable@vger.kernel.org, Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2] mmc: dw_mmc: Fix the DTO timeout overflow calculation for 32-bit systems
Date: Thu, 22 Feb 2018 16:34:18 +0300
Message-Id: <20180222133418.29336-1-Evgeniy.Didin@synopsys.com>
X-Mailer: git-send-email 2.11.0
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In commit 9d9491a7da2a ("mmc: dw_mmc: Fix the DTO timeout calculation") have been made
changes which cause multiply overflow for 32-bit systems.
The broken timeout calculations caused false interrupt latency warnings
and stacktrace splat (such as below) when accessing the SD Card.

| Running :  4M-check-reassembly-tcp-cmykw2-rotatew2.out -v0 -w1
| -  Info: Finished target initialization.
| mmcblk0: error -110 transferring data, sector 320544, nr 2048, cmd response
|  0x900, card status 0x0
| mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual
| 396825HZ div = 63)
| mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 25000000Hz, actual
|  25000000HZ div = 1)
| ------------[ cut here ]------------
| softirq: huh, entered softirq 6 TASKLET 6f6a9412 with preempt_count 00000101,
| exited with 00000100?
| WARNING: CPU: 2 PID: 0 at ../lib/scatterlist.c:652 sg_miter_next+0x28/0x20c
| Modules linked in:
| CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.15.0 #57
|
| Stack Trace:
|  arc_unwind_core.constprop.1+0xd0/0xf4
|  dump_stack+0x68/0x80
|  warn_slowpath_null+0x4e/0xec
|  sg_miter_next+0x28/0x20c
|  dw_mci_read_data_pio+0x44/0x190
|  dw_mmc f000a000.mmc: Unexpected interrupt latency
|   dw_mci_interrupt+0x3ee/0x530
|  __handle_irq_event_percpu+0x56/0x150
|  handle_irq_event+0x34/0x78
|  handle_level_irq+0x8e/0x120
|  generic_handle_irq+0x1c/0x2c
|  idu_cascade_isr+0x30/0x6c
|  __handle_domain_irq+0x72/0xc8
|  ret_from_exception+0x0/0x8
|---[ end trace 2a58c9af6c25fe51 ]---

Lets cast this multiply to u64 type which prevents overflow.

Tested-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Fixes: ARC STAR 9001306872 HSDK, sdio: board crashes when copying big files

Signed-off-by: Evgeniy Didin <Evgeniy.Didin@synopsys.com>

CC: Alexey Brodkin <abrodkin@synopsys.com>
CC: Eugeniy Paltsev <paltsev@synopsys.com>
CC: Douglas Anderson <dianders@chromium.org>
CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: linux-kernel@vger.kernel.org
CC: linux-snps-arc@lists.infradead.org
Cc: <stable@vger.kernel.org> #  9d9491a7da2a mmc: dw_mmc: Fix the DTO timeout calculation
---
Changes since v1:
-uint64_t switched to u64
-changed commit message
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0aa39975f33b..1a0b9751c67c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1944,7 +1944,7 @@ static void dw_mci_set_drto(struct dw_mci *host)
 	drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
 	if (drto_div == 0)
 		drto_div = 1;
-	drto_ms = DIV_ROUND_UP(MSEC_PER_SEC * drto_clks * drto_div,
+	drto_ms = DIV_ROUND_UP((u64)MSEC_PER_SEC * drto_clks * drto_div,
 			       host->bus_hz);
 
 	/* add a bit spare time */
-- 
2.11.0
