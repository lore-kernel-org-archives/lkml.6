Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F6FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDF620872
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 23:54:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKUyujU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbfAJXyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 18:54:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41037 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbfAJXyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 18:54:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so5880130plm.8;
        Thu, 10 Jan 2019 15:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9OSJXwq+5tHO1JQDm4KQG1s2hskv8QIur7ekeZsRXkg=;
        b=NKUyujU/HW6Jul/7mEtDclb690I9Mkqs4AQTiqyhim0/HhOTNB5FC/A1ujHYUxRtnY
         Klq3zq+w5odZCBy96NIIde4A5VA9ow4Sy02iRtIdxg8qC7V2nPfg/flQ0XrlH41SZVge
         UNqEO/T4zz3qbjoU2cBsDS6hNzn8QvOa4/IgtiZRa2ApN3zbJ2etKTDeUOaEYrk88Tux
         X1bNidEJMzk+e1kJ+9kxoeP/TF3Byu2UjWWnsRFkntCQ6usFRWp1UqFVKKIWtAWFM5/7
         6Qb+pJnLJbXfX5Z4F/CIRsyw6o5cilIRmSD93ONvYBM7jl5EI0t49mgt6iXLEba+3hKY
         M1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9OSJXwq+5tHO1JQDm4KQG1s2hskv8QIur7ekeZsRXkg=;
        b=RQqtnTYaxPbJVlBeZ4D9qELoyuk+FEusp+BwkH0sLlxLgBUAJsER/jTuMUPJCBy0aw
         NCXn88x52fMl+xPBL9ahYCBTS6EJ0zZ/FAhJGaunL9ZE9K61uOEW9rYayDmDkCQW0e1I
         GKhEsCL6mfiy8Zmsra/7b1fBhr22HDZDHoXQMnCQnyEEyTChOCh+dErYLIVVtggNlARp
         n4lVmJekumO/g/p+Ir/huLz7E1la1DJHGQth5BxAcd6qmqIAk1RI2VsiaBLA6+AHNNzA
         Jt3YLwFAuf5JZlTn8E8Bue1LdppBAMRYEyJCph3GCI0PIDnwICEeZtmGpaP3sst5qwzT
         6Dwg==
X-Gm-Message-State: AJcUukeASUHPYRez24yTG7GkB9ItIm16gOJgcRAeOWeUUY73vI0vOyMu
        fgoc3g1z2HaiBHjzvvWuPJw=
X-Google-Smtp-Source: ALg8bN4wLm8yKI8ZaVpCWfmkGv4jymJG3QiJEV0onwiLNmN/ZkEDJPA8s7vMNUR5XQzNbkgxQkQdaA==
X-Received: by 2002:a17:902:3f81:: with SMTP id a1mr12223329pld.258.1547164471091;
        Thu, 10 Jan 2019 15:54:31 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j197sm116689262pgc.76.2019.01.10.15.54.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 15:54:29 -0800 (PST)
Date:   Thu, 10 Jan 2019 15:54:28 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-sh@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH 2/2] sh: generate uapi header and syscall table header
 files
Message-ID: <20190110235428.GA10016@roeck-us.net>
References: <1546443445-21075-1-git-send-email-firoz.khan@linaro.org>
 <1546443445-21075-3-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546443445-21075-3-git-send-email-firoz.khan@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2019 at 09:07:25PM +0530, Firoz Khan wrote:
> Unified system call table generation script must be run to
> generate unistd_32.h and syscall_table.h files. This patch
> will have changes which will invokes the script.
> 
> This patch will generate unistd_32.h and syscall_table.h
> files by the syscall table generation script invoked by
> sh/Makefile and the generated files against the removed
> files must be identical.
> 
> The generated uapi header file will be included in uapi/-
> asm/unistd.h and generated system call table header file
> will be included by kernel/syscall_32.S file.
> 
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Have you tested this patch ?

Building sh:defconfig ... failed
--------------
Error log:
make[2]: *** No rule to make target
'/opt/buildbot/slave/next-next/build/scripts/syscalltbl.sh',
	needed by 'arch/sh/include/generated/asm/syscall_table.h'.  Stop.

This affects all 'sh' builds. Not surprisingly, reverting the patch fixes
the problem.

Guenter

---
# bad: [6cab33afc3dd17bd9922c99a828f5680b4667cd9] Add linux-next specific files for 20190110
# good: [bfeffd155283772bbe78c6a05dec7c0128ee500c] Linux 5.0-rc1
git bisect start 'HEAD' 'v5.0-rc1'
# good: [45daa05b201d684d42a186970731a9e39f75beb7] Merge remote-tracking branch 'mtd/mtd/next'
git bisect good 45daa05b201d684d42a186970731a9e39f75beb7
# good: [62d9bf7cbfd16d41f30de4439d7349c70d99923b] Merge remote-tracking branch 'tip/auto-latest'
git bisect good 62d9bf7cbfd16d41f30de4439d7349c70d99923b
# good: [cff8f6ab40ac1f5681ba37a663382d0c5d1b07d1] Merge remote-tracking branch 'vhost/linux-next'
git bisect good cff8f6ab40ac1f5681ba37a663382d0c5d1b07d1
# bad: [ed7209d69de4c01d589b030c34412d093aac3801] mm: initialize MAX_ORDER_NR_PAGES at a time instead of doing larger sections
git bisect bad ed7209d69de4c01d589b030c34412d093aac3801
# bad: [8fd9cdac0385dcec3534d79bf6ad29e33a6cfe1f] vmalloc: add test driver to analyse vmalloc allocator
git bisect bad 8fd9cdac0385dcec3534d79bf6ad29e33a6cfe1f
# good: [e804aa1e321d349514c121c3bff66dee1cff3dd5] sh: remove nargs from __SYSCALL
git bisect good e804aa1e321d349514c121c3bff66dee1cff3dd5
# bad: [7f3303ead0bd6fc02ca0d5a2e6a3ce8f653afbea] mm: reuse only-pte-mapped KSM page in do_wp_page()
git bisect bad 7f3303ead0bd6fc02ca0d5a2e6a3ce8f653afbea
# bad: [7dc035ee0653362ae11187152ac5942e230fb523] fs/file.c: initialize init_files.resize_wait
git bisect bad 7dc035ee0653362ae11187152ac5942e230fb523
# bad: [539eec285bc3a61570493f08fca6d84e09e77d3c] ocfs2: clear zero in unaligned direct IO
git bisect bad 539eec285bc3a61570493f08fca6d84e09e77d3c
# bad: [63ef58895f79a7dea083dff346a6504b87e1a7dc] lib/debugobjects.c: move printk out of db lock critical sections
git bisect bad 63ef58895f79a7dea083dff346a6504b87e1a7dc
# bad: [60a47bb1b736b2be71ff6f256693595af5c707e8] sh: generate uapi header and syscall table header files
git bisect bad 60a47bb1b736b2be71ff6f256693595af5c707e8
# first bad commit: [60a47bb1b736b2be71ff6f256693595af5c707e8] sh: generate uapi header and syscall table header files
