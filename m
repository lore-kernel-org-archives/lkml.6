Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769B1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E5C20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:50:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="d/36T2g6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E5C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbeGTAfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:35:52 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:60380 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbeGTAfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:35:52 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 208DC8365D;
        Fri, 20 Jul 2018 11:50:22 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1532044222;
        bh=WfqjXkWtXPcZHm7FTE4R0xxcV9MN5+p2Jqtz/Nm1Pi0=;
        h=From:To:Cc:Subject:Date;
        b=d/36T2g6bPwviUC9LF86IqE+hxIGS5yuoUHYllVMBOe+0SIm9bD3GS8fGYjKVHvY7
         e8avGfTI5DlIB+SqgzVoJOLbxPMPGjFe//xsTy74pm1kb2u5CwgdUfYyvusymSwAGV
         8DKvp+0LMy2jnBFv/sRwM7F0zhxWEEAJADhM+db8=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b5123be0000>; Fri, 20 Jul 2018 11:50:22 +1200
Received: from theunsv-dl.ws.atlnz.lc (theunsv-dl.ws.atlnz.lc [10.33.14.29])
        by smtp (Postfix) with ESMTP id 041E013EED3;
        Fri, 20 Jul 2018 11:50:23 +1200 (NZST)
Received: by theunsv-dl.ws.atlnz.lc (Postfix, from userid 1451)
        id E2F025A04AF; Fri, 20 Jul 2018 11:50:21 +1200 (NZST)
From:   Theuns Verwoerd <theuns.verwoerd@alliedtelesis.co.nz>
To:     dwmw2@infradead.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Theuns Verwoerd <theuns.verwoerd@alliedtelesis.co.nz>
Subject: [PATCH 0/2] Secure deletion under JFFS2
Date:   Fri, 20 Jul 2018 11:50:10 +1200
Message-Id: <cover.1532043059.git.theuns.verwoerd@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Security certifications such as FIPS require the capability to securely 
delete files, which is problematic under JFFS2's log-based model.  We can
ensure that all dirty or obsolete data has been cleared at the conclusion 
of secure deletion by forcibly driving the existing garbage collection 
system however.

To that end, these patches provide two pieces of functionality:
1. -POLL signal handling in jffs2_gc to force complete collection of 
   dirty blocks up to the time it was started.
2. Synchronisation with userspace (via debugfs files) to allow 
   secure deletion to wait until that process has completed.

Theuns Verwoerd (2):
  jffs2: Provide forced dirty node cleanup via POLL signal
  jffs2: Provide jffs2_sync files to track gc POLL progress

 fs/jffs2/Kconfig       |  8 ++++++++
 fs/jffs2/background.c  | 31 ++++++++++++++++++++++++++++++-
 fs/jffs2/build.c       |  1 +
 fs/jffs2/jffs2_fs_sb.h |  2 ++
 fs/jffs2/nodelist.h    |  1 +
 fs/jffs2/nodemgmt.c    |  6 +++++-
 fs/jffs2/super.c       | 40 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 87 insertions(+), 2 deletions(-)

-- 
2.18.0

