Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB49C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970512082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TusO8oMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970512082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbeK3BX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:23:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730527AbeK3BX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BE85205C9;
        Thu, 29 Nov 2018 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501077;
        bh=qgAuFzBF0SWyyW8iNrQcgoPTTuS+XxDqG/RWBFvKnAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TusO8oMi8L33QbX4eYLZ741EoUfNCju0z4GwbAgoa1E17K5FVQ96eq7Zi2Fs7foan
         NkvTv2ri8bYDpdLCkjud4JOSPLwnVN0gD3zW33ZjQKK6a71YfO8TdGfpAKZNbEor5q
         GvzG2Nxq2XoQ3h3nPILkr4ezZWwxh0VtN8LY4EhY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Clement Calmels <clement.calmels@free.fr>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 32/86] Input: xpad - remove spurious events of wireless xpad 360 controller
Date:   Thu, 29 Nov 2018 15:11:57 +0100
Message-Id: <20181129140112.723108661@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 93a017aa2f77291752e637bfd83f2459dba714cb ]

When powering up a wireless xbox 360 controller, some wrong joystick
events are generated. It is annoying because, for example, it makes
unwanted moves in Steam big picture mode's menu.

When my controller is powering up, this packet is received by the
driver:
00000000: 00 0f 00 f0 00 cc ff cf 8b e0 86 6a 68 f0 00 20  ...........jh..
00000010: 13 e3 20 1d 30 03 40 01 50 01 ff ff              .. .0.@.P...

According to xboxdrv userspace driver source code, this packet is only
dumping a serial id and should not be interpreted as joystick events.
This issue can be easily seen with jstest:
$ jstest --event /dev/input/js0

This patch only adds a way to filter out this "serial" packet and as a
result it removes the spurous events.

Signed-off-by: Clement Calmels <clement.calmels@free.fr>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 3258baf3282e..2f16d07db8ef 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -546,7 +546,7 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 	}
 
 	/* Valid pad data */
-	if (!(data[1] & 0x1))
+	if (data[1] != 0x1)
 		return;
 
 	xpad360_process_packet(xpad, cmd, &data[4]);
-- 
2.17.1



