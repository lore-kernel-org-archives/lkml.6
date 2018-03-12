Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeCLTxm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 15:53:42 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:47455 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932215AbeCLTxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 15:53:40 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
References: <20180312171330.32054-1-christian.brauner@ubuntu.com>
        <20180312171330.32054-3-christian.brauner@ubuntu.com>
Date: Mon, 12 Mar 2018 14:52:53 -0500
In-Reply-To: <20180312171330.32054-3-christian.brauner@ubuntu.com> (Christian
        Brauner's message of "Mon, 12 Mar 2018 18:13:29 +0100")
Message-ID: <87a7vdf4ve.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1evTVq-0001Dx-Do;;;mid=<87a7vdf4ve.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Ln8U5vCTM8gVf+KyBn0p22gA98OMFZUc=
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
        *  0.2 T_XMDrugObfuBody_14 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 446 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (0.6%), b_tie_ro: 1.83 (0.4%), parse: 0.87 (0.2%),
        extract_message_metadata: 18 (3.9%), get_uri_detail_list: 4.3 (1.0%),
        tests_pri_-1000: 8 (1.9%), tests_pri_-950: 1.20 (0.3%), tests_pri_-900: 0.95
        (0.2%), tests_pri_-400: 34 (7.7%), check_bayes: 33 (7.4%), b_tokenize: 14
        (3.1%), b_tok_get_all: 10 (2.3%), b_comp_prob: 3.1 (0.7%), b_tok_touch_all:
        4.0 (0.9%), b_finish: 0.65 (0.1%), tests_pri_0: 371 (83.3%),
        check_dkim_signature: 0.68 (0.2%), check_dkim_adsp: 2.5 (0.6%),
        tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3 v3] devpts: resolve devpts bind-mounts
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> Most libcs will still look at /dev/ptmx when opening the master fd of a pty
> device. When /dev/ptmx is a bind-mount of /dev/pts/ptmx and the TIOCGPTPEER
> ioctl() is used to safely retrieve a file descriptor for the slave side of
> the pty based on the master fd, the /proc/self/fd/{0,1,2} symlinks will
> point to /.
>
> When the kernel tries to look up the root mount of the dentry for the slave
> file descriptor it will detect that the dentry is escaping its bind-mount
> since the root mount of the dentry is /dev/pts where the devpts is mounted
> but the root mount of /dev/ptmx is /dev.
>
> Having bind-mounts of /dev/pts/ptmx to /dev/ptmx not working correctly is a
> regression. In addition, it is also a fairly common scenario in containers
> employing user namespaces.
>
> To handle bind-mounts of /dev/pts/ptmx to /dev/ptmx correctly we need to
> walk up the bind-mounts for /dev/ptmx in devpts_mntget(). Since the
> contents of /proc/<pid>/fd/<nr> symlinks attached to the slave side of a
> file descriptor will always point to a path under the devpts mount we need
> to try and ensure that the kernel doesn't falsely get the impression that a
> pty slave file descriptor retrieved via TIOCGPTPEER based on a pty master
> file descriptor opened via a bind-mount of the ptmx device escapes its
> bind-mount. To clarify in pseudo code:
>
> * bind-mount /dev/pts/ptmx to /dev/ptmx
> * master = open("/dev/ptmx", O_RDWR | O_NOCTTY | O_CLOEXEC);
> * slave = ioctl(master, TIOCGPTPEER, O_RDWR | O_NOCTTY | O_CLOEXEC);
>
> would cause the kernel to think that slave is escaping its bind-mount. The
> reason is that while the devpts mounted at /dev/pts has devtmpfs mounted at
> /dev as its parent mount:
>
> 21 -- -- / /dev
> -- 21 -- / /dev/pts
>
> they are on different devices
>
> -- -- 0:6  / /dev
> -- -- 0:20 / /dev/pts
>
> which has the consequence that the pathname of the directory which forms
> the root of the /dev/pts mount is /. So if we bind-mount /dev/pts/ptmx to
> /dev/ptmx we will end up on the same device as the devtmpfs mount at
> /dev/pts
>
> -- -- 0:20 /ptmx /dev/ptmx
>
> Without the bind-mount resolution patch here the kernel will now perform
> the bind-mount escape check directly on /dev/ptmx. When it hits
> devpts_ptmx_path()  calls pts_path() which in turn calls
> path_parent_directory(). While one would expect that
> path_parent_directory() *should* yield /dev it will yield / since
> /dev and /dev/pts are on different devices. This will cause path_pts() to
> fail finding a "pts" directory since there is none under /. Thus, the
> kernel detects that /dev/ptmx is escaping its bind-mount and will set
> /proc/<pid>/fd/<nr> to /.
>
> This patch changes the logic to do bind-mount resolution and after the
> bind-mount has been resolved (i.e. we have traced it back to the devpts
> mount) we can safely perform devpts_ptmx_path() and check whether we find a
> "pts" directory in the parent directory of the devpts mount. Since
> path_parent_directory() will now correctly yield /dev as parent directory
> for the devpts mount at /dev/pts.
>
> However, we can only perform devpts_ptmx_path() devpts_mntget() if we
> either did resolve a bind-mount or did not find a suitable devpts
> filesystem. The reason is that we want and need to support non-standard
> mountpoints for the devpts filesystem. If we call devpts_ptmx_path()
> although we did already find a devpts filesystem and did not resolve
> bind-mounts we will fail on devpts mounts such as:
>
> mount -t devpts devpts /mnt
>
> where no "pts" directory will be under /. So change the logic to account
> for this.
>
> Here's a little reproducer that presupposes a libc that uses TIOCGPTPEER in
> its openpty() implementation:
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
>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> Suggested-by: Eric Biederman <ebiederm@xmission.com>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
> ChangeLog v2->v3:
> * rework logic to account for non-standard devpts mounts such as
>   mount -t devpts devpts /mnt
> ChangeLog v1->v2:
> * move removal of if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
>   condition to separate patch with non-functional changes
> ChangeLog v0->v1:
> * remove
>         /* Has the devpts filesystem already been found? */
>         if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
> 	                return 0
>   from devpts_ptmx_path()
> * check superblock after devpts_ptmx_path() returned
> ---
>  fs/devpts/inode.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index d3ddbb888874..b31362c6c548 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -154,27 +154,35 @@ static int devpts_ptmx_path(struct path *path)

