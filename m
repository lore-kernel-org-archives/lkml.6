Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96401C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596542087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAqMV/bA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596542087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbeJICBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbeJICBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:01:40 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A51E3204FD;
        Mon,  8 Oct 2018 18:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024513;
        bh=JPpA0AvHJZJNT1Zn/rcnJ1UD+QDDahrKh1Lb6i5eKSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAqMV/bA/SgY5CSuRxPjQOdFTZerXpZ/vXEF7ItBPcgPoeXpWErTQE67SLKMTM4QW
         nBncHTfqQfzSqq5azmwRMII1Q2ZvwaKiGiuXskPKPj4Vkn9m5fFP9OhdM4wctFx3Hp
         hdmcWkI1X8xZ1zTJ4pdZrm7sB3iolYMOlbea3xJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Raspl <raspl@linux.ibm.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 042/168] tools/kvm_stat: fix updates for dead guests
Date:   Mon,  8 Oct 2018 20:30:22 +0200
Message-Id: <20181008175621.647120346@linuxfoundation.org>
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

[ Upstream commit 710ab11ad9329d2d4b044405e328c994b19a2aa9 ]

With pid filtering active, when a guest is removed e.g. via virsh shutdown,
successive updates produce garbage.
Therefore, we add code to detect this case and prevent further body updates.
Note that when displaying the help dialog via 'h' in this case, once we exit
we're stuck with the 'Collecting data...' message till we remove the filter.

Signed-off-by: Stefan Raspl <raspl@linux.ibm.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/kvm/kvm_stat/kvm_stat |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/tools/kvm/kvm_stat/kvm_stat
+++ b/tools/kvm/kvm_stat/kvm_stat
@@ -1170,6 +1170,9 @@ class Tui(object):
 
             return sorted_items
 
+        if not self._is_running_guest(self.stats.pid_filter):
+            # leave final data on screen
+            return
         row = 3
         self.screen.move(row, 0)
         self.screen.clrtobot()
@@ -1327,6 +1330,12 @@ class Tui(object):
                 msg = '"' + str(val) + '": Invalid value'
         self._refresh_header()
 
+    def _is_running_guest(self, pid):
+        """Check if pid is still a running process."""
+        if not pid:
+            return True
+        return os.path.isdir(os.path.join('/proc/', str(pid)))
+
     def _show_vm_selection_by_guest(self):
         """Draws guest selection mask.
 
@@ -1354,7 +1363,7 @@ class Tui(object):
             if not guest or guest == '0':
                 break
             if guest.isdigit():
-                if not os.path.isdir(os.path.join('/proc/', guest)):
+                if not self._is_running_guest(guest):
                     msg = '"' + guest + '": Not a running process'
                     continue
                 pid = int(guest)


