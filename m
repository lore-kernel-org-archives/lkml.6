Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F04CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C2820838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 09:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C2820838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeJYSKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:10:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40282 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726913AbeJYSKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:10:54 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9P9conD013383
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 05:38:56 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2nbbb983j5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 05:38:56 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 25 Oct 2018 10:38:53 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Oct 2018 10:38:45 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9P9cijR35061846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 25 Oct 2018 09:38:44 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11E1C4C052;
        Thu, 25 Oct 2018 09:38:44 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AD0C4C046;
        Thu, 25 Oct 2018 09:38:37 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.29])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 25 Oct 2018 09:38:37 +0000 (GMT)
Date:   Thu, 25 Oct 2018 10:38:34 +0100
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Olof Johansson <olof@lixom.net>, linux-alpha@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        Linux-MIPS <linux-mips@linux-mips.org>,
        nios2-dev@lists.rocketboards.org,
        Openrisc <openrisc@lists.librecores.org>,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        SH-Linux <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        devicetree@vger.kernel.org,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: Cut rebuild time when changing
 CONFIG_BLK_DEV_INITRD
References: <20181024193256.23734-1-f.fainelli@gmail.com>
 <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+KCOv6pXXHhHDZ+7-QUrmtMDvSjEVhK15yZ3qbnn61Ag@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18102509-4275-0000-0000-000002D37AFD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102509-4276-0000-0000-000037DF8880
Message-Id: <20181025093833.GA23607@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810250088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 02:55:17PM -0500, Rob Herring wrote:
> On Wed, Oct 24, 2018 at 2:33 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >
> > Hi all,
> >
> > While investigating why ARM64 required a ton of objects to be rebuilt
> > when toggling CONFIG_DEV_BLK_INITRD, it became clear that this was
> > because we define __early_init_dt_declare_initrd() differently and we do
> > that in arch/arm64/include/asm/memory.h which gets included by a fair
> > amount of other header files, and translation units as well.
> 
> I scratch my head sometimes as to why some config options rebuild so
> much stuff. One down, ? to go. :)
> 
> > Changing the value of CONFIG_DEV_BLK_INITRD is a common thing with build
> > systems that generate two kernels: one with the initramfs and one
> > without. buildroot is one of these build systems, OpenWrt is also
> > another one that does this.
> >
> > This patch series proposes adding an empty initrd.h to satisfy the need
> > for drivers/of/fdt.c to unconditionally include that file, and moves the
> > custom __early_init_dt_declare_initrd() definition away from
> > asm/memory.h
> >
> > This cuts the number of objects rebuilds from 1920 down to 26, so a
> > factor 73 approximately.
> >
> > Apologies for the long CC list, please let me know how you would go
> > about merging that and if another approach would be preferable, e.g:
> > introducing a CONFIG_ARCH_INITRD_BELOW_START_OK Kconfig option or
> > something like that.
> 
> There may be a better way as of 4.20 because bootmem is now gone and
> only memblock is used. This should unify what each arch needs to do
> with initrd early. We need the physical address early for memblock
> reserving. Then later on we need the virtual address to access the
> initrd. Perhaps we should just change initrd_start and initrd_end to
> physical addresses (or add 2 new variables would be less invasive and
> allow for different translation than __va()). The sanity checks and
> memblock reserve could also perhaps be moved to a common location.
>
> Alternatively, given arm64 is the only oddball, I'd be fine with an
> "if (IS_ENABLED(CONFIG_ARM64))" condition in the default
> __early_init_dt_declare_initrd as long as we have a path to removing
> it like the above option.

I think arm64 does not have to redefine __early_init_dt_declare_initrd().
Something like this might be just all we need (completely untested,
probably it won't even compile):

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9d9582c..e9ca238 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -62,6 +62,9 @@ s64 memstart_addr __ro_after_init = -1;
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
 #ifdef CONFIG_BLK_DEV_INITRD
+
+static phys_addr_t initrd_start_phys, initrd_end_phys;
+
 static int __init early_initrd(char *p)
 {
 	unsigned long start, size;
@@ -71,8 +74,8 @@ static int __init early_initrd(char *p)
 	if (*endp == ',') {
 		size = memparse(endp + 1, NULL);
 
-		initrd_start = start;
-		initrd_end = start + size;
+		initrd_start_phys = start;
+		initrd_end_phys = end;
 	}
 	return 0;
 }
@@ -407,14 +410,27 @@ void __init arm64_memblock_init(void)
 		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && initrd_start) {
+	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
+	    (initrd_start || initrd_start_phys)) {
+		/*
+		 * FIXME: ensure proper precendence between
+		 * early_initrd and DT when both are present
+		 */
+		if (initrd_start) {
+			initrd_start_phys = __phys_to_virt(initrd_start);
+			initrd_end_phys = __phys_to_virt(initrd_end);
+		} else if (initrd_start_phys) {
+			initrd_start = __va(initrd_start_phys);
+			initrd_end = __va(initrd_start_phys);
+		}
+
 		/*
 		 * Add back the memory we just removed if it results in the
 		 * initrd to become inaccessible via the linear mapping.
 		 * Otherwise, this is a no-op
 		 */
-		u64 base = initrd_start & PAGE_MASK;
-		u64 size = PAGE_ALIGN(initrd_end) - base;
+		u64 base = initrd_start_phys & PAGE_MASK;
+		u64 size = PAGE_ALIGN(initrd_end_phys) - base;
 
 		/*
 		 * We can only add back the initrd memory if we don't end up
@@ -458,7 +474,7 @@ void __init arm64_memblock_init(void)
 	 * pagetables with memblock.
 	 */
 	memblock_reserve(__pa_symbol(_text), _end - _text);
-#ifdef CONFIG_BLK_DEV_INITRD
+#if 0
 	if (initrd_start) {
 		memblock_reserve(initrd_start, initrd_end - initrd_start);
 
 
> Rob
> 

-- 
Sincerely yours,
Mike.

