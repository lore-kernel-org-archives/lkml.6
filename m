Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5E4C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F04A20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F04A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeLCXg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:36:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbeLCXgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:36:23 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78B5D307EA90;
        Mon,  3 Dec 2018 23:36:22 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-188.rdu2.redhat.com [10.10.120.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 296FE60566;
        Mon,  3 Dec 2018 23:36:19 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Haggai Eran <haggaie@mellanox.com>,
        Balbir Singh <balbirs@au1.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Paul Blinzer <Paul.Blinzer@amd.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Vivek Kini <vkini@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [RFC PATCH 12/14] mm/hbind: add migrate command to hbind() ioctl
Date:   Mon,  3 Dec 2018 18:35:07 -0500
Message-Id: <20181203233509.20671-13-jglisse@redhat.com>
In-Reply-To: <20181203233509.20671-1-jglisse@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 03 Dec 2018 23:36:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

This patch add migrate commands to hbind() ioctl, user space can use
this commands to migrate a range of virtual address to list of target
memory.

This does not change the policy for the range, it also ignores any of
the existing policy range, it does not changes the policy for the
range.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Haggai Eran <haggaie@mellanox.com>
Cc: Balbir Singh <balbirs@au1.ibm.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Philip Yang <Philip.Yang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Paul Blinzer <Paul.Blinzer@amd.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>
Cc: Vivek Kini <vkini@nvidia.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
---
 include/uapi/linux/hbind.h |  9 ++++++++
 mm/hms.c                   | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/uapi/linux/hbind.h b/include/uapi/linux/hbind.h
index 7bb876954e3f..ededbba22121 100644
--- a/include/uapi/linux/hbind.h
+++ b/include/uapi/linux/hbind.h
@@ -57,6 +57,15 @@ struct hbind_params {
  */
 #define HBIND_CMD_BIND 1
 
+/*
+ * HBIND_CMD_MIGRATE move existing memory to use listed target memory. This is
+ * a best effort.
+ *
+ * Additional dwords:
+ *      [0] result ie number of pages that have been migrated.
+ */
+#define HBIND_CMD_MIGRATE 2
+
 
 #define HBIND_IOCTL		_IOWR('H', 0x00, struct hbind_params)
 
diff --git a/mm/hms.c b/mm/hms.c
index 6be6f4acdd49..6764908f47bf 100644
--- a/mm/hms.c
+++ b/mm/hms.c
@@ -368,6 +368,39 @@ static int hbind_bind(struct mm_struct *mm, struct hbind_params *params,
 }
 
 
+static int hbind_migrate(struct mm_struct *mm, struct hbind_params *params,
+			 const uint32_t *targets, uint32_t *atoms)
+{
+	unsigned long size, npages;
+	int ret = -EINVAL;
+	unsigned i;
+
+	size = PAGE_ALIGN(params->end) - (params->start & PAGE_MASK);
+	npages = size >> PAGE_SHIFT;
+
+	for (i = 0; params->ntargets; ++i) {
+		struct hms_target *target;
+
+		target = hms_target_find(targets[i]);
+		if (target == NULL)
+			continue;
+
+		ret = target->hbind->migrate(target, mm, params->start,
+					     params->end, params->natoms,
+					     atoms);
+		hms_target_put(target);
+
+		if (ret)
+			continue;
+
+		if (atoms[0] >= npages)
+			break;
+	}
+
+	return ret;
+}
+
+
 static long hbind_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
 	uint32_t *targets, *_dtargets = NULL, _ftargets[HBIND_FIX_ARRAY];
@@ -458,6 +491,16 @@ static long hbind_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 			if (ret)
 				goto out_mm;
 			break;
+		case HBIND_CMD_MIGRATE:
+			if (ndwords != 2) {
+				ret = -EINVAL;
+				goto out_mm;
+			}
+			ret = hbind_migrate(current->mm, &params,
+					    targets, atoms);
+			if (ret)
+				goto out_mm;
+			break;
 		default:
 			ret = -EINVAL;
 			goto out_mm;
-- 
2.17.2

