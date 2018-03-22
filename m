Return-Path: <jlayton@kernel.org>
X-Google-Smtp-Source: AG47ELuTJC7j+S8Mo05tZFmT2d3N22XtNDgnS+U6X+54jNW/trDTOcMldaQhs9favy6YDElcZdMK
ARC-Seal: i=1; a=rsa-sha256; t=1521716276; cv=none;
        d=google.com; s=arc-20160816;
        b=ChQmQugT0KUcjIv+wFEqXYr5oBfNNrOQza8IBzVFBgvVk/Tluf6srPf7gihu1pBW/l
         napKu7ZjB1HdRo9iab6RNUm2pkxgYg/EreThT7j83zIkl+6e/VRZ2Q0wOTA8HFlH/1DF
         WUJuhhA9DhW2wzys8Vb2iyswndc//IqQDUPFWufR5EGE/Jn+UruDthM/Og4DUZR5fBQM
         6wToj98ucpUV3C2/OpdVqtyWT8KRmTi4EC5DLkubocO83xeceESFrN9xoE2s5U4jQL+w
         aIh2LLzPUvq4S79nEe6Bkzqn4agEj6/zsFg2CvyllmNskhNWMvzbfj+HBUrhSmonzf76
         u0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dmarc-filter
         :arc-authentication-results;
        bh=FN+ztVcy93FJ9+3tb9CUQ98eGaWQUFC4xVecVGHEDow=;
        b=jGZfnYkHMGyE16iddKjGvhjeU14zT634IfhXO03h0IzEsZc+cGjqlsvnCVqgG3hDy9
         e7n1toJ0/8v06QzLf/qPKp9yt83y5qFHbEvrH78I+rcPpZMwISERzJtGmb7dEGmx79Yq
         XsSWCyEMU0ptzten6srlZVZNRLovj7aYJ81J3/1ykD790Bdr3vl87T8NsgxkZZ3sAOVa
         kJyYK/xgyCS0epsis5jp2FKBCbUhqau1CZD9IWqa7O0lqm2BzS7kqVBetqQLUFwixhPC
         WE22UMCCdn07BCpeYQPLf2g9w7bpMa2iN3TJHq4ebnX04xn6xwRUjNS2anenC+qMuYw0
         t8tQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jlayton@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jlayton@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jlayton@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jlayton@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019BD2172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jlayton@kernel.org
Message-ID: <1521716273.4722.10.camel@kernel.org>
Subject: Re: [PATCH v2] locks: change POSIX lock ownership on execve when
 files_struct is displaced
From: Jeff Layton <jlayton@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander
 Viro <viro@zeniv.linux.org.uk>, "J. Bruce Fields" <bfields@fieldses.org>,
 Thomas Gleixner <tglx@linutronix.de>, Daniel
 =?ISO-8859-1?Q?P=2EBerrang=E9?= <berrange@redhat.com>,  Kate Stewart
 <kstewart@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Date: Thu, 22 Mar 2018 06:57:53 -0400
In-Reply-To: <871sgcvfh7.fsf@xmission.com>
References: <20180317142520.30520-1-jlayton@kernel.org>
	 <20180317165859.26200-1-jlayton@kernel.org> <87bmfgvg8w.fsf@xmission.com>
	 <871sgcvfh7.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595195233416759536?=
