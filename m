Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 02585C004E4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2CA0208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 01:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CA0208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934722AbeFLBWO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 21:22:14 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57396 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932893AbeFLBWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 21:22:11 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fSY0g-0000cn-Sp; Mon, 11 Jun 2018 19:22:10 -0600
Received: from 97-119-124-205.omah.qwest.net ([97.119.124.205] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fSY0g-0005vc-2u; Mon, 11 Jun 2018 19:22:10 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alistair Strachan <astrachan@google.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        Djalal Harouni <tixxdz@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20180611195744.154962-1-astrachan@google.com>
Date:   Mon, 11 Jun 2018 20:22:03 -0500
In-Reply-To: <20180611195744.154962-1-astrachan@google.com> (Alistair
        Strachan's message of "Mon, 11 Jun 2018 12:57:44 -0700")
Message-ID: <87bmcgpzno.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fSY0g-0005vc-2u;;;mid=<87bmcgpzno.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19iWsf7U7zpmbf6wtTrrXL9BuGresvtPk8=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] proc: Fix parsing of mount parameters.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair Strachan <astrachan@google.com> writes:

> In commit e94591d0d90c "proc: Convert proc_mount to use mount_ns"
> the parsing of mount parameters for the proc filesystem was broken.
>
> The SB_KERNMOUNT for procfs happens via:
>
>   start_kernel()
>     rest_init()
>       kernel_thread()
>         _do_fork()
>            copy_process()
>              alloc_pid()
>                pid_ns_prepare_proc()
>                  kern_mount_data()
>                    proc_mount()
>                      mount_ns()
>
> In mount_ns(), the kernel calls proc_fill_super() only if the superblock
> has not previously been set up (i.e. the first mount reference),
> regardless of SB_KERNMOUNT. Because the call to proc_parse_options() had
> been moved inside here, and the SB_KERNMOUNT uses no mount options, the
> option parser became a no-op.
>
> When userspace later mounted procfs with e.g. hidepid=2, the options
> would be ignored.
>
> This change backs out a part of the original cleanup and parses the
> procfs mount options at every mount call. Because the options currently
> only update the pid_ns for the mount, they are applied for all mounts of
> proc by that pid or childen of that pid, instantaneously. This is the
> same behavior as the original code.

Two years for a regression to be reported is a litte long.  I think that
gets out of the kneejerk immediate fix or revert phase and into thinking
a little bout about what makes sense in this code.

As we say with devpts there is a very real danger of someone mounting
a second instance of proc in a chroot and causing problems by either
strengthening or weakening the hid pid protections for the entire pid
namespace.  If we go with your proposed change in behavior.

Ordinary block device filesystems (like ext4) avoid this problem by
allowing a second mount and by not parsing the mount options except
on remount.  What proc currently does.

So I think it can be reasonably argued that the change in behavior is
was an unintentional fix.

I can see an argument for failing the mount of proc if mount options
are specified or if those mount options differ from the existing mount
options.  

proc_remount's call of proc_parse_options is definitely buggy as it can
partially succeed and change the pid namespace and return an error code.
That is bad error handling.

There may be an argument for making these options available in something
other than a mount of proc.  As they are pid namespace wide.

There may be an argument for multiple instances of proc so that it makes
sense to process these options during an ordinary mount.


Ultimately what I see is that this is a difficult area of semantics that
there is at least a little room for improvement on, but it is not
as simple as this proposed change.


> Fixes: e94591d0d90c ("proc: Convert proc_mount to use mount_ns")
> Signed-off-by: Alistair Strachan <astrachan@google.com>
> Cc: Seth Forshee <seth.forshee@canonical.com>
> Cc: Djalal Harouni <tixxdz@gmail.com>
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: kernel-team@android.com
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/proc/inode.c    | 4 ----
>  fs/proc/internal.h | 1 -
>  fs/proc/root.c     | 5 ++++-
>  3 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index 2cf3b74391ca..bbbbf348be0a 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -492,13 +492,9 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
>  
>  int proc_fill_super(struct super_block *s, void *data, int silent)
>  {
> -	struct pid_namespace *ns = get_pid_ns(s->s_fs_info);
>  	struct inode *root_inode;
>  	int ret;
>  
> -	if (!proc_parse_options(data, ns))
> -		return -EINVAL;
> -
>  	/* User space would break if executables or devices appear on proc */
>  	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
>  	s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 50cb22a08c2f..89b7e845b000 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -264,7 +264,6 @@ static inline void proc_tty_init(void) {}
>   * root.c
>   */
>  extern struct proc_dir_entry proc_root;
> -extern int proc_parse_options(char *options, struct pid_namespace *pid);
>  
>  extern void proc_self_init(void);
>  extern int proc_remount(struct super_block *, int *, char *);
> diff --git a/fs/proc/root.c b/fs/proc/root.c
> index 61b7340b357a..d40676a5dd6c 100644
> --- a/fs/proc/root.c
> +++ b/fs/proc/root.c
> @@ -36,7 +36,7 @@ static const match_table_t tokens = {
>  	{Opt_err, NULL},
>  };
>  
> -int proc_parse_options(char *options, struct pid_namespace *pid)
> +static int proc_parse_options(char *options, struct pid_namespace *pid)
>  {
>  	char *p;
>  	substring_t args[MAX_OPT_ARGS];
> @@ -98,6 +98,9 @@ static struct dentry *proc_mount(struct file_system_type *fs_type,
>  		ns = task_active_pid_ns(current);
>  	}
>  
> +	if (!proc_parse_options(data, ns))
> +		return ERR_PTR(-EINVAL);
> +
>  	return mount_ns(fs_type, flags, data, ns, ns->user_ns, proc_fill_super);
>  }
