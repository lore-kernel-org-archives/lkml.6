Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964970AbeBLQfd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:35:33 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:54342 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964902AbeBLQfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:35:31 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Dongsu Park <dongsu@kinvolk.io>, lkml <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org, Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <cover.1512741134.git.dongsu@kinvolk.io>
        <c85c293e19a478353aba8e6e3ee39e5914f798d5.1512041070.git.dongsu@kinvolk.io>
        <CAOssrKd6vkMDwRT=QQofKCufzQczzQ7dXoVbVfVax-0HqD986w@mail.gmail.com>
Date: Mon, 12 Feb 2018 10:35:10 -0600
In-Reply-To: <CAOssrKd6vkMDwRT=QQofKCufzQczzQ7dXoVbVfVax-0HqD986w@mail.gmail.com>
        (Miklos Szeredi's message of "Mon, 12 Feb 2018 16:57:31 +0100")
Message-ID: <87lgfy5fpd.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1elH4i-00015e-2e;;;mid=<87lgfy5fpd.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/r1yDrhTMr8L80CT+9n3+hcd56YWHayew=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 754 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.3 (0.4%), b_tie_ro: 2.2 (0.3%), parse: 1.42 (0.2%),
        extract_message_metadata: 22 (2.9%), get_uri_detail_list: 10 (1.3%),
        tests_pri_-1000: 7 (1.0%), tests_pri_-950: 1.17 (0.2%), tests_pri_-900: 0.99
        (0.1%), tests_pri_-400: 62 (8.2%), check_bayes: 61 (8.1%), b_tokenize: 22
        (2.9%), b_tok_get_all: 24 (3.2%), b_comp_prob: 3.8 (0.5%), b_tok_touch_all: 9
        (1.2%), b_finish: 0.57 (0.1%), tests_pri_0: 647 (85.8%),
        check_dkim_signature: 0.67 (0.1%), check_dkim_adsp: 2.6 (0.3%),
        tests_pri_500: 4.5 (0.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 08/11] fuse: Support fuse filesystems outside of init_user_ns
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> On Fri, Dec 22, 2017 at 3:32 PM, Dongsu Park <dongsu@kinvolk.io> wrote:
>> From: Seth Forshee <seth.forshee@canonical.com>
>>
>> In order to support mounts from namespaces other than
>> init_user_ns, fuse must translate uids and gids to/from the
>> userns of the process servicing requests on /dev/fuse. This
>> patch does that, with a couple of restrictions on the namespace:
>>
>>  - The userns for the fuse connection is fixed to the namespace
>>    from which /dev/fuse is opened.
>>
>>  - The namespace must be the same as s_user_ns.
>>
>> These restrictions simplify the implementation by avoiding the
>> need to pass around userns references and by allowing fuse to
>> rely on the checks in inode_change_ok for ownership changes.
>> Either restriction could be relaxed in the future if needed.
>
> Can we not introduce potential userspace interface regressions?
>
> The issue with pid namespaces fixed in commit 5d6d3a301c4e ("fuse:
> allow server to run in different pid_ns") will probably bite us here
> as well.

Maybe, but unlike the pid namespace no one has been able to mount
fuse outside of init_user_ns so we are much less exposed.  I agree we
should be careful.

> We basically need two modes of operation:
>
> a) old, backward compatible (not introducing any new failure mores),
> created with privileged mount
> b) new, non-backward compatible, created with unprivileged mount
>
> Technically there would still be a risk from breaking userspace, since
> we are using the same entry point for both, but let's hope that no
> practical problems come from that.

Answering from a 10,000 foot perspective:

There are two cases.  Requests to read/write the filesystem from outside
of s_user_ns.  These run no risk of breaking userspace as this mode has
not been implemented before.

Restrictions at mount time to ensure we are not dealing with a crazy mix
of namespaces.  This has a small chance of breaking someone's crazy
setup.


Dropping requests to read/write the filesystem when the requester does
not map into s_user_ns should not be a problem to enable universally.  If
s_user_ns is init_user_ns everything maps so there is no restriction.



What we can do if we want to ensure maximum backwards compatibility
is if the fuse filesystem is mounted in init_user_ns but if device for
the communication channel is opened in some other user namespace we
can just force the communication channel to operate in init_user_ns.

That will be 100% backwards compatible in all cases and as far as I can
see remove the need for having different ``modes'' of operation.



This does look like the time to give all of this a hard look and see if
we can get these patches in shape to be merged.

