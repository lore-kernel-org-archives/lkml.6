Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753025AbeCMQfs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:35:48 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53700 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932850AbeCMQfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:35:43 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, containers@lists.linux-foundation.org
References: <20180313121713.32551-1-christian.brauner@ubuntu.com>
        <20180313121713.32551-2-christian.brauner@ubuntu.com>
Date: Tue, 13 Mar 2018 11:34:55 -0500
In-Reply-To: <20180313121713.32551-2-christian.brauner@ubuntu.com> (Christian
        Brauner's message of "Tue, 13 Mar 2018 13:17:10 +0100")
Message-ID: <87h8pk2ats.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1evmtp-00013R-9V;;;mid=<87h8pk2ats.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19LM1aRxpxZBwWUHNzS2jvNUw+u5MODieM=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 196 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.6 (1.3%), b_tie_ro: 1.75 (0.9%), parse: 0.82 (0.4%),
        extract_message_metadata: 11 (5.8%), get_uri_detail_list: 1.37 (0.7%),
        tests_pri_-1000: 3.7 (1.9%), tests_pri_-950: 1.03 (0.5%), tests_pri_-900:
        0.84 (0.4%), tests_pri_-400: 19 (9.9%), check_bayes: 19 (9.4%), b_tokenize: 6
        (3.1%), b_tok_get_all: 5 (2.6%), b_comp_prob: 1.55 (0.8%), b_tok_touch_all:
        2.9 (1.5%), b_finish: 0.52 (0.3%), tests_pri_0: 150 (76.6%),
        check_dkim_signature: 0.52 (0.3%), check_dkim_adsp: 2.6 (1.3%),
        tests_pri_500: 3.8 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/4 v5] devpts: hoist out check for DEVPTS_SUPER_MAGIC
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

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> ChangeLog v4->v5:
> * dput() dentry
> ChangeLog v3->v4:
> * patch unchanged
> ChangeLog v2->v3:
> * patch unchanged
> ChangeLog v1->v2:
> * patch added
> ChangeLog v0->v1:
> * patch not present
> ---
>  fs/devpts/inode.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
> index e31d6ed3ec32..71b901936113 100644
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
> @@ -159,21 +155,25 @@ static int devpts_ptmx_path(struct path *path)
>  struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
>  {
>  	struct path path;
> -	int err;
> +	int err = 0;
>  
>  	path = filp->f_path;
>  	path_get(&path);
>  
> -	err = devpts_ptmx_path(&path);
> +	/* Has the devpts filesystem already been found? */
> +	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC)
> +		err = devpts_ptmx_path(&path);
>  	dput(path.dentry);
>  	if (err) {
>  		mntput(path.mnt);
>  		return ERR_PTR(err);
>  	}
> +
>  	if (DEVPTS_SB(path.mnt->mnt_sb) != fsi) {
>  		mntput(path.mnt);
>  		return ERR_PTR(-ENODEV);
>  	}
> +
>  	return path.mnt;
>  }
>  
> @@ -182,15 +182,19 @@ struct pts_fs_info *devpts_acquire(struct file *filp)
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
