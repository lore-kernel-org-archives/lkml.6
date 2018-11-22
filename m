Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD01EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3272081C
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 14:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXhWTROb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3272081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395544AbeKWBKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:10:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:41816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388795AbeKWBKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 20:10:36 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2673B2081C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 14:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542897059;
        bh=WrGUn0fxfSQ2mN56S7rSgwTWITWbwB/PeweoQG01Z70=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uXhWTRObUDwx49Zi3HygeWtOQE+PoVALiB/n/6dRMwTgT5XvFD4/OpTVhUr/onogd
         YwarLDe4RL4TG5fS84hEN/ag3t6093tEVIfBxmg2YR+jHC+7Dv5xdvNPpF+XOW+ziL
         gKhQJ0cZzIHvZO2kCj+9EXWLbcFtl7FIWF7ky25w=
Received: by mail-wr1-f45.google.com with SMTP id v13so6000109wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 06:30:59 -0800 (PST)
X-Gm-Message-State: AA+aEWbax8nA3z6K+eOuFSLZMVv8WqTO3r8FKkjtXwWkbb7E0umGnl1m
        ZDtTOmXBU3YLcYflAk1DaOLd3V5YwnM3r3WE+vV84Q==
X-Google-Smtp-Source: AFSGD/VKgjMBj9ndZrjnWValdGZR7+wLFSGhE0Q9lvknNaA1W20pj7k0sJzKh+hsrcJV9PUqCaz/DdGIjiJQ3ckRuXE=
X-Received: by 2002:adf:ea81:: with SMTP id s1mr9769861wrm.309.1542897057685;
 Thu, 22 Nov 2018 06:30:57 -0800 (PST)
MIME-Version: 1.0
References: <tip-a2aa52ab16efbee40ad118ebac4a5e438f5b43ee@git.kernel.org>
In-Reply-To: <tip-a2aa52ab16efbee40ad118ebac4a5e438f5b43ee@git.kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 22 Nov 2018 06:30:45 -0800
X-Gmail-Original-Message-ID: <CALCETrUY9vp21JJGwErvHwrQAfc1nL4iyJZJb2GvnS1pe8H1MQ@mail.gmail.com>
Message-ID: <CALCETrUY9vp21JJGwErvHwrQAfc1nL4iyJZJb2GvnS1pe8H1MQ@mail.gmail.com>
Subject: Re: [tip:x86/mm] x86/fault: Clean up the page fault oops decoder a bit
To:     Rik van Riel <riel@surriel.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Lutomirski <luto@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 2:13 AM tip-bot for Ingo Molnar
<tipbot@zytor.com> wrote:
>
> Commit-ID:  a2aa52ab16efbee40ad118ebac4a5e438f5b43ee
> Gitweb:     https://git.kernel.org/tip/a2aa52ab16efbee40ad118ebac4a5e438f5b43ee
> Author:     Ingo Molnar <mingo@kernel.org>
> AuthorDate: Thu, 22 Nov 2018 09:34:03 +0100
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Thu, 22 Nov 2018 09:38:13 +0100
>
> x86/fault: Clean up the page fault oops decoder a bit

Thanks!

>
>  - Make the oops messages a bit less scary (don't mention 'HW errors')

I thought the goal was to divert bug reports to the hardware vendors.
"My Linux laptop crashed.  It said that hardware was WRITE PROT.  Fix
it!!!!!!!1111!"  :)

--Andy
