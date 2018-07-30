Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D6FCFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D200320893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pbn/53v1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D200320893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeG3NUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:20:42 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59267 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbeG3NUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:20:41 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180730114604euoutp0139c2df60288d191ef483d0ec93805485~GIvY4ds4u2326823268euoutp014;
        Mon, 30 Jul 2018 11:46:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180730114604euoutp0139c2df60288d191ef483d0ec93805485~GIvY4ds4u2326823268euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532951164;
        bh=KGwwtqmUWh4NU3kbbssJUZXV8FwEMojDgURHL1kiTpg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pbn/53v1V1U0ZtuDgN1SuM9S1vO6mtLIPeeZy4gz3Q9t1UqaqhZniNYsUpyawWYN4
         NAi+8ODMn4kQSQ6kkolzceijgDZgNbHa04DUIzvQrg++oCcz7eXNiEaFnyJPgLkLew
         Dcs2feieG7o58HIxdUyX9pGJyhjCptwd2QghYLRc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180730114603eucas1p213a9cd940683f350b3bdd5b827cef2ff~GIvYHhSmh1376613766eucas1p2z;
        Mon, 30 Jul 2018 11:46:03 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 03.11.61560.A7AFE5B5; Mon, 30
        Jul 2018 12:46:02 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180730114602eucas1p14b7cd9e90df341d88fa5d97ec74f005a~GIvXQ1jfj1728717287eucas1p1J;
        Mon, 30 Jul 2018 11:46:02 +0000 (GMT)
X-AuditID: cbfec7f5-207ff7000002f078-1c-5b5efa7a782b
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BE.6D.04183.A7AFE5B5; Mon, 30
        Jul 2018 12:46:02 +0100 (BST)
Received: from localhost.localdomain ([10.88.99.240]) by eusync3.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCO0073CGOG4E00@eusync3.samsung.com>; Mon, 30 Jul
        2018 12:46:02 +0100 (BST)
From:   Huijin Park <huijin.park@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huijin Park <huijin.park@samsung.com>, js07.lee@samsung.com,
        bbanghj.park@gmail.com
Subject: [PATCH] genhd: incrase size of disk stat counters
Date:   Mon, 30 Jul 2018 07:43:10 -0400
Message-id: <1532950990-1657-1-git-send-email-huijin.park@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplkeLIzCtJLcpLzFFi42LZduznOd2qX3HRBi/O61qsvtvPZvFy7yFm
        i46LLhaPbv5mtdh7S9vi8q45bA5sHjtn3WX3uHy21KNvyypGj8+b5AJYorhsUlJzMstSi/Tt
        ErgyJi4QKtipVfH/gngD43WlLkZODgkBE4l5O1pYuhi5OIQEVjBKTLv0lhXC+cwo0fd9GxtM
        1YHGj2wQiWWMEis/NTNBOH8ZJea/XMoOUsUmoC1xfe1WRhBbREBBouf3SrAOZoEpjBIb3v4A
        SwgLWEksX3WFCcRmEVCV+PhsEzOIzSvgJnF73homiHVyEjfPdTKDNEsI3GSV+DtxCitEwkVi
        3pU3LBC2sMSr41vYIWwZicuTu6Hi2RK/HrUC2RxAdoXE23kqEGFjiXdv14LtYhbgk5i0bToz
        RAmvREebEESJh8SdN8/BzhQSiJXo3fCTfQKjxAJGhlWM4qmlxbnpqcXGeanlesWJucWleel6
        yfm5mxiBkXT63/GvOxj3/Uk6xCjAwajEw5shFRctxJpYVlyZe4hRgoNZSYQ36X5stBBvSmJl
        VWpRfnxRaU5q8SFGaQ4WJXHeO/1A1QLpiSWp2ampBalFMFkmDk6pBsZ1yqv/deyxSLm6V4Xx
        HYOnYYNBgiT30gIn/udXm9QN+U9Nr5W2WLK5ehbzdIkVjx9wVfz3sFfqDf27skzwHHeOhijb
        duHyTWYhW0w8ts85nzgrUZPzTFTk4zUaW8NqZrDVPP1c8YzHhUOURXJ3WhT3p5Ql973P/62r
        +79yb2Nlf4Y8Q8eJo0osxRmJhlrMRcWJAMf1Oi6gAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIJMWRmVeSWpSXmKPExsVy+t/xq7pVv+KiDSa9ErRYfbefzeLl3kPM
        Fh0XXSwe3fzNarH3lrbF5V1z2BzYPHbOusvucflsqUffllWMHp83yQWwRHHZpKTmZJalFunb
        JXBlTFwgVLBTq+L/BfEGxutKXYycHBICJhIHGj+ydTFycQgJLGGUuNP9kgnC+c8o0Xj2FRtI
        FZuAtsT1tVsZQWwRAQWJnt8rwTqYBaYxSjyZ/osFJCEsYCWxfNUVJhCbRUBV4uOzTcwgNq+A
        m8TteWuYINbJSdw818k8gZFrASPDKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjECPbzv2c8sO
        xq53wYcYBTgYlXh4BSTiooVYE8uKK3MPMUpwMCuJ8Cbdj40W4k1JrKxKLcqPLyrNSS0+xCjN
        waIkznveoDJKSCA9sSQ1OzW1ILUIJsvEwSnVwKgb8Ov4rZmzV/0SW/IqabnRFC4zi6M8C8Tu
        K+1e6ibAr/CtU830yBLrGfEOq1bIv/50wf0Kg4F/gzLrr7WJ6pMMnn2bGC4ePIHtuql7WPK+
        U7temZ610UlUnqp3OO/vaRlr29OLXFcwqlirXk7IsNq8fcXDAjPJ/XvEb1ZzMtkqBioFPpaS
        YlViKc5INNRiLipOBACUCM3I9AEAAA==
X-CMS-MailID: 20180730114602eucas1p14b7cd9e90df341d88fa5d97ec74f005a
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180730114602eucas1p14b7cd9e90df341d88fa5d97ec74f005a
References: <CGME20180730114602eucas1p14b7cd9e90df341d88fa5d97ec74f005a@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huijin.park" <huijin.park@samsung.com>

The kernel's representation of the disk statistics uses different size
on 32b and 64b platforms. But the data size of io is not different
between 32b and 64b platforms. So in the 32b platform, it might happen
overflow earlier than 64b platform. Therefore, it seems like a better
approach would be to extend the length of the disk_stats structure on
32b architectures to 64b.

Signed-off-by: huijin.park <huijin.park@samsung.com>
---
 block/genhd.c             |   28 +++++++++++++++++++---------
 block/partition-generic.c |   31 +++++++++++++++++++------------
 include/linux/genhd.h     |   12 ++++++------
 3 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 8cc719a3..3e6d0c2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1334,27 +1334,37 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 		part_stat_unlock();
 		part_in_flight(gp->queue, hd, inflight);
 		seq_printf(seqf, "%4d %7d %s "
-			   "%lu %lu %lu %u "
-			   "%lu %lu %lu %u "
-			   "%u %u %u "
-			   "%lu %lu %lu %u\n",
+			   "%llu %llu %llu %llu "
+			   "%llu %llu %llu %llu "
+			   "%u %llu %llu "
+			   "%llu %llu %llu %llu\n",
 			   MAJOR(part_devt(hd)), MINOR(part_devt(hd)),
 			   disk_name(gp, hd->partno, buf),
 			   part_stat_read(hd, ios[STAT_READ]),
 			   part_stat_read(hd, merges[STAT_READ]),
 			   part_stat_read(hd, sectors[STAT_READ]),
-			   jiffies_to_msecs(part_stat_read(hd, ticks[STAT_READ])),
+			   div_u64(jiffies64_to_nsecs(part_stat_read(hd,
+							ticks[STAT_READ])),
+				   NSEC_PER_MSEC),
 			   part_stat_read(hd, ios[STAT_WRITE]),
 			   part_stat_read(hd, merges[STAT_WRITE]),
 			   part_stat_read(hd, sectors[STAT_WRITE]),
-			   jiffies_to_msecs(part_stat_read(hd, ticks[STAT_WRITE])),
+			   div_u64(jiffies64_to_nsecs(part_stat_read(hd,
+							ticks[STAT_WRITE])),
+				   NSEC_PER_MSEC),
 			   inflight[0],
-			   jiffies_to_msecs(part_stat_read(hd, io_ticks)),
-			   jiffies_to_msecs(part_stat_read(hd, time_in_queue)),
+			   div_u64(jiffies64_to_nsecs(part_stat_read(hd,
+							io_ticks)),
+				   NSEC_PER_MSEC),
+			   div_u64(jiffies64_to_nsecs(part_stat_read(hd,
+							time_in_queue)),
+				   NSEC_PER_MSEC),
 			   part_stat_read(hd, ios[STAT_DISCARD]),
 			   part_stat_read(hd, merges[STAT_DISCARD]),
 			   part_stat_read(hd, sectors[STAT_DISCARD]),
-			   jiffies_to_msecs(part_stat_read(hd, ticks[STAT_DISCARD]))
+			   div_u64(jiffies64_to_nsecs(part_stat_read(hd,
+							ticks[STAT_DISCARD])),
+				   NSEC_PER_MSEC)
 			);
 	}
 	disk_part_iter_exit(&piter);
