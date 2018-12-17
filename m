Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01104C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98462086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545068254;
	bh=fpSpXHDZice98F5k01iF/befmPt1YK0dl7nKRIi4pQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Safi09CVnC44Tps3JXpkf0K9p6YnkefWdMmmBgDsy1UON1AC9hgCzbmgDJ3OnOFF9
	 kx5V6UK21CbZXm9PpSG6iUY+VhY2AOpqpDtptVHfo+hy9lVLKj9OTrGn0GM32xp8II
	 Q5jM3fL6l6O8pZPFR25pUk2CoDSiqaofN7uUZZDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388432AbeLQRhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:37:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388415AbeLQRhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:37:33 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B77620675;
        Mon, 17 Dec 2018 17:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545068252;
        bh=fpSpXHDZice98F5k01iF/befmPt1YK0dl7nKRIi4pQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2sh/ZbUgYBb8aNMfJ0rFHcTspboSvqx+1JsDBB9JQvhbHxF7l+f12YRp/Gvywwtg
         H4ezSPV9easRK76IByolBRIBBpqyrX9MzNtSZg0WohGwmdB2qfUD8zhvTgDHjb7ds3
         hiwoKAky+g48gdyDyPloqFtEH2n08jBUKEzcuSQA=
From:   Eric Biggers <ebiggers@kernel.org>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc:     Peng Hao <peng.hao2@zte.com.cn>, syzkaller-bugs@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: fix unregistering coalesced mmio zone from wrong bus
Date:   Mon, 17 Dec 2018 09:36:19 -0800
Message-Id: <20181217173619.210795-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
In-Reply-To: <5b22a63b-e4c2-58af-8070-5aec20302dfc@redhat.com>
References: <5b22a63b-e4c2-58af-8070-5aec20302dfc@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If you register a kvm_coalesced_mmio_zone with '.pio = 0' but then
unregister it with '.pio = 1', KVM_UNREGISTER_COALESCED_MMIO will try to
unregister it from KVM_PIO_BUS rather than KVM_MMIO_BUS, which is a
no-op.  But it frees the kvm_coalesced_mmio_dev anyway, causing a
use-after-free.

Fix it by only unregistering and freeing the zone if the correct value
of 'pio' is provided.

Reported-by: syzbot+f87f60bb6f13f39b54e3@syzkaller.appspotmail.com
Fixes: 0804c849f1df ("kvm/x86 : add coalesced pio support")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 virt/kvm/coalesced_mmio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 3710342cf6ad0..6855cce3e5287 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -175,10 +175,14 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
 {
 	struct kvm_coalesced_mmio_dev *dev, *tmp;
 
+	if (zone->pio != 1 && zone->pio != 0)
+		return -EINVAL;
+
 	mutex_lock(&kvm->slots_lock);
 
 	list_for_each_entry_safe(dev, tmp, &kvm->coalesced_zones, list)
-		if (coalesced_mmio_in_range(dev, zone->addr, zone->size)) {
+		if (zone->pio == dev->zone.pio &&
+		    coalesced_mmio_in_range(dev, zone->addr, zone->size)) {
 			kvm_io_bus_unregister_dev(kvm,
 				zone->pio ? KVM_PIO_BUS : KVM_MMIO_BUS, &dev->dev);
 			kvm_iodevice_destructor(&dev->dev);
-- 
2.20.0.405.gbc1bbc6f85-goog

