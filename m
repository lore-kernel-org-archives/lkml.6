Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D315C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E0621104
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSZ7bRt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E0621104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbeKLIRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:17:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730094AbeKLIRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:03 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 591E82175B;
        Sun, 11 Nov 2018 22:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975227;
        bh=YLe9JA+/ljFvaLAQeuNcG8/wdX8eJQYlO4FVySp4pww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mSZ7bRt7ra3Cn6hgmgkTThDryw3LQ+SjhnHHujLH0sR85TgcKfzeAm5vBL94ffOEw
         6XBTcd/7OOmhW0k2OFgphIZB2nRDz71Yr6qRXNcyrtUQrNvlFjteZKWOiIutVEWk36
         tNevDd0fv0enLakQvyDtQbi4GxdZXrfUrcpSqEGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4.19 046/361] x86/numa_emulation: Fix uniform-split numa emulation
Date:   Sun, 11 Nov 2018 14:16:33 -0800
Message-Id: <20181111221626.445125200@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Jiang <dave.jiang@intel.com>

commit c6ee7a548e2c291398b4f32c1f741c66b9f98e1c upstream.

The numa_emulation() routine in the 'uniform' case walks through all the
physical 'memblk' instances and divides them into N emulated nodes with
split_nodes_size_interleave_uniform(). As each physical node is consumed it
is removed from the physical memblk array in the numa_remove_memblk_from()
helper.

Since split_nodes_size_interleave_uniform() handles advancing the array as
the 'memblk' is consumed it is expected that the base of the array is
always specified as the argument.

Otherwise, on multi-socket (> 2) configurations the uniform-split
capability can generate an invalid numa configuration leading to boot
failures with signatures like the following:

    rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
    Sending NMI from CPU 0 to CPUs 2:
    NMI backtrace for cpu 2
    CPU: 2 PID: 1332 Comm: pgdatinit0 Not tainted 4.19.0-rc8-next-20181019-baseline #59
    RIP: 0010:__init_single_page.isra.74+0x81/0x90
    [..]
    Call Trace:
     deferred_init_pages+0xaa/0xe3
     deferred_init_memmap+0x18f/0x318
     kthread+0xf8/0x130
     ? deferred_free_pages.isra.105+0xc9/0xc9
     ? kthread_stop+0x110/0x110
     ret_from_fork+0x35/0x40

Fixes: 1f6a2c6d9f121 ("x86/numa_emulation: Introduce uniform split capability")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/154049911459.2685845.9210186007479774286.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/numa_emulation.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -400,9 +400,17 @@ void __init numa_emulation(struct numa_m
 		n = simple_strtoul(emu_cmdline, &emu_cmdline, 0);
 		ret = -1;
 		for_each_node_mask(i, physnode_mask) {
+			/*
+			 * The reason we pass in blk[0] is due to
+			 * numa_remove_memblk_from() called by
+			 * emu_setup_memblk() will delete entry 0
+			 * and then move everything else up in the pi.blk
+			 * array. Therefore we should always be looking
+			 * at blk[0].
+			 */
 			ret = split_nodes_size_interleave_uniform(&ei, &pi,
-					pi.blk[i].start, pi.blk[i].end, 0,
-					n, &pi.blk[i], nid);
+					pi.blk[0].start, pi.blk[0].end, 0,
+					n, &pi.blk[0], nid);
 			if (ret < 0)
 				break;
 			if (ret < n) {


