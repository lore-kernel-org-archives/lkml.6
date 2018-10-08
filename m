Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43563C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BDFD2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zfz/p3oG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDFD2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbeJICBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:01:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeJICBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:01:36 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0002204FD;
        Mon,  8 Oct 2018 18:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024509;
        bh=0I75gtAas8BA1GWrmmwtgT+89OHtL1rzDSrW3M8CdCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zfz/p3oGTIGODXm/7DdYDFQW5I2ECuYDsF5N2RK1f698G2CgAVEdbW3tjSApZbPtQ
         vsvE6nT6QzkzL5I8XDP5NBHcRnpw0NDybw0KtXvQ4oGjcbK1ZQVHx3FeuS9u4f1ViF
         sPifkVwbiYpUeCGfOfj5MLfo2Kez9qy6Fs0WFSz0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Raspl <raspl@linux.vnet.ibm.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 041/168] tools/kvm_stat: fix handling of invalid paths in debugfs provider
Date:   Mon,  8 Oct 2018 20:30:21 +0200
Message-Id: <20181008175621.607112948@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Raspl <stefan.raspl@de.ibm.com>

[ Upstream commit 617c66b9f236d20f11cecbb3f45e6d5675b2fae1 ]

When filtering by guest, kvm_stat displays garbage when the guest is
destroyed - see sample output below.
We add code to remove the invalid paths from the providers, so at least
no more garbage is displayed.
Here's a sample output to illustrate:

  kvm statistics - pid 13986 (foo)

   Event                                         Total %Total CurAvg/s
   diagnose_258                                     -2    0.0        0
   deliver_program_interruption                     -3    0.0        0
   diagnose_308                                     -4    0.0        0
   halt_poll_invalid                               -91    0.0       -6
   deliver_service_signal                         -244    0.0      -16
   halt_successful_poll                           -250    0.1      -17
   exit_pei                                       -285    0.1      -19
   exit_external_request                          -312    0.1      -21
   diagnose_9c                                    -328    0.1      -22
   userspace_handled                              -713    0.1      -47
   halt_attempted_poll                            -939    0.2      -62
   deliver_emergency_signal                      -3126    0.6     -208
   halt_wakeup                                   -7199    1.5     -481
   exit_wait_state                               -7379    1.5     -493
   diagnose_500                                 -56499   11.5    -3757
   exit_null                                    -85491   17.4    -5685
   diagnose_44                                 -133300   27.1    -8874
   exit_instruction                            -195898   39.8   -13037
   Total                                       -492063

Signed-off-by: Stefan Raspl <raspl@linux.vnet.ibm.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/kvm/kvm_stat/kvm_stat |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/tools/kvm/kvm_stat/kvm_stat
+++ b/tools/kvm/kvm_stat/kvm_stat
@@ -766,6 +766,13 @@ class DebugfsProvider(Provider):
             self.do_read = True
         self.reset()
 
+    def _verify_paths(self):
+        """Remove invalid paths"""
+        for path in self.paths:
+            if not os.path.exists(os.path.join(PATH_DEBUGFS_KVM, path)):
+                self.paths.remove(path)
+                continue
+
     def read(self, reset=0, by_guest=0):
         """Returns a dict with format:'file name / field -> current value'.
 
@@ -780,6 +787,7 @@ class DebugfsProvider(Provider):
         # If no debugfs filtering support is available, then don't read.
         if not self.do_read:
             return results
+        self._verify_paths()
 
         paths = self.paths
         if self._pid == 0:


