Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80401C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1575420841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kOzyb1qw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1575420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732621AbeGaVpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:45:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44711 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732373AbeGaVpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:45:35 -0400
Received: by mail-lj1-f196.google.com with SMTP id q127-v6so14790986ljq.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 13:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tOogUcHOEtB3UKMCP89e3s2RWpykTHR3DRPeXDi5NWw=;
        b=kOzyb1qwc+bLzfEkf9X8eQ9ms0PyM2yDCTgI4x1UqghkB7f+PZ8WAWIzZSz5te45pr
         prWK+or8DJyX71x0Nu7RpzaDuny+ltxKO0xxQXPSH3EYGOU19nOsHHvjoroas6LT47VS
         xvyVyHUhZpY1laCnZpZ1GL3W5ii33qEsiZkKLb776e3zdUo/+qI/P8r2F9nYEy7abNSu
         imrjRj3X0tkbRQaamgIMWsu6of5+QeVmJA/e9F72lUHhzci2bZ6gwRwmjMy8QJK+wSc9
         VYpAeVsnmvftvT46gR18Lb/Eejh+M4mcL6Db+Iqgs3w81cgMnpkgHyr++EgFbqnlnKq8
         Cs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tOogUcHOEtB3UKMCP89e3s2RWpykTHR3DRPeXDi5NWw=;
        b=s5YEJb2kwgvibraZoAIuoCa8n1XjsrFBArpBPj2zG8OshuDZkD7UmBjJ4IZxUU8WoK
         3CY+M6Loi11HxP6KyZSV2TBW+yNtAQ+H7g7/m98tI6J3qNDk0E7cFyNKe8wgAqTeSRbS
         9yPnRwzEI8xLqP9ondZGSlGpVDMkhBo2C7ndDKDnchn8T1N8vRaKQ2n066TyRpYT4IYg
         pZ3zk53mV5G6ffTzTO2PsQvqy2vtKwJ0d/nOORcWTmeawNyHDcDf5mYgR46b0VpHRORU
         0Msz5ky/cd50nheCxSH3LfarGzR3tq/9ZcCu9Jl2HcYEaUJ+oJS+6MA+tXU5H7XaYpjf
         Qaww==
X-Gm-Message-State: AOUpUlEibE0dCNwBFj10XH+nxDr0zPxByQWTOThCPWr3Jx0PXKVUOS6u
        vMxU7GeV101y7cOharyjRWGUHBG0gEogHAUyDtHONFRd4A==
X-Google-Smtp-Source: AAOMgpc7/ZRzzk2W+5VW8HKqXvU7qYBgIOpay1kbmtBs8xMKeQg3d/sgNHiC/oQhNsOQs1qrvKE1IFwpp6qrCFIf4HA=
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr16950444ljf.102.1533067417967;
 Tue, 31 Jul 2018 13:03:37 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 31 Jul 2018 16:03:25 -0400
Message-ID: <CAHC9VhR3vzLkso4kiqKoA4nyZJeD9S8jTE7yZiVMeWfL-acPrg@mail.gmail.com>
Subject: [GIT PULL] Audit fixes for v4.18 (#1)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        wang.yi59@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A single small audit fix to guard against memory allocation failures
when logging information about a kernel module load.  It's small, easy
to understand, and self-contained; while nothing is zero risk, this
should be pretty low.

Please merge for v4.18, thanks.
-Paul

--
The following changes since commit 5b71388663c0920848c0ee7de946970a2692b76d:

 audit: Fix wrong task in comparison of session ID (2018-05-21 14:27:43 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
   tags/audit-pr-20180731

for you to fetch changes up to b305f7ed0f4f494ad6f3ef5667501535d5a8fa31:

 audit: fix potential null dereference 'context->module.name'
   (2018-07-30 18:09:37 -0400)

----------------------------------------------------------------
audit/stable-4.18 PR 20180731

----------------------------------------------------------------
Yi Wang (1):
     audit: fix potential null dereference 'context->module.name'

kernel/auditsc.c | 13 +++++++++----
1 file changed, 9 insertions(+), 4 deletions(-)

-- 
paul moore
www.paul-moore.com
