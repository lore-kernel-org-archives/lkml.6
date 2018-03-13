Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932493AbeCMAhw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 20:37:52 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54510 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbeCMAhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 20:37:51 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
References: <20180313000131.28971-1-christian.brauner@ubuntu.com>
        <20180313000131.28971-2-christian.brauner@ubuntu.com>
Date: Mon, 12 Mar 2018 19:37:03 -0500
In-Reply-To: <20180313000131.28971-2-christian.brauner@ubuntu.com> (Christian
        Brauner's message of "Tue, 13 Mar 2018 01:01:29 +0100")
Message-ID: <871sgo95g0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1evXwr-0001OJ-2U;;;mid=<871sgo95g0.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19uK4sUi5qrOiWcIPEBlC09KraSf8IzxRw=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 618 ms - load_scoreonly_sql: 0.23 (0.0%),
        signal_user_changed: 5 (0.9%), b_tie_ro: 3.2 (0.5%), parse: 2.1 (0.3%),
        extract_message_metadata: 31 (5.0%), get_uri_detail_list: 3.6 (0.6%),
        tests_pri_-1000: 13 (2.1%), tests_pri_-950: 2.8 (0.5%), tests_pri_-900: 2.0
        (0.3%), tests_pri_-400: 31 (5.1%), check_bayes: 29 (4.7%), b_tokenize: 13
        (2.0%), b_tok_get_all: 6 (1.0%), b_comp_prob: 3.9 (0.6%), b_tok_touch_all:
        3.1 (0.5%), b_finish: 0.93 (0.2%), tests_pri_0: 509 (82.3%),
        check_dkim_signature: 1.21 (0.2%), check_dkim_adsp: 5 (0.9%), tests_pri_500:
        13 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3 v4] devpts: hoist out check for DEVPTS_SUPER_MAGIC
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> Hoist the check whether we have already found a suitable devpts filesystem
> out of devpts_ptmx_path() in preparation for the devpts bind-mount
> resolution patch. This is a non-functional change.

Sigh.  Scratch my review-by.


>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
>  ---
> ChangeLog v3->v4:
> * patch unchanged
> ChangeLog v2->v3:
> * patch unchanged
> ChangeLog v1->v2:
> * patch added
> ChangeLog v0->v1:
> * patch not present
> ---
>  fs/devpts/inode.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
>
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index e31d6ed3ec32..d3ddbb888874 100644
> --- a/fs/devpts/inode.c
> +++ b/fs/devpts/inode.c
> @@ -138,10 +138,6 @@ static int devpts_ptmx_path(struct path *path)
>  	struct super_block *sb;
>  	int err;
>  
> -	/* Has the devpts filesystem already been found? */
> -	if (path->mnt->mnt_sb->s_magic == DEVPTS_SUPER_MAGIC)
> -		return 0;
> -
>  	/* Is a devpts filesystem at "pts" in the same directory? */
>  	err = path_pts(path);
>  	if (err)
> @@ -159,17 +155,22 @@ static int devpts_ptmx_path(struct path *path)
>  struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
>  {
>  	struct path path;
> -	int err;
>  
>  	path = filp->f_path;
>  	path_get(&path);
>  
> -	err = devpts_ptmx_path(&path);
> -	dput(path.dentry);
> -	if (err) {
> -		mntput(path.mnt);
> -		return ERR_PTR(err);
> +	/* Has the devpts filesystem already been found? */
> +	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) {
> +		int err;
> +
> +		err = devpts_ptmx_path(&path);
> +		dput(path.dentry);
> +		if (err) {
> +			mntput(path.mnt);
> +			return ERR_PTR(err);
> +		}
>  	}

Indenting the dput results in a dentry leak.  You catch this
in your next patch but this is still wrong in this one.

>  	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
>  		mntput(path.mnt);
>  		return ERR_PTR(-ENODEV);
> @@ -182,15 +183,19 @@ struct pts_fs_info *devpts_acquire(struct file *filp)
>  	struct pts_fs_info *result;
>  	struct path path;
>  	struct super_block *sb;
> -	int err;
>  
>  	path = filp->f_path;
>  	path_get(&path);
>  
> -	err = devpts_ptmx_path(&path);
> -	if (err) {
> -		result = ERR_PTR(err);
> -		goto out;
> +	/* Has the devpts filesystem already been found? */
> +	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) {
> +		int err;
> +
> +		err = devpts_ptmx_path(&path);
> +		if (err) {
> +			result = ERR_PTR(err);
> +			goto out;
> +		}
>  	}
>  
>  	/*

Eric
