Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A72FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B60E520837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="br9e3Osg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B60E520837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeH3WcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:32:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727748AbeH3WcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:32:25 -0400
Received: from jouet.infradead.org (unknown [189.43.51.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 349DE20835;
        Thu, 30 Aug 2018 18:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535653737;
        bh=nZXCBhnAYxIvZExdTki87i1+Ypmu1nE4Br9Su32v/C8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=br9e3OsgvTqZe9qvqtqkIxsiRBgowbGJBtxYJ3atkeVRNDPwDuCrAad7mcezLNJD5
         gvkXcv3cmAWagAe1hFXM2Wxh99jPIIuiDA4CNu9QuhqVw9VRL1N4ZaE7rmM4qVxIBn
         ItYRTV1Om7x8VJ+2r7VF/nAEMY7Hdg3p7ixRkSkM=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 6A7A7141C3F; Thu, 30 Aug 2018 15:28:48 -0300 (-03)
Date:   Thu, 30 Aug 2018 15:28:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Benjamin Peterson <benjamin@python.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf trace beautify: Beautify flags of mount(2) and
 umount(2).
Message-ID: <20180830182848.GE6097@kernel.org>
References: <20180828035344.31500-1-benjamin@python.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180828035344.31500-1-benjamin@python.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 27, 2018 at 08:53:44PM -0700, Benjamin Peterson escreveu:
> Example output of perf trace -e mount,umount2:
> 
>   6243.930 ( 0.052 ms): mount/30976 mount(dev_name: 0x55dc541bb920, dir_name: 0x55dc541bc960, type: 0x55dc541b9c40, flags: BIND) = 0
>   7851.821 (26.015 ms): umount/30983 umount2(name: 0x558daa82cf50, flags: MNT_FORCE                        ) = 0
> 
> Signed-off-by: Benjamin Peterson <benjamin@python.org>

So, I tried:

Before your patch:

  # perf trace -e *mount* mount /dev/mapper/fedora-home /s
     0.000 ( 4.335 ms): mount/3126 mount(dev_name: 0x55deecc4d480, dir_name: 0x55deecc4d4a0, type: 0x55deecc53880, flags: 3236757504) = 0
  #
  # perf trace -e *mount* umount /dev/mapper/fedora-home /s
         ? (         ): umount/3138  ... [continued]: umount2()) = 0
    11.576 (umount:  0.004 ms): /s: not mounted.umount/
3138 umount2(arg0: 94501956754656, arg1: 0, arg2: 1, arg3: 140051050083104, arg4: 4, arg5: 94501956755136) = -1 EINVAL Invalid argument
  #

After:

[root@jouet ~]# perf trace -e *mount* mount /dev/mapper/fedora-home /s
     0.000 ( 1.213 ms): mount/5244 mount(dev_name: 0x5558c1169480, dir_name: 0x5558c11694a0, type: 0x5558c116f880, flags: ) = 0
[root@jouet ~]# perf trace -e *mount* umount /s
     0.000 ( 9.241 ms): umount/5251 umount2(name: 0x55f74a986480                                          ) = 0

The flags for mount got empty? Can you pleaes check that? I.e. using the
default mount options, not specifying a 'bind' mount like you did.

I'm splitting this patch so that the aliasing of 'umount2' to 'umount'
gets merged now,

Check my perf/core branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git

- Arnaldo

> ---
>  tools/perf/builtin-trace.c            |  5 ++
>  tools/perf/trace/beauty/mount_flags.c | 79 +++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
>  create mode 100644 tools/perf/trace/beauty/mount_flags.c
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 22ab8e67c760..3cffb25d1928 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -603,6 +603,7 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
>  #include "trace/beauty/futex_val3.c"
>  #include "trace/beauty/mmap.c"
>  #include "trace/beauty/mode_t.c"
> +#include "trace/beauty/mount_flags.c"
>  #include "trace/beauty/msg_flags.c"
>  #include "trace/beauty/open_flags.c"
>  #include "trace/beauty/perf_event_open.c"
> @@ -722,6 +723,8 @@ static struct syscall_fmt {
>  	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* addr */ },
>  		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
>  		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ }, }, },
> +	{ .name     = "mount",
> +	  .arg = { [3] = { .scnprintf = SCA_MOUNT_FLAGS, /* flags */ }, }, },
>  	{ .name	    = "mprotect",
>  	  .arg = { [0] = { .scnprintf = SCA_HEX,	/* start */ },
>  		   [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ }, }, },
> @@ -830,6 +833,8 @@ static struct syscall_fmt {
>  	  .arg = { [2] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
>  	{ .name	    = "tkill",
>  	  .arg = { [1] = { .scnprintf = SCA_SIGNUM, /* sig */ }, }, },
> +	{ .name     = "umount2", .alias = "umount",
> +	  .arg = { [1] = { .scnprintf = SCA_UMOUNT_FLAGS, /* flags */ }, }, },
>  	{ .name	    = "uname", .alias = "newuname", },
>  	{ .name	    = "unlinkat",
>  	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
> diff --git a/tools/perf/trace/beauty/mount_flags.c b/tools/perf/trace/beauty/mount_flags.c
> new file mode 100644
> index 000000000000..86790b82c869
> --- /dev/null
> +++ b/tools/perf/trace/beauty/mount_flags.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <sys/mount.h>
> +
> +static size_t syscall_arg__scnprintf_mount_flags(char *bf, size_t size, struct syscall_arg *arg)
> +{
> +	size_t printed = 0;
> +	int flags = arg->val;
> +
> +	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
> +		flags &= ~MS_MGC_MSK;
> +
> +#define	P_FLAG(n) \
> +	if (flags & MS_##n) { \
> +		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", #n); \
> +		flags &= ~MS_##n; \
> +	}
> +
> +	P_FLAG(RDONLY);
> +	P_FLAG(NOSUID);
> +	P_FLAG(NODEV);
> +	P_FLAG(NOEXEC);
> +	P_FLAG(SYNCHRONOUS);
> +	P_FLAG(REMOUNT);
> +	P_FLAG(MANDLOCK);
> +	P_FLAG(DIRSYNC);
> +	P_FLAG(NOATIME);
> +	P_FLAG(NODIRATIME);
> +	P_FLAG(BIND);
> +	P_FLAG(MOVE);
> +	P_FLAG(REC);
> +	P_FLAG(SILENT);
> +	P_FLAG(POSIXACL);
> +	P_FLAG(UNBINDABLE);
> +	P_FLAG(PRIVATE);
> +	P_FLAG(SLAVE);
> +	P_FLAG(SHARED);
> +	P_FLAG(RELATIME);
> +	P_FLAG(KERNMOUNT);
> +	P_FLAG(I_VERSION);
> +	P_FLAG(STRICTATIME);
> +	P_FLAG(LAZYTIME);
> +	P_FLAG(ACTIVE);
> +	P_FLAG(NOUSER);
> +
> +#undef P_FLAG
> +
> +	if (flags)
> +		printed += scnprintf(bf + printed, size - printed, "%s%#x", printed ? "|" : "", flags);
> +
> +	return printed;
> +}
> +
> +#define SCA_MOUNT_FLAGS syscall_arg__scnprintf_mount_flags
> +
> +static size_t syscall_arg__scnprintf_umount_flags(char *bf, size_t size, struct syscall_arg *arg)
> +{
> +	size_t printed = 0;
> +	int flags = arg->val;
> +
> +#define	P_FLAG(n) \
> +	if (flags & n) { \
> +		printed += scnprintf(bf + printed, size - printed, "%s%s", printed ? "|" : "", #n); \
> +		flags &= ~n; \
> +	}
> +
> +	P_FLAG(MNT_FORCE);
> +	P_FLAG(MNT_DETACH);
> +	P_FLAG(MNT_EXPIRE);
> +	P_FLAG(UMOUNT_NOFOLLOW);
> +
> +#undef P_FLAG
> +
> +	if (flags)
> +		printed += scnprintf(bf + printed, size - printed, "%s%#x", printed ? "|" : "", flags);
> +
> +	return printed;
> +}
> +
> +#define SCA_UMOUNT_FLAGS syscall_arg__scnprintf_umount_flags
> -- 
> 2.17.1
