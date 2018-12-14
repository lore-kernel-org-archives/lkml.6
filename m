Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2600C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A4C208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791067;
	bh=4uNSTqPFYf3E8AzhFPhuUL7r+4dipjkWGWXdQAH5+9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R9Pxor3m5nLQvfkciP4ziVcLs18ojei5Ax4VPXhoVsTOQ6+0UAU3xh3h+HShDFYDQ
	 tnveyNvQDPCGYOXyxAB5kWnMyp302syk/Tm9CxowSF538Ak3XjOPCZXT26133XFywz
	 yRJSg+OAII8vDiuXQad1CjIm0+tWcvNgqNoUaPhg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A4C208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbeLNMhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:37:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:51238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729950AbeLNMGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA0CC21479;
        Fri, 14 Dec 2018 12:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789174;
        bh=4uNSTqPFYf3E8AzhFPhuUL7r+4dipjkWGWXdQAH5+9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yFoSz3KzigHvtbE2ZfoBAt29d32hKBrb475EWH+o4UNux6Awn5Vw8160/HQo1hZpn
         d1yhFh3Pqj8O6KRzLoYmpbKhiiIfgsTmJUClIUkDSfP9NIF4764++W5CAZZ1v0W85I
         4MvCnlr9lJfflqT2Z7o6W9fM9HIbIWAM3oCU4FQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 100/142] net: thunderx: fix NULL pointer dereference in nic_remove
Date:   Fri, 14 Dec 2018 12:59:45 +0100
Message-Id: <20181214115751.050995627@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 24a6d2dd263bc910de018c78d1148b3e33b94512 ]

Fix a possible NULL pointer dereference in nic_remove routine
removing the nicpf module if nic_probe fails.
The issue can be triggered with the following reproducer:

$rmmod nicvf
$rmmod nicpf

[  521.412008] Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000000000014
[  521.422777] Mem abort info:
[  521.425561]   ESR = 0x96000004
[  521.428624]   Exception class = DABT (current EL), IL = 32 bits
[  521.434535]   SET = 0, FnV = 0
[  521.437579]   EA = 0, S1PTW = 0
[  521.440730] Data abort info:
[  521.443603]   ISV = 0, ISS = 0x00000004
[  521.447431]   CM = 0, WnR = 0
[  521.450417] user pgtable: 4k pages, 48-bit VAs, pgdp = 0000000072a3da42
[  521.457022] [0000000000000014] pgd=0000000000000000
[  521.461916] Internal error: Oops: 96000004 [#1] SMP
[  521.511801] Hardware name: GIGABYTE H270-T70/MT70-HD0, BIOS T49 02/02/2018
[  521.518664] pstate: 80400005 (Nzcv daif +PAN -UAO)
[  521.523451] pc : nic_remove+0x24/0x88 [nicpf]
[  521.527808] lr : pci_device_remove+0x48/0xd8
[  521.532066] sp : ffff000013433cc0
[  521.535370] x29: ffff000013433cc0 x28: ffff810f6ac50000
[  521.540672] x27: 0000000000000000 x26: 0000000000000000
[  521.545974] x25: 0000000056000000 x24: 0000000000000015
[  521.551274] x23: ffff8007ff89a110 x22: ffff000001667070
[  521.556576] x21: ffff8007ffb170b0 x20: ffff8007ffb17000
[  521.561877] x19: 0000000000000000 x18: 0000000000000025
[  521.567178] x17: 0000000000000000 x16: 000000000000010ffc33ff98 x8 : 0000000000000000
[  521.593683] x7 : 0000000000000000 x6 : 0000000000000001
[  521.598983] x5 : 0000000000000002 x4 : 0000000000000003
[  521.604284] x3 : ffff8007ffb17184 x2 : ffff8007ffb17184
[  521.609585] x1 : ffff000001662118 x0 : ffff000008557be0
[  521.614887] Process rmmod (pid: 1897, stack limit = 0x00000000859535c3)
[  521.621490] Call trace:
[  521.623928]  nic_remove+0x24/0x88 [nicpf]
[  521.627927]  pci_device_remove+0x48/0xd8
[  521.631847]  device_release_driver_internal+0x1b0/0x248
[  521.637062]  driver_detach+0x50/0xc0
[  521.640628]  bus_remove_driver+0x60/0x100
[  521.644627]  driver_unregister+0x34/0x60
[  521.648538]  pci_unregister_driver+0x24/0xd8
[  521.652798]  nic_cleanup_module+0x14/0x111c [nicpf]
[  521.657672]  __arm64_sys_delete_module+0x150/0x218
[  521.662460]  el0_svc_handler+0x94/0x110
[  521.666287]  el0_svc+0x8/0xc
[  521.669160] Code: aa1e03e0 9102c295 d503201f f9404eb3 (b9401660)

Fixes: 4863dea3fab0 ("net: Adding support for Cavium ThunderX network controller")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cavium/thunder/nic_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nic_main.c b/drivers/net/ethernet/cavium/thunder/nic_main.c
index 55af04fa03a7..6c8dcb65ff03 100644
--- a/drivers/net/ethernet/cavium/thunder/nic_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nic_main.c
@@ -1441,6 +1441,9 @@ static void nic_remove(struct pci_dev *pdev)
 {
 	struct nicpf *nic = pci_get_drvdata(pdev);
 
+	if (!nic)
+		return;
+
 	if (nic->flags & NIC_SRIOV_ENABLED)
 		pci_disable_sriov(pdev);
 
-- 
2.19.1



