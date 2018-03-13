Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbeCMQkW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:40:22 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51089 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbeCMQkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:40:19 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, containers@lists.linux-foundation.org
References: <20180313121713.32551-1-christian.brauner@ubuntu.com>
        <20180313121713.32551-3-christian.brauner@ubuntu.com>
Date: Tue, 13 Mar 2018 11:39:31 -0500
In-Reply-To: <20180313121713.32551-3-christian.brauner@ubuntu.com> (Christian
        Brauner's message of "Tue, 13 Mar 2018 13:17:11 +0100")
Message-ID: <878taw2am4.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1evmyH-000747-DV;;;mid=<878taw2am4.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX189E3UQuR9H6DXj2tCfZUnqv9LX7nIbAbA=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 424 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 3.6 (0.8%), b_tie_ro: 2.4 (0.6%), parse: 1.22 (0.3%),
        extract_message_metadata: 19 (4.4%), get_uri_detail_list: 3.8 (0.9%),
        tests_pri_-1000: 11 (2.5%), tests_pri_-950: 1.45 (0.3%), tests_pri_-900: 1.02
        (0.2%), tests_pri_-400: 33 (7.9%), check_bayes: 32 (7.6%), b_tokenize: 13
        (3.0%), b_tok_get_all: 10 (2.4%), b_comp_prob: 3.2 (0.8%), b_tok_touch_all:
        3.5 (0.8%), b_finish: 0.64 (0.2%), tests_pri_0: 345 (81.4%),
        check_dkim_signature: 0.89 (0.2%), check_dkim_adsp: 3.2 (0.8%),
        tests_pri_500: 5 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/4 v5] devpts: resolve devpts bind-mounts
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

It would have been more readable if Linus's suggested cleanup were
in a separate patch.  But unless you need to respin I would not worry
about that.

