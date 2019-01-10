Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E25C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D14F214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730184AbfAJQ1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:27:31 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:59445 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbfAJQ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:26:22 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MXGzQ-1gmTTU2Mc2-00YlJB; Thu, 10 Jan 2019 17:25:10 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     y2038@lists.linaro.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, tony.luck@intel.com, fenghua.yu@intel.com,
        geert@linux-m68k.org, monstr@monstr.eu, paul.burton@mips.com,
        deller@gmx.de, mpe@ellerman.id.au, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, dalias@libc.org, davem@davemloft.net,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, jcmvbkbc@gmail.com,
        firoz.khan@linaro.org, ebiederm@xmission.com,
        deepa.kernel@gmail.com, linux@dominikbrodowski.net,
        akpm@linux-foundation.org, dave@stgolabs.net,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 04/15] alpha: wire up io_pgetevents system call
Date:   Thu, 10 Jan 2019 17:24:24 +0100
Message-Id: <20190110162435.309262-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IuTdScJNFP/vlVpLiekPy1ow4ZHjUHd9bBQuCDC76YNBRibrohQ
 xe4PTU5B3/2nsf++H4PdApUdmfw+lrf+m4akyCZLHyYTCLErcx0kRCUeA5fx2pSYrXhfboI
 TGcpRPLubhe7ITv+g8HM3hG2m2F8x+f0mihrQflNCCgZKTCoOQI1SPWgWNjeYt2eQffohnL
 2+S4SOm3O/NYGRyHFCqnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xg+0ntML16s=:vQUEgMtLWbgXhUDfOD4tFX
 XVNGSeubXuS5k5TazDG/RTdD+JSIqKb/pqlh4L0fs8LKwLKGo9Mr7o0bUxYV4FvRtEPZM+GKv
 UfYdpiNhsKK7dBkmvzm5tkoM7X+/xOL79IaUdjoW/sM48o9/nL0wpTNmfPxRgKXqXbNQIiALo
 n+08m1jAdAD3r6B+DybJibdim3imldLCouU/K09vqwerADzQiMJc13fKPRn0V60r/kWpeotYH
 OtY4V38lQzwSmWjU9owIspp0el3VCTwvDZbYu7ojyyAcDHZAYvPrK8caRi3SOaHdwFqesPlpx
 GUzFCEvd4/c2t6OOcaCMSDOy3AMIWnnOK+CMb6653SXWw3bhDJjZFw3EJL/dSwwWluWv8ILx0
 0gajNPyzAPBbJyOhecVf2SSzqeyfzeow/YNVRERPCe+L3c43vvO5D3bIGZExSdI0iLqiyJpXL
 DSMRbux5mjH5JbIiMck0dOMMoRlUXHbvb9V4XPibE4zBWammySsIbDptCPBfr8Ne895uaLKJ5
 p+DL/Lg1ijinapAoxBaw8V2s1MIyXB/ov86x7SR2xFfoSb5fyn9VshvOo8iFhkyv+xIPzpyyY
 vQbuFM1W5zrSVFQlRiSF5Q4hwf/SFkFNVGvJC+s/JC5XiBAffWJcxH0VqilVba1u5pblYuaYz
 5eqR6z5hxwaLgpk95sWnUAn0rfYw3vIQCCkKfnvOdk2lPgt/6pLaX3KfQs02ySpY3vvpD5UNK
 Xq5j6U5WXDRMdBdxYGE53f4ixXF9gjVFB99CiA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The io_pgetevents system call was added in linux-4.18 but has
no entry for alpha:

warning: #warning syscall io_pgetevents not implemented [-Wcpp]

Assign a the next system call number here.

Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/syscalls/syscall.tbl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 7b56a53be5e3..e09558edae73 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -451,3 +451,4 @@
 520	common	preadv2				sys_preadv2
 521	common	pwritev2			sys_pwritev2
 522	common	statx				sys_statx
+523	common	io_pgetevents			sys_io_pgetevents
-- 
2.20.0

