Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB20C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA9C21B1A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731373AbfBOCBk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:01:40 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:58334 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbfBOCBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:01:39 -0500
Received: from DGGEMA403-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 6625C6B72CD48228C24F;
        Fri, 15 Feb 2019 10:01:37 +0800 (CST)
Received: from DGGEMA503-MBX.china.huawei.com ([169.254.1.64]) by
 DGGEMA403-HUB.china.huawei.com ([10.3.20.44]) with mapi id 14.03.0415.000;
 Fri, 15 Feb 2019 10:01:31 +0800
From:   "chenzefeng (A)" <chenzefeng2@huawei.com>
To:     "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "sjenning@redhat.com" <sjenning@redhat.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "vojtech@suse.com" <vojtech@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "chengjian (D)" <cj.chengjian@huawei.com>
Subject: [PATCH] x86: livepatch: Treat R_X86_64_PLT32 as R_X86_64_PC32
Thread-Topic: [PATCH] x86: livepatch: Treat R_X86_64_PLT32 as R_X86_64_PC32
Thread-Index: AdTE0VS6YxuMC8nAT2u21pUoQUU8yw==
Date:   Fri, 15 Feb 2019 02:01:31 +0000
Message-ID: <79A62BFA453EFB42B7A4E40AD8F3A2264F2A872D@DGGEMA503-MBX.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.50.95]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86-64, for 32-bit PC-relacive branches, we can generate PLT32 relocation, instead of PC32 relocation. and R_X86_64_PLT32 can be treated the same as R_X86_64_PC32 since linux kernel doesn't use PLT.

In linux 4.4 commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as R_X86_64_PC32") been fixed for the module loading, but not fixed for livepatch relocation, which will fail to load livepatch with the error message as follow:
relocation failed for symbol <symbol name> at <symbol address>

Signed-off-by: chenzefeng <chenzefeng2@huawei.com>
---
 arch/x86/kernel/livepatch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/livepatch.c b/arch/x86/kernel/livepatch.c index d1d35cc..579f8f8 100644
--- a/arch/x86/kernel/livepatch.c
+++ b/arch/x86/kernel/livepatch.c
@@ -58,6 +58,7 @@ int klp_write_module_reloc(struct module *mod, unsigned long type,
 		val = (s32)value;
 		break;
 	case R_X86_64_PC32:
+	case R_X86_64_PLT32:
 		val = (u32)(value - loc);
 		break;
 	default:
--
1.8.5.6

