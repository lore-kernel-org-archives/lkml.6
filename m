Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF12C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6E12177A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6E12177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389021AbeHDLKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:10:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50084 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732670AbeHDLKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:10:46 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 005E6BBF;
        Sat,  4 Aug 2018 09:10:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 087/124] microblaze: Fix simpleImage format generation
Date:   Sat,  4 Aug 2018 11:01:16 +0200
Message-Id: <20180804082705.753003840@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Simek <michal.simek@xilinx.com>

[ Upstream commit ece97f3a5fb50cf5f98886fbc63c9665f2bb199d ]

simpleImage generation was broken for some time. This patch is fixing
steps how simpleImage.*.ub file is generated. Steps are objdump of
vmlinux and create .ub.
Also make sure that there is striped elf version with .strip suffix.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/microblaze/boot/Makefile |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/arch/microblaze/boot/Makefile
+++ b/arch/microblaze/boot/Makefile
@@ -21,17 +21,19 @@ $(obj)/linux.bin.gz: $(obj)/linux.bin FO
 quiet_cmd_cp = CP      $< $@$2
 	cmd_cp = cat $< >$@$2 || (rm -f $@ && echo false)
 
-quiet_cmd_strip = STRIP   $@
+quiet_cmd_strip = STRIP   $< $@$2
 	cmd_strip = $(STRIP) -K microblaze_start -K _end -K __log_buf \
-				-K _fdt_start vmlinux -o $@
+				-K _fdt_start $< -o $@$2
 
 UIMAGE_LOADADDR = $(CONFIG_KERNEL_BASE_ADDR)
+UIMAGE_IN = $@
+UIMAGE_OUT = $@.ub
 
 $(obj)/simpleImage.%: vmlinux FORCE
 	$(call if_changed,cp,.unstrip)
 	$(call if_changed,objcopy)
 	$(call if_changed,uimage)
-	$(call if_changed,strip)
-	@echo 'Kernel: $@ is ready' ' (#'`cat .version`')'
+	$(call if_changed,strip,.strip)
+	@echo 'Kernel: $(UIMAGE_OUT) is ready' ' (#'`cat .version`')'
 
 clean-files += simpleImage.*.unstrip linux.bin.ub dts/*.dtb


