Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C9CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5468E20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 21:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jZ51C+XC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5468E20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeHYAv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 20:51:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37784 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbeHYAv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 20:51:57 -0400
Received: by mail-pf1-f195.google.com with SMTP id h69-v6so5081566pfd.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 14:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mh2KZDxgLOR5rF7CDKH71tMjDPkgT4/FlTyA6n+EiYc=;
        b=jZ51C+XCTTDYofziMtss28BT0xMMUgYBWA1wXOCBGVu6KJqYJTCd72oKnYSJ7oe2Kb
         8ODFqrD5ssVX18tIIoRAdCoeFt1n9qImmpRZiDg7UJWgzAxxd7RAzMUjvDS7ELyNn66n
         l0+RQQQlmH+BzyCF83rjUteVG0Xt4eQyfNFM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mh2KZDxgLOR5rF7CDKH71tMjDPkgT4/FlTyA6n+EiYc=;
        b=pl5GZMz7AjzMEnIGcskto0IWBuM/Sh882NH2tjdpFcVCZy8BaQGPsBgSiV3QFkMCEG
         SkQoProAr7Go2B0JkXacUS0qX0OBfZNisMZRV8xV8+a8ijDkgEVsLuoyW4N9BvznSi8a
         OJU4dH1Wr9HtRr5gIElYeQn9ydOjXiVgKTkxOcp+S4GlvV9VKhT3mvLgNZkCN4AQMqgS
         fpvyhjL3KbzI9jFbp7v/FAaI23BqIT7mQeN3UwaC3C370jov2neIwUPz/PfXzR3YGngE
         BPXwB1tzvhnxCX3emzI2tJnKozYDnq0TKpVwfHaX8AxpmHFuVMvWz6Rr6jc0C/VV60Kj
         OP4Q==
X-Gm-Message-State: APzg51DB+mQCmivk65IZr2vpyctNtgsQQLplsRVE4cD5MWYU9KcZzP8V
        9v1dJ3y/csmGv6IXN8y7D/2Rxw==
X-Google-Smtp-Source: ANB0VdZyE6iLpBpoNPTtiLzaSvpse3hciHF6lq/l5Y9KIaTf9OX+xg46CTIsHVY4xDH+mrHF5vg1TQ==
X-Received: by 2002:a65:5004:: with SMTP id f4-v6mr3155005pgo.54.1535145338285;
        Fri, 24 Aug 2018 14:15:38 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id v8-v6sm11092901pff.120.2018.08.24.14.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Aug 2018 14:15:37 -0700 (PDT)
Date:   Fri, 24 Aug 2018 14:15:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: Replace bio_check_ro()'s WARN_ON()
Message-ID: <20180824211535.GA22251@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described in commit 96c6a32ccb55a ("include/asm-generic/bug.h: clarify
valid uses of WARN()"), this replaces a userspace-reachable WARN_ON()
with pr_warn_once(). The reachability is even noted in the existing
comment. This appears to be an "expected by unlikely" condition, so
getting rid of the WARN_ON() means kernel fuzzers will stop reporting
the problem. Additionally un-breaks the error string so it can more
easily be found with grep.

Reported-by: syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 block/blk-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index dee56c282efb..470c3cea8cb0 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2166,11 +2166,9 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 	if (part->policy && (op_is_write(op) && !op_is_flush(op))) {
 		char b[BDEVNAME_SIZE];
 
-		WARN_ONCE(1,
-		       "generic_make_request: Trying to write "
-			"to read-only block-device %s (partno %d)\n",
+		/* Older lvm-tools actually triggers this. */
+		pr_warn_once("Trying to write to read-only block-device %s (partno %d)\n",
 			bio_devname(bio, b), part->partno);
-		/* Older lvm-tools actually trigger this */
 		return false;
 	}
 
-- 
2.17.1


-- 
Kees Cook
Pixel Security
