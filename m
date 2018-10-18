Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2CAECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0852C2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YPznNv4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0852C2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbeJSC6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:58:55 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43782 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbeJSC6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:58:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so14704544plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=UAC7itPjn1n3cU4ajwtqM9vct1m7amWPP0Fs908u5/8=;
        b=YPznNv4EZY18Tw54DBeMZ6osM7CW5sCJNtDQpR2ZHg6vdEdJa0LKdodLiPKFyW3VqD
         TF4LHfYTtGLumdjJrSvy/bVdLw4VAf/HvrYqO0XEiG+VwTaVpPUArSe1Hl0pQbGidQ59
         HYFnr77DOKyhsWCyWYRKkngp06T3mxc01wX8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UAC7itPjn1n3cU4ajwtqM9vct1m7amWPP0Fs908u5/8=;
        b=nL8k0unnLJ3bpNQ1mI4KXPPdSAH9+/jiM09R/NRp6pOPVZCLWUlvp1yUgn9ydqt66z
         2gYNH/xqWyZ3P8sxCcsjZRVKsTaa/ATDukVOj5Z5sYRGCgO33rveexQSvU26n5f7kVT3
         ju9Jkw9KUY5vwlLBlfmOKaYJei8bCh9wUIbeoGtWCS/M5Gfvaym6zT1R9Iz+Sj4YSVwP
         jV+DDS1mu6MPn2AnYVEfCgdPNlYSnnLyffObJ8immnzhG88exejGfL/Ngezv/bL09ghT
         jH0DI7Xv0fllRHWdzSZxcfq6LM9CFQjciCt9yKaIjP/nh4spUZdxKcujsD1b4222hSt0
         fBjQ==
X-Gm-Message-State: ABuFfoiczjYxQ2CqJnOl6xxkIqqrbJpyZIgC2UIMbLP+5/ER92+puMZi
        swAdhkRSqmjAuSSJv9apVU5CbQ==
X-Google-Smtp-Source: ACcGV62pNG5vhH8RlQt2IDj3gsR2HPvvKogW8dzpPQUV0ZvxvgxOrL5u+1hx3MUvOcUbl0+7TudcFw==
X-Received: by 2002:a17:902:9a94:: with SMTP id w20-v6mr18828694plp.115.1539888984337;
        Thu, 18 Oct 2018 11:56:24 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id n82-v6sm31438893pfg.21.2018.10.18.11.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 11:56:19 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH pstore-next v2 0/4] Refactor compression initialization
Date:   Thu, 18 Oct 2018 11:56:12 -0700
Message-Id: <20181018185616.14768-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sai noticed pstore wasn't catching early crashes, so Joel fixed it
by moving init earlier again (with compression init done later). I
refactored things a bit to avoid modular build problems noticed by
Guenter. And while doing this work, I also improved /proc/iomem labels
after Dan helped me get NVDIMM working so I could meaningfully test the
very early crash handling.

Thanks everyone!

-Kees

v2:
- add init refactoring to avoid modular build failures.


Joel Fernandes (Google) (1):
  pstore: Allocate compression during late_initcall()

Kees Cook (3):
  pstore: Centralize init/exit routines
  pstore: Refactor compression initialization
  pstore/ram: Clarify resource reservation labels

 fs/pstore/inode.c          | 11 +-----
 fs/pstore/internal.h       |  5 ++-
 fs/pstore/platform.c       | 75 +++++++++++++++++++++++++++++++-------
 fs/pstore/ram.c            | 18 +++++++--
 fs/pstore/ram_core.c       | 11 ++++--
 include/linux/pstore_ram.h |  3 +-
 6 files changed, 90 insertions(+), 33 deletions(-)

-- 
2.17.1

