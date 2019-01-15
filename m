Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC9AC43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6940720656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388429AbfAORhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:37:20 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.91]:27068 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388412AbfAORhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:37:18 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id E33E7400C7FB4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 11:37:17 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id jSeLg1ntf2PzOjSeLgeVPb; Tue, 15 Jan 2019 11:37:17 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=46950 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gjSeK-003gt7-5U; Tue, 15 Jan 2019 11:37:17 -0600
Date:   Tue, 15 Jan 2019 11:37:13 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] x86/platform/UV: Replace kmalloc and memset with kzalloc and
 kcalloc
Message-ID: <20190115173713.GA31031@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gjSeK-003gt7-5U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:46950
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace kmalloc_node and memset with kzalloc_node, and
kmalloc_array and memset with kcalloc.

Also, remove unnecessary pointer to void vp.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/x86/platform/uv/tlb_uv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
index a4130b84d1ff..ed7e3a21344b 100644
--- a/arch/x86/platform/uv/tlb_uv.c
+++ b/arch/x86/platform/uv/tlb_uv.c
@@ -2010,8 +2010,7 @@ static void make_per_cpu_thp(struct bau_control *smaster)
 	int cpu;
 	size_t hpsz = sizeof(struct hub_and_pnode) * num_possible_cpus();
 
-	smaster->thp = kmalloc_node(hpsz, GFP_KERNEL, smaster->osnode);
-	memset(smaster->thp, 0, hpsz);
+	smaster->thp = kzalloc_node(hpsz, GFP_KERNEL, smaster->osnode);
 	for_each_present_cpu(cpu) {
 		smaster->thp[cpu].pnode = uv_cpu_hub_info(cpu)->pnode;
 		smaster->thp[cpu].uvhub = uv_cpu_hub_info(cpu)->numa_blade_id;
@@ -2135,15 +2134,12 @@ static int __init summarize_uvhub_sockets(int nuvhubs,
 static int __init init_per_cpu(int nuvhubs, int base_part_pnode)
 {
 	unsigned char *uvhub_mask;
-	void *vp;
 	struct uvhub_desc *uvhub_descs;
 
 	if (is_uv3_hub() || is_uv2_hub() || is_uv1_hub())
 		timeout_us = calculate_destination_timeout();
 
-	vp = kmalloc_array(nuvhubs, sizeof(struct uvhub_desc), GFP_KERNEL);
-	uvhub_descs = (struct uvhub_desc *)vp;
-	memset(uvhub_descs, 0, nuvhubs * sizeof(struct uvhub_desc));
+	uvhub_descs = kcalloc(nuvhubs, sizeof(*uvhub_descs), GFP_KERNEL);
 	uvhub_mask = kzalloc((nuvhubs+7)/8, GFP_KERNEL);
 
 	if (get_cpu_topology(base_part_pnode, uvhub_descs, uvhub_mask))
-- 
2.20.1

