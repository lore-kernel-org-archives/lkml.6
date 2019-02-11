Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4597BC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011AE20836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="yGd5RcUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388181AbfBKT7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:59:42 -0500
Received: from mail-pl1-f173.google.com ([209.85.214.173]:33478 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfBKT7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:59:42 -0500
Received: by mail-pl1-f173.google.com with SMTP id y10so78345plp.0;
        Mon, 11 Feb 2019 11:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=TDeuT6V3lqE2LFcnTCKtegHpdN3WHW/krAayHK4A2hM=;
        b=yGd5RcUmeo0Fnq03/JiZWesCI74BDTmf60OZtnci5kVO2qTL49wF63EF2qMd/Q1onM
         B4pl0I7c7hed1+ypuC6BreoKBoODdmsM0na0P1ivRSbddsklvjKmv5m0WxMHeVyVjVvC
         dLGgepM0u5rFLB/D66sbl6gTCffQQcvyKFfLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TDeuT6V3lqE2LFcnTCKtegHpdN3WHW/krAayHK4A2hM=;
        b=MwksH5wHQnUvaBXjjIQj9BxkBWA1zGk7118ystmhxLgClJM+gG4CeOT6IcmYUQ1yrV
         CmwMNsGUR+5eisYnIrkSX2z+1QTvN9aCBcr6/RQSoX5tLULRqsAu1O+t1r2zaTbMSCUF
         kUyel3DI4rxLP6R/UHOh4jX9MLurRGYperyCf4WA6dtx3YaCT/ZUNpRq79+hfT+XjJWt
         k0Yw4CP4cATt0p5r8rtH++eQI4XagzD6S4OPwHgEqtVonWNWZT8bN7RYSMpXHtfpbnZC
         0K8QdFMhrPrW86DSEXYLJwVrFLDo8p9OAQiuCpyQ3CR9NBskYGfcYoYz6fsowb3G9orP
         KP5w==
X-Gm-Message-State: AHQUAuaSw5G8jLcu/xDbj/4OkbIA1qGjjEOM64NXAJX44ptqyVos63ub
        mybf9DCkpOpQs5pJatM22VohLsF46p5mn32h2MoVSVky
X-Google-Smtp-Source: AHgI3IYimZCTA+grrrDWO4LVhmVg3Lh3qlB894Cbn7yjBbCtoGbxvODdtYKWAyI8oY53+g4xHU4xXcDUCsFmmk/lsik=
X-Received: by 2002:a17:902:e01:: with SMTP id 1mr38250994plw.251.1549915180540;
 Mon, 11 Feb 2019 11:59:40 -0800 (PST)
MIME-Version: 1.0
From:   Tavian Barnes <tavianator@tavianator.com>
Date:   Mon, 11 Feb 2019 14:59:29 -0500
Message-ID: <CABg4E-mbCk-jeRjETEtXk+ZHVub00_G5QaOnxbf5fgKd5MpD+A@mail.gmail.com>
Subject: d_type and bind mounts
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that readdir()/getdents() fill d_type from the underlying
filesystem, not respecting bind mounts of non-directories:

$ touch mount_point
$ sudo mount --bind /dev/null mount_point
$ find -name mount_point -type c
$ find -name mount_point -type f
./mount_point

(Requires a fairly recent GNU findutils to reproduce, older ones
always call stat().)  I've seen similar discussions about d_ino being
for the underlying file, not the mount point, which people have said
is technically a POSIX violation but also unlikely to be fixed.  Is
the same true of d_type?  And is there some workaround a program could
use to get the actual type without the overhead of a whole stat()
call?  For example, a way to tell whether a directory entry is a mount
point?

For reference, the relevant findutils bug is
https://savannah.gnu.org/bugs/?54913.

(Please keep me cc'd, I'm not subscribed to lkml or fsdevel.  Thanks!)

-- 
Tavian Barnes
