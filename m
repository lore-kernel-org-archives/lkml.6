Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11B1C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B91572087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HciY7oqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B91572087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbeJIBy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:42444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729388AbeJIByy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:54:54 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9978C21479;
        Mon,  8 Oct 2018 18:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024110;
        bh=FsRtLMVyfp70I4VCy7zncvHEmakHdOueQc7lvu9zG6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HciY7oqKnuBCcZbRv3Dz0XIP/8NaxJlIV3PBgp3YLHW3QHZmGKDBRMkQmGxtdN7gr
         B4NDTHbt56nhbFzq2PkdNqUOlSczMDIWK58d3lbsNNUZ8LhhjMT+D/heSNRfl35U2K
         GUPrJcnaVEQ7OMCv+z1XeMdTtmmS25I8x9aavyf8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Raspl <raspl@linux.vnet.ibm.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 23/94] tools/kvm_stat: fix handling of invalid paths in debugfs provider
Date:   Mon,  8 Oct 2018 20:31:04 +0200
Message-Id: <20181008175606.134712040@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -731,6 +731,13 @@ class DebugfsProvider(Provider):
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
 
@@ -745,6 +752,7 @@ class DebugfsProvider(Provider):
         # If no debugfs filtering support is available, then don't read.
         if not self.do_read:
             return results
+        self._verify_paths()
 
         paths = self.paths
         if self._pid == 0:


