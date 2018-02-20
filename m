Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932377AbeBTCNL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 21:13:11 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:39874 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932325AbeBTCNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 21:13:09 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dongsu Park <dongsu@kinvolk.io>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        Alban Crequy <alban@kinvolk.io>, Miklos Szeredi <mszeredi@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, linux-fsdevel@vger.kernel.org
References: <cover.1512741134.git.dongsu@kinvolk.io>
        <c85c293e19a478353aba8e6e3ee39e5914f798d5.1512041070.git.dongsu@kinvolk.io>
Date: Mon, 19 Feb 2018 20:12:42 -0600
In-Reply-To: <c85c293e19a478353aba8e6e3ee39e5914f798d5.1512041070.git.dongsu@kinvolk.io>
        (Dongsu Park's message of "Fri, 22 Dec 2017 15:32:32 +0100")
Message-ID: <877er8if39.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1enxQZ-0005lb-2s;;;mid=<877er8if39.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18inHyoAJWd0OA95O9oT6ywpYypTZdSEaM=
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
X-Spam-Combo: **;Dongsu Park <dongsu@kinvolk.io>
X-Spam-Relay-Country: 
X-Spam-Timing: total 854 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.0 (0.4%), b_tie_ro: 2.0 (0.2%), parse: 1.42 (0.2%),
        extract_message_metadata: 33 (3.9%), get_uri_detail_list: 6 (0.7%),
        tests_pri_-1000: 14 (1.6%), tests_pri_-950: 2.3 (0.3%), tests_pri_-900: 1.82
        (0.2%), tests_pri_-400: 46 (5.4%), check_bayes: 44 (5.1%), b_tokenize: 18
        (2.1%), b_tok_get_all: 11 (1.3%), b_comp_prob: 6 (0.7%), b_tok_touch_all: 4.3
        (0.5%), b_finish: 0.86 (0.1%), tests_pri_0: 738 (86.4%),
        check_dkim_signature: 1.04 (0.1%), check_dkim_adsp: 4.5 (0.5%),
        tests_pri_500: 8 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 08/11] fuse: Support fuse filesystems outside of init_user_ns
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongsu Park <dongsu@kinvolk.io> writes:

> From: Seth Forshee <seth.forshee@canonical.com>
>
> In order to support mounts from namespaces other than
> init_user_ns, fuse must translate uids and gids to/from the
> userns of the process servicing requests on /dev/fuse. This
> patch does that, with a couple of restrictions on the namespace:
>
>  - The userns for the fuse connection is fixed to the namespace
>    from which /dev/fuse is opened.
>
>  - The namespace must be the same as s_user_ns.
>
> These restrictions simplify the implementation by avoiding the
> need to pass around userns references and by allowing fuse to
> rely on the checks in inode_change_ok for ownership changes.
> Either restriction could be relaxed in the future if needed.
>
> For cuse the namespace used for the connection is also simply
> current_user_ns() at the time /dev/cuse is opened.
>
> Patch v4 is available: https://patchwork.kernel.org/patch/8944661/
>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> Signed-off-by: Dongsu Park <dongsu@kinvolk.io>
> ---
>  fs/fuse/cuse.c   |  3 ++-
>  fs/fuse/dev.c    | 11 ++++++++---
>  fs/fuse/dir.c    | 14 +++++++-------
>  fs/fuse/fuse_i.h |  6 +++++-
>  fs/fuse/inode.c  | 31 +++++++++++++++++++------------
>  5 files changed, 41 insertions(+), 24 deletions(-)
>
> diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
> index e9e97803..b1b83259 100644
> --- a/fs/fuse/cuse.c
> +++ b/fs/fuse/cuse.c
> @@ -48,6 +48,7 @@
>  #include <linux/stat.h>
>  #include <linux/module.h>
>  #include <linux/uio.h>
> +#include <linux/user_namespace.h>
>  
>  #include "fuse_i.h"
>  
> @@ -498,7 +499,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
>  	if (!cc)
>  		return -ENOMEM;
>  
As noticed in the review this should probably say:
	if (current_user_ns() != &init_user_ns)
		return -EINVAL;

Just so we don't need to think about cuse being opened in a user
namespace at this point.  It is probably harmless.  But it isn't
what we are focusing on.

> -	fuse_conn_init(&cc->fc);
> +	fuse_conn_init(&cc->fc, current_user_ns());
>  
>  	fud = fuse_dev_alloc(&cc->fc);
>  	if (!fud) {


> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 17f0d05b..0f780e16 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -114,8 +114,8 @@ static void __fuse_put_request(struct fuse_req *req)
>  
>  static void fuse_req_init_context(struct fuse_conn *fc, struct fuse_req *req)
>  {
> -	req->in.h.uid = from_kuid_munged(&init_user_ns, current_fsuid());
> -	req->in.h.gid = from_kgid_munged(&init_user_ns, current_fsgid());
> +	req->in.h.uid = from_kuid(fc->user_ns, current_fsuid());
> +	req->in.h.gid = from_kgid(fc->user_ns, current_fsgid());
>  	req->in.h.pid = pid_nr_ns(task_pid(current), fc->pid_ns);
>  }
>  
> @@ -167,6 +167,10 @@ static struct fuse_req *__fuse_get_req(struct fuse_conn *fc, unsigned npages,
>  	__set_bit(FR_WAITING, &req->flags);
>  	if (for_background)
>  		__set_bit(FR_BACKGROUND, &req->flags);
> +	if (req->in.h.uid == (uid_t)-1 || req->in.h.gid == (gid_t)-1) {
> +		fuse_put_request(fc, req);
> +		return ERR_PTR(-EOVERFLOW);
> +	}
>  
>  	return req;
>  
> @@ -1260,7 +1264,8 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  	in = &req->in;
>  	reqsize = in->h.len;
>  
> -	if (task_active_pid_ns(current) != fc->pid_ns) {
> +	if (task_active_pid_ns(current) != fc->pid_ns ||
> +	    current_user_ns() != fc->user_ns) {
>  		rcu_read_lock();
>  		in->h.pid = pid_vnr(find_pid_ns(in->h.pid, fc->pid_ns));
>  		rcu_read_unlock();

The hunk above is a rebase error.  I believe it started out by erroring
out in the same case the pid namespace case errored out.  Miklos has a
good point that we need to handle the case where we have servers running
in jails of one sort or another because at least sandstorm runs
applications in that fashion, and we have previously had error reports
about that configuration breaking.

I think we can easily fix that.  Either by adding extra translation as
we did for the pid namespace or changing the user namespace used on the
connection.  I believe extra translation like we did with the pid
namespace will be more consistent.  And again it won't be a special
case except possibly during mount.  Of course there is weirdness there.

Eric
