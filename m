Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9667C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F741208EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F741208EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeHUAez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:34:55 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:46868
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbeHUAez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:34:55 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id rrXVfaJmEVktnrrXVf6yz3; Mon, 20 Aug 2018 14:16:41 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1frrXV-0001Wr-I9; Mon, 20 Aug 2018 14:16:41 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        "K . Y . Srinivasan" <kys@microsoft.com>, stable@vger.kernel.org
Subject: [PATCH] vmbus: don't return values for uninitalized channels
Date:   Mon, 20 Aug 2018 21:16:40 +0000
Message-Id: <20180820211640.5837-1-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfDkzshGT77mbFDdXSsKT4apJJApotcPT84Hywvd191Wwi4kfQVeenwpYEfdaMfTPoDQWFAtTW/iMd/oblBFH3u8Vx+zRacbQnbr+lUS4UyggkpWBzrOU
 AypueXvtfmYMccsBFOyn6vHOckVejxKfOyv4I4h+dIUSM3U9L0dY/jc2CfMSR85wu5tsI77Q9dDH7NF0ZrQeBNUHLeoCgE6tO1tSxFjAzWlOmr+771Fuheww
 s7806HNp10s/pNy6WRkcnD18PfunYcXu9jDiNpllqypYU1PsHZuWcND4ngIipbECvERdKoY+6d0SRcdBylrjoREEHGFn9coHNRsfEYRt6EbiC65bZ6QF7Bm+
 X9OYKJ9W9MqPDKZuSHNIqoLQvxNmUf8/BoNjwvElYlcL0iQs5jFKy7aNczYfXEMrjFTwLt/l7sNNmlxcGiXcVw8Nm/ZXLEG0cu2rMfuYtO+/P/MwB//xPJVZ
 z2NT93548KMHD6OnTElW9O32wTZrIU5mAMoXpv1/yyUnKcxTaI/QBa0EiBnFVTSPEmug6E26UcSeueC4Xj8q2pr8WaMJOB6DWDrd7XKsSa0TPFIPnq8OYorQ
 sVMJN3zgd1z+pukrGdHqeJtA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>

For unsupported device types, the vmbus channel ringbuffer is never
initialized, and therefore reading the sysfs files will return garbage
or cause a kernel OOPS.

Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Cc: <stable@vger.kernel.org> # 4.15
---
 drivers/hv/vmbus_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index e6d8fdac6d8b..4bbc420d1213 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1368,6 +1368,9 @@ static ssize_t vmbus_chan_attr_show(struct kobject *kobj,
 	if (!attribute->show)
 		return -EIO;
 
+	if (chan->state != CHANNEL_OPENED_STATE)
+		return -EINVAL;
+
 	return attribute->show(chan, buf);
 }
 
-- 
2.18.0

