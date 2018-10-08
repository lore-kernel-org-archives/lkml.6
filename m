Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39ACFC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34562087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iih1kZL7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34562087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbeJIByx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:54:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:42394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729388AbeJIByv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:54:51 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D61F52087D;
        Mon,  8 Oct 2018 18:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024107;
        bh=5cATYzWfwnmeB8PLYEaYHAh68um9cGqUD2Y2XDWmoyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iih1kZL7BGHJSVKspqcS3clWuKpxbcNiqllT+GbDFsSDPVNMlpYHtguSCiL4qX1wF
         slspU+ZPTgWYcvY49LYR2aJ/Yj5M/tXpagUpKdMNOU29nnZ3ygE9S/Pm/XU8PQQk99
         MwnDypLkwwe5Cs2wwWYxmqPBIBTCMVBCgsVRkhoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Raspl <raspl@linux.ibm.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 22/94] tools/kvm_stat: fix python3 issues
Date:   Mon,  8 Oct 2018 20:31:03 +0200
Message-Id: <20181008175606.087511806@linuxfoundation.org>
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

[ Upstream commit 58f33cfe73076b6497bada4f7b5bda961ed68083 ]

Python3 returns a float for a regular division - switch to a division
operator that returns an integer.
Furthermore, filters return a generator object instead of the actual
list - wrap result in yet another list, which makes it still work in
both, Python2 and 3.

Signed-off-by: Stefan Raspl <raspl@linux.ibm.com>
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/kvm/kvm_stat/kvm_stat |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/tools/kvm/kvm_stat/kvm_stat
+++ b/tools/kvm/kvm_stat/kvm_stat
@@ -724,7 +724,7 @@ class DebugfsProvider(Provider):
             if len(vms) == 0:
                 self.do_read = False
 
-            self.paths = filter(lambda x: "{}-".format(pid) in x, vms)
+            self.paths = list(filter(lambda x: "{}-".format(pid) in x, vms))
 
         else:
             self.paths = []
@@ -1119,10 +1119,10 @@ class Tui(object):
         (x, term_width) = self.screen.getmaxyx()
         row = 2
         for line in text:
-            start = (term_width - len(line)) / 2
+            start = (term_width - len(line)) // 2
             self.screen.addstr(row, start, line)
             row += 1
-        self.screen.addstr(row + 1, (term_width - len(hint)) / 2, hint,
+        self.screen.addstr(row + 1, (term_width - len(hint)) // 2, hint,
                            curses.A_STANDOUT)
         self.screen.getkey()
 