Eric



>> For cuse the namespace used for the connection is also simply
>> current_user_ns() at the time /dev/cuse is opened.
>>
>> Patch v4 is available: https://patchwork.kernel.org/patch/8944661/
>>
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: Miklos Szeredi <mszeredi@redhat.com>
>> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
>> Signed-off-by: Dongsu Park <dongsu@kinvolk.io>
>> ---
>>  fs/fuse/cuse.c   |  3 ++-
>>  fs/fuse/dev.c    | 11 ++++++++---
>>  fs/fuse/dir.c    | 14 +++++++-------
>>  fs/fuse/fuse_i.h |  6 +++++-
>>  fs/fuse/inode.c  | 31 +++++++++++++++++++------------
>>  5 files changed, 41 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
>> index e9e97803..b1b83259 100644
>> --- a/fs/fuse/cuse.c
>> +++ b/fs/fuse/cuse.c
>> @@ -48,6 +48,7 @@
>>  #include <linux/stat.h>
>>  #include <linux/module.h>
>>  #include <linux/uio.h>
>> +#include <linux/user_namespace.h>
>>
>>  #include "fuse_i.h"
>>
>> @@ -498,7 +499,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
>>         if (!cc)
>>                 return -ENOMEM;
>>
>> -       fuse_conn_init(&cc->fc);
>> +       fuse_conn_init(&cc->fc, current_user_ns());
>>
>>         fud = fuse_dev_alloc(&cc->fc);
>>         if (!fud) {
>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>> index 17f0d05b..0f780e16 100644
>> --- a/fs/fuse/dev.c
>> +++ b/fs/fuse/dev.c
>> @@ -114,8 +114,8 @@ static void __fuse_put_request(struct fuse_req *req)
>>
>>  static void fuse_req_init_context(struct fuse_conn *fc, struct fuse_req *req)
>>  {
>> -       req->in.h.uid = from_kuid_munged(&init_user_ns, current_fsuid());
>> -       req->in.h.gid = from_kgid_munged(&init_user_ns, current_fsgid());
>> +       req->in.h.uid = from_kuid(fc->user_ns, current_fsuid());
>> +       req->in.h.gid = from_kgid(fc->user_ns, current_fsgid());
>>         req->in.h.pid = pid_nr_ns(task_pid(current), fc->pid_ns);
>>  }
>>
>> @@ -167,6 +167,10 @@ static struct fuse_req *__fuse_get_req(struct fuse_conn *fc, unsigned npages,
>>         __set_bit(FR_WAITING, &req->flags);
>>         if (for_background)
>>                 __set_bit(FR_BACKGROUND, &req->flags);
>> +       if (req->in.h.uid == (uid_t)-1 || req->in.h.gid == (gid_t)-1) {
>> +               fuse_put_request(fc, req);
>> +               return ERR_PTR(-EOVERFLOW);
>> +       }
>>
>>         return req;
>>
>> @@ -1260,7 +1264,8 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>>         in = &req->in;
>>         reqsize = in->h.len;
>>
>> -       if (task_active_pid_ns(current) != fc->pid_ns) {
>> +       if (task_active_pid_ns(current) != fc->pid_ns ||
>> +           current_user_ns() != fc->user_ns) {
>
> I don't get it.  Why recalculate the pid if the user_ns does not match?
>
>>                 rcu_read_lock();
>>                 in->h.pid = pid_vnr(find_pid_ns(in->h.pid, fc->pid_ns));
>>                 rcu_read_unlock();
>> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
>> index 24967382..ad1cfac1 100644
>> --- a/fs/fuse/dir.c
>> +++ b/fs/fuse/dir.c
>> @@ -858,8 +858,8 @@ static void fuse_fillattr(struct inode *inode, struct fuse_attr *attr,
>>         stat->ino = attr->ino;
>>         stat->mode = (inode->i_mode & S_IFMT) | (attr->mode & 07777);
>>         stat->nlink = attr->nlink;
>> -       stat->uid = make_kuid(&init_user_ns, attr->uid);
>> -       stat->gid = make_kgid(&init_user_ns, attr->gid);
>> +       stat->uid = make_kuid(fc->user_ns, attr->uid);
>> +       stat->gid = make_kgid(fc->user_ns, attr->gid);
>>         stat->rdev = inode->i_rdev;
>>         stat->atime.tv_sec = attr->atime;
>>         stat->atime.tv_nsec = attr->atimensec;
>> @@ -1475,17 +1475,17 @@ static bool update_mtime(unsigned ivalid, bool trust_local_mtime)
>>         return true;
>>  }
>>
>> -static void iattr_to_fattr(struct iattr *iattr, struct fuse_setattr_in *arg,
>> -                          bool trust_local_cmtime)
>> +static void iattr_to_fattr(struct fuse_conn *fc, struct iattr *iattr,
>> +                          struct fuse_setattr_in *arg, bool trust_local_cmtime)
>>  {
>>         unsigned ivalid = iattr->ia_valid;
>>
>>         if (ivalid & ATTR_MODE)
>>                 arg->valid |= FATTR_MODE,   arg->mode = iattr->ia_mode;
>>         if (ivalid & ATTR_UID)
>> -               arg->valid |= FATTR_UID,    arg->uid = from_kuid(&init_user_ns, iattr->ia_uid);
>> +               arg->valid |= FATTR_UID,    arg->uid = from_kuid(fc->user_ns, iattr->ia_uid);
>>         if (ivalid & ATTR_GID)
>> -               arg->valid |= FATTR_GID,    arg->gid = from_kgid(&init_user_ns, iattr->ia_gid);
>> +               arg->valid |= FATTR_GID,    arg->gid = from_kgid(fc->user_ns, iattr->ia_gid);
>>         if (ivalid & ATTR_SIZE)
>>                 arg->valid |= FATTR_SIZE,   arg->size = iattr->ia_size;
>>         if (ivalid & ATTR_ATIME) {
>> @@ -1646,7 +1646,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
>>
>>         memset(&inarg, 0, sizeof(inarg));
>>         memset(&outarg, 0, sizeof(outarg));
>> -       iattr_to_fattr(attr, &inarg, trust_local_cmtime);
>> +       iattr_to_fattr(fc, attr, &inarg, trust_local_cmtime);
>>         if (file) {
>>                 struct fuse_file *ff = file->private_data;
>>                 inarg.valid |= FATTR_FH;
>> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
>> index d5773ca6..364e65c8 100644
>> --- a/fs/fuse/fuse_i.h
>> +++ b/fs/fuse/fuse_i.h
>> @@ -26,6 +26,7 @@
>>  #include <linux/xattr.h>
>>  #include <linux/pid_namespace.h>
>>  #include <linux/refcount.h>
>> +#include <linux/user_namespace.h>
>>
>>  /** Max number of pages that can be used in a single read request */
>>  #define FUSE_MAX_PAGES_PER_REQ 32
>> @@ -466,6 +467,9 @@ struct fuse_conn {
>>         /** The pid namespace for this mount */
>>         struct pid_namespace *pid_ns;
>>
>> +       /** The user namespace for this mount */
>> +       struct user_namespace *user_ns;
>> +
>>         /** Maximum read size */
>>         unsigned max_read;
>>
>> @@ -870,7 +874,7 @@ struct fuse_conn *fuse_conn_get(struct fuse_conn *fc);
>>  /**
>>   * Initialize fuse_conn
>>   */
>> -void fuse_conn_init(struct fuse_conn *fc);
>> +void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns);
>>
>>  /**
>>   * Release reference to fuse_conn
>> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
>> index 2f504d61..7f6b2e55 100644
>> --- a/fs/fuse/inode.c
>> +++ b/fs/fuse/inode.c
>> @@ -171,8 +171,8 @@ void fuse_change_attributes_common(struct inode *inode, struct fuse_attr *attr,
>>         inode->i_ino     = fuse_squash_ino(attr->ino);
>>         inode->i_mode    = (inode->i_mode & S_IFMT) | (attr->mode & 07777);
>>         set_nlink(inode, attr->nlink);
>> -       inode->i_uid     = make_kuid(&init_user_ns, attr->uid);
>> -       inode->i_gid     = make_kgid(&init_user_ns, attr->gid);
>> +       inode->i_uid     = make_kuid(fc->user_ns, attr->uid);
>> +       inode->i_gid     = make_kgid(fc->user_ns, attr->gid);
>>         inode->i_blocks  = attr->blocks;
>>         inode->i_atime.tv_sec   = attr->atime;
>>         inode->i_atime.tv_nsec  = attr->atimensec;
>> @@ -477,7 +477,8 @@ static int fuse_match_uint(substring_t *s, unsigned int *res)
>>         return err;
>>  }
>>
>> -static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev)
>> +static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev,
>> +                         struct user_namespace *user_ns)
>>  {
>>         char *p;
>>         memset(d, 0, sizeof(struct fuse_mount_data));
>> @@ -513,7 +514,7 @@ static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev)
>>                 case OPT_USER_ID:
>>                         if (fuse_match_uint(&args[0], &uv))
>>                                 return 0;
>> -                       d->user_id = make_kuid(current_user_ns(), uv);
>> +                       d->user_id = make_kuid(user_ns, uv);
>>                         if (!uid_valid(d->user_id))
>>                                 return 0;
>>                         d->user_id_present = 1;
>> @@ -522,7 +523,7 @@ static int parse_fuse_opt(char *opt, struct fuse_mount_data *d, int is_bdev)
>>                 case OPT_GROUP_ID:
>>                         if (fuse_match_uint(&args[0], &uv))
>>                                 return 0;
>> -                       d->group_id = make_kgid(current_user_ns(), uv);
>> +                       d->group_id = make_kgid(user_ns, uv);
>>                         if (!gid_valid(d->group_id))
>>                                 return 0;
>>                         d->group_id_present = 1;
>> @@ -565,8 +566,8 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
>>         struct super_block *sb = root->d_sb;
>>         struct fuse_conn *fc = get_fuse_conn_super(sb);
>>
>> -       seq_printf(m, ",user_id=%u", from_kuid_munged(&init_user_ns, fc->user_id));
>> -       seq_printf(m, ",group_id=%u", from_kgid_munged(&init_user_ns, fc->group_id));
>> +       seq_printf(m, ",user_id=%u", from_kuid_munged(fc->user_ns, fc->user_id));
>> +       seq_printf(m, ",group_id=%u", from_kgid_munged(fc->user_ns, fc->group_id));
>>         if (fc->default_permissions)
>>                 seq_puts(m, ",default_permissions");
>>         if (fc->allow_other)
>> @@ -597,7 +598,7 @@ static void fuse_pqueue_init(struct fuse_pqueue *fpq)
>>         fpq->connected = 1;
>>  }
>>
>> -void fuse_conn_init(struct fuse_conn *fc)
>> +void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns)
>>  {
>>         memset(fc, 0, sizeof(*fc));
>>         spin_lock_init(&fc->lock);
>> @@ -621,6 +622,7 @@ void fuse_conn_init(struct fuse_conn *fc)
>>         fc->attr_version = 1;
>>         get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
>>         fc->pid_ns = get_pid_ns(task_active_pid_ns(current));
>> +       fc->user_ns = get_user_ns(user_ns);
>>  }
>>  EXPORT_SYMBOL_GPL(fuse_conn_init);
>>
>> @@ -630,6 +632,7 @@ void fuse_conn_put(struct fuse_conn *fc)
>>                 if (fc->destroy_req)
>>                         fuse_request_free(fc->destroy_req);
>>                 put_pid_ns(fc->pid_ns);
>> +               put_user_ns(fc->user_ns);
>>                 fc->release(fc);
>>         }
>>  }
>> @@ -1061,7 +1064,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
>>
>>         sb->s_flags &= ~(MS_NOSEC | SB_I_VERSION);
>>
>> -       if (!parse_fuse_opt(data, &d, is_bdev))
>> +       if (!parse_fuse_opt(data, &d, is_bdev, sb->s_user_ns))
>>                 goto err;
>>
>>         if (is_bdev) {
>> @@ -1086,8 +1089,12 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
>>         if (!file)
>>                 goto err;
>>
>> -       if ((file->f_op != &fuse_dev_operations) ||
>> -           (file->f_cred->user_ns != &init_user_ns))
>> +       /*
>> +        * Require mount to happen from the same user namespace which
>> +        * opened /dev/fuse to prevent potential attacks.
>> +        */
>> +       if (file->f_op != &fuse_dev_operations ||
>> +           file->f_cred->user_ns != sb->s_user_ns)
>>                 goto err_fput;
>>
>>         fc = kmalloc(sizeof(*fc), GFP_KERNEL);
>> @@ -1095,7 +1102,7 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
>>         if (!fc)
>>                 goto err_fput;
>>
>> -       fuse_conn_init(fc);
>> +       fuse_conn_init(fc, sb->s_user_ns);
>>         fc->release = fuse_free_conn;
>>
>>         fud = fuse_dev_alloc(fc);
>> --
>> 2.13.6
>>
