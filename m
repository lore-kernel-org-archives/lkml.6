Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AE2C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051E02087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079172;
	bh=98OTRqafMgqhZ0Zntq+roO5MwbjzFSroaZw8PesDdy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VXmp05FHnpy9h41Tk7hZUXkSro0EkKGSlgG+0+dayD6xf8TQTvcQY5N3xu1MzpmNQ
	 KxXucfEn8FROs0DIIJI78/hDOPIleNATv+qP77ssxtFLICPJkOph6er3AyyC4sY2w7
	 mxiRqqVOEnFYOmvgPnCf5PAwAMR7LPoHy32q+CY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbfAUN7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:59:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731351AbfAUN71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:59:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3B7E2084C;
        Mon, 21 Jan 2019 13:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079167;
        bh=98OTRqafMgqhZ0Zntq+roO5MwbjzFSroaZw8PesDdy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1x9IeEXWg/fOmtXIobT4LTe8XKFg2A22qAEU7mxVEP+LVm+h/SVrBE+M20FAvgXSs
         0Ar1IrQvRoQGv4oMG9vDCRDiAuHovg+IGBJ7qKqJaXSQLfU5jkeg6IZzg+Cx5fpmwj
         x+GGdjayHIzdYrtKkuxqxINj6Www8LzI9qhrwpV4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 30/99] r8169: load Realtek PHY driver module before r8169
Date:   Mon, 21 Jan 2019 14:48:22 +0100
Message-Id: <20190121134915.043367282@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 11287b693d03830010356339e4ceddf47dee34fa ]

This soft dependency works around an issue where sometimes the genphy
driver is used instead of the dedicated PHY driver. The root cause of
the issue isn't clear yet. People reported the unloading/re-loading
module r8169 helps, and also configuring this soft dependency in
the modprobe config files. Important just seems to be that the
realtek module is loaded before r8169.

Once this has been applied preliminary fix 38af4b903210 ("net: phy:
add workaround for issue where PHY driver doesn't bind to the device")
will be removed.

Fixes: f1e911d5d0df ("r8169: add basic phylib support")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -717,6 +717,7 @@ module_param(use_dac, int, 0);
 MODULE_PARM_DESC(use_dac, "Enable PCI DAC. Unsafe on 32 bit PCI slot.");
 module_param_named(debug, debug.msg_enable, int, 0);
 MODULE_PARM_DESC(debug, "Debug verbosity level (0=none, ..., 16=all)");
+MODULE_SOFTDEP("pre: realtek");
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE(FIRMWARE_8168D_1);
 MODULE_FIRMWARE(FIRMWARE_8168D_2);


