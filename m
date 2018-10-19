Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627CFECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7392064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="AYCD5ASs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7392064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeJSWSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:18:42 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:57252 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbeJSWSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:18:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id E568CB15
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 14:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Bv8LpSe72A5M for <linux-kernel@vger.kernel.org>;
        Fri, 19 Oct 2018 09:12:22 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id B8DD3B7F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 09:12:22 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id z9-v6so28336305iog.18
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IdR5RWyi13UjuFxFx/MYrdfMzBlnARDvWIhmLOIXZLs=;
        b=AYCD5ASs8NKY/0uwfFT1Ql/lJATcMCG2qPWrfIslEvTOvLA18rOtyvYrTADO2OtdkX
         U8sxGRKZ7CgievdV52byps+cBcQbcC7vP0htTpu7lNWDYd94XSnot+sb3RTITsVLMLRm
         cegrJV8zRqkJi/ZizoIQ4DOhPkry2yQPke54JCngg401juHosZ0PA4jXE7X5zhM7f+3X
         qCHsTaRjvH+XQIrIYsgq/64eJAaQ/mkAA8iy1dJ8tmLY0fucch0DjG9OhCC7cvuQIUZd
         auxWzenF/lswEsBPlCJgb+T+scSW2fz+15RDsWuIR00YKUrjtnjJ/visE35QHVs4N2Xa
         I1bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IdR5RWyi13UjuFxFx/MYrdfMzBlnARDvWIhmLOIXZLs=;
        b=LoteYuYNDsDkosXZlvRoueeMdOX7J43FVvHQA8aeS9Aq+CoC2Bjll5jeE+fL7cxx/d
         sksUMfAA7djHPWb0qWrKirYsf0mbjWg4L1A/7ovB/K4O1zY5S5lQUTEYj2imRxJ1gSe0
         sHH8F4L4XUuWd9avQsQrMZKSN/+EnkqYcfrdUtRZy5Yqv83tMN1F3ba51EhzaMqYF9AN
         +kVMApfGx0pwv329bW7qEwGCLFkgwxCtCVxtAFXbVxyBwIfkw4cU3nbJpqMKu6B/ZOLN
         rg9JdKLMCbo77bg+T9knSCIDJIr8clHWyfCve56McDmL/9nWnCjflya5KL9T6NWXGxD8
         1IGg==
X-Gm-Message-State: ABuFfogy0cdp1x3snY84dOztgtyifR4T0NyI/EE7mGIVEW2oF+NcZ6aw
        8wvfjL3iY4Up4CsuebdUME5s1NvjywFTbNp1wi8Yn5/IDGWCUw0AXFJdueF2MurN0dUONrvnJP9
        H6RjZ1a32+d0qpxaGZP3PG65rZ/qA
X-Received: by 2002:a24:5314:: with SMTP id n20-v6mr3149667itb.37.1539958342305;
        Fri, 19 Oct 2018 07:12:22 -0700 (PDT)
X-Google-Smtp-Source: ACcGV63t+pQQMUKWr5P38vB9C6wKMD3i6GqukkoVco0KKtQ7yq/ZTEGR8jpTibA9fJFPrfPzaKh5PA==
X-Received: by 2002:a24:5314:: with SMTP id n20-v6mr3149655itb.37.1539958342115;
        Fri, 19 Oct 2018 07:12:22 -0700 (PDT)
Received: from cs-u-cslp16.cs.umn.edu (cs-u-cslp16.cs.umn.edu. [134.84.121.95])
        by smtp.gmail.com with ESMTPSA id a14-v6sm7324499iod.53.2018.10.19.07.12.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Oct 2018 07:12:21 -0700 (PDT)
From:   Wenwen Wang <wang6495@umn.edu>
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-media@vger.kernel.org (open list:MEDIA INPUT INFRASTRUCTURE
        (V4L/DVB)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] media: dvb: fix a missing-check bug
Date:   Fri, 19 Oct 2018 09:12:13 -0500
Message-Id: <1539958334-11531-1-git-send-email-wang6495@umn.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In dvb_audio_write(), the first byte of the user-space buffer 'buf' is
firstly copied and checked to see whether this is a TS packet, which always
starts with 0x47 for synchronization purposes. If yes, ts_play() will be
called. Otherwise, dvb_aplay() will be called. In ts_play(), the content of
'buf', including the first byte, is copied again from the user space.
However, after the copy, no check is re-enforced on the first byte of the
copied data.  Given that 'buf' is in the user space, a malicious user can
race to change the first byte after the check in dvb_audio_write() but
before the copy in ts_play(). Through this way, the user can supply
inconsistent code, which can cause undefined behavior of the kernel and
introduce potential security risk.

This patch adds a necessary check in ts_play() to make sure the first byte
acquired in the second copy contains the expected value. Otherwise, an
error code EINVAL will be returned.

Signed-off-by: Wenwen Wang <wang6495@umn.edu>
---
 drivers/media/pci/ttpci/av7110_av.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/pci/ttpci/av7110_av.c b/drivers/media/pci/ttpci/av7110_av.c
index ef1bc17..1ff6062 100644
--- a/drivers/media/pci/ttpci/av7110_av.c
+++ b/drivers/media/pci/ttpci/av7110_av.c
@@ -468,6 +468,8 @@ static ssize_t ts_play(struct av7110 *av7110, const char __user *buf,
 		}
 		if (copy_from_user(kb, buf, TS_SIZE))
 			return -EFAULT;
+		if (kb[0] != 0x47)
+			return -EINVAL;
 		write_ts_to_decoder(av7110, type, kb, TS_SIZE);
 		todo -= TS_SIZE;
 		buf += TS_SIZE;
-- 
2.7.4

