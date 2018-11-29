Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCC9C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD8C20673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OxjGwjna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FD8C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbeK3KW2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:22:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44170 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbeK3KW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:22:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so1602768pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NVyjaGp8IOcrCrN3a2BNLZw7Dwrq3JENMXtAxnjgbjg=;
        b=OxjGwjnatUbW9czNxTPqEGeKuUWraq9WMrPbbriEH0MwO71q9DJ95m70IIB1FeZFSp
         hvEinBRiDcsF3504UycynhBhjmSINFDQwcDxzCQlqjl+XILRKkgdIT2nTg0S9TzBxiyB
         I6You/wLdXuSjcM8OHlZSTMODYigSy/7r5uNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NVyjaGp8IOcrCrN3a2BNLZw7Dwrq3JENMXtAxnjgbjg=;
        b=aJgbLIQRrr/rnJ8Po+8OiOdSi3HY9cSg+7Gn3pWolSpBPf2JaaIGXJbwwOSQVuZShL
         YvJF/k57/+T4QPzJHAZXLcTm/FI1Ut81dIk9s2jaCbkQmj8qzLTXcm2wEi40Jh4Xa4Ci
         xAwcKdDhqvS6q4wJkLW8FE5KxIQrw1szlxBpLPbCAfU1VRxq7Gkt/k/Dm/dDBDUix2NW
         0cvxtJChUoerLRlGhvNZOC3z0GbpKjbVx8M3SZJ8iXRYKLot8oELeSjScA/ZKE6XPsu8
         p6q98sOWD5dI+XCsMSaXGGYlev5MiLUCV56f79MWzxCJ7dQ1YjkpKP4DOJBFrzxdnenN
         vd7w==
X-Gm-Message-State: AA+aEWZS2uUuaUMOP4VYSQvnkSTndVsTeQXzvwdjoTbfG6e5zU7ggkDR
        HlvaYGULvxKBzNZKaZ4M9Cf6hA==
X-Google-Smtp-Source: AFSGD/WwSpa3/srQ9WBnxL925vcWb8szIUPUXrD8OWbO8jrWOjantfv7vrAemaQUk9pfe2XFMQyA7w==
X-Received: by 2002:a63:1204:: with SMTP id h4mr2898938pgl.51.1543533318049;
        Thu, 29 Nov 2018 15:15:18 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id x27sm4460911pfe.178.2018.11.29.15.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:15:17 -0800 (PST)
Date:   Thu, 29 Nov 2018 15:15:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] pstore fix for v4.20-rc5
Message-ID: <20181129231516.GA30466@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this pstore fix for v4.20-rc5.

Thanks!

-Kees

The following changes since commit 1227daa43bce1318ff6fb54e6cd862b4f60245c7:

  pstore/ram: Clarify resource reservation labels (2018-10-22 07:11:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v4.20-rc5

for you to fetch changes up to 89d328f637b9904b6d4c9af73c8a608b8dd4d6f8:

  pstore/ram: Correctly calculate usable PRZ bytes (2018-11-29 13:46:43 -0800)

----------------------------------------------------------------
pstore fix:

- Fix corrupted compression due to unlucky size choice with ECC

----------------------------------------------------------------
Kees Cook (1):
      pstore/ram: Correctly calculate usable PRZ bytes

 fs/pstore/ram.c        | 15 ++++++---------
 include/linux/pstore.h |  5 ++++-
 2 files changed, 10 insertions(+), 10 deletions(-)

-- 
Kees Cook
