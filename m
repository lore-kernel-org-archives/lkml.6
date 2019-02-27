Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B5DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB2721850
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fp3+FJ57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730442AbfB0UBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:01:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35602 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfB0UBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:01:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id e17so6423482pgd.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 12:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=V0NeIBsPNBoRD2pFCiw1DUTUXltsyF4/p/mZyc9fLQI=;
        b=fp3+FJ57juo0JnLnuE7KZJA6ZZ7hs5R8nr3WerpWPi20S7jaQwuZHDD2MOpAocSV2C
         TMuwF2Nc1TjiyMLdjJU04wYTXorL+JgqSvOTUI7zJW2vEeRW/2mujAATPh4W7k0oxeeS
         TkSEjXfIhoLLnDz/IktzUySd1S7evA6srfAwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V0NeIBsPNBoRD2pFCiw1DUTUXltsyF4/p/mZyc9fLQI=;
        b=HbggZo18aC2G7HvQukRewELnnuyvsmt6vSbWcxoCsBkmhppmKSUy5LFT6leEf0tBEo
         4bqnjYVQgIDFmPqdjGOzlj6cZc8OZAiANcbNijMM8aEBZVOE1jZ8xa8uuskYu44utbwQ
         m9hra9+XtTp4sWlgOUXxRU4mSqoshI9alJ49dDnH3hDUrD5yrhJoKvROFGU+ve7qMW/J
         0u8Rbmq+rBfpeVfHA8dMaDg+ojyqXc1Ii06SCChj5TWRVnLSZkCejRlXe2SKJfQZT9N7
         36oRZb7SSTXdOq88i+gppFVHjcxjL1v9TG+6mYOS6UIhok36tRfCZwAVZ4EKUT4Brahp
         q+ow==
X-Gm-Message-State: AHQUAua6w1KN4nRzc2PMxFrfLlnwC8RCFMFj9bQnm3dQ5gGVOafbntvO
        B5MftcPktDToqGMb7bm1RrJqNw==
X-Google-Smtp-Source: AHgI3Ia0vuHMX7/9qMBiXJ07EZD6cEdVCVqNy+e+uzZ8bxFQOUrzBf5N3KCcOPnd05IbXFAUfbB2fw==
X-Received: by 2002:a62:1bd4:: with SMTP id b203mr3395835pfb.144.1551297700845;
        Wed, 27 Feb 2019 12:01:40 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id l12sm27831995pgn.83.2019.02.27.12.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 12:01:38 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: [PATCH v2 0/3] x86/asm: More pinning
Date:   Wed, 27 Feb 2019 12:01:29 -0800
Message-Id: <20190227200132.24707-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds CR0 pinning (for WP), and cleans up the CR4 pin to avoid
taking an exception from WARN before fixing up the desired pin.
Additionally adds lkdtm test (which depends on the CR4 patch, otherwise
I'd send it via Greg's tree).

v2:
- include brown-paper-bag fix to lkdtm test in v1
- clean up comments

Thanks!

-Kees

Kees Cook (3):
  x86/asm: Pin sensitive CR0 bits
  x86/asm: Avoid taking an exception before cr4 restore
  lkdtm: Check for SMEP clearing protections

 arch/x86/include/asm/special_insns.h | 37 ++++++++++++++---
 drivers/misc/lkdtm/bugs.c            | 61 ++++++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c            |  1 +
 drivers/misc/lkdtm/lkdtm.h           |  1 +
 4 files changed, 95 insertions(+), 5 deletions(-)

-- 
2.17.1

