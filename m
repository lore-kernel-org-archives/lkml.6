Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92FFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C48218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NTI4zYlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbfBZXhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:37:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45245 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbfBZXg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:36:56 -0500
Received: by mail-pl1-f193.google.com with SMTP id r14so6988083pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jSZgJudrM5m8qRDb6mLMsIQpowkW9zj+Jyi847C46W4=;
        b=NTI4zYljQwhgGhws5FsjIhRy0mTJhBCzvvkBhh5rFJkV7hzk3M2e5L8CItzwMPXX4K
         oozTdwF/aPXCevV0LKHDXUFbeZ3zYVNUsQdYjXlEQNv9tZOvQZbgJ6/YP0vCCmZs43Bz
         Aj8wWAjAYKVxnwtkDmmrEtr3Y7lhhFU1JKPcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jSZgJudrM5m8qRDb6mLMsIQpowkW9zj+Jyi847C46W4=;
        b=mnpMU8zozbZkp5uwqoXqeixgZBywTIbKLIlgWPqSxXZmEvdlQcblRr2Ehm3SXrNec2
         otCk4emhO9B6lSbdOM/aJz8jaWrdsRrYV/eKzyqZXm6dk8+ZIVwcB2gAVY3lTwzdabvu
         uslDClfs5+9K3CjjepsTY3U0TsOOAfuCOeye2gstH3lfTTesP3tyf4huS5N731pZIXYc
         uECbt1T7DaUT/nsYE7xBhVlBTyfaWje2RIFvy9BBt225c7U1aASVtMxGgbxFdcPngDY5
         sqiWdboyEUUmO3jDDEEgkKvWBJnRcf1+jl9RGvROEY+XrGGAy03d/huR0L03wXhjcdqL
         7N0A==
X-Gm-Message-State: AHQUAuZ0XmSNwum6OSr9CbWn7jmvWbgAB+2017TzxBY9lnoBpcZK6wWm
        1lxAlQThjTQKExAVuPRoatOJaO+6170=
X-Google-Smtp-Source: AHgI3IagwOi8d8Yc8CqzB7DHOUxlkrn6Z+QYE6ghnOkDZ8+auNgE01cZdXF4ItbK4kd5cp66yJfmPA==
X-Received: by 2002:a17:902:2aaa:: with SMTP id j39mr29433062plb.335.1551224216261;
        Tue, 26 Feb 2019 15:36:56 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id j24sm21222445pgl.58.2019.02.26.15.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 15:36:54 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] x86/asm: More pinning
Date:   Tue, 26 Feb 2019 15:36:44 -0800
Message-Id: <20190226233647.28547-1-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds CR0 pinning (for WP), and cleans up the CR4 pin to avoid
taking an exception from WARN before fixing up the desired pin.
Additionally adds lkdtm test (which depends on the CR4 patch, otherwise
I'd send it via Greg's tree).

Thanks!

-Kees

Kees Cook (3):
  x86/asm: Pin sensitive CR0 bits
  x86/asm: Avoid taking an exception before cr4 restore
  lkdtm: Check for SMEP clearing protections

 arch/x86/include/asm/special_insns.h | 33 +++++++++++++--
 drivers/misc/lkdtm/bugs.c            | 60 ++++++++++++++++++++++++++++
 drivers/misc/lkdtm/core.c            |  1 +
 drivers/misc/lkdtm/lkdtm.h           |  1 +
 4 files changed, 91 insertions(+), 4 deletions(-)

-- 
2.17.1

