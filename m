Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36920C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBECC21479
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="efsoaVoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBECC21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeJJUSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:18:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726573AbeJJUSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:18:46 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DEAE21479;
        Wed, 10 Oct 2018 12:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539176201;
        bh=TNIyknD+anM6E1euzhFaEFBftP/T+8I8M+MhUdEyp+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=efsoaVoB4cCvvHXz1Y5ni0Tyxk+ktNz5Z1IYR8TsTYvmXshALpJy+9m+pCeWKEeMN
         p8zXWuzdl/O56QPXlOvBnDiUvQy6Eej/k9m3ATUBuNsuWIOSE4Rg7iHuSazqX8qSxK
         +mT3yusoy/9bxmKEkZCNNgcXy0vxNs5pCIykXewQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 9C8CE142C5E; Wed, 10 Oct 2018 09:56:39 -0300 (-03)
Date:   Wed, 10 Oct 2018 09:56:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Benjamin Peterson <benjamin@python.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace beautify: Beautify flags of mount(2) and
 umount(2).
Message-ID: <20181010125639.GI10775@kernel.org>
References: <20180828035344.31500-1-benjamin@python.org>
 <20180830182848.GE6097@kernel.org>
 <1535665851.2058334.1491869472.4E860103@webmail.messagingengine.com>
 <1539143546.2716467.1536750504.65ADF11A@webmail.messagingengine.com>
 <20181010125506.GH10775@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010125506.GH10775@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 10, 2018 at 09:55:06AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Oct 09, 2018 at 08:52:26PM -0700, Benjamin Peterson escreveu:
> > Hi Arnaldo,
> > Did you get a chance to look at this again?
> 
> Thanks, for pinging me about it, will check.

So, this is already upstream, I'll check the other bit.

commit 3de3e8bbf302545ef9acebb9f900939ac5c3820f
Author: Benjamin Peterson <benjamin@python.org>
Date:   Mon Aug 27 20:53:44 2018 -0700

    perf trace beauty: Alias 'umount' to 'umount2'
    
    Before:
    
      # perf trace -e *mount* umount /dev/mapper/fedora-home /s
        11.576 ( 0.004 ms) umount/3138 umount2(arg0: 94501956754656, arg1: 0, arg2: 1, arg3: 140051050083104, arg4: 4, arg5: 94501956755136) = -1 EINVAL Invalid argument
      #
    
    After:
    
      # perf trace -e *mount* umount /s
         0.000 ( 9.241 ms): umount/5251 umount2(name: 0x55f74a986480) = 0
    
    Signed-off-by: Benjamin Peterson <benjamin@python.org>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: http://lkml.kernel.org/r/20180828035344.31500-1-benjamin@python.org
    [ split from a larger patch ]
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 97ace635bed8..c106189f4066 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -825,6 +825,7 @@ static struct syscall_fmt {
 	  .arg = { [2] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
 	{ .name	    = "tkill",
 	  .arg = { [1] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
+	{ .name     = "umount2", .alias = "umount", },
 	{ .name	    = "uname", .alias = "newuname", },
 	{ .name	    = "unlinkat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 
> - Arnaldo
>  
> > On Thu, Aug 30, 2018, at 14:50, Benjamin Peterson wrote:
> > > Thanks for the review.
> > > 
> > > On Thu, Aug 30, 2018, at 11:28, Arnaldo Carvalho de Melo wrote:
> > > > Em Mon, Aug 27, 2018 at 08:53:44PM -0700, Benjamin Peterson escreveu:
> > > > > Example output of perf trace -e mount,umount2:
> > > > > 
> > > > >   6243.930 ( 0.052 ms): mount/30976 mount(dev_name: 0x55dc541bb920, dir_name: 0x55dc541bc960, type: 0x55dc541b9c40, flags: BIND) = 0
> > > > >   7851.821 (26.015 ms): umount/30983 umount2(name: 0x558daa82cf50, flags: MNT_FORCE                        ) = 0
> > > > > 
> > > > > Signed-off-by: Benjamin Peterson <benjamin@python.org>
> > > > 
> > > > So, I tried:
> > > > 
> > > > Before your patch:
> > > > 
> > > >   # perf trace -e *mount* mount /dev/mapper/fedora-home /s
> > > >      0.000 ( 4.335 ms): mount/3126 mount(dev_name: 0x55deecc4d480, 
> > > > dir_name: 0x55deecc4d4a0, type: 0x55deecc53880, flags: 3236757504) = 0
> > > >   #
> > > >   # perf trace -e *mount* umount /dev/mapper/fedora-home /s
> > > >          ? (         ): umount/3138  ... [continued]: umount2()) = 0
> > > >     11.576 (umount:  0.004 ms): /s: not mounted.umount/
> > > > 3138 umount2(arg0: 94501956754656, arg1: 0, arg2: 1, arg3: 
> > > > 140051050083104, arg4: 4, arg5: 94501956755136) = -1 EINVAL Invalid 
> > > > argument
> > > >   #
> > > > 
> > > > After:
> > > > 
> > > > [root@jouet ~]# perf trace -e *mount* mount /dev/mapper/fedora-home /s
> > > >      0.000 ( 1.213 ms): mount/5244 mount(dev_name: 0x5558c1169480, 
> > > > dir_name: 0x5558c11694a0, type: 0x5558c116f880, flags: ) = 0
> > > > [root@jouet ~]# perf trace -e *mount* umount /s
> > > >      0.000 ( 9.241 ms): umount/5251 umount2(name: 
> > > > 0x55f74a986480                                          ) = 0
> > > > 
> > > > The flags for mount got empty? Can you pleaes check that? I.e. using the
> > > > default mount options, not specifying a 'bind' mount like you did.
> > > 
> > > That comes from these lines in syscall_arg__scnprintf_mount_flags:
> > > 
> > > if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
> > > 	flags &= ~MS_MGC_MSK;
> > > 
> > > The reason for this is explained in the comment for do_mount in fs/namespace.c:
> > > 
> > > /*
> > >  * Pre-0.97 versions of mount() didn't have a flags word.
> > >  * When the flags word was introduced its top half was required
> > >  * to have the magic value 0xC0ED, and this remained so until 2.4.0-test9.
> > >  * Therefore, if this magic number is present, it carries no information
> > >  * and must be discarded.
> > > */
> > > 
> > > (I used a bind mount for my commit message example because a "default" 
> > > mount() doesn't use any flags.)
> > > 
> > > > 
> > > > I'm splitting this patch so that the aliasing of 'umount2' to 'umount'
> > > > gets merged now,
> > > > 
> > > > Check my perf/core branch at:
> > > > 
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git
> > > 
> > > LGTM. Thanks
> > > 
