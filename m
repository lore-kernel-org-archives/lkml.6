Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E11C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF7820652
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 09:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF7820652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965011AbeFRJ4V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 05:56:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55002 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935308AbeFRIUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:20:08 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8DE2AC3C;
        Mon, 18 Jun 2018 08:20:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacek Tomaka <jacek.tomaka@poczta.fm>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 110/279] x86/cpu/intel: Add missing TLB cpuid values
Date:   Mon, 18 Jun 2018 10:11:35 +0200
Message-Id: <20180618080613.375395183@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "jacek.tomaka@poczta.fm" <jacek.tomaka@poczta.fm>

[ Upstream commit b837913fc2d9061bf9b8c0dd6bf2d24e2f98b84a ]

Make kernel print the correct number of TLB entries on Intel Xeon Phi 7210
(and others)

Before:
[ 0.320005] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
After:
[ 0.320005] Last level dTLB entries: 4KB 256, 2MB 128, 4MB 128, 1GB 16

The entries do exist in the official Intel SMD but the type column there is
incorrect (states "Cache" where it should read "TLB"), but the entries for
the values 0x6B, 0x6C and 0x6D are correctly described as 'Data TLB'.

Signed-off-by: Jacek Tomaka <jacek.tomaka@poczta.fm>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20180423161425.24366-1-jacekt@dugeo.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/intel.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -751,6 +751,9 @@ static const struct _tlb_table intel_tlb
 	{ 0x5d, TLB_DATA_4K_4M,		256,	" TLB_DATA 4 KByte and 4 MByte pages" },
 	{ 0x61, TLB_INST_4K,		48,	" TLB_INST 4 KByte pages, full associative" },
 	{ 0x63, TLB_DATA_1G,		4,	" TLB_DATA 1 GByte pages, 4-way set associative" },
+	{ 0x6b, TLB_DATA_4K,		256,	" TLB_DATA 4 KByte pages, 8-way associative" },
+	{ 0x6c, TLB_DATA_2M_4M,		128,	" TLB_DATA 2 MByte or 4 MByte pages, 8-way associative" },
+	{ 0x6d, TLB_DATA_1G,		16,	" TLB_DATA 1 GByte pages, fully associative" },
 	{ 0x76, TLB_INST_2M_4M,		8,	" TLB_INST 2-MByte or 4-MByte pages, fully associative" },
 	{ 0xb0, TLB_INST_4K,		128,	" TLB_INST 4 KByte pages, 4-way set associative" },
 	{ 0xb1, TLB_INST_2M_4M,		4,	" TLB_INST 2M pages, 4-way, 8 entries or 4M pages, 4-way entries" },


