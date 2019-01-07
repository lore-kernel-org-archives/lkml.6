Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A1BC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA39B2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmCDrypP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfAGT0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:26:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37124 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfAGT0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:26:52 -0500
Received: by mail-pf1-f196.google.com with SMTP id y126so650649pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 11:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wxiswoGvNOkYufXv5Pcu3TaPLYykn9tVz7mvJKc08DI=;
        b=cmCDrypPnt8EUytvGdbewQMgoz/hPT+gpbOnsVB5BwnJkF72eAQaG1by0PWmMkEPyr
         huveWqLA/MyrU+wWjO7A8w8XKfBGHgOYPRAMHVTjdZWOe1QX5NPxuDPw0APo3rhsesL/
         F6e35dQ9KPpbd0ubq915gJ1ogBoch9X70QEaU3ERXRtFuF1tt/RDziWIrkudbeVll1Uy
         EZe4WZoill3rqCJZY6PVIXT/IC32HKx/fhJiL7XKplXllHEuVgcWW9ZoemYiA9y6TuPI
         QD0HbSEJmLgOqdpJRQH+BmILrhrpKJnryfoWs8E164DwzpjP8BtlrI3BFrpciMPYicMJ
         Wv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wxiswoGvNOkYufXv5Pcu3TaPLYykn9tVz7mvJKc08DI=;
        b=NwHxZigcuTN8VMXpHWU468nr26hhP3YWX6iM/JKKjr48EUmV4fREaohXSLnpDEUeJE
         yWOJSBuIy5YVVjgOVvitrsTxpcEUYVdS5lkJXwfkI6fsJOsQ6KjyvSphsniPj4ThNRDE
         ettUlGCFPQUh3t/YX3nuCKyJUMMtlzaJFtJimlkpJdi1S4OG9DNPyNHsZ6ItxezYnOWJ
         8rHPPZw6oS1HCcLGr6j9OiEDhT2S/tAVKnfcxEkXwHRmsHodrdsiscOBaspn9YCN4sho
         H2XIYvfmAo+qIVrymKFjn1gDMKx2vYKbZEGYVqC44CERMx/+AXbbebOdlSDgfA8399l4
         eBlQ==
X-Gm-Message-State: AA+aEWYU3jfjnxoZxTBxBljJum/JkzClw/I/Tjq5MVDnCo8tY5NzdYWp
        korh5uoS9Gyrnpt0z4CmjMY=
X-Google-Smtp-Source: AFSGD/UY4WO0yluwo2V/LPLQ1P5Rk+InUdF7bPXGgcVRTstPv9PWj4ji5zNT2jm2TekD8Neblf42MA==
X-Received: by 2002:a62:fc8a:: with SMTP id e132mr63134919pfh.176.1546889211198;
        Mon, 07 Jan 2019 11:26:51 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u70sm117797246pfa.176.2019.01.07.11.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 11:26:50 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:26:48 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@kernel.org>
