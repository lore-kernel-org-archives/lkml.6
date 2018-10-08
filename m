Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57CAC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800F821479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1qJZ6nV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800F821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731680AbeJICBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731667AbeJICBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:01:33 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23BEE214C4;
        Mon,  8 Oct 2018 18:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024506;
        bh=S90ZsJHK/axGvNAlnPADTywXEw0IKBbR8xhtqOb05LY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1qJZ6nV2K/4ZhD+NeSBJHPvZHL2iAu6h6muAb2JazWQsT74B7ywFO1N487FMJD6s
         h9Hq26xyxCXlFFwYW+x6c0bgwhXsVMHKxAPhe4G/AEViFqfBksTXjwycMLaulq+Wa/
         hbqUFch1VFdloNMZT+cuURsD9A8Yv/QR9b/hfVHY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Raspl <raspl@linux.ibm.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 040/168] tools/kvm_stat: fix python3 issues
Date:   Mon,  8 Oct 2018 20:30:20 +0200
Message-Id: <20181008175621.572285969@linuxfoundation.org>
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
@@ -759,7 +759,7 @@ class DebugfsProvider(Provider):
             if len(vms) == 0:
                 self.do_read = False
 
-            self.paths = filter(lambda x: "{}-".format(pid) in x, vms)
+            self.paths = list(filter(lambda x: "{}-".format(pid) in x, vms))
 
         else:
             self.paths = []
@@ -1219,10 +1219,10 @@ class Tui(object):
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
 


