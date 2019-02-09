Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1019AC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0AF21916
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738128;
	bh=ArKN5lGSVrm1Im/GtslV+Q9YX5p/4swjLHVDUfSJjSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nlw0mDKkEzVIhcicB5JD3bARs9ltdBd9Ny8azuOhK2GOl7f6IK0kIuYAVd8S1rHbU
	 lG5QJmrPC8CGW4wvsdg8Hl1jjs9uZzEmB+/klhjhQhJ54BrE2pLUSmIpHTFqhEK2LU
	 qiVoHMHKXd2DP5UP2HZ/3ci+dOCXr2RXiBCCKHEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfBISss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:48:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbfBISso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:48:44 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F3F421916;
        Sat,  9 Feb 2019 18:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738123;
        bh=ArKN5lGSVrm1Im/GtslV+Q9YX5p/4swjLHVDUfSJjSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lF7PF7Uem9MNQRWVRuQd/CBHfbFIBOHOS+Muohb03ybiA9hRQkcBm7EKt2tIu7dic
         h70T+RShmakD17BdCp/Ak2STeeDMWeAuREyDZSJ80xXGh7oZ8NQf55vPVNq4ldfTzW
         Lmc13CzYwFYY4UcXEyphfiD98sR6gIBtV06F7JuY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 02/28] ACPI: NUMA: Use correct type for printing addresses on i386-PAE
Date:   Sat,  9 Feb 2019 13:48:10 -0500
Message-Id: <20190209184840.126418-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184840.126418-1-sashal@kernel.org>
References: <20190209184840.126418-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Fan <fanc.fnst@cn.fujitsu.com>

[ Upstream commit b9ced18acf68dffebe6888c7ec765a2b1db7a039 ]

The addresses of NUMA nodes are not printed correctly on i386-PAE
which is misleading.

Here is a debian9-32bit with PAE in a QEMU guest having more than 4G
of memory:

qemu-system-i386 \
-hda /var/lib/libvirt/images/debian32.qcow2 \
-m 5G \
-enable-kvm \
-smp 10 \
-numa node,mem=512M,nodeid=0,cpus=0 \
-numa node,mem=512M,nodeid=1,cpus=1 \
-numa node,mem=512M,nodeid=2,cpus=2 \
-numa node,mem=512M,nodeid=3,cpus=3 \
-numa node,mem=512M,nodeid=4,cpus=4 \
-numa node,mem=512M,nodeid=5,cpus=5 \
-numa node,mem=512M,nodeid=6,cpus=6 \
-numa node,mem=512M,nodeid=7,cpus=7 \
-numa node,mem=512M,nodeid=8,cpus=8 \
-numa node,mem=512M,nodeid=9,cpus=9 \
-serial stdio

Because of the wrong value type, it prints as below:

[    0.021049] ACPI: SRAT Memory (0x0 length 0xa0000) in proximity domain 0 enabled
[    0.021740] ACPI: SRAT Memory (0x100000 length 0x1ff00000) in proximity domain 0 enabled
[    0.022425] ACPI: SRAT Memory (0x20000000 length 0x20000000) in proximity domain 1 enabled
[    0.023092] ACPI: SRAT Memory (0x40000000 length 0x20000000) in proximity domain 2 enabled
[    0.023764] ACPI: SRAT Memory (0x60000000 length 0x20000000) in proximity domain 3 enabled
[    0.024431] ACPI: SRAT Memory (0x80000000 length 0x20000000) in proximity domain 4 enabled
[    0.025104] ACPI: SRAT Memory (0xa0000000 length 0x20000000) in proximity domain 5 enabled
[    0.025791] ACPI: SRAT Memory (0x0 length 0x20000000) in proximity domain 6 enabled
[    0.026412] ACPI: SRAT Memory (0x20000000 length 0x20000000) in proximity domain 7 enabled
[    0.027118] ACPI: SRAT Memory (0x40000000 length 0x20000000) in proximity domain 8 enabled
[    0.027802] ACPI: SRAT Memory (0x60000000 length 0x20000000) in proximity domain 9 enabled

The upper half of the start address of the NUMA domains between 6
and 9 inclusive was cut, so the printed values are incorrect.

Fix the value type, to get the correct values in the log as follows:

[    0.023698] ACPI: SRAT Memory (0x0 length 0xa0000) in proximity domain 0 enabled
[    0.024325] ACPI: SRAT Memory (0x100000 length 0x1ff00000) in proximity domain 0 enabled
[    0.024981] ACPI: SRAT Memory (0x20000000 length 0x20000000) in proximity domain 1 enabled
[    0.025659] ACPI: SRAT Memory (0x40000000 length 0x20000000) in proximity domain 2 enabled
[    0.026317] ACPI: SRAT Memory (0x60000000 length 0x20000000) in proximity domain 3 enabled
[    0.026980] ACPI: SRAT Memory (0x80000000 length 0x20000000) in proximity domain 4 enabled
[    0.027635] ACPI: SRAT Memory (0xa0000000 length 0x20000000) in proximity domain 5 enabled
[    0.028311] ACPI: SRAT Memory (0x100000000 length 0x20000000) in proximity domain 6 enabled
[    0.028985] ACPI: SRAT Memory (0x120000000 length 0x20000000) in proximity domain 7 enabled
[    0.029667] ACPI: SRAT Memory (0x140000000 length 0x20000000) in proximity domain 8 enabled
[    0.030334] ACPI: SRAT Memory (0x160000000 length 0x20000000) in proximity domain 9 enabled

Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
[ rjw: Subject & changelog ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/numa.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 85167603b9c9..0da58f0bf7e5 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -147,9 +147,9 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
 		{
 			struct acpi_srat_mem_affinity *p =
 			    (struct acpi_srat_mem_affinity *)header;
-			pr_debug("SRAT Memory (0x%lx length 0x%lx) in proximity domain %d %s%s%s\n",
-				 (unsigned long)p->base_address,
-				 (unsigned long)p->length,
+			pr_debug("SRAT Memory (0x%llx length 0x%llx) in proximity domain %d %s%s%s\n",
+				 (unsigned long long)p->base_address,
+				 (unsigned long long)p->length,
 				 p->proximity_domain,
 				 (p->flags & ACPI_SRAT_MEM_ENABLED) ?
 				 "enabled" : "disabled",
-- 
2.19.1