There is a question I asked in my original version and I haven't
seen it answered.

What do we want to do in the case where TIOCGPTPEER is called and
the ptmx file descriptor is not from a mount that has pty's under it.

a) We can continue the existing problematic behavior and return
   a pty fd whose proc path is '/'

b) We can return an error which changes the observable behavior.

My comments below are presuming we change the kernel to error.

>From my experience introducing the path following version of /dev/ptmx
no one in practice has a /dev/ptmx dentry without an accompoanying
/dev/pts/ptmx.  Therefore I do not expect changing the behavior to
error will introduce a regression in userspace.

So let's just change the behavior of devpts_mntget error if a mount with
the pty underneath it can not be found.

>  struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
>  {
> +	bool unwind;
>  	struct path path;
> +	int err = 0;

The only use I see for unwind is to ensure we don't change path
when we would want to return the mount from filp->f_path even it
is not connected to it's mount.

>  
>  	path = filp->f_path;
>  	path_get(&path);

> -	/* Has the devpts filesystem already been found? */
> -	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) {
> -		int err;
> +	unwind = (DEVPTS_SB(path.mnt->mnt_sb) == fsi) &&
> +		 (path.mnt->mnt_root == fsi->ptmx_dentry);
> +	/* Walk upward while the start point is a bind mount of
> +	 * a single file.
> +	 */
> +	while (path.mnt->mnt_root == path.dentry && unwind)
> +		if (follow_up(&path) == 0)
> +			break;
This look can become simply:
	while (path.mnt->mnt_root == path.dentry)
		if (follow_up(&path) == 0)
			break;

> +	if ((path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) || unwind)
This test can become simply:

	if ((path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) ||
            (DEVPTS_SB(path->mnt.mnt_sb) != fsi))
>  		err = devpts_ptmx_path(&path);
> -		dput(path.dentry);
> -		if (err) {
> -			mntput(path.mnt);
> -			return ERR_PTR(err);
> -		}
> +	dput(path.dentry);
> +	if (err) {
> +		mntput(path.mnt);
> +		return ERR_PTR(err);
>  	}
>  
>  	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
>  		mntput(path.mnt);
>  		return ERR_PTR(-ENODEV);
>  	}
> +
>  	return path.mnt;
>  }

Eric
