Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9970C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7391720855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 09:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Ma23cGbX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7391720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeKYU2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:28:31 -0500
Received: from onstation.org ([52.200.56.107]:43218 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbeKYU2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 15:28:31 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id D1EB657D;
        Sun, 25 Nov 2018 09:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1543138670;
        bh=0HR8EpxO2GEdmafSntDoyckcx8FOlg951VyJc3pZ5Lw=;
        h=Date:From:To:Cc:Subject:From;
        b=Ma23cGbXdq6/tZc9DMKKZ+zNX/aBkB1OFjQUxXOy4bjyX7PLgdE/nnF9fJBH3tyjk
         uLpw8kaQ7YuHhKCAvBnMFgFtAkUfk4/GD5JyjRMD/qNRDAKxrV1O1UGg8BADlkm04T
         zLI9XM1GoWRmgzsmhlAelK2YfpHHVWRPWBLl75UQ=
Date:   Sun, 25 Nov 2018 04:37:50 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Question about "regulator: core: Only count load for enabled
 consumers" in -next
Message-ID: <20181125093750.GA28055@basecamp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I see errors like the following in linux next-20181123 when trying to
boot a mainline kernel on a LG Nexus 5 phone:

[   14.495056] mmc1: Card stuck in wrong state! mmcblk1 card_busy_detect status: 0xe00
[   14.495185] mmc1: cache flush error -110
[   14.601547] mmc1: Reset 0x1 never completed.
[   14.601572] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[   14.604882] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00003802
[   14.611240] mmc1: sdhci: Blk size:  0x00004000 | Blk cnt:  0x00000000
[   14.617664] mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
[   14.624064] mmc1: sdhci: Present:   0x01e80000 | Host ctl: 0x00000000
[   14.630508] mmc1: sdhci: Power:     0x00000000 | Blk gap:  0x00000000
[   14.636930] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000003
[   14.643335] mmc1: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
[   14.649778] mmc1: sdhci: Int enab:  0x00000000 | Sig enab: 0x00000000
[   14.656200] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[   14.662606] mmc1: sdhci: Caps:      0x642dc8b2 | Caps_1:   0x00008007
[   14.669051] mmc1: sdhci: Cmd:       0x00000000 | Max curr: 0x00000000
[   14.675469] mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
[   14.681877] mmc1: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[   14.688320] mmc1: sdhci: Host ctl2: 0x00000000
[   14.694720] mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x70042330
[   14.699080] mmc1: sdhci: ============================================

I bisected the issue to the following commit:

5451781dadf8 ("regulator: core: Only count load for enabled consumers")

We have to increase the load for the sdhci in device tree in order for
the phone to boot properly. This change was made with the commit:

03864e57770a ("ARM: dts: qcom: msm8974-hammerhead: increase load on l20
for sdhci")

Is there a change that I should make in device tree to get the SD card
working again on the phone?

Thanks,

Brian