diff --git a/block/partition-generic.c b/block/partition-generic.c
index 5a8975a..108b473 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -128,26 +128,33 @@ ssize_t part_stat_show(struct device *dev,
 	part_stat_unlock();
 	part_in_flight(q, p, inflight);
 	return sprintf(buf,
-		"%8lu %8lu %8llu %8u "
-		"%8lu %8lu %8llu %8u "
-		"%8u %8u %8u "
-		"%8lu %8lu %8llu %8u"
+		"%8llu %8llu %8llu %8llu "
+		"%8llu %8llu %8llu %8llu "
+		"%8u %8llu %8llu "
+		"%8llu %8llu %8llu %8llu"
 		"\n",
 		part_stat_read(p, ios[STAT_READ]),
 		part_stat_read(p, merges[STAT_READ]),
-		(unsigned long long)part_stat_read(p, sectors[STAT_READ]),
-		jiffies_to_msecs(part_stat_read(p, ticks[STAT_READ])),
+		part_stat_read(p, sectors[STAT_READ]),
+		div_u64(jiffies64_to_nsecs(part_stat_read(p, ticks[STAT_READ])),
+			NSEC_PER_MSEC),
 		part_stat_read(p, ios[STAT_WRITE]),
 		part_stat_read(p, merges[STAT_WRITE]),
-		(unsigned long long)part_stat_read(p, sectors[STAT_WRITE]),
-		jiffies_to_msecs(part_stat_read(p, ticks[STAT_WRITE])),
+		part_stat_read(p, sectors[STAT_WRITE]),
+		div_u64(jiffies64_to_nsecs(part_stat_read(p,
+							  ticks[STAT_WRITE])),
+			NSEC_PER_MSEC),
 		inflight[0],
-		jiffies_to_msecs(part_stat_read(p, io_ticks)),
-		jiffies_to_msecs(part_stat_read(p, time_in_queue)),
+		div_u64(jiffies64_to_nsecs(part_stat_read(p, io_ticks)),
+			NSEC_PER_MSEC),
+		div_u64(jiffies64_to_nsecs(part_stat_read(p, time_in_queue)),
+			NSEC_PER_MSEC),
 		part_stat_read(p, ios[STAT_DISCARD]),
 		part_stat_read(p, merges[STAT_DISCARD]),
-		(unsigned long long)part_stat_read(p, sectors[STAT_DISCARD]),
-		jiffies_to_msecs(part_stat_read(p, ticks[STAT_DISCARD])));
+		part_stat_read(p, sectors[STAT_DISCARD]),
+		div_u64(jiffies64_to_nsecs(part_stat_read(p,
+							  ticks[STAT_DISCARD])),
+			NSEC_PER_MSEC));
 }
 
 ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 5786442..d4cb798 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -83,12 +83,12 @@ struct partition {
 } __attribute__((packed));
 
 struct disk_stats {
-	unsigned long sectors[NR_STAT_GROUPS];
-	unsigned long ios[NR_STAT_GROUPS];
-	unsigned long merges[NR_STAT_GROUPS];
-	unsigned long ticks[NR_STAT_GROUPS];
-	unsigned long io_ticks;
-	unsigned long time_in_queue;
+	unsigned long long sectors[NR_STAT_GROUPS];
+	unsigned long long ios[NR_STAT_GROUPS];
+	unsigned long long merges[NR_STAT_GROUPS];
+	unsigned long long ticks[NR_STAT_GROUPS];
+	unsigned long long io_ticks;
+	unsigned long long time_in_queue;
 };
 
 #define PARTITION_META_INFO_VOLNAMELTH	64
-- 
1.7.9.5