Subject: Re: Linux 5.0-rc1 (test results)
Message-ID: <20190107192648.GA10789@roeck-us.net>
References: <CAHk-=wgKYnrL3LjhVkH2Fp+ecmWhLqezT9zmR6CzfcpwcJX0qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgKYnrL3LjhVkH2Fp+ecmWhLqezT9zmR6CzfcpwcJX0qA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 06:14:15PM -0800, Linus Torvalds wrote:
> So this was a fairly unusual merge window with the holidays, and as a
> result I'm not even going to complain about the pull requests that
> ended up coming in late. It all mostly worked out fine, I think. And
> lot of people got their pull requests in early, and hopefully had a
> calm holiday season. Thanks again to everybody.
> 
> The numbering change is not indicative of anything special. If you
> want to have an official reason, it's that I ran out of fingers and
> toes to count on, so 4.21 became 5.0. There's no nice git object
> numerology this time (we're _about_ 6.5M objects in the git repo), and
> there isn't any major particular feature that made for the release
> numbering either. Of course, depending on your particular interests,
> some people might well find a feature _they_ like so much that they
> think it can do as a reason for incrementing the major number.
> 
> So go wild. Make up your own reason for why it's 5.0.
> 
> Because as usual, there's a lot of changes in there. Not because this
> merge window was particularly big - but even our smaller merge windows
> aren't exactly small. It's a very solid and average merge window with
> just under 11k commits (or about 11.5k if you count merges).
> 
> The stats look fairly normal. About 50% is drivers, 20% is
> architecture updates, 10% is tooling, and the remaining 20% is all
> over (documentation, networking, filesystems, header file updates,
> core kernel code..). Nothing particular stands out, although I do like
> seeing how some ancient drivers are getting put out to pasture
> (*cought*isdn*cough*).
> 
> As usual even the shortlog is much too big to post, so the summary
> below is only a list of the pull requests I merged.
> 
> Go test. Kick the tires. Be the first kid on your block running a 5.0
> pre-release kernel.
> 

For v5.0-rc1-1-g3bd6e94bec12:

Build results:
	total: 158 pass: 155 fail: 3
Failed builds: 
	csky:defconfig 
	csky:allnoconfig
	csky:tinyconfig 
Qemu test results:
	total: 332 pass: 332 fail: 0

mm/memory.c: In function ‘__pte_alloc’:
mm/memory.c:406:18: error: too few arguments to function ‘pte_alloc_one’

mm/memory.c: In function ‘__pte_alloc_kernel’:
mm/memory.c:439:15: error: too few arguments to function ‘pte_alloc_one_kernel’

mm/memory.c: In function ‘do_fault_around’:
mm/memory.c:3363:23: error: too few arguments to function ‘pte_alloc_one’

Bisect points to commit 4cf58924951ef ("mm: treewide: remove unused address
argument from pte_alloc functions"). Interesting - wasn't that supposed
to be automatic ?

csky does use the the removed address argument, so I won't even try to
provide a patch. Copying csky maintainer instead.

Guenter

---
# bad: [3bd6e94bec122a951d462c239b47954cf5f36e33] arch: restore generic-y += shmparam.h for some architectures
# good: [3fed6ae4b027f9c93be18520f87bd06bdffd196b] ia64: fix compile without swiotlb
git bisect start 'HEAD' '3fed6ae4b027'
# bad: [e9666d10a5677a494260d60d1fa0b73cc7646eb3] jump_label: move 'asm goto' support test to Kconfig
git bisect bad e9666d10a5677a494260d60d1fa0b73cc7646eb3
# bad: [b23b0ea3708c3dec599966fc856836aca48835b9] Merge tag 'armsoc-late' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
git bisect bad b23b0ea3708c3dec599966fc856836aca48835b9
# bad: [9ee3b3f4a5eb523ef27675ac2fcd2269b9d68767] Merge tag 'csky-for-linus-4.21' of git://github.com/c-sky/csky-linux
git bisect bad 9ee3b3f4a5eb523ef27675ac2fcd2269b9d68767
# good: [655c16a8ce9c15842547f40ce23fd148aeccc074] exec: separate MM_ANONPAGES and RLIMIT_STACK accounting
git bisect good 655c16a8ce9c15842547f40ce23fd148aeccc074
# bad: [a65981109f294ba7e64b33ad3b4575a4636fce66] Merge branch 'akpm' (patches from Andrew)
git bisect bad a65981109f294ba7e64b33ad3b4575a4636fce66
# bad: [3bb5f4ac55dd91d516e7e36b45c94bd57efbb068] kernel/locking/mutex.c: remove caller signal_pending branch predictions
git bisect bad 3bb5f4ac55dd91d516e7e36b45c94bd57efbb068
# good: [b058809bfc8faeb7b7cae047666e23375a060059] scripts/gdb: fix lx-version string output
git bisect good b058809bfc8faeb7b7cae047666e23375a060059
# bad: [4cf58924951ef80eec636b863e7a53973c44261a] mm: treewide: remove unused address argument from pte_alloc functions
git bisect bad 4cf58924951ef80eec636b863e7a53973c44261a
# good: [ff1522bb7d98450c72aea729f0b4147bc9986aed] initramfs: cleanup incomplete rootfs
git bisect good ff1522bb7d98450c72aea729f0b4147bc9986aed
# first bad commit: [4cf58924951ef80eec636b863e7a53973c44261a] mm: treewide: remove unused address argument from pte_alloc functions
