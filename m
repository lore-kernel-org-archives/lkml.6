Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FF7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B4DD21470
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 18:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KhrKdGbs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B4DD21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbeHOVeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 17:34:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34926 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeHOVeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 17:34:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10-v6so880565pgv.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 11:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2u1XyQ+pQUj4W4IDxCxzIdxk2FNtV3NzBki2hFTdpN4=;
        b=KhrKdGbs2eSFVmA1dZlJFDr2tLtLTDTpHs+dONntDU8c3Lm/Xe+aIKh6myMfAczhE3
         zfSHUY1v1z6IcL/UOshtrxtvlVFLAon/Cu/2QZktvTifzh80N3ybUDge5Kr5lgP86v5g
         qhq1LsK2veiC2+1dzThvcCBw2+9RfBH7rZxwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2u1XyQ+pQUj4W4IDxCxzIdxk2FNtV3NzBki2hFTdpN4=;
        b=hxl9BQyHA50P4+Rru7S4YnDWI6Lhbilm1uCL6/a5YVryifrkByZjihGP9fXorJrzQv
         ih84WYYyVTU4UCIuymuW6821od6z1e1BB+O3PDzjWihk5x+Mmp1EHziqXJTYdrckU31Q
         tVHFKTPwigxj8Yl9HSvvBGkZLrLMUvKchosWlaVPyYanvVqgbIVmC/9j5ZaOCpqDE0VZ
         h56jSb+S5OMvCq0dMQTGfxmh0aOgvZ4NDDVKnrTKx2MMGhmTbypd98idEv4GDKEdpG7R
         bn6UYUD3UzkK6MXeoQOjfbXgP0o28tUoHtjFLCiH23wjCY9ONBNQYoupcDXX/Il9qPBn
         iZhQ==
X-Gm-Message-State: AOUpUlFT6ZWC0/rZLofkB4J0Sm4OYMYwLGucxzambV0fuglJiDbp/ShF
        pAig8AOnGvK8YSJ9P1MwptK51yXnN7I=
X-Google-Smtp-Source: AA+uWPwmV2sihTWC5cCAIGt4eGnZwl1OIFeJN3D7aBPnFIm8gazqNTcobAO656tYCkBPwwAgELEUUQ==
X-Received: by 2002:a62:d8c:: with SMTP id 12-v6mr29098259pfn.202.1534358453415;
        Wed, 15 Aug 2018 11:40:53 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id d10-v6sm22510073pgo.2.2018.08.15.11.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 11:40:52 -0700 (PDT)
Date:   Wed, 15 Aug 2018 11:40:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [GIT PULL] gcc-plugin cleanups for v4.19-rc1
Message-ID: <20180815184051.GA28557@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please pull these gcc-plugin cleanups for v4.19-rc1. This moves the Kconfig
menu around, makes the Makefile more readable, and clean up a function
declaration.

Thanks!

-Kees

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugin-cleanup-v4.19-rc1

for you to fetch changes up to 45d9a1e3cc45efee6c0ef82b77269d6944d9d8a5:

  gcc-plugins: Clean up the cgraph_create_edge* macros (2018-07-24 16:14:06 -0700)

----------------------------------------------------------------
- Kconfig and Makefile clean-ups (Masahiro Yamada, Kees Cook)
- gcc-common.h definition clean-ups (Alexander Popov)

----------------------------------------------------------------
Alexander Popov (1):
      gcc-plugins: Clean up the cgraph_create_edge* macros

Kees Cook (1):
      gcc-plugins: Regularize Makefile.gcc-plugins

Masahiro Yamada (2):
      gcc-plugins: remove unused GCC_PLUGIN_SUBDIR
      gcc-plugins: split out Kconfig entries to scripts/gcc-plugins/Kconfig

 arch/Kconfig                     | 146 +--------------------------------------
 scripts/Makefile.gcc-plugins     |  37 ++++++----
 scripts/gcc-plugins/Kconfig      | 142 +++++++++++++++++++++++++++++++++++++
 scripts/gcc-plugins/Makefile     |   5 --
 scripts/gcc-plugins/gcc-common.h |  26 ++++---
 5 files changed, 184 insertions(+), 172 deletions(-)
 create mode 100644 scripts/gcc-plugins/Kconfig

-- 
Kees Cook
Pixel Security
