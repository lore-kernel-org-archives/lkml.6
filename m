Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2060CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8A662146D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4AmalMo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8A662146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeLEJku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:40:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727500AbeLEJkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:40:45 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D48720851;
        Wed,  5 Dec 2018 09:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002844;
        bh=Cu2NJWob1a5/hZCzsRBOB0mAnio3LE33hNgRasoQk30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M4AmalMoi2jF50xCgmGFZVOMXZhRKSYplYgXtGVBAm9l9dJB71aby7GvCUMuZ9F9J
         /+HQTQQ914K2vSlFisgiSbC3Zhze3GptVxKN3PPV1T7gUJJqacyPktBbcCVHTO04Hw
         Bl+kI3qsVEfuv1JxeSAE39FiwHzVyjbn3uGXgc0g=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 085/123] net: thunderx: fix NULL pointer dereference in nic_remove
Date:   Wed,  5 Dec 2018 04:35:17 -0500
Message-Id: <20181205093555.5386-85-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

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
2.17.1

