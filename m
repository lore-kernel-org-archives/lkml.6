Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB19C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B2C2082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B2C2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeH3MEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:04:13 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:59520 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727870AbeH3MEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:04:12 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 493C41B4C99F76CC7CC5;
        Thu, 30 Aug 2018 16:03:16 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w7U839rO016073;
        Thu, 30 Aug 2018 16:03:09 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018083016031650-6560001 ;
          Thu, 30 Aug 2018 16:03:16 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, wanpeng.li@hotmail.com,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V4 2/2]  kvm/x86 : add document for coalesced pio
Date:   Fri, 31 Aug 2018 00:17:21 +0800
Message-Id: <1535645841-111837-3-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1535645841-111837-1-git-send-email-peng.hao2@zte.com.cn>
References: <1535645841-111837-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-30 16:03:16,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-30 16:02:57,
        Serialize complete at 2018-08-30 16:02:57
X-MAIL: mse01.zte.com.cn w7U839rO016073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 Documentation/virtual/kvm/00-INDEX          |  2 ++
 Documentation/virtual/kvm/coalesced-pio.txt | 15 +++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100644 Documentation/virtual/kvm/coalesced-pio.txt

diff --git a/Documentation/virtual/kvm/00-INDEX b/Documentation/virtual/kvm/00-INDEX
index 3492458..4b7a37b 100644
--- a/Documentation/virtual/kvm/00-INDEX
+++ b/Documentation/virtual/kvm/00-INDEX
@@ -9,6 +9,8 @@ arm
 	- internal ABI between the kernel and HYP (for arm/arm64)
 cpuid.txt
 	- KVM-specific cpuid leaves (x86).
+coalesced-pio.txt
+	- KVM_CAP_COALESCED_PIO
 devices/
 	- KVM_CAP_DEVICE_CTRL userspace API.
 halt-polling.txt
diff --git a/Documentation/virtual/kvm/coalesced-pio.txt b/Documentation/virtual/kvm/coalesced-pio.txt
new file mode 100644
index 0000000..38dac11
--- /dev/null
+++ b/Documentation/virtual/kvm/coalesced-pio.txt
@@ -0,0 +1,15 @@
+Linux KVM Coalesced PIO:
+============================
+Coalesced pio is base on coalesced mmio. When the write access to a port
+of a device does a simple work (just like setting a register ID or address
+index), then we can use coalesced pio.
+
+Setting a port as coalesced pio, the write access to the port don't need to
+exit to userspace, and just record the value in shared coalesced ring in kernel.
+Then following access to another port of the same device which relys on the
+first port's setting or a read access to the first port will set the previous
+write value of the first port firstly in usersapce according to the shared
+coalesced ring.
+
+Coalesced pio can be used for rtc 0x70 port, pci-host config port, virtio-pci
+config port and so on.
-- 
1.8.3.1

