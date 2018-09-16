Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8356ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 16:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB462083A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 16:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB462083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbeIPVec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 17:34:32 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:42773 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbeIPVec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 17:34:32 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1ZdZ-0004CM-V8; Sun, 16 Sep 2018 10:11:05 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g1ZdY-00023K-9i; Sun, 16 Sep 2018 10:11:05 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, viro@zeniv.linux.org.uk,
        berrange@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180914105310.6454-1-jlayton@kernel.org>
        <20180914105310.6454-2-jlayton@kernel.org>
        <20180915160423.GA31461@redhat.com>
Date:   Sun, 16 Sep 2018 18:10:54 +0200
In-Reply-To: <20180915160423.GA31461@redhat.com> (Oleg Nesterov's message of
        "Sat, 15 Sep 2018 18:04:23 +0200")
Message-ID: <87o9cxv2wh.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g1ZdY-00023K-9i;;;mid=<87o9cxv2wh.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/YkrHqovZo6CIkzw35z2q4drqe+Ug4XHk=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v3 1/3] exec: separate thread_count for files_struct
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 09/14, Jeff Layton wrote:
>>
>> Currently, we have a single refcount variable inside the files_struct.
>> When we go to unshare the files_struct, we check this counter and if
>> it's elevated, then we allocate a new files_struct instead of just
>> repurposing the old one, under the assumption that that indicates that
>> it's shared between tasks.
>>
>> This is not necessarily the case, however. Each task associated with the
>> files_struct does get a long-held reference, but the refcount can be
>> elevated for other reasons as well, by callers of get_files_struct.
>>
>> This means that we can end up allocating a new files_struct if we just
>> happen to race with a call to get_files_struct. Fix this by adding a new
>> counter to track the number associated threads, and use that to
>> determine whether to allocate a new files_struct when unsharing.
>
> But who actually needs get_files_struct() ? All users except binder.c need
> struct file, not struct files_struct.

I think the difficult case is flock64_to_posix_lock.  Where it sets
fl_owner to current->files.

There is also mandatory locking.

Ah.  I see you are talking about the cases that increment the count on
files_struct.  So that a count on files_struct is unambiguously the
number of threads sharing it.

> See the (completely untested) patch below. It adds the new fget_task() helper
> and converts all other users to use it.
>
> As for binder.c, in this case we probably actually want to unshare ->files
> on exec so we can ignore it?

Looking at the binder case it only captures ->files on mmap.  Exec
ditches the mmap.  So if the order of operations are correct than
the dropping of the old mm will also drop the count on files_struct
held by binder.

So semantically binder should not effect locks on exec, nor should
binder effect the files_count.  So I think as long as our order of
operations are correct we are good.

I have concerns about binder.  It is not pid namespace safe.
It assumes but does not enforce all threads share a single fs struct.

Binder at least limits mmapers to the thread group of the opener of
the binder file.  This limits the worst of the shenanighans with
file descriptor passing that I can imagine.

In short as long as we get the oder of operations correct we should be
able to safely ignore binder, and not have binder affect the results of
this code.

Eric

