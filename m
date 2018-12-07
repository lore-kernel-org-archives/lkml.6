Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0C5C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824862082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 17:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i5R9DnAU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824862082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbeLGRIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 12:08:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44398 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGRIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 12:08:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id k8so2089988pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 09:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qqHkIbAJvmnMCQD5AWZrvyunFcXgF8YfmLbiuK32AMI=;
        b=i5R9DnAUu5BjtxmY5/aXmEFxTc3TA/RCh9F2SOMllr8SNW+Lsm2MpHbsNiVWLGxgjt
         VURXpLzWh3ZSKf0YuYJr6EZfiM0UVnwk6pDapECnV94Hg8Bhma1GKbLysTK5WfRwU4yF
         Ygx2mSxJxSNV97jJ6bFqfmiXKA1VArbC07enE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qqHkIbAJvmnMCQD5AWZrvyunFcXgF8YfmLbiuK32AMI=;
        b=gtr2PdfqxZt7IjW3pMG+WZwIcHlkps/T8vIdRYKlbsm68gmn2UrgZ7RKCgoq8CfR/3
         nRtEvuK3mgxpFYuhDkkQ6/9KNrVx0Em/i2b4GAGSlNhwg1qfVyNtBccJn8plj+KiGcOx
         2hPYC9pVu5bnQOh2Do/aesq752rXpUayQAXabjZ/2bmd5slGlOS5kdqV3KHDAyGrc7qs
         Pjo3sA1m6/i38eS1FddWwCLMXwZY3y+nviHo3WluLWaXk+LC6nz+fOsoJNxMaLpE2SJd
         atWCkoXktjF3owAIq7X0hqdhj2XpfI9jWGcZ8/SuERUDRULrkYqeyYYawTPn7zeVzkp0
         t+fA==
X-Gm-Message-State: AA+aEWZlv+TGXDB81Yk3BzjAoFpECP3vg3SAroYs0BKYAv5PYMo+x3vN
        pEmNY1g/pYT18GTgccBlhbk8zA==
X-Google-Smtp-Source: AFSGD/VdcNgvuuvYA1W438M8dWMI99/c+Ne8KdqBndbPuAcifE4ZPgRNTu9QpxL7DDMexhbex0QyGQ==
X-Received: by 2002:a17:902:b112:: with SMTP id q18mr2858302plr.255.1544202527260;
        Fri, 07 Dec 2018 09:08:47 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id e65sm7664220pfc.74.2018.12.07.09.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 09:08:46 -0800 (PST)
Date:   Fri, 7 Dec 2018 09:08:45 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Popov <alex.popov@linux.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [GIT PULL] gcc-plugin updates for v4.20-rc6
Message-ID: <20181207170845.GA24251@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these gcc-plugin fixes for v4.20-rc6.

Thanks!

-Kees

The following changes since commit ef1a8409348966f0b25ff97a170d6d0367710ea9:

  stackleak: Disable function tracing and kprobes for stackleak_erase() (2018-11-30 09:05:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/gcc-plugins-v4.20-rc6

for you to fetch changes up to 8fb2dfb228df785bbeb4d055a74402ef4b07fc25:

  stackleak: Register the 'stackleak_cleanup' pass before the '*free_cfg' pass (2018-12-06 09:10:23 -0800)

----------------------------------------------------------------
Fixes for stackleak

- Remove tracing for inserted stack depth marking function (Anders Roxell)
- Move gcc-plugin pass location to avoid objtool warnings (Alexander Popov)

----------------------------------------------------------------
Alexander Popov (1):
      stackleak: Register the 'stackleak_cleanup' pass before the '*free_cfg' pass

Anders Roxell (1):
      stackleak: Mark stackleak_track_stack() as notrace

 kernel/stackleak.c                     | 2 +-
 scripts/gcc-plugins/stackleak_plugin.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

-- 
Kees Cook