> Most libcs will still look at /dev/ptmx when opening the master fd of a pty
> device. When /dev/ptmx is a bind-mount of /dev/pts/ptmx and the TIOCGPTPEER
> ioctl() is used to safely retrieve a file descriptor for the slave side of
> the pty based on the master fd, the /proc/self/fd/{0,1,2} symlinks will
> point to /. A very simply reproducer for this issue presupposing a libc
> that uses TIOCGPTPEER in its openpty() implementation is:
>
> unshare --mount
> mount --bind /dev/pts/ptmx /dev/ptmx
> chmod 666 /dev/ptmx
> script
> ls -al /proc/self/fd/0
>
> Having bind-mounts of /dev/pts/ptmx to /dev/ptmx not working correctly is a
> regression. In addition, it is also a fairly common scenario in containers
> employing user namespaces.
>
> The reason for the current failure is that the kernel tries to verify the
> useability of the devpts filesystem without resolving the /dev/ptmx
> bind-mount first. This will lead it to detect that the dentry is escaping
> its bind-mount. The reason is that while the devpts filesystem mounted at
> /dev/pts has the devtmpfs mounted at /dev as its parent mount:
>
> 21 -- -- / /dev
> -- 21 -- / /dev/pts
>
> devtmpfs and devpts are on different devices
>
> -- -- 0:6  / /dev
> -- -- 0:20 / /dev/pts
>
> This has the consequence that the pathname of the parent directory of the
> devpts filesystem mount at /dev/pts is /. So if /dev/ptmx is a bind-mount
> of /dev/pts/ptmx then the /dev/ptmx bind-mount and the devpts mount at
> /dev/pts will end up being located on the same device which is recorded in
> the superblock of their vfsmount. This means the parent directory of the
> /dev/ptmx bind-mount will be /ptmx:
>
> -- -- ---- /ptmx /dev/ptmx
>
> Without the bind-mount resolution patch the kernel will now perform the
> bind-mount escape check directly on /dev/ptmx. The function responsible for
> this is devpts_ptmx_path() which calls pts_path() which in turn calls
> path_parent_directory(). Based on the above explanation,
> path_parent_directory() will yield / as the parent directory for the
> /dev/ptmx bind-mount and not the expected /dev. Thus, the kernel detects
> that /dev/ptmx is escaping its bind-mount and will set /proc/<pid>/fd/<nr>
> to /.
>
> This patch changes the logic to first resolve any bind-mounts. After the
> bind-mounts have been resolved (i.e. we have traced it back to the
> associated devpts mount) devpts_ptmx_path() can be called. In order to
> guarantee correct path generation for the slave file descriptor the kernel
> now requires that a pts directory is found in the parent directory of the
> ptmx bind-mount. This implies that when doing bind-mounts the ptmx
> bind-mount and the devpts mount should have a common parent directory. A
> valid example is:
>
> mount -t devpts devpts /dev/pts
> mount --bind /dev/pts/ptmx /dev/ptmx
>
> an invalid example is:
>
> mount -t devpts devpts /dev/pts
> mount --bind /dev/pts/ptmx /ptmx
>
> This allows us to support:
> - calling open on ptmx devices located inside non-standard devpts mounts:
>   mount -t devpts devpts /mnt
>   master = open("/mnt/ptmx", ...);
>   slave = ioctl(master, TIOCGPTPEER, ...);
> - calling open on ptmx devices located outside the devpts mount with a
>   common ancestor directory:
>   mount -t devpts devpts /dev/pts
>   mount --bind /dev/pts/ptmx /dev/ptmx
>   master = open("/dev/ptmx", ...);
>   slave = ioctl(master, TIOCGPTPEER, ...);
>
> while failing on ptmx devices located outside the devpts mount without a
> common ancestor directory:
>   mount -t devpts devpts /dev/pts
>   mount --bind /dev/pts/ptmx /ptmx
>   master = open("/ptmx", ...);
>   slave = ioctl(master, TIOCGPTPEER, ...);
>
> in which case save path generation cannot be guaranteed.
>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Suggested-by: Eric Biederman <ebiederm@xmission.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> ChangeLog v4->v5:
> * reverse error handling logic to further simplify (Linus)
> ChangeLog v3->v4:
> * simplify if condition (Eric)
> ChangeLog v2->v3:
> * rework logic to account for non-standard devpts mounts such as
>   mount -t devpts devpts /mnt (Christian)
> ChangeLog v1->v2:
> * move removal of if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
>   condition to separate patch with non-functional changes (Linus)
> ChangeLog v0->v1:
> * remove
>         /* Has the devpts filesystem already been found? */
>         if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
>                         return 0
>   from devpts_ptmx_path() (Eric)
> * check superblock after devpts_ptmx_path() returned (Christian)
> ---
>  fs/devpts/inode.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index 71b901936113..542364bf923e 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -160,21 +160,27 @@ struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
>  	path = filp->f_path;
>  	path_get(&path);
>  
> -	/* Has the devpts filesystem already been found? */
> -	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC)
> +	/* Walk upward while the start point is a bind mount of
> +	 * a single file.
> +	 */
> +	while (path.mnt->mnt_root == path.dentry)
> +		if (follow_up(&path) == 0)
> +			break;
> +
> +	/* devpts_ptmx_path() finds a devpts fs or returns an error. */
> +	if ((path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) ||
> +	    (DEVPTS_SB(path.mnt->mnt_sb) != fsi))
>  		err = devpts_ptmx_path(&path);
>  	dput(path.dentry);
> -	if (err) {
> -		mntput(path.mnt);
> -		return ERR_PTR(err);
> -	}
> +	if (!err) {
> +		if (DEVPTS_SB(path.mnt->mnt_sb) == fsi)
> +			return path.mnt;
>  
> -	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
> -		mntput(path.mnt);
> -		return ERR_PTR(-ENODEV);
> +		err = -ENODEV;
>  	}
>  
> -	return path.mnt;
> +	mntput(path.mnt);
> +	return ERR_PTR(err);
>  }
>  
>  struct pts_fs_info *devpts_acquire(struct file *filp)
