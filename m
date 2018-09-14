Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B388C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958122086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 01:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958122086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeINGel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 02:34:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbeINGel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 02:34:41 -0400
Received: from vmware.local.home (unknown [206.121.37.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84CED2086D;
        Fri, 14 Sep 2018 01:22:41 +0000 (UTC)
Date:   Thu, 13 Sep 2018 21:22:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        penguin-kernel@i-love.sakura.ne.jp,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20180913212239.112ab10b@vmware.local.home>
In-Reply-To: <20180913142802.GB517@tigerII.localdomain>
References: <20180620091541.GB444@jagdpanzerIV>
        <CACT4Y+bcp4fSBBq3F86T-C4+n-YkeXUGMqpvkJ6vj6mK-TU2EA@mail.gmail.com>
        <20180620110759.GD444@jagdpanzerIV>
        <CACT4Y+aER3O2x2ApM=MVFoFXhp_T_rUeyG9CBx031qyH0voSRg@mail.gmail.com>
        <20180620130628.GA1000@tigerII.localdomain>
        <CAG_fn=XuZo5yrZzVizP26iV6eFfJtAHUs4NsDFXFyvnaJkdSQw@mail.gmail.com>
        <20180912065307.GA606@jagdpanzerIV>
        <20180912120548.4280f04a@vmware.local.home>
        <20180913071204.GA604@jagdpanzerIV>
        <20180913122625.6ieyexpcmlc5z2it@pathway.suse.cz>
        <20180913142802.GB517@tigerII.localdomain>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Sep 2018 23:28:02 +0900
Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:

> Good call. It was a fast path for pr_cont("\n").
> But it made me wondering and I did some grepping
> 

[..]

> kernel/trace/ftrace.c:          pr_cont("\n expected tramp: %lx\n", ip);

Note, looking at the history of that, I was just combining a lone "\n"
with the next string. The code before this print add info to the line
depending on the input, thus none do a "\n". The "expected tramp" part
is added to the next line, but I'm fine if you want to break this up.
This print is very unlikely done with other prints happening. It
happens when modifying (serially) ftrace nops to calls or back to nops.

Feel free to send a patch that breaks it up into:

	pr_cont("\n");
	pr_info(" expected tramp: %lx\n", ip);

-- Steve
