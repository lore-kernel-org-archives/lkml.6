Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1858AC282CA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 00:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37012148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 00:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfA1AAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 19:00:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfA1AAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 19:00:52 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7ACBC002964;
        Mon, 28 Jan 2019 00:00:50 +0000 (UTC)
Received: from sandy.ghostprotocols.net (ovpn-112-13.phx2.redhat.com [10.3.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E6E5E5C21A;
        Mon, 28 Jan 2019 00:00:49 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id BE5044AE2; Sun, 27 Jan 2019 22:00:46 -0200 (BRST)
Date:   Sun, 27 Jan 2019 22:00:46 -0200
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        peterz@infradead.org, mingo@elte.hu, ak@linux.intel.com,
        kan.liang@intel.com
Subject: Re: [PATCH] perf tools api fs: make xxx__mountpoint() more scalable
Message-ID: <20190128000046.GB3883@redhat.com>
References: <1548285047-5808-1-git-send-email-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548285047-5808-1-git-send-email-eranian@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 28 Jan 2019 00:00:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jan 23, 2019 at 03:10:47PM -0800, Stephane Eranian escreveu:
> The xxx_mountpoint() interface provided by fs.c finds
> mount points for common pseudo filesystems. The first
> time xxx_mountpoint() is invoked, it scans the mount
> table (/proc/mounts) looking for a match. If found, it
> is cached. The price to scan /proc/mounts is paid once
> if the mount is found.
> 
> When the mount point is not found, subsequent calls to
> xxx_mountpoint() scan /proc/mounts over and over again.
> There is no cacheing.
> 
> This causes a scaling issue in perf record with hugeltbfs__mountpoint().
> The function is called for each process found in synthesize__mmap_events().
> If the machine has thousands of processes and if the /proc/mounts has many
> entries this could cause major overhead in perf record. We have observed
> multi-second slowdowns on some configurations.
> 
> As an example on a laptop:
> 
> Before:
> $ sudo umount /dev/hugepages
> $ strace -etrace=open -o /tmp/tt perf record -a ls
> $ fgrep mounts /tmp/tt
> 285
> 
> After:
> $ sudo umount /dev/hugepages
> $ strace -etrace=open -o /tmp/tt perf record -a ls
> $ fgrep mounts /tmp/tt
> 1
> 
> One could argue that the non-cacheing in case the moint point is not found
> is intentional. That way subsequent calls may discover a moint point if
> the syadmin mounts the filesystem. But the same argument could be made
> against cacheing the moint point. It could be unmounted causing errors.
> It all depends on the intent of the interface. This patch assumes it
> is expected to scan /proc/mounts once. The patch documents the cacheing
> behavior in the fs.h header file.
> 
> An alternative would be to just fix perf record. But it would solve
> the problem with hugetlbs__mountpoint() but there could be similar
> issues (possibly down the line) with other xxx_mountpoint() calls
> in perf or other tools.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  tools/lib/api/fs/fs.c | 19 +++++++++++++++++++
>  tools/lib/api/fs/fs.h | 11 +++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
> index 7aba8243a0e7..6934da54c96b 100644
> --- a/tools/lib/api/fs/fs.c
> +++ b/tools/lib/api/fs/fs.c
> @@ -90,6 +90,7 @@ struct fs {
>  	const char * const	*mounts;
>  	char			 path[PATH_MAX];
>  	bool			 found;
> +	bool			 checked;
>  	long			 magic;
>  };
>  
> @@ -111,31 +112,37 @@ static struct fs fs__entries[] = {
>  		.name	= "sysfs",
>  		.mounts	= sysfs__fs_known_mountpoints,
>  		.magic	= SYSFS_MAGIC,
> +		.checked= false,

No need for these initializations, 0 == false, and since we initialize
some of the other fields, the ones that haven't are set to zero.

>  	},
>  	[FS__PROCFS] = {
>  		.name	= "proc",
>  		.mounts	= procfs__known_mountpoints,
>  		.magic	= PROC_SUPER_MAGIC,
> +		.checked= false,
>  	},
>  	[FS__DEBUGFS] = {
>  		.name	= "debugfs",
>  		.mounts	= debugfs__known_mountpoints,
>  		.magic	= DEBUGFS_MAGIC,
> +		.checked= false,
>  	},
>  	[FS__TRACEFS] = {
>  		.name	= "tracefs",
>  		.mounts	= tracefs__known_mountpoints,
>  		.magic	= TRACEFS_MAGIC,
> +		.checked= false,
>  	},
>  	[FS__HUGETLBFS] = {
>  		.name	= "hugetlbfs",
>  		.mounts = hugetlbfs__known_mountpoints,
>  		.magic	= HUGETLBFS_MAGIC,
> +		.checked= false,
>  	},
>  	[FS__BPF_FS] = {
>  		.name	= "bpf",
>  		.mounts = bpf_fs__known_mountpoints,
>  		.magic	= BPF_FS_MAGIC,
> +		.checked= false,
>  	},
>  };
>  
> @@ -158,6 +165,7 @@ static bool fs__read_mounts(struct fs *fs)
>  	}
>  
>  	fclose(fp);
> +	fs->checked = true;
>  	return fs->found = found;
>  }
>  
> @@ -219,6 +227,7 @@ static bool fs__env_override(struct fs *fs)
>  		return false;
>  
>  	fs->found = true;
> +	fs->checked = true;
>  	strncpy(fs->path, override_path, sizeof(fs->path));
>  	return true;
>  }
> @@ -244,6 +253,16 @@ static const char *fs__mountpoint(int idx)
>  	if (fs->found)
>  		return (const char *)fs->path;
>  
> +	/* the mount point was already checked for the mount point

Nit, we start with:

   	/*
         * The mount point was already checked for the mount point
> +	 * but and did not exist, so return NULL to avoid scanning again.
> +	 * This makes the found and not found paths cost equivalent
> +	 * in case of multiple calls. This was not the case before
> +	 * and could cause significant scaling issues with callers.
> +	 * in case /proc/mounts need to be checked many times
                                                             .
> +	 */
> +	if (fs->checked)
> +		return NULL;
> +
>  	return fs__get_mountpoint(fs);
>  }
>  
> diff --git a/tools/lib/api/fs/fs.h b/tools/lib/api/fs/fs.h
> index 92d03b8396b1..00a5127b00e8 100644
> --- a/tools/lib/api/fs/fs.h
> +++ b/tools/lib/api/fs/fs.h
> @@ -18,6 +18,17 @@
>  	const char *name##__mount(void);	\
>  	bool name##__configured(void);		\
>  
> +/*
> + * The xxxx__mountpoint() entry points find the first match mount point for each

Nicely written :-)

> + * filesystems listed below, where xxxx is the filesystem type.
> + *
> + * The interface is as follows:
> + * - If a mount point is found on first call, it is cached and used for all subsequent
> + *   calls.
> + *
> + * - If a mount point is not found, NULL is returned on first call and all
> + *   subsequent calls.
                        Ditto.
> + */
>  FS(sysfs)
>  FS(procfs)
>  FS(debugfs)
> -- 
> 2.7.4