X-GMAIL-MSGID: =?utf-8?q?1595635166067729948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 2018-03-22 at 00:36 -0500, Eric W. Biederman wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> > Jeff Layton <jlayton@kernel.org> writes:
> > 
> > > From: Jeff Layton <jlayton@redhat.com>
> > > 
> > > POSIX mandates that open fds and their associated file locks should be
> > > preserved across an execve. This works, unless the process is
> > > multithreaded at the time that execve is called.
> > Would this perhaps work better if we moved unshare_files to after or
> > inside of de_thread.  That would remove any cases where fd->count is > 1
> > simply because you are multi-threaded.  It would only leave the strange
> > cases where files struct is shared between different processes.
> 
> The fact we have a problem here appears to be a regression caused by:
> fd8328be874f ("[PATCH] sanitize handling of shared descriptor tables in
> failing execve()")
> 
> So I really think we are calling unshare_files in the wrong location.
> 
> We could perhaps keep the benefit of being able to fail exec cleanly
> if we freeze the threads and then only unshare if the count of threads
> differs from the fd->count.  I don't know if it is worth it.
> 

I'm certainly open to your idea, and that does sound simpler.

I looked at a couple of different solutions here, and considered moving
the unshare_files call, but the problem is just what you state: the
error handling in here is _really_ difficult to manage.

Would you be willing to draft a patch that does what you're suggesting?
execve/thread handling is not really my area of expertise, so I'd
appreciate some guidance on how best to fix this.

Daniel wrote a testcase for the problem he reported, so we should be
able to quickly verify that the original problem is fixed if you have a
patch that does this. We probably we ought to get that testcase into LTP
or something too.

> > > In that case, we'll end up unsharing the files_struct but the locks will
> > > still have their fl_owner set to the address of the old one. Eventually,
> > > when the other threads die and the last reference to the old
> > > files_struct is put, any POSIX locks get torn down since it looks like
> > > a close occurred on them.
> > > 
> > > The result is that all of your open files will be intact with none of
> > > the locks you held before execve. The simple answer to this is "use OFD
> > > locks", but this is a nasty surprise and it violates the spec.
> > > 
> > > On a successful execve, change ownership of any POSIX file_locks
> > > associated with the old files_struct to the new one, if we ended up
> > > swapping it out.
> > 
> > If we can move unshare_files I believe the need for changing the
> > ownership would go away.  Which seems like easier to understand
> > and simpler code in the end.  With fewer surprises.
> > 
> > Eric
> > 
> > > Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > 
> > 
> > > ---
> > >  fs/exec.c          |  4 +++-
> > >  fs/locks.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/fs.h |  8 ++++++++
> > >  3 files changed, 71 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/exec.c b/fs/exec.c
> > > index 7eb8d21bcab9..35b05376bf78 100644
> > > --- a/fs/exec.c
> > > +++ b/fs/exec.c
> > > @@ -1812,8 +1812,10 @@ static int do_execveat_common(int fd, struct filename *filename,
> > >  	free_bprm(bprm);
> > >  	kfree(pathbuf);
> > >  	putname(filename);
> > > -	if (displaced)
> > > +	if (displaced) {
> > > +		posix_change_lock_owners(current->files, displaced);
> > >  		put_files_struct(displaced);
> > > +	}
> > >  	return retval;
> > >  
> > >  out:
> > > diff --git a/fs/locks.c b/fs/locks.c
> > > index d6ff4beb70ce..ab428ca8bb11 100644
> > > --- a/fs/locks.c
> > > +++ b/fs/locks.c
> > > @@ -993,6 +993,66 @@ static int flock_lock_inode(struct inode *inode, struct file_lock *request)
> > >  	return error;
> > >  }
> > >  
> > > +struct posix_change_lock_owners_arg {
> > > +	fl_owner_t old;
> > > +	fl_owner_t new;
> > > +};
> > > +
> > > +static int posix_change_lock_owners_cb(const void *varg, struct file *file,
> > > +					  unsigned int fd)
> > > +{
> > > +	const struct posix_change_lock_owners_arg *arg = varg;
> > > +	struct inode *inode = file_inode(file);
> > > +	struct file_lock_context *ctx;
> > > +	struct file_lock *fl, *tmp;
> > > +
> > > +	/* If there is no context, then no locks need to be changed */
> > > +	ctx = locks_get_lock_context(inode, F_UNLCK);
> > > +	if (!ctx)
> > > +		return 0;
> > > +
> > > +	percpu_down_read_preempt_disable(&file_rwsem);
> > > +	spin_lock(&ctx->flc_lock);
> > > +	/* Find the first lock with the old owner */
> > > +	list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> > > +		if (fl->fl_owner == arg->old)
> > > +			break;
> > > +	}
> > > +
> > > +	list_for_each_entry_safe_from(fl, tmp, &ctx->flc_posix, fl_list) {
> > > +		if (fl->fl_owner != arg->old)
> > > +			break;
> > > +
> > > +		/* This should only be used for normal userland lockmanager */
> > > +		if (fl->fl_lmops) {
> > > +			WARN_ON_ONCE(1);
> > > +			break;
> > > +		}
> > > +		fl->fl_owner = arg->new;
> > > +	}
> > > +	spin_unlock(&ctx->flc_lock);
> > > +	percpu_up_read_preempt_enable(&file_rwsem);
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * posix_change_lock_owners - change lock owners from old files_struct to new
> > > + * @files: new files struct to own locks
> > > + * @old: old files struct that previously held locks
> > > + *
> > > + * On execve, a process may end up with a new files_struct. In that case, we
> > > + * must change all of the locks that were owned by the previous files_struct
> > > + * to the new one.
> > > + */
> > > +void posix_change_lock_owners(struct files_struct *new,
> > > +			      struct files_struct *old)
> > > +{
> > > +	struct posix_change_lock_owners_arg arg = { .old = old,
> > > +						    .new = new };
> > > +
> > > +	iterate_fd(new, 0, posix_change_lock_owners_cb, &arg);
> > > +}
> > > +
> > >  static int posix_lock_inode(struct inode *inode, struct file_lock *request,
> > >  			    struct file_lock *conflock)
> > >  {
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 79c413985305..65fa99707bf9 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -1098,6 +1098,8 @@ extern int lease_modify(struct file_lock *, int, struct list_head *);
> > >  struct files_struct;
> > >  extern void show_fd_locks(struct seq_file *f,
> > >  			 struct file *filp, struct files_struct *files);
> > > +extern void posix_change_lock_owners(struct files_struct *new,
> > > +				     struct files_struct *old);
> > >  #else /* !CONFIG_FILE_LOCKING */
> > >  static inline int fcntl_getlk(struct file *file, unsigned int cmd,
> > >  			      struct flock __user *user)
> > > @@ -1232,6 +1234,12 @@ static inline int lease_modify(struct file_lock *fl, int arg,
> > >  struct files_struct;
> > >  static inline void show_fd_locks(struct seq_file *f,
> > >  			struct file *filp, struct files_struct *files) {}
> > > +
> > > +static inline void posix_change_lock_owners(struct files_struct *new,
> > > +					    struct files_struct *old)
> > > +{
> > > +}
> > > +
> > >  #endif /* !CONFIG_FILE_LOCKING */
> > >  
> > >  static inline struct inode *file_inode(const struct file *f)

-- 
Jeff Layton <jlayton@kernel.org>
