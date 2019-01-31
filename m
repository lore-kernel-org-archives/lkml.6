Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB09C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EDA32085B
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbfAaNlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 08:41:08 -0500
Received: from vrout10-bl2.yaziba.net ([185.56.204.56]:46780 "EHLO
        vrout10.yaziba.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387821AbfAaNkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 08:40:15 -0500
X-Greylist: delayed 1117 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Jan 2019 08:40:14 EST
Received: from mtaout10.int.yaziba.net (mtaout10.int.yaziba.net [10.4.20.36])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by vrout10.yaziba.net (mx10.yaziba.net) with ESMTPS id 8FDF651F11;
        Thu, 31 Jan 2019 14:21:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mtaout10.int.yaziba.net (Postfix) with ESMTP id 9F411160316;
        Thu, 31 Jan 2019 14:21:35 +0100 (CET)
Received: from mtaout10.int.yaziba.net ([127.0.0.1])
        by localhost (mtaout10.int.yaziba.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cPJjs-uYRbwB; Thu, 31 Jan 2019 14:21:35 +0100 (CET)
Received: from archlinux.softathome.com (unknown [149.6.166.170])
        by mtaout10.int.yaziba.net (Postfix) with ESMTPSA id 7CD6A160315;
        Thu, 31 Jan 2019 14:21:35 +0100 (CET)
From:   alexandre.besnard@softathome.com
To:     davem@davemloft.net, ktkhai@virtuozzo.com, ecree@solarflare.com,
        jiri@mellanox.com, petrm@mellanox.com, alexander.h.duyck@intel.com,
        amritha.nambiar@intel.com, lirongqing@baidu.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Besnard <alexandre.besnard@softathome.com>
Subject: [PATCH] net: check negative value for signed refcnt
Date:   Thu, 31 Jan 2019 14:20:08 +0100
Message-Id: <20190131132008.23161-1-alexandre.besnard@softathome.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLAMAV-SCAN: ok
X-VRSPAM-SCORE: -100
X-VRSPAM-STATE: legit
X-VRSPAM-CAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrjeeigdehvdcutefuodetggdotefrucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpegrlhgvgigrnhgurhgvrdgsvghsnhgrrhgusehsohhfthgrthhhohhmvgdrtghomhenucfkphepudegledriedrudeiiedrudejtdenucfrrghrrghmpehmohguvgepshhmthhpohhuth
X-VRSPAM-EXTCAUSE: mhhouggvpehsmhhtphhouhht
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Besnard <alexandre.besnard@softathome.com>

Device remaining references counter is get as a signed integer.

When unregistering network devices, the loop waiting for this counter
to decrement tests the 0 strict equality. Thus if an error occurs and
two references are given back by a protocol, we are stuck in the loop
forever, with a -1 value.

Robustness is added by checking a negative value: the device is then
considered free of references, and a warning is issued (it should not
happen, one should check that behavior)

Signed-off-by: Alexandre Besnard <alexandre.besnard@softathome.com>
---
 net/core/dev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index ddc551f..e4190ae 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8687,6 +8687,11 @@ static void netdev_wait_allrefs(struct net_device *dev)
 	refcnt = netdev_refcnt_read(dev);

 	while (refcnt != 0) {
+		if (refcnt < 0) {
+			pr_warn("Device %s refcnt negative: device considered free, but it should not happen\n",
+				dev->name);
+			break;
+		}
 		if (time_after(jiffies, rebroadcast_time + 1 * HZ)) {
 			rtnl_lock();

--
2.7.4

