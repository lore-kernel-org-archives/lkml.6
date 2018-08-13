Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFABC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007F32172D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 20:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ESBZ+Rte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007F32172D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbeHMXRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 19:17:07 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34710 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeHMXRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 19:17:06 -0400
Received: by mail-pl0-f67.google.com with SMTP id f6-v6so7374587plo.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 13:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NnoIluC1smEg6WGx78jp9+ywyejsAyq2FmmJHjpEMHA=;
        b=ESBZ+RtexNL7/A9FGo+D8bphwCE+Yx/xGuSsO89XhXWp7LjuKeyh9wNOHHq46uQQgA
         35SLZi9t1/mSiz8/MSyrbGWQns6ZoLZWQBmkrB1ygxetxQ6GTmo6hPAgWqpg+V9ZYil+
         vo71wr6Xq9bg+KNeSYQ557u+z9oWip8nvhXpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NnoIluC1smEg6WGx78jp9+ywyejsAyq2FmmJHjpEMHA=;
        b=O5DthWWdg9B4fwovgKLzvgIcAuSNEA2U+jkp+Wy2+YO0OsQi+iVR3wcqShBoNpTNhK
         hepbZ0oO0C28ECILIUTNfVEryFcRpdZd3HwaZSRhyAFI+9Lo+/HaMNsY5ZfDX/wGA8uK
         /QUpasgS1G6kxSiVhYlRhX9AT/OAPeF35tQRi6pdCR5quvkdPw6fu+rGuC3WlB77Junq
         B4wH6xU2uJEErWhuN1XLdIPlEyHj7cCBdR4KBirPBP6Pi74nLjWwE1yOek8QZBW9HhA6
         +1oEWEHNktTNPUgPQ3Zia0ijFKy/hL0s8jka96YFioS7dzrQW7IfDelqEf9WJE5vzJuc
         yrCA==
X-Gm-Message-State: AOUpUlGlAGfTIZHv9KPiX6wK5CcpAUsBGUpgHpbP/DtAZygQjf1KzyZJ
        UZMIUmIraeu0dSdeOGxgYhSw4w==
X-Google-Smtp-Source: AA+uWPwLFBBRbRiNrhP2O/xFztzE5pwKBj7y8JJePfXt3DqxQzxxUz4l9/Fz/ybvFmWBRsrmXucPBA==
X-Received: by 2002:a17:902:b401:: with SMTP id x1-v6mr17860054plr.236.1534192398598;
        Mon, 13 Aug 2018 13:33:18 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a17-v6sm28310136pfg.106.2018.08.13.13.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 13:33:17 -0700 (PDT)
Date:   Mon, 13 Aug 2018 13:33:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Chris von Recklinghausen <crecklin@redhat.com>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [GIT PULL] hardened-usercopy updates for v4.19-rc1
Message-ID: <20180813203316.GA9967@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these hardened-usercopy changes for v4.19-rc1. This cleans
up a minor Kconfig issue and adds a kernel boot option for disabling
hardened usercopy for distro users that may have corner-case performance
issues (e.g. high bandwidth small-packet UDP traffic).

Thanks!

-Kees

The following changes since commit 7daf201d7fe8334e2d2364d4e8ed3394ec9af819:

  Linux 4.18-rc2 (2018-06-24 20:54:29 +0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardened-usercopy-v4.19-rc1

for you to fetch changes up to b5cb15d9372abc9adc4e844c0c1bf594ca6a7695:

  usercopy: Allow boot cmdline disabling of hardening (2018-07-04 08:04:52 -0700)

----------------------------------------------------------------
- drop unneeded Kconfig "select BUG" (Kamal Mostafa)
- add "hardened_usercopy=off" rare performance needs (Chris von Recklinghausen)

----------------------------------------------------------------
Chris von Recklinghausen (1):
      usercopy: Allow boot cmdline disabling of hardening

Kamal Mostafa (1):
      usercopy: Do not select BUG with HARDENED_USERCOPY

 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
 include/linux/jump_label.h                      |  6 ++++++
 mm/usercopy.c                                   | 25 +++++++++++++++++++++++++
 security/Kconfig                                |  1 -
 4 files changed, 42 insertions(+), 1 deletion(-)

-- 
Kees Cook
Pixel Security
