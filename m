Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD494C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A6121571
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 03:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A6121571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeHXGim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 02:38:42 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:38252 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeHXGil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 02:38:41 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 84B2BB2A474EFA4E3352;
        Fri, 24 Aug 2018 11:06:02 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id w7O35tQi036824;
        Fri, 24 Aug 2018 11:05:55 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018082411060379-5963665 ;
          Fri, 24 Aug 2018 11:06:03 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     pbonzini@redhat.com, rkrcmar@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, wanpeng.li@hotmail.com,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH V3 2/2]  kvm/x86 : add document for coalesced pio
Date:   Fri, 24 Aug 2018 19:20:32 +0800
Message-Id: <1535109632-59745-3-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1535109632-59745-1-git-send-email-peng.hao2@zte.com.cn>
References: <1535109632-59745-1-git-send-email-peng.hao2@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-08-24 11:06:03,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-08-24 11:05:40,
        Serialize complete at 2018-08-24 11:05:40
X-MAIL: mse01.zte.com.cn w7O35tQi036824
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 Documentation/virtual/kvm/00-INDEX          |  2 ++
 Documentation/virtual/kvm/coalesced-pio.txt | 14 ++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 Documentation/virtual/kvm/coalesced-pio.txt

diff --git a/Documentation/virtual/kvm/00-INDEX b/Documentation/virtual/kvm/00-INDEX
index 3492458..3d68164 100644
--- a/Documentation/virtual/kvm/00-INDEX
+++ b/Documentation/virtual/kvm/00-INDEX
@@ -11,6 +11,8 @@ cpuid.txt
 	- KVM-specific cpuid leaves (x86).
 devices/
 	- KVM_CAP_DEVICE_CTRL userspace API.
+coalesced-pio.txt
+	- KVM_CAP_COALESCED_PIO
 halt-polling.txt
 	- notes on halt-polling
 hypercalls.txt
diff --git a/Documentation/virtual/kvm/coalesced-pio.txt b/Documentation/virtual/kvm/coalesced-pio.txt
new file mode 100644
index 0000000..932d5cd
--- /dev/null
+++ b/Documentation/virtual/kvm/coalesced-pio.txt
@@ -0,0 +1,14 @@
+Linux KVM Coalesced PIO:
+========================
+Coalesced pio is base on coalesced mmio. When the write access to a port
+of a device does a simple work (just like setting a register ID or address
+index), then we can use coalesced pio.
+
+Setting a port as coalesced pio, the write access to the port don't need to
+exit to userspace, and just record the value in shared coalesced ring in kernel.
+Then following access to another port of the same device which relys on the first
+port's setting or a read access to the first port will set the previous write
+value of the first port firstly in usersapce according to the shared coalesced ring.
+
+Coalesced pio can be used for rtc 0x70 port, pci-host config port, virtio-pci config
+port and so on.
-- 
1.8.3.1

