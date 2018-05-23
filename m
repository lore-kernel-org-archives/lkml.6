Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754711AbeEWQLv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:11:51 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57863 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeEWQLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:11:49 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <87r2mre5b3.fsf@xmission.com>
Date: Wed, 23 May 2018 11:11:24 -0500
In-Reply-To: <87r2mre5b3.fsf@xmission.com> (Eric W. Biederman's message of
        "Fri, 04 May 2018 11:47:28 -0500")
Message-ID: <87wovubbdf.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fLWMO-0001OX-3T;;;mid=<87wovubbdf.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ebVb4Dk35lpTfK+RkaSTxdUBDQ6J2NyA=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15024 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.9 (0.0%), b_tie_ro: 2.1 (0.0%), parse: 1.09 (0.0%),
        extract_message_metadata: 13 (0.1%), get_uri_detail_list: 2.5 (0.0%),
        tests_pri_-1000: 2.9 (0.0%), tests_pri_-950: 1.18 (0.0%), tests_pri_-900:
        0.97 (0.0%), tests_pri_-400: 25 (0.2%), check_bayes: 24 (0.2%), b_tokenize: 9
        (0.1%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.3 (0.0%), b_tok_touch_all:
        3.7 (0.0%), b_finish: 0.64 (0.0%), tests_pri_0: 270 (1.8%),
        check_dkim_signature: 0.52 (0.0%), check_dkim_adsp: 3.1 (0.0%),
        tests_pri_500: 14705 (97.9%), poll_dns_idle: 14697 (97.8%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] fuse: Ensure posix acls are translated outside of init_user_ns
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Ensure the translation happens by failing to read or write
> posix acls when the filesystem has not indicated it supports
> posix acls.
>
> This ensures that modern cached posix acl support is available
> and used when dealing with posix acls.  This is important
> because only that path has the code to convernt the uids and
> gids in posix acls into the user namespace of a fuse filesystem.
>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---

ping.

Miklos are you around where you can look at this?

> Miklos after several attempts to handle this better last cycle.  I
> figure we should go with the stupid version for now.  I think I know
> how to do better but I don't want that to gate forward progress on
> fully unprivileged fuse mounts.  Especially as this is the last known
> issue to deal with.
>
>  fs/fuse/fuse_i.h |  1 +
>  fs/fuse/inode.c  |  7 +++++++
>  fs/fuse/xattr.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+)
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index f630951df8dc..5256ad333b05 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -985,6 +985,7 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size);
>  int fuse_removexattr(struct inode *inode, const char *name);
>  extern const struct xattr_handler *fuse_xattr_handlers[];
>  extern const struct xattr_handler *fuse_acl_xattr_handlers[];
> +extern const struct xattr_handler *fuse_no_acl_xattr_handlers[];
>  
>  struct posix_acl;
>  struct posix_acl *fuse_get_acl(struct inode *inode, int type);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 1643043d4fe5..22c76cf8c2e3 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1100,6 +1100,13 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
>  	    file->f_cred->user_ns != sb->s_user_ns)
>  		goto err_fput;
>  
> +	/*
> +	 * If we are not in the initial user namespace posix
> +	 * acls must be translated.
> +	 */
> +	if (sb->s_user_ns != &init_user_ns)
> +		sb->s_xattr = fuse_no_acl_xattr_handlers;
> +
>  	fc = kmalloc(sizeof(*fc), GFP_KERNEL);
>  	err = -ENOMEM;
>  	if (!fc)
> diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
> index 3caac46b08b0..433717640f78 100644
> --- a/fs/fuse/xattr.c
> +++ b/fs/fuse/xattr.c
> @@ -192,6 +192,26 @@ static int fuse_xattr_set(const struct xattr_handler *handler,
>  	return fuse_setxattr(inode, name, value, size, flags);
>  }
>  
> +static bool no_xattr_list(struct dentry *dentry)
> +{
> +	return false;
> +}
> +
> +static int no_xattr_get(const struct xattr_handler *handler,
> +			struct dentry *dentry, struct inode *inode,
> +			const char *name, void *value, size_t size)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static int no_xattr_set(const struct xattr_handler *handler,
> +			struct dentry *dentry, struct inode *nodee,
> +			const char *name, const void *value,
> +			size_t size, int flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static const struct xattr_handler fuse_xattr_handler = {
>  	.prefix = "",
>  	.get    = fuse_xattr_get,
> @@ -209,3 +229,26 @@ const struct xattr_handler *fuse_acl_xattr_handlers[] = {
>  	&fuse_xattr_handler,
>  	NULL
>  };
> +
> +static const struct xattr_handler fuse_no_acl_access_xattr_handler = {
> +	.name  = XATTR_NAME_POSIX_ACL_ACCESS,
> +	.flags = ACL_TYPE_ACCESS,
> +	.list  = no_xattr_list,
> +	.get   = no_xattr_get,
> +	.set   = no_xattr_set,
> +};
> +
> +static const struct xattr_handler fuse_no_acl_default_xattr_handler = {
> +	.name  = XATTR_NAME_POSIX_ACL_DEFAULT,
> +	.flags = ACL_TYPE_ACCESS,
> +	.list  = no_xattr_list,
> +	.get   = no_xattr_get,
> +	.set   = no_xattr_set,
> +};
> +
> +const struct xattr_handler *fuse_no_acl_xattr_handlers[] = {
> +	&fuse_no_acl_access_xattr_handler,
> +	&fuse_no_acl_default_xattr_handler,
> +	&fuse_xattr_handler,
> +	NULL
> +};
