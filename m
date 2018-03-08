Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934172AbeCHRyt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 12:54:49 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:42744 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752197AbeCHRys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 12:54:48 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
References: <20180308170051.17007-1-christian.brauner@ubuntu.com>
Date: Thu, 08 Mar 2018 11:54:05 -0600
In-Reply-To: <20180308170051.17007-1-christian.brauner@ubuntu.com> (Christian
        Brauner's message of "Thu, 8 Mar 2018 18:00:51 +0100")
Message-ID: <878tb2qwqq.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1etzkc-0006w1-Rm;;;mid=<878tb2qwqq.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+WHRSgcTH0L7+rqu+QaaoKttErkqmv/KU=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 197 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.7 (1.9%), b_tie_ro: 2.7 (1.4%), parse: 1.06 (0.5%),
        extract_message_metadata: 12 (6.2%), get_uri_detail_list: 1.54 (0.8%),
        tests_pri_-1000: 6 (2.9%), tests_pri_-950: 1.04 (0.5%), tests_pri_-900: 0.87
        (0.4%), tests_pri_-400: 24 (12.0%), check_bayes: 23 (11.5%), b_tokenize: 6
        (3.3%), b_tok_get_all: 8 (3.9%), b_comp_prob: 1.85 (0.9%), b_tok_touch_all:
        3.9 (2.0%), b_finish: 0.76 (0.4%), tests_pri_0: 142 (72.1%),
        check_dkim_signature: 0.49 (0.2%), check_dkim_adsp: 2.9 (1.5%),
        tests_pri_500: 3.8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] devpts: resolve devpts bind-mounts
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> Most libcs will still look at /dev/ptmx when opening the master fd of pty
> device. When /dev/ptmx is a bind-mount of /dev/pts/ptmx and the TIOCGPTPEER
> ioctl() is used to safely retrieve a file descriptor for the slave side of the
> pty based on the master fd the /proc/self/fd/{0,1,2} symlinks will point to "/".
> When the kernel tries to look up the root mount of the dentry for the slave
> file descriptor it will detect that the dentry is escaping it's bind-mount
> since the root mount of the dentry is /dev/pts where the devpts is mounted but
> the root mount of /dev/ptmx is /dev.
> Having bind-mounts of /dev/pts/ptmx to /dev/ptmx not working correctly is a
> regression. In addition, it is also a fairly common scenario in containers
> employing user namespaces.
> To handle this situation correctly we walk up the bind-mounts for the /dev/ptmx
> file.
>
> Here's a little reproducer that presupposes a libc that uses TIOCGPTPEER in its
> openpty() implementation:
>
> unshare --mount
> mount --bind /dev/pts/ptmx /dev/ptmx
> chmod 666 /dev/ptmx
> script
> ls -al /proc/self/fd/0
>
> with output:
>
> lrwx------ 1 chb chb 64 Mar  7 16:41 /proc/self/fd/0 -> /

I have two concerns.
1) By leaving the test:

	/* Has the devpts filesystem already been found? */
	if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
		return 0;

In the version of devpts_ptmx_path that you call in the new code
there is a chance it will trip up on that test and return early.
Not that we are likely to hit that in practice, but let's be clear
about what we are doing.

2) After the call of devpts_ptmx_path in the new code there is not
   a check that the returned mount is the filesystem we are looking
   for.  AKA it is missing a "DEVPTS_SB(path.mnt->mnt_sb) == fsi" test.

Eric


> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Suggested-by: Eric Biederman <ebiederm@xmission.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  fs/devpts/inode.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index e31d6ed3ec32..4059e3e69d57 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -163,6 +163,26 @@ struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
>  
>  	path = filp->f_path;
>  	path_get(&path);
> +	if ((DEVPTS_SB(path.mnt->mnt_sb) == fsi) &&
> +	    (path.mnt->mnt_root == fsi->ptmx_dentry)) {
> +		/* Walk upward while the start point is a bind mount of a single
> +		 * file.
> +		 */
> +		while (path.mnt->mnt_root == path.dentry)
> +			if (follow_up(&path) == 0)
> +				break;
> +
> +		/* Is this path a valid devpts filesystem? */
> +		err = devpts_ptmx_path(&path);
> +		if (err == 0) {
> +			dput(path.dentry);
> +			return path.mnt;
> +		}
> +
> +		path_put(&path);
> +		path = filp->f_path;
> +		path_get(&path);
> +	}
>  
>  	err = devpts_ptmx_path(&path);
>  	dput(path.dentry);
