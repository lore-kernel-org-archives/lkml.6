Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0294ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B862146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B862146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbeIREcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:32:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48810 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbeIREcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:32:47 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6F1DFC03;
        Mon, 17 Sep 2018 23:03:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jinbum Park <jinb.park7@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 069/126] pktcdvd: Fix possible Spectre-v1 for pkt_devs
Date:   Tue, 18 Sep 2018 00:41:57 +0200
Message-Id: <20180917211708.811442655@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jinbum Park <jinb.park7@gmail.com>

[ Upstream commit 55690c07b44a82cc3359ce0c233f4ba7d80ba145 ]

User controls @dev_minor which to be used as index of pkt_devs.
So, It can be exploited via Spectre-like attack. (speculative execution)

This kind of attack leaks address of pkt_devs, [1]
It leads an attacker to bypass security mechanism such as KASLR.

So sanitize @dev_minor before using it to prevent attack.

[1] https://github.com/jinb-park/linux-exploit/
tree/master/exploit-remaining-spectre-gadget/leak_pkt_devs.c

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/pktcdvd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -67,7 +67,7 @@
 #include <scsi/scsi.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
-
+#include <linux/nospec.h>
 #include <linux/uaccess.h>
 
 #define DRIVER_NAME	"pktcdvd"
@@ -2231,6 +2231,8 @@ static struct pktcdvd_device *pkt_find_d
 {
 	if (dev_minor >= MAX_WRITERS)
 		return NULL;
+
+	dev_minor = array_index_nospec(dev_minor, MAX_WRITERS);
 	return pkt_devs[dev_minor];
 }
 


