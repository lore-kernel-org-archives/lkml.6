Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787A8C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BC220685
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BC220685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbeIXRmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:42:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50896 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbeIXRmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:42:37 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1A6BD1070;
        Mon, 24 Sep 2018 11:40:56 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ritesh Harjani <riteshh@codeaurora.org>,
        Jens Axboe <axboe@kernel.dk>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 3.18 034/105] cfq: Give a chance for arming slice idle timer in case of group_idle
Date:   Mon, 24 Sep 2018 13:33:20 +0200
Message-Id: <20180924113117.274825740@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113113.268650190@linuxfoundation.org>
References: <20180924113113.268650190@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ritesh Harjani <riteshh@codeaurora.org>

commit b3193bc0dca9bb69c8ba1ec1a318105c76eb4172 upstream.

In below scenario blkio cgroup does not work as per their assigned
weights :-
1. When the underlying device is nonrotational with a single HW queue
with depth of >= CFQ_HW_QUEUE_MIN
2. When the use case is forming two blkio cgroups cg1(weight 1000) &
cg2(wight 100) and two processes(file1 and file2) doing sync IO in
their respective blkio cgroups.

For above usecase result of fio (without this patch):-
file1: (groupid=0, jobs=1): err= 0: pid=685: Thu Jan  1 19:41:49 1970
  write: IOPS=1315, BW=41.1MiB/s (43.1MB/s)(1024MiB/24906msec)
<...>
file2: (groupid=0, jobs=1): err= 0: pid=686: Thu Jan  1 19:41:49 1970
  write: IOPS=1295, BW=40.5MiB/s (42.5MB/s)(1024MiB/25293msec)
<...>
// both the process BW is equal even though they belong to diff.
cgroups with weight of 1000(cg1) and 100(cg2)

In above case (for non rotational NCQ devices),
as soon as the request from cg1 is completed and even
though it is provided with higher set_slice=10, because of CFQ
algorithm when the driver tries to fetch the request, CFQ expires
this group without providing any idle time nor weight priority
and schedules another cfq group (in this case cg2).
And thus both cfq groups(cg1 & cg2) keep alternating to get the
disk time and hence loses the cgroup weight based scheduling.

Below patch gives a chance to cfq algorithm (cfq_arm_slice_timer)
to arm the slice timer in case group_idle is enabled.
In case if group_idle is also not required (including for nonrotational
NCQ drives), we need to explicitly set group_idle = 0 from sysfs for
such cases.

With this patch result of fio(for above usecase) :-
file1: (groupid=0, jobs=1): err= 0: pid=690: Thu Jan  1 00:06:08 1970
  write: IOPS=1706, BW=53.3MiB/s (55.9MB/s)(1024MiB/19197msec)
<..>
file2: (groupid=0, jobs=1): err= 0: pid=691: Thu Jan  1 00:06:08 1970
  write: IOPS=1043, BW=32.6MiB/s (34.2MB/s)(1024MiB/31401msec)
<..>
// In this processes BW is as per their respective cgroups weight.

Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/cfq-iosched.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -2728,7 +2728,8 @@ static void cfq_arm_slice_timer(struct c
 	 * for devices that support queuing, otherwise we still have a problem
 	 * with sync vs async workloads.
 	 */
-	if (blk_queue_nonrot(cfqd->queue) && cfqd->hw_tag)
+	if (blk_queue_nonrot(cfqd->queue) && cfqd->hw_tag &&
+		!cfqd->cfq_group_idle)
 		return;
 
 	WARN_ON(!RB_EMPTY_ROOT(&cfqq->sort_list));


