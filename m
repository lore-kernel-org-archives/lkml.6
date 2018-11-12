Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B4CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5AB620868
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="UivY+G/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5AB620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=natalenko.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbeKLTx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 14:53:28 -0500
Received: from vulcan.natalenko.name ([104.207.131.136]:40626 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbeKLTx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 14:53:28 -0500
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id D45DF468763;
        Mon, 12 Nov 2018 11:00:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1542016855;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIjnITL+Qix3ERbg+ppZVBVdtzYUaflwCxUYxkNdx+U=;
        b=UivY+G/5g0aKuA5alM2N7czeih+XA4p/cc723Fz7ApV+UB55Git2dpLfTbDjVp78fxPE5O
        yaMa/mD90iXzmmYbzFvwxwTXry6D+d4S/z7CEeVi973H3uFmduFylmssqkr5lc8OS9uY4G
        ilrYPwYgY3dxFRWA8pZMDg9qGTVUzZI=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 12 Nov 2018 11:00:55 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Angelo Ruocco <angeloruocco90@gmail.com>,
        Dennis Zhou <dennis@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        broonie@kernel.org, bfq-iosched@googlegroups.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 00/12] unify the interface of the proportional-share
 policy in blkio/io
In-Reply-To: <20181112095632.69114-1-paolo.valente@linaro.org>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
Message-ID: <9e8adb3271680165d85994a225713391@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=arc-20170712; t=1542016855;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIjnITL+Qix3ERbg+ppZVBVdtzYUaflwCxUYxkNdx+U=;
        b=U3OgXpaSRpHM+8NbZNfl6Q9oK+W68f9zBIOwl2DhUi18jP/RKVt0KwZWAkXmuzrL2K7kmU
        FXr89McMGEehh4wQPjB3rbnLLCPo2YWAvCQjFVTFv+Unr5f/fI3FmeM8TVKAqKKwAvHtjx
        xdvyS/HLhY54tPLW+HnWTs1DzzfMNZ4=
ARC-Seal: i=1; s=arc-20170712; d=natalenko.name; t=1542016855; a=rsa-sha256;
        cv=none;
        b=JhaZpFK5j553zyd8AtV8SpQ27i7rbxO3VfPZKRgnmDdUGHQFtZCjXEEJ4nheNxbKN//qIALrjvzBAcJ93I8BlJ2AM0mtnb7sn9p/uSUjvC69ZMEBK0/X/J9wdZFWHZ84gr1qFcxi78KAIX1to5KtcGTIX16h8ayLVDg9cthCLFE=
ARC-Authentication-Results: i=1;
        vulcan.natalenko.name;
        auth=pass smtp.auth=oleksandr@natalenko.name smtp.mailfrom=oleksandr@natalenko.name
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.11.2018 10:56, Paolo Valente wrote:
> Hi Jens, Tejun, all,
> about nine months ago, we agreed on a solution for unifying the
> interface of the proportional-share policy in blkio/io [1].  Angelo
> and I finally completed it.  Let me briefly recall the problem and the
> solution.
> 
> The current implementation of cgroups doesn't allow two or more
> entities, e.g., I/O schedulers, to share the same files.  So, if CFQ
> creates its files for the proportional-share policy, such as, e.g,
> weight files for blkio/io groups, BFQ cannot attach somehow to them.
> Thus, to enable people to set group weights with BFQ, I resorted to
> making BFQ create its own version of these common files, by prepending
> a bfq prefix.
> 
> Actually, no legacy code uses these different names, or is likely to
> do so.  Having these two sets of names is simply a source of
> confusion, as pointed out also, e.g., by Lennart Poettering (CCed
> here), and acknowledged by Tejun [2].
> 
> In [1] we agreed on a solution that solves this problem, by actually
> making it possible to share cgroups files.  Both writing to and
> reading from a shared file trigger the appropriate operation for each
> of the entities that share the file.  In particular, in case of
> reading,
> - if all entities produce the same output, the this common output is
>   shown only once;
> - if the outputs differ, then every per-entity output is shown,
>   preceded by the name of the entity that produced that output.
> 
> With this solution, legacy code that, e.g., sets group weights, just
> works, regardless of the I/O scheduler actually implementing
> proportional share.
> 
> But note that this extension is not restricted to only blkio/io.  The
> general group interface now enables files to be shared among multiple
> entities of any kind.
> 
> (I have also added a patch to fix some clerical errors in bfq doc,
> which I found while making the latter consistent with the new
> interface.)
> 
> Thanks,
> Paolo
> 
> [1] https://lkml.org/lkml/2018/1/4/667
> [2] https://github.com/systemd/systemd/issues/7057
> 
> Angelo Ruocco (7):
>   kernfs: add function to find kernfs_node without increasing ref
>     counter
>   cgroup: link cftypes of the same subsystem with the same name
>   cgroup: add owner name to cftypes
>   block, bfq: align min and default weights with cfq
>   cgroup: make all functions of all cftypes be invoked
>   block, cfq: allow cgroup files to be shared
>   block, throttle: allow sharing cgroup statistic files
> 
> Paolo Valente (5):
>   cgroup: add hook seq_show_cft with also the owning cftype as 
> parameter
>   block, cgroup: pass cftype to functions that need to use it
>   block, bfq: use standard file names for the proportional-share policy
>   doc, bfq-iosched: fix a few clerical errors
>   doc, bfq-iosched: make it consistent with the new cgroup interface
> 
>  Documentation/block/bfq-iosched.txt |  31 +++--
>  block/bfq-cgroup.c                  | 148 +++++++++++++-------
>  block/bfq-iosched.h                 |   4 +-
>  block/blk-cgroup.c                  |  22 +--
>  block/blk-throttle.c                |  24 ++--
>  block/cfq-iosched.c                 | 105 +++++++++++----
>  fs/kernfs/dir.c                     |  13 ++
>  include/linux/blk-cgroup.h          |  10 +-
>  include/linux/cgroup-defs.h         |  14 +-
>  include/linux/cgroup.h              |  13 ++
>  include/linux/kernfs.h              |   7 +
>  kernel/cgroup/cgroup.c              | 262 
> +++++++++++++++++++++++++++++-------
>  12 files changed, 483 insertions(+), 170 deletions(-)
> 
> --
> 2.16.1

I thought all the legacy stuff including CFS et al. is going to be 
removed in v4.21 completely…

-- 
   Oleksandr Natalenko (post-factum)
