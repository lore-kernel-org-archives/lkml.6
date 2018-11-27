Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F9BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119B720659
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n8Ig5tAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 119B720659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeK1EiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:38:05 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34451 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbeK1EiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:38:05 -0500
Received: by mail-ua1-f68.google.com with SMTP id z23so7924485uam.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxG22gKp3uE4WIbzN+Oih1tHSp7o6ihhKSzDyg1OL+k=;
        b=n8Ig5tAbA7o3/Ez/WMYwOM6FQ8Y7htlXMticvVSwbTd68NwdFgyL/WgOnsMP1ni1pW
         +STDRZ2AFIiJAy+B5Z9uUEyF+oxnMtVjLcHdm9Hmx/v9AvHS61VlBIbAUOani6h8lpAJ
         yz3zvL8AcXhbiLN04crZSzLzeHZC9ti8UKCIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxG22gKp3uE4WIbzN+Oih1tHSp7o6ihhKSzDyg1OL+k=;
        b=MxiiNMS6FF800hRVpwdwo6wF1NGrfrRCJCDWwZBoJRcH0gNafHf9Z7cHv/1M1CzdXU
         uHFhRm9IT09RRt+cbeAsmbWCxCSt3DseN232DQ688ws1HvIzeT65x2FWkakL+c3a32jn
         MjIf644/pTMGlrmo0U1HaJc5JtT9uQBTDAr6JTug40fKRsknPvll+Ntf3iWcLrKAPyLT
         G7PFA4n8fKWn0OJVW4WObS4af+HDjrvrlacOLIW6bkT7iY6Aw7dKWCoaWMUQ0FOjHGn1
         kRLa9q8YENSj/8hh6daf8kZxlYWmbESNAEwzB96y0zdEx7EUuaweJbLSBE/Qx+HTUh5s
         Retw==
X-Gm-Message-State: AA+aEWboG/tThf1YJVRE+QVyLFfu+8etM8uIFVd71rQWUB/zwoN6JdTk
        I/sJjbkX5Opn5tdkCSmqcP1Lb1iM0nQ=
X-Google-Smtp-Source: AFSGD/W507/zee/qMZIFioHQWNceZHPgNvwjwPN4D00O0UP8/8jK1ZzCbAhOgYgsfoKVBfFhUzQyOw==
X-Received: by 2002:ab0:5b1c:: with SMTP id u28mr14145975uae.135.1543340365895;
        Tue, 27 Nov 2018 09:39:25 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id n15sm2866187vsi.5.2018.11.27.09.39.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 09:39:24 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id t17so14283363vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 09:39:24 -0800 (PST)
X-Received: by 2002:a67:6cc1:: with SMTP id h184mr14355429vsc.149.1543340364044;
 Tue, 27 Nov 2018 09:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20181127035133.225592-3-dianders@chromium.org> <201811271333.8ZTVxYUT%fengguang.wu@intel.com>
In-Reply-To: <201811271333.8ZTVxYUT%fengguang.wu@intel.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 27 Nov 2018 09:39:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V087x+56aWFtJxg31O09cFUm00grH7bq1rLSwoq68WdA@mail.gmail.com>
Message-ID: <CAD=FV=V087x+56aWFtJxg31O09cFUm00grH7bq1rLSwoq68WdA@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, jhogan@kernel.org,
        linux-hexagon@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        dalias@libc.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        paulus@samba.org, Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        christophe.leroy@c-s.fr, mpe@ellerman.id.au, paul.burton@mips.com,
        rkuo@codeaurora.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 26, 2018 at 9:39 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Douglas,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on kgdb/kgdb-next]
> [also build test ERROR on v4.20-rc4 next-20181126]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/kgdb-Fix-kgdb_roundup_cpus/20181127-115425
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jwessel/kgdb.git kgdb-next
> config: sparc64-allyesconfig (attached as .config)
> compiler: sparc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=sparc64
>
> Note: the linux-review/Douglas-Anderson/kgdb-Fix-kgdb_roundup_cpus/20181127-115425 HEAD b8d0502e65f2d7a2187baa69870146a6fbf18c9f builds fine.
>       It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>    kernel/debug/debug_core.c: In function 'kgdb_roundup_cpus':
> >> kernel/debug/debug_core.c:261:18: error: 'struct debuggerinfo_struct' has no member named 'rounding_up'
>        kgdb_info[cpu].rounding_up = false;
>                      ^

Oops, I squashed this into the wrong patch.  It should have been in
patch #3.  Sorry about that.  I'll send out a quick v6.
