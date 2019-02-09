Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94386C4151A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6209920821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738176;
	bh=N/UMkshsGoP29Llt4XiAfp+i34JTLqgRtXUlTfdAvqI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=k95vuW/WdHy2hMzeFgIIpC7IhIwqJbud86hoKPA0OZB76+tLydLEs6holYXjze69f
	 6DX8iIovpr21eDIAAljaH65xcps61WPwTRfImYbBZ5pPc6QZXOL0IYQifuWi/bTVRu
	 4/S7WJ8XTTKCzsLYYVxyY7qESlJsG1M+0bOuDmNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfBISte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:49:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727476AbfBISta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:30 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06FA520821;
        Sat,  9 Feb 2019 18:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738169;
        bh=N/UMkshsGoP29Llt4XiAfp+i34JTLqgRtXUlTfdAvqI=;
        h=From:To:Cc:Subject:Date:From;
        b=NLZ9H1rMy3siCEFdSQA2zgYnd0BsNTyAkMRgsMOuvzYeQu0TkifdpZyhP9imO6XA5
         Kt8ni2UfMeRsvovoO1ZlUGhtc2NxmMjytF69f8RMFXogKvh1x0k3pO4vz3caPVgwkV
         sA+cHCEFnmpzha7L6Or99etD4qnnN2WlVf8tBSV8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 01/16] ACPI: NUMA: Use correct type for printing addresses on i386-PAE
Date:   Sat,  9 Feb 2019 13:49:12 -0500
Message-Id: <20190209184927.126791-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
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
index 8fb74d9011da..a7907b58562a 100644
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

