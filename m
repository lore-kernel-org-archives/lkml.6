Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894B6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D5E20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D5E20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbeLCXgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:36:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbeLCXgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:36:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 05B5D87629;
        Mon,  3 Dec 2018 23:36:19 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-188.rdu2.redhat.com [10.10.120.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3704600C1;
        Mon,  3 Dec 2018 23:36:15 +0000 (UTC)
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
Subject: [RFC PATCH 11/14] mm/hbind: add bind command to heterogeneous memory policy
Date:   Mon,  3 Dec 2018 18:35:06 -0500
Message-Id: <20181203233509.20671-12-jglisse@redhat.com>
In-Reply-To: <20181203233509.20671-1-jglisse@redhat.com>
References: <20181203233509.20671-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 03 Dec 2018 23:36:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

This patch add bind command to hbind() ioctl, this allow to bind a
range of virtual address to given list of target memory. New memory
allocated in the range will try to use memory from the target memory
list.

Note that this patch does not modify existing page fault path and thus
does not activate new heterogeneous policy. Updating the CPU page fault
code path or device page fault code path (HMM) will be done in separate
patches.

Here we only introduce helpers and infrastructure that will be use by
page fault code path.

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
 include/uapi/linux/hbind.h | 10 ++++++++++
 mm/hms.c                   | 40 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/uapi/linux/hbind.h b/include/uapi/linux/hbind.h
index cc4687587f5a..7bb876954e3f 100644
--- a/include/uapi/linux/hbind.h
+++ b/include/uapi/linux/hbind.h
@@ -47,6 +47,16 @@ struct hbind_params {
  */
 #define HBIND_CMD_DEFAULT 0
 
+/*
+ * HBIND_CMD_BIND strict policy ie new allocations will comes from one of the
+ * listed targets until they run of memory. Other targets can be use if the
+ * none of the listed targets can be accessed by the initiator that did fault.
+ *
+ * Additional dwords:
+ *      NONE (DWORDS MUST BE 0 !)
+ */
+#define HBIND_CMD_BIND 1
+
 
 #define HBIND_IOCTL		_IOWR('H', 0x00, struct hbind_params)
 
diff --git a/mm/hms.c b/mm/hms.c
index be2c4e526f25..6be6f4acdd49 100644
--- a/mm/hms.c
+++ b/mm/hms.c
@@ -338,6 +338,36 @@ static struct hms_policy *hms_policy_get(struct mm_struct *mm)
 }
 
 
+static int hbind_bind(struct mm_struct *mm, struct hbind_params *params,
+		      const uint32_t *targets, uint32_t *atoms)
+{
+	struct hms_policy_range *prange;
+	struct hms_policy *hpolicy;
+	int ret;
+
+	hpolicy = hms_policy_get(mm);
+	if (hpolicy == NULL)
+		return -ENOMEM;
+
+	prange = hms_policy_range_new(targets, params->start, params->end,
+				      params->ntargets);
+	if (prange == NULL)
+		return -ENOMEM;
+
+	down_write(&hpolicy->sem);
+	ret = hbind_default_locked(hpolicy, params);
+	if (ret)
+		goto out;
+
+	interval_tree_insert(&prange->node, &hpolicy->ranges);
+
+out:
+	up_write(&hpolicy->sem);
+
+	return ret;
+}
+
+
 static long hbind_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
 	uint32_t *targets, *_dtargets = NULL, _ftargets[HBIND_FIX_ARRAY];
@@ -418,6 +448,16 @@ static long hbind_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 			if (ret)
 				goto out_mm;
 			break;
+		case HBIND_CMD_BIND:
+			if (ndwords != 1) {
+				ret = -EINVAL;
+				goto out_mm;
+			}
+			ret = hbind_bind(current->mm, &params,
+					 targets, atoms);
+			if (ret)
+				goto out_mm;
+			break;
 		default:
 			ret = -EINVAL;
 			goto out_mm;
-- 
2.17.2

