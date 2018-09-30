Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F59C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF5B208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT9yZ3ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF5B208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeI3WPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 18:15:51 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41157 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeI3WPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 18:15:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id m77-v6so7423972pfi.8;
        Sun, 30 Sep 2018 08:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wxLcsMoyJBPgRuOROBHGBN9CD6e7NIkPBBXGTZp+Qd8=;
        b=MT9yZ3haSCYIS6RdudbE/LW81DwqfMvDsKgV3EYUj3ECWvGcXLiLR9tvnFotd5ZoK3
         3cgi7JeMVU5cgPjv5hILscjiVtiRxsFHYkC2UsqLpAnU6NuXsCuxDmK0zYtfxMRsR7h1
         B0ZG5Dhf3b//L3LpvbGMZaI8pDfk78dXte2BC+sLB7CMgEJ1GLd/P3en1l3n5992WX6u
         CbLLDCGJP9DKkfvX8u3FAKiCkL5KOlwzb+Nb/5qg5GXBF48O5qZ2nJ3TqakDOazfSDm0
         7c8Dw/wxuLz9oz+/uQ4gLrnBqnfeDbbHtcjJZI2CqaQJP1Pj4IqyiJZeevHPLknG6WJp
         aYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wxLcsMoyJBPgRuOROBHGBN9CD6e7NIkPBBXGTZp+Qd8=;
        b=moOVf8DAiN2mwecWVRC0nxdI9vLa+t7WFvjO8YjmIrCSQHfnY9gzwE5LzneubEm8La
         Eljs7wyV28bM2efRqnjP7MzOTEik8ioga1z2x6ob0TgjpGVLLEdv+jvP5uHn3wenH2kg
         gtTZvUDBdSYzIjoE5nVQevGLJ6lH0jjLsvN8TxZJC7tSvikc2aQ8mGDau/STOY/PP1UD
         xkpL250ITrnRqpYZ6eExJ+h0UxSzglVpLx6VggKRDqWV7JaotytXzpyOZEkf/doMctRt
         PENVsnevLXdcTEF4AnCcaM0Cw6IAtAF16cWyF/EjbA9ZF2A0YUIBOv50xKoFw/3Ce32o
         KLSw==
X-Gm-Message-State: ABuFfohiaR+M1ZHDlZXBNZEyrCEcFMd8Fss7KyCk5RqENauWFJWFo7XK
        hdW/FgmqTVJbrHq8eSyZq0o=
X-Google-Smtp-Source: ACcGV61wjv3WVNs7Rb0FqisA5HoQ5/+jskEvrsazqKNpCPd6DY9ZAr0MBGzzPNIjzOaQBSnC36+MNg==
X-Received: by 2002:a65:6204:: with SMTP id d4-v6mr6757819pgv.121.1538322140320;
        Sun, 30 Sep 2018 08:42:20 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p7-v6sm16754581pfb.101.2018.09.30.08.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 08:42:19 -0700 (PDT)
Date:   Sun, 30 Sep 2018 08:42:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 8/9] jump_table: move entries into ro_after_init region
Message-ID: <20180930154218.GA9917@roeck-us.net>
References: <20180919065144.25010-1-ard.biesheuvel@linaro.org>
 <20180919065144.25010-9-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919065144.25010-9-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 18, 2018 at 11:51:43PM -0700, Ard Biesheuvel wrote:
> The __jump_table sections emitted into the core kernel and into
> each module consist of statically initialized references into
> other parts of the code, and with the exception of entries that
> point into init code, which are defused at post-init time, these
> data structures are never modified.
> 
> So let's move them into the ro_after_init section, to prevent them
> from being corrupted inadvertently by buggy code, or deliberately
> by an attacker.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Jessica Yu <jeyu@kernel.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This patch results in build failures when trying to build s390
images.

s390-linux-ld:./arch/s390/kernel/vmlinux.lds:41: syntax error

Bisect log is attached.

Guenter

---
# bad: [4794a36bf08dfa89fe636e5080db9d8350e255dd] Add linux-next specific files for 20180928
# good: [6bf4ca7fbc85d80446ac01c0d1d77db4d91a6d84] Linux 4.19-rc5
git bisect start 'HEAD' 'v4.19-rc5'
# good: [d5b0eb1f139e00e8fd18329d446688b19859755e] Merge remote-tracking branch 'crypto/master'
git bisect good d5b0eb1f139e00e8fd18329d446688b19859755e
# bad: [d9c3085241c16503e659c2d7f43578f297bf30dc] Merge remote-tracking branch 'tip/auto-latest'
git bisect bad d9c3085241c16503e659c2d7f43578f297bf30dc
# good: [db9825c95498280718c4687fcf712016f5b6f5f6] Merge tag 'drm-intel-next-2018-09-21' of git://anongit.freedesktop.org/drm/drm-intel into drm-next
git bisect good db9825c95498280718c4687fcf712016f5b6f5f6
# good: [b22777af06f425911c85d8a2c6b4ed929d4e829f] Merge remote-tracking branch 'mmc/next'
git bisect good b22777af06f425911c85d8a2c6b4ed929d4e829f
# bad: [14cb9d65a396c00eb44e1af967f1c393593f3a4c] Merge branch 'x86/microcode'
git bisect bad 14cb9d65a396c00eb44e1af967f1c393593f3a4c
# good: [c6b5da093a8ba740b71dd0052f3846016986fd21] perf intel-pt: Add decoder flags for trace begin / end
git bisect good c6b5da093a8ba740b71dd0052f3846016986fd21
# bad: [441a6b5c97e0136b416a2c12a0c361423a47c717] Merge branch 'sched/core'
git bisect bad 441a6b5c97e0136b416a2c12a0c361423a47c717
# bad: [d43b23bddade094b1a64a087bc5626a065c3c6e5] Merge branch 'locking/core'
git bisect bad d43b23bddade094b1a64a087bc5626a065c3c6e5
# good: [fa70f0d2ce96a892b38fbbaa60584af536f21f97] Merge tag 'efi-next' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/core
git bisect good fa70f0d2ce96a892b38fbbaa60584af536f21f97
# bad: [ecf89ab872e94999366834689198c436c06ab68f] Merge branch 'core/core'
git bisect bad ecf89ab872e94999366834689198c436c06ab68f
# good: [9fc0f798ab8a6c042d811e45086260eb59be45c1] x86/jump_label: Switch to jump_entry accessors
git bisect good 9fc0f798ab8a6c042d811e45086260eb59be45c1
# good: [19483677684b6ca01606f58503cb79cdfbbc7c72] jump_label: Annotate entries that operate on __init code earlier
git bisect good 19483677684b6ca01606f58503cb79cdfbbc7c72
# bad: [13ddb52c165ba47d153b7b040931a5cbe9220866] s390/jump_label: Switch to relative references
git bisect bad 13ddb52c165ba47d153b7b040931a5cbe9220866
# bad: [e872267b8bcbb179e21ccc7118f258873d6e7a59] jump_table: Move entries into ro_after_init region
git bisect bad e872267b8bcbb179e21ccc7118f258873d6e7a59
# first bad commit: [e872267b8bcbb179e21ccc7118f258873d6e7a59] jump_table: Move entries into ro_after_init region
