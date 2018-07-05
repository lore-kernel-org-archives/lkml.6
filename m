Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C258C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A740B241AC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJtaHU9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A740B241AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbeGEGYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:24:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40173 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbeGEGYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 02:24:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id t6-v6so560187wrn.7;
        Wed, 04 Jul 2018 23:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5MYgilYC4cquGc7OWEhXUutdtOPnglhG1gkBGz8DZxQ=;
        b=PJtaHU9jBe9nIUdrZUce4aMRIWJ72pM0RtoG9JholIxpcVkRwXOJzP+iY0KXYQ9BQW
         ncVoxlgOlxaUKXp1y9PN7/RlUthdepl5Dtt6ZW8oPY2VKNSnaLwdQWoPSMa3HkhNh1Cl
         wkPa74NxBdvBMm5cXNJUOwp2OEB0AMq15q/pMOZBygqYzkp7nT4cEmwobcjP/iZ4seMf
         1/k0Yg9WUJqQHeKoDtZpF27+A+pKlAYul7z0oKI1YsLkYQuDZVLYE/07sAFTvGQTjJQy
         Cb9POlU9InzgdAD4ixlGCwQll8FZFl0mIKQexty/Civv6bbviRGNyLoNaMp+OypbbwrN
         e0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5MYgilYC4cquGc7OWEhXUutdtOPnglhG1gkBGz8DZxQ=;
        b=T4EYe0ehZhMdk76RE9px/YiwQY7hkoPKXJpnhdZP9Kb1q7DLVbNJFm7SEe3TgW68ng
         yWnqXtbivHaATVZN6T1tUT6BWh73cSqXw+bJl8mfeR3Vbml+uEHOLQkHupLS96UE88Fb
         NROcDq/e0GpklHwo/7LfWcWPswbTrbKfPQzrHEK3z3QTpbntPlHK5E4f8coBGHa8vcY3
         xKuUEmYqoPdWPiKi2BmB63gmA01I986F8srGm+o5s0liwaNOdSp+3PIiLA/uRpi2+dOB
         GW6xgYJzGTsSZZfbEoGQ0DkFEVJgL0abBAhZqdBEDcm1RnWPvBWxLsWFoRspncOwXNNk
         hOpg==
X-Gm-Message-State: APt69E283igfuKkluuRPeXE4Rqi+goo9UA/pC3NC1gLYWKUZGgmWgybB
        QUIKv6BoyIFZvt48KOjeEr0=
X-Google-Smtp-Source: AAOMgpde0J3RkTAxutk080ewIvLkZhwoJ2A6GWGeih6vHqmdaDFvv/jqDnf7SfKYObBjqG95Yp8Bzg==
X-Received: by 2002:adf:b2a7:: with SMTP id g36-v6mr3365115wrd.218.1530771849682;
        Wed, 04 Jul 2018 23:24:09 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.12])
        by smtp.gmail.com with ESMTPSA id 203-v6sm7833928wmn.38.2018.07.04.23.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Jul 2018 23:24:09 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        kernel test robot <xiaolong.ye@intel.com>, LKP <lkp@01.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs: shave 8 bytes off of struct inode
Date:   Thu,  5 Jul 2018 09:25:43 +0300
Message-Id: <1530771943-17705-1-git-send-email-amir73il@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a link to Linus' reply to Jan's concern about making
i_blkbibts byte addressable:
https://marc.info/?l=linux-fsdevel&m=152882624707975&w=2

Here is a link to an lkp.org report about potential performance
improvement in some workload, which could(?) be related to packing
i_blkbits closer to i_bytes/i_lock:
https://marc.info/?l=linux-fsdevel&m=153077048108198&w=2

Changes since v1:
- Add links to relevant discussions

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Al,

Re-posting the patch per your request.

Regarding your question:
"I would like more details about the variation of timing -
 what's the dispersion from boot to boot, for starters?"

I haven't run those performance tests, just got them from lkp robot,
so perhaps Xiaolong can answer your question.
I too, find the reported improvement a bit too good to be reliably
true. I do see in the graphs at the bottom of the report that there
are many good vs. bad samples though.

Thanks,
Amir.

 include/linux/fs.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 760d8da1b6c7..6d0489613dc1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -274,6 +274,7 @@ struct writeback_control;
 
 /*
  * Write life time hint values.
+ * Stored in struct inode as u8.
  */
 enum rw_hint {
 	WRITE_LIFE_NOT_SET	= 0,
@@ -607,8 +608,8 @@ struct inode {
 	struct timespec		i_ctime;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	unsigned short          i_bytes;
-	unsigned int		i_blkbits;
-	enum rw_hint		i_write_hint;
+	u8			i_blkbits;
+	u8			i_write_hint;
 	blkcnt_t		i_blocks;
 
 #ifdef __NEED_I_SIZE_ORDERED
-- 
2.7.4

