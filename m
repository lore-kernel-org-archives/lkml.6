Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD08C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6681B21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j33Rz5OU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6681B21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbeJSCFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbeJSCFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:05:17 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00F7A2148D;
        Thu, 18 Oct 2018 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885790;
        bh=s+bohfJI/87q/O1UVJbNvRH2rCtvI+GODMrGehFB2jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j33Rz5OU1NbRch4uyPvrsrKd7+ffKhFeQznXAg2k1kdHyVlLabVLQ6W0SQCps7ZU2
         sJ4WcB9Afmj6H3MAQ5FH75P+lNceJpSXYDP2HIRxMrmVo/VNpA2wJiKVMjCc/1oelQ
         9beRNMKa6rTrdoKxqVZXrZrfJ0D5W/9Csqc3XlcI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sven Eckelmann <sven@narfation.org>,
        Marek Lindner <mareklindner@neomailbox.ch>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 02/35] batman-adv: Fix segfault when writing to throughput_override
Date:   Thu, 18 Oct 2018 19:54:31 +0200
Message-Id: <20181018175422.793287919@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

[ Upstream commit b9fd14c20871e6189f635e49b32d7789e430b3c8 ]

The per hardif sysfs file "batman_adv/throughput_override" prints the
resulting change as info text when the users writes to this file. It uses
the helper function batadv_info to add it at the same time to the kernel
ring buffer and to the batman-adv debug log (when CONFIG_BATMAN_ADV_DEBUG
is enabled).

The function batadv_info requires as first parameter the batman-adv softif
net_device. This parameter is then used to find the private buffer which
contains the debug log for this batman-adv interface. But
batadv_store_throughput_override used as first argument the slave
net_device. This slave device doesn't have the batadv_priv private data
which is access by batadv_info.

Writing to this file with CONFIG_BATMAN_ADV_DEBUG enabled can either lead
to a segfault or to memory corruption.

Fixes: 0b5ecc6811bd ("batman-adv: add throughput override attribute to hard_ifaces")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Acked-by: Marek Lindner <mareklindner@neomailbox.ch>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/sysfs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1084,8 +1084,9 @@ static ssize_t batadv_store_throughput_o
 	if (old_tp_override == tp_override)
 		goto out;
 
-	batadv_info(net_dev, "%s: Changing from: %u.%u MBit to: %u.%u MBit\n",
-		    "throughput_override",
+	batadv_info(hard_iface->soft_iface,
+		    "%s: %s: Changing from: %u.%u MBit to: %u.%u MBit\n",
+		    "throughput_override", net_dev->name,
 		    old_tp_override / 10, old_tp_override % 10,
 		    tp_override / 10, tp_override % 10);
 


