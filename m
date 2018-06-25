Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE98C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D75621EC3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:09:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D75621EC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934754AbeFYPJc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:09:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934649AbeFYPJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:09:28 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PF05ip005268
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 11:09:28 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju0h3yk3p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 11:09:27 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <gor@linux.ibm.com>;
        Mon, 25 Jun 2018 16:09:24 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 16:09:22 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PF9Kwe28770502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 15:09:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19CA0A4040;
        Mon, 25 Jun 2018 16:09:15 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA7FBA404D;
        Mon, 25 Jun 2018 16:09:14 +0100 (BST)
Received: from localhost (unknown [9.152.212.171])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 25 Jun 2018 16:09:14 +0100 (BST)
Date:   Mon, 25 Jun 2018 17:09:19 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, qemu-s390x <qemu-s390x@nongnu.org>,
        qemu-devel <qemu-devel@nongnu.org>,
        Thomas Huth <thuth@redhat.com>
Subject: [PATCH] s390/boot: block uncompressed vmlinux booting attempts
References: <64bcba64-b88f-3594-da6e-7c2118482c20@roeck-us.net>
 <cover.thread-8b0da3.your-ad-here.call-01529937119-ext-3705@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.thread-8b0da3.your-ad-here.call-01529937119-ext-3705@work.hours>
X-TM-AS-GCONF: 00
x-cbid: 18062515-0012-0000-0000-000002834A51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062515-0013-0000-0000-000020B4A498
Message-Id: <patch-1.thread-8b0da3.git-8b0da335b2d3.your-ad-here.call-01529937119-ext-3705@work.hours>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since uncompressed kernel image "vmlinux" elf file is not bootable under
qemu anymore, add a check which would report that.

Qemu users are encouraged to use bzImage or
arch/s390/boot/compressed/vmlinux instead.

The check relies on s390 linux entry point ABI definition, which is only
present in bzImage and arch/s390/boot/compressed/vmlinux.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/boot/head.S         |  4 ++--
 arch/s390/include/asm/setup.h |  3 ++-
 arch/s390/kernel/early.c      | 12 ++++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/s390/boot/head.S b/arch/s390/boot/head.S
index f09e792df495..f721913b73f1 100644
--- a/arch/s390/boot/head.S
+++ b/arch/s390/boot/head.S
@@ -272,14 +272,14 @@ iplstart:
 	.org	0x10000
 ENTRY(startup)
 	j	.Lep_startup_normal
-	.org	0x10008
+	.org	EP_OFFSET
 #
 # This is a list of s390 kernel entry points. At address 0x1000f the number of
 # valid entry points is stored.
 #
 # IMPORTANT: Do not change this table, it is s390 kernel ABI!
 #
-	.ascii	"S390EP"
+	.ascii	EP_STRING
 	.byte	0x00,0x01
 #
 # kdump startup-code at 0x10010, running in 64 bit absolute addressing mode
diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index be02f0558048..1d66016f4170 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -9,7 +9,8 @@
 #include <linux/const.h>
 #include <uapi/asm/setup.h>
 
-
+#define EP_OFFSET		0x10008
+#define EP_STRING		"S390EP"
 #define PARMAREA		0x10400
 #define PARMAREA_END		0x11000
 
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 827699eb48fa..45c5be3d8777 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -331,8 +331,20 @@ static void __init setup_boot_command_line(void)
 	append_to_cmdline(append_ipl_scpdata);
 }
 
+static void __init check_image_bootable(void)
+{
+	if (!memcmp(EP_STRING, (void *)EP_OFFSET, strlen(EP_STRING)))
+		return;
+
+	sclp_early_printk("The linux kernel boot failure: the image is corrupted or not bootable.\n");
+	sclp_early_printk("Please check that you are using bootable kernel image \"bzImage\".\n");
+	sclp_early_printk("(or alternatively \"arch/s390/boot/compressed/vmlinux\" image for qemu)\n");
+	disabled_wait(0xbadb007);
+}
+
 void __init startup_init(void)
 {
+	check_image_bootable();
 	time_early_init();
 	init_kernel_storage_key();
 	lockdep_off();
-- 
⣔⢻⣟⢢ 2.18.0.rc2.13.g4da9a5d
⣿⢿⡿⣿ pacman edition

