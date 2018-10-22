Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F30C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B3042064C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XBivyPIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3042064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeJVWna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:43:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37027 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeJVWna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:43:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so19105291pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=hwgG+wVJwk8OupbloF2M5Ky7PHxCUaly0QaqiCX6TwE=;
        b=XBivyPIi8zt3LpbVtZf1sMnD49F2p8c0xOagzUTNHkBaFYI+pUdIBe7KDzPEe1Fbzk
         bNVnPxUoob2VWKjVkR7ynyHDZF4xxZoG6A1P4OUtSAaQkNFCCYVhDs/3MT0s5mIaOWLw
         EhA/HIjHhGJcWGG7ckNO75AeaAOOtVdyv65Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hwgG+wVJwk8OupbloF2M5Ky7PHxCUaly0QaqiCX6TwE=;
        b=iRO0tdGCApXYbTi0+2k48P6jXEBOVu3kJcAMIZKZEs0oUQm5utfhM5Zs1lMsQCTg41
         8dHFMLogKZnC/oeAV6miLH0iy0sC31IKOyEyrSB26zJBmL4xhlorditFyN9ho7dC6y/3
         3VNQTg898NeZHokgG+YoV9j4FOqTxTO4CfCntsikbhxNMDgAO6XmAu4zxYSVNjifMzrY
         bwyiyo68eCRC7FcAr1p/KW6ZQEf4dV/g3expLjcxNlYLaKx8kGCKFrnIqRReKoqeP9Zs
         shEQ//Zld6IzlgjU0HJ6VKJn3r8iDg2VLM6kDsgJqdWY5y3yKixMVP2EK8Wyg8UaVlRX
         5gpg==
X-Gm-Message-State: ABuFfohND6xOEEZAW5gMbowLCXrwTd4goRXMaswTri3JMdKvFODEN9I4
        x+gKcEsS7+ECHMCoNJ10av+I+oA5D+0=
X-Google-Smtp-Source: ACcGV63D8bIfMrJfuUWMQZevW7bi6vB5gV0hYZ3egDgb70zufhL7sylM3rMcU2TSlSZ9MPGTPKgtjw==
X-Received: by 2002:a65:5147:: with SMTP id g7-v6mr43834469pgq.252.1540218282726;
        Mon, 22 Oct 2018 07:24:42 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id b29-v6sm52161581pfj.183.2018.10.22.07.24.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 07:24:41 -0700 (PDT)
Date:   Mon, 22 Oct 2018 07:24:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [GIT PULL] pstore updates for v4.20-rc1
Message-ID: <20181022142440.GA10225@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore changes for v4.20-rc1.

Thanks!

-Kees

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v4.20-rc1

for you to fetch changes up to 1227daa43bce1318ff6fb54e6cd862b4f60245c7:

  pstore/ram: Clarify resource reservation labels (2018-10-22 07:11:58 -0700)

----------------------------------------------------------------
pstore improvements:

- refactor init to happen as early as possible again (Joel Fernandes)
- improve resource reservation names

----------------------------------------------------------------
Joel Fernandes (Google) (1):
      pstore: Allocate compression during late_initcall()

Kees Cook (3):
      pstore: Centralize init/exit routines
      pstore: Refactor compression initialization
      pstore/ram: Clarify resource reservation labels

 fs/pstore/inode.c          | 11 ++-----
 fs/pstore/internal.h       |  5 ++--
 fs/pstore/platform.c       | 75 ++++++++++++++++++++++++++++++++++++++--------
 fs/pstore/ram.c            | 18 ++++++++---
 fs/pstore/ram_core.c       | 11 ++++---
 include/linux/pstore_ram.h |  3 +-
 6 files changed, 90 insertions(+), 33 deletions(-)

-- 
Kees Cook
Pixel Security