> Oleg.
> ---
>
>  fs/file.c            |  29 ++++++++++++-
>  fs/proc/fd.c         | 117 +++++++++++++++++++--------------------------------
>  include/linux/file.h |   3 ++
>  kernel/bpf/syscall.c |  23 +++-------
>  kernel/kcmp.c        |  20 ++-------
>  5 files changed, 83 insertions(+), 109 deletions(-)
>
> diff --git a/fs/file.c b/fs/file.c
> index 7ffd6e9..a685cc0 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -676,9 +676,9 @@ void do_close_on_exec(struct files_struct *files)
>  	spin_unlock(&files->file_lock);
>  }
>  
> -static struct file *__fget(unsigned int fd, fmode_t mask)
> +static struct file *__fget_files(struct files_struct *files,
> +				unsigned int fd, fmode_t mask)
>  {
> -	struct files_struct *files = current->files;
>  	struct file *file;
>  
>  	rcu_read_lock();
> @@ -699,12 +699,37 @@ static struct file *__fget(unsigned int fd, fmode_t mask)
>  	return file;
>  }
>  
> +static inline struct file *__fget(unsigned int fd, fmode_t mask)
> +{
> +	return __fget_files(current->files, fd, mask);
> +}
> +
>  struct file *fget(unsigned int fd)
>  {
>  	return __fget(fd, FMODE_PATH);
>  }
>  EXPORT_SYMBOL(fget);
>  
> +struct file *fget_task(struct task_struct *task, unsigned int fd)
> +{
> +	struct files_struct *files;
> +	struct file *file = ERR_PTR(-EBADF);
> +
> +	task_lock(task);
> +	/*
> +	 * __fget_files() checks max_fds itself but we want -EBADF
> +	 * if fd is too big; and files_fdtable() needs rcu lock.
> +	 */
> +	rcu_read_lock();
> +	files = task->files;
> +	if (files && fd < files_fdtable(files)->max_fds)
> +		file = __fget_files(files, fd, FMODE_PATH);
> +	rcu_read_unlock();
> +	task_unlock(task);
> +
> +	return file;
> +}
> +
>  struct file *fget_raw(unsigned int fd)
>  {
>  	return __fget(fd, 0);
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 81882a1..bb61890 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -19,54 +19,45 @@
>  
>  static int seq_show(struct seq_file *m, void *v)
>  {
> -	struct files_struct *files = NULL;
> +	struct task_struct *task = get_proc_task(m->private);
> +	unsigned int fd = proc_fd(m->private);
>  	int f_flags = 0, ret = -ENOENT;
>  	struct file *file = NULL;
> -	struct task_struct *task;
>  
> -	task = get_proc_task(m->private);
>  	if (!task)
> -		return -ENOENT;
> -
> -	files = get_files_struct(task);
> -	put_task_struct(task);
> -
> -	if (files) {
> -		unsigned int fd = proc_fd(m->private);
> -
> -		spin_lock(&files->file_lock);
> -		file = fcheck_files(files, fd);
> -		if (file) {
> -			struct fdtable *fdt = files_fdtable(files);
> +		return ret;
>  
> -			f_flags = file->f_flags;
> -			if (close_on_exec(fd, fdt))
> -				f_flags |= O_CLOEXEC;
> +	file = fget_task(task, fd);
> +	if (IS_ERR_OR_NULL(file))
> +		goto out;
>  
> -			get_file(file);
> -			ret = 0;
> -		}
> -		spin_unlock(&files->file_lock);
> -		put_files_struct(files);
> +	/* TODO: add another helper ? */
> +	task_lock(task);
> +	rcu_read_lock();
> +	if (task->files) {
> +		struct fdtable *fdt = files_fdtable(task->files);
> +		if (fd < fdt->max_fds && close_on_exec(fd, fdt))
> +			f_flags |= O_CLOEXEC;
>  	}
> -
> -	if (ret)
> -		return ret;
> +	rcu_read_unlock();
> +	task_unlock(task);
>  
>  	seq_printf(m, "pos:\t%lli\nflags:\t0%o\nmnt_id:\t%i\n",
>  		   (long long)file->f_pos, f_flags,
>  		   real_mount(file->f_path.mnt)->mnt_id);
>  
> -	show_fd_locks(m, file, files);
> +	/* show_fd_locks() never dereferences file, NULL is fine too */
> +	show_fd_locks(m, file, task->files);
>  	if (seq_has_overflowed(m))
>  		goto out;
>  
>  	if (file->f_op->show_fdinfo)
>  		file->f_op->show_fdinfo(m, file);
>  
> -out:
>  	fput(file);
> -	return 0;
> +out:
> +	put_task_struct(task);
> +	return ret;
>  }
>  
>  static int seq_fdinfo_open(struct inode *inode, struct file *file)
> @@ -83,19 +74,14 @@ static const struct file_operations proc_fdinfo_file_operations = {
>  
>  static bool tid_fd_mode(struct task_struct *task, unsigned fd, fmode_t *mode)
>  {
> -	struct files_struct *files = get_files_struct(task);
> -	struct file *file;
> +	struct file *file = fget_task(task, fd);
>  
> -	if (!files)
> +	if (IS_ERR_OR_NULL(file))
>  		return false;
>  
> -	rcu_read_lock();
> -	file = fcheck_files(files, fd);
> -	if (file)
> -		*mode = file->f_mode;
> -	rcu_read_unlock();
> -	put_files_struct(files);
> -	return !!file;
> +	*mode = file->f_mode;
> +	fput(file);
> +	return true;
>  }
>  
>  static void tid_fd_update_inode(struct task_struct *task, struct inode *inode,
> @@ -146,31 +132,24 @@ static const struct dentry_operations tid_fd_dentry_operations = {
>  
>  static int proc_fd_link(struct dentry *dentry, struct path *path)
>  {
> -	struct files_struct *files = NULL;
> -	struct task_struct *task;
> +	struct task_struct *task = get_proc_task(d_inode(dentry));
> +	unsigned int fd = proc_fd(d_inode(dentry));
> +	struct file *fd_file;
>  	int ret = -ENOENT;
>  
>  	task = get_proc_task(d_inode(dentry));
> -	if (task) {
> -		files = get_files_struct(task);
> -		put_task_struct(task);
> -	}
> -
> -	if (files) {
> -		unsigned int fd = proc_fd(d_inode(dentry));
> -		struct file *fd_file;
> +	if (!task)
> +		return ret;
>  
> -		spin_lock(&files->file_lock);
> -		fd_file = fcheck_files(files, fd);
> -		if (fd_file) {
> -			*path = fd_file->f_path;
> -			path_get(&fd_file->f_path);
> -			ret = 0;
> -		}
> -		spin_unlock(&files->file_lock);
> -		put_files_struct(files);
> +	fd_file = fget_task(task, fd);
> +	if (!IS_ERR_OR_NULL(fd_file)) {
> +		*path = fd_file->f_path;
> +		path_get(&fd_file->f_path);
> +		fput(fd_file);
> +		ret = 0;
>  	}
>  
> +	put_task_struct(task);
>  	return ret;
>  }
>  
> @@ -229,7 +208,6 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
>  			      instantiate_t instantiate)
>  {
>  	struct task_struct *p = get_proc_task(file_inode(file));
> -	struct files_struct *files;
>  	unsigned int fd;
>  
>  	if (!p)
> @@ -237,37 +215,30 @@ static int proc_readfd_common(struct file *file, struct dir_context *ctx,
>  
>  	if (!dir_emit_dots(file, ctx))
>  		goto out;
> -	files = get_files_struct(p);
> -	if (!files)
> -		goto out;
>  
> -	rcu_read_lock();
> -	for (fd = ctx->pos - 2;
> -	     fd < files_fdtable(files)->max_fds;
> -	     fd++, ctx->pos++) {
> +	for (fd = ctx->pos - 2;; fd++, ctx->pos++) {
>  		struct file *f;
>  		struct fd_data data;
>  		char name[10 + 1];
>  		unsigned int len;
>  
> -		f = fcheck_files(files, fd);
> +		f = fget_task(p, fd);
>  		if (!f)
>  			continue;
> +		if (IS_ERR(f))
> +			break;
> +
>  		data.mode = f->f_mode;
> -		rcu_read_unlock();
>  		data.fd = fd;
> +		fput(f);
>  
>  		len = snprintf(name, sizeof(name), "%u", fd);
>  		if (!proc_fill_cache(file, ctx,
>  				     name, len, instantiate, p,
>  				     &data))
> -			goto out_fd_loop;
> +			goto out;
>  		cond_resched();
> -		rcu_read_lock();
>  	}
> -	rcu_read_unlock();
> -out_fd_loop:
> -	put_files_struct(files);
>  out:
>  	put_task_struct(p);
>  	return 0;
> diff --git a/include/linux/file.h b/include/linux/file.h
> index 6b2fb03..8b7abdb 100644
> --- a/include/linux/file.h
> +++ b/include/linux/file.h
> @@ -43,6 +43,9 @@ static inline void fdput(struct fd fd)
>  		fput(fd.file);
>  }
>  
> +struct task_struct;
> +extern struct file *fget_task(struct task_struct *task, unsigned int fd);
> +
>  extern struct file *fget(unsigned int fd);
>  extern struct file *fget_raw(unsigned int fd);
>  extern unsigned long __fdget(unsigned int fd);
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 8339d81..2cbf26d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2260,7 +2260,6 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>  	pid_t pid = attr->task_fd_query.pid;
>  	u32 fd = attr->task_fd_query.fd;
>  	const struct perf_event *event;
> -	struct files_struct *files;
>  	struct task_struct *task;
>  	struct file *file;
>  	int err;
> @@ -2278,24 +2277,13 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>  	if (!task)
>  		return -ENOENT;
>  
> -	files = get_files_struct(task);
> -	put_task_struct(task);
> -	if (!files)
> -		return -ENOENT;
> -
> -	err = 0;
> -	spin_lock(&files->file_lock);
> -	file = fcheck_files(files, fd);
> -	if (!file)
> -		err = -EBADF;
> -	else
> -		get_file(file);
> -	spin_unlock(&files->file_lock);
> -	put_files_struct(files);
> -
> -	if (err)
> +	err = -EBADF;
> +	file = fget_task(task, fd);
> +	if (IS_ERR_OR_NULL(file))
>  		goto out;
>  
> +	err = -ENOTSUPP;
> +
>  	if (file->f_op == &bpf_raw_tp_fops) {
>  		struct bpf_raw_tracepoint *raw_tp = file->private_data;
>  		struct bpf_raw_event_map *btp = raw_tp->btp;
> @@ -2324,7 +2312,6 @@ static int bpf_task_fd_query(const union bpf_attr *attr,
>  		goto put_file;
>  	}
>  
> -	err = -ENOTSUPP;
>  put_file:
>  	fput(file);
>  out:
> diff --git a/kernel/kcmp.c b/kernel/kcmp.c
> index a0e3d7a..067639e 100644
> --- a/kernel/kcmp.c
> +++ b/kernel/kcmp.c
> @@ -107,7 +107,6 @@ static int kcmp_epoll_target(struct task_struct *task1,
>  {
>  	struct file *filp, *filp_epoll, *filp_tgt;
>  	struct kcmp_epoll_slot slot;
> -	struct files_struct *files;
>  
>  	if (copy_from_user(&slot, uslot, sizeof(slot)))
>  		return -EFAULT;
> @@ -116,23 +115,12 @@ static int kcmp_epoll_target(struct task_struct *task1,
>  	if (!filp)
>  		return -EBADF;
>  
> -	files = get_files_struct(task2);
> -	if (!files)
> +	filp_epoll = fget_task(task2, slot.efd);
> +	if (IS_ERR_OR_NULL(filp_epoll))
>  		return -EBADF;
>  
> -	spin_lock(&files->file_lock);
> -	filp_epoll = fcheck_files(files, slot.efd);
> -	if (filp_epoll)
> -		get_file(filp_epoll);
> -	else
> -		filp_tgt = ERR_PTR(-EBADF);
> -	spin_unlock(&files->file_lock);
> -	put_files_struct(files);
> -
> -	if (filp_epoll) {
> -		filp_tgt = get_epoll_tfile_raw_ptr(filp_epoll, slot.tfd, slot.toff);
> -		fput(filp_epoll);
> -	}
> +	filp_tgt = get_epoll_tfile_raw_ptr(filp_epoll, slot.tfd, slot.toff);
> +	fput(filp_epoll);
>  
>  	if (IS_ERR(filp_tgt))
>  		return PTR_ERR(filp_tgt);
