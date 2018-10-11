Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148F4C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7699620841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 07:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="OdY73tfQ";
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="OdY73tfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7699620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeJKOdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:33:08 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:48400 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725995AbeJKOdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:33:08 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id 9CAFB20BED;
        Thu, 11 Oct 2018 10:07:09 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net [2a02:6b8:0:1619::137])
        by mxbackcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id b1IpkaNjzF-79L8beHm;
        Thu, 11 Oct 2018 10:07:09 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1539241629; bh=DlLFE8ju7tTYfiIrLYAg+MjuEhwNdSLAzYQ/oBtFa34=;
        h=Subject:From:To:Date:Message-ID;
        b=OdY73tfQmhqr7GXZH/R9LKtzPvXrDWIz81XhAeIwFYBRPq68Pi0DDJzSZo7l5z8Ds
         a3eqI+2UOZV6ZTOZ4ooS0iRnPJNWfBqQEbRKA87ixYfIyYdOHv/OhrhCf4+RM3FOJV
         Eda8OqxFbq+65KaM7oux9d9LmmIQ7alyfOyD8BbY=
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:972:af14:8126:58e2])
        by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id H5xiTiYJ29-79JSnZaR;
        Thu, 11 Oct 2018 10:07:09 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1539241629; bh=DlLFE8ju7tTYfiIrLYAg+MjuEhwNdSLAzYQ/oBtFa34=;
        h=Subject:From:To:Date:Message-ID;
        b=OdY73tfQmhqr7GXZH/R9LKtzPvXrDWIz81XhAeIwFYBRPq68Pi0DDJzSZo7l5z8Ds
         a3eqI+2UOZV6ZTOZ4ooS0iRnPJNWfBqQEbRKA87ixYfIyYdOHv/OhrhCf4+RM3FOJV
         Eda8OqxFbq+65KaM7oux9d9LmmIQ7alyfOyD8BbY=
Authentication-Results: smtpcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH] block: describe difference between flags IO_STAT and STATS
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Date:   Thu, 11 Oct 2018 10:07:06 +0300
Message-ID: <153924162613.241965.12232363505207460166.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds reasonable comments, but they definitely needs better names.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/blkdev.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6980014357d4..4f8440dc469b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -108,7 +108,7 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_QUIET		((__force req_flags_t)(1 << 11))
 /* elevator private data attached */
 #define RQF_ELVPRIV		((__force req_flags_t)(1 << 12))
-/* account I/O stat */
+/* account into disk and partition IO statistics */
 #define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
 /* request came from our alloc pool */
 #define RQF_ALLOCED		((__force req_flags_t)(1 << 14))
@@ -116,7 +116,7 @@ typedef __u32 __bitwise req_flags_t;
 #define RQF_PM			((__force req_flags_t)(1 << 15))
 /* on IO scheduler merge hash */
 #define RQF_HASHED		((__force req_flags_t)(1 << 16))
-/* IO stats tracking on */
+/* track IO completion time */
 #define RQF_STATS		((__force req_flags_t)(1 << 17))
 /* Look at ->special_vec for the actual data payload instead of the
    bio chain. */
@@ -679,7 +679,7 @@ struct request_queue {
 #define QUEUE_FLAG_FAIL_IO	7	/* fake timeout */
 #define QUEUE_FLAG_NONROT	9	/* non-rotational device (SSD) */
 #define QUEUE_FLAG_VIRT        QUEUE_FLAG_NONROT /* paravirt device */
-#define QUEUE_FLAG_IO_STAT     10	/* do IO stats */
+#define QUEUE_FLAG_IO_STAT     10	/* do disk/partitions IO accounting */
 #define QUEUE_FLAG_DISCARD     11	/* supports DISCARD */
 #define QUEUE_FLAG_NOXMERGES   12	/* No extended merges */
 #define QUEUE_FLAG_ADD_RANDOM  13	/* Contributes to random pool */
@@ -693,7 +693,7 @@ struct request_queue {
 #define QUEUE_FLAG_FUA	       21	/* device supports FUA writes */
 #define QUEUE_FLAG_FLUSH_NQ    22	/* flush not queueuable */
 #define QUEUE_FLAG_DAX         23	/* device supports DAX */
-#define QUEUE_FLAG_STATS       24	/* track rq completion times */
+#define QUEUE_FLAG_STATS       24	/* track IO start and completion times */
 #define QUEUE_FLAG_POLL_STATS  25	/* collecting stats for hybrid polling */
 #define QUEUE_FLAG_REGISTERED  26	/* queue has been registered to a disk */
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */

