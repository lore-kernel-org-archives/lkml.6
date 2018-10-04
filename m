Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4714C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925F92087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sU4W6leU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925F92087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeJEANR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:13:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55788 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeJEANQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:13:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w94H9LKq060287;
        Thu, 4 Oct 2018 17:19:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=SUMThIHP/J89j9ROreiDoGFd6p7qScujQjvcnDLFO1c=;
 b=sU4W6leULgVnIUmF+KMk6TFVeDyv521THxcuo+2fBZvHpPJBmmfJxPNHvAtfGidR/8QA
 QJktvf0S4P1lFSXa/JOfTom5Vrh3rSYJBL109TRWcDVaGic5pG632luNnjeSQc0fIOav
 djAL7QzZ1RLal4jlBM6XW4yjkdgsc1xKVbjCgSauwMZTSbeDgGskkjbl5sHsQtZ6pBm0
 GUUqkYmUPcPNLI9tpcLE88GgQWtJmkR8n6uoLXx5Kke9jH2JJ4kDrE0w9zdNlSCj5vbO
 F7TX9bI85yid6KESKOYLHPk7qBbVGK5ovUDouIVeZqe3iRrPe2/cqb7zcC9T9iPwNDxF 1g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mt1bqdq1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Oct 2018 17:19:00 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w94HIx3s019701
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Oct 2018 17:19:00 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w94HIxcY011599;
        Thu, 4 Oct 2018 17:18:59 GMT
Received: from anastasis.us.oracle.com (/10.152.36.80)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 04 Oct 2018 17:18:59 +0000
Subject: [PATCH 1/1] drivers/char/mem.c: Disable encryption bit in page tables
 for, MMIO access
From:   James Puthukattukaran <james.puthukattukaran@oracle.com>
To:     "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Cc:     gregkh@linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <671c6651-71b3-0e0d-8e87-191ca14fed50@oracle.com>
Message-ID: <f2160d42-9bbf-b7fc-315c-7db8f799cab3@oracle.com>
Date:   Thu, 4 Oct 2018 13:18:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <671c6651-71b3-0e0d-8e87-191ca14fed50@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9036 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=891
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810040159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attempting to mmap to a memory mapped IO space returns -1s because the
memory encryption bit is set for these pages. According to the AMD spec,
this bit should not be set for non-DRAM space. The patch checks if this
is an memory IO region being accessed and decrypts accordingly.

Signed-off-by: James Puthukattukaran<james.puthukattukaran@oracle.com>
---
 drivers/char/mem.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index ffeb60d..beaa374 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -355,10 +355,30 @@ static inline int private_mapping_ok(struct vm_area_struct *vma)
 #endif
 };
 
+static int check_flags(struct resource *res, void *arg)
+{
+	int *mmio = arg;
+	*mmio = (!((res->flags & IORESOURCE_SYSTEM_RAM) ==
+		IORESOURCE_SYSTEM_RAM) && (res->desc == IORES_DESC_NONE));
+	return *mmio;
+}
+
+static void check_iomem_region(phys_addr_t addr, size_t size,
+				int *mmio)
+{
+	u64 start, end;
+
+	start = (u64)addr;
+	end = start + size - 1;
+	*mmio = 0;
+	walk_mem_res(start, end, mmio, check_flags);
+}
+
 static int mmap_mem(struct file *file, struct vm_area_struct *vma)
 {
 	size_t size = vma->vm_end - vma->vm_start;
 	phys_addr_t offset = (phys_addr_t)vma->vm_pgoff << PAGE_SHIFT;
+	int mmio;
 
 	/* Does it even fit in phys_addr_t? */
 	if (offset >> PAGE_SHIFT != vma->vm_pgoff)
@@ -387,6 +407,13 @@ static int mmap_mem(struct file *file, struct vm_area_struct *vma)
 
 	vma->vm_ops = &mmap_mem_ops;
 
+	if (mem_encrypt_active()) {
+		check_iomem_region(vma->vm_pgoff, size, &mmio);
+		if (mmio)
+			vma->vm_page_prot  =
+					pgprot_decrypted(vma->vm_page_prot);
+	}
+
 	/* Remap-pfn-range will mark the range VM_IO */
 	if (remap_pfn_range(vma,
 			    vma->vm_start,

