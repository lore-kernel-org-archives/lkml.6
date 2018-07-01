Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E691AC6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB882251EB
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 11:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB882251EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeGALND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 07:13:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:47714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752031AbeGALI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 07:08:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8B3BCAE55;
        Sun,  1 Jul 2018 11:08:57 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     netdev@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        Jiri Pirko <jiri@resnulli.us>,
        Marcel Holtmann <marcel@holtmann.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Janus Piwek <jpiwek@arroweurope.com>,
        =?UTF-8?q?Michael=20R=C3=B6der?= <michael.roeder@avnet.eu>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [RFC net-next 05/15] HACK: net: lora: Deal with .poll_mask in 4.18-rc2
Date:   Sun,  1 Jul 2018 13:07:54 +0200
Message-Id: <20180701110804.32415-6-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180701110804.32415-1-afaerber@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux-next and 4.18-rc2 both identify as LINUX_VERSION(4,18,0), but
commit a11e1d432b51f63ba698d044441284a661f01144 (Revert changes to
convert to ->poll_mask() and aio IOCB_CMD_POLL) reverted .poll_mask
to .poll again.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 net/lora/dgram.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/lora/dgram.c b/net/lora/dgram.c
index 4d931fd3778a..ef56fd90e762 100644
--- a/net/lora/dgram.c
+++ b/net/lora/dgram.c
@@ -217,7 +217,11 @@ const struct proto_ops dgram_proto_ops = {
 	.socketpair	= sock_no_socketpair,
 	.accept		= sock_no_accept,
 	.getname	= dgram_getname,
+#if 0 /* LINUX_VERSION_CODE >= LINUX_VERSION(4, 18, 0) */
+	.poll_mask	= datagram_poll_mask,
+#else
 	.poll		= datagram_poll,
+#endif
 	.ioctl		= dgram_ioctl,
 	.listen		= sock_no_listen,
 	.shutdown	= sock_no_shutdown,
-- 
2.16.4

