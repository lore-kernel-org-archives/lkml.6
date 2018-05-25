Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969273AbeEYBsV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 21:48:21 -0400
Received: from smtprelay0048.hostedemail.com ([216.40.44.48]:36840 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965533AbeEYBsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 21:48:19 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::,RULES_HIT:2:41:355:379:541:599:960:966:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1730:1747:1777:1792:2196:2198:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3870:3871:3872:3874:4049:4118:4321:4384:4385:4395:5007:6119:6691:7875:7903:10004:10848:11026:11232:11473:11658:11914:12043:12296:12438:12663:12740:12760:12895:13439:14659:21080:21433:21451:21627:30051:30054:30091,0,RBL:23.242.70.174:@perches.com:.lbl8.mailshell.net-62.8.0.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: color88_825c603303142
X-Filterd-Recvd-Size: 7133
Message-ID: <9207979b211a5a20a9fe5fff96979735b83af26d.camel@perches.com>
Subject: Re: [PATCH 23/32] VFS: Implement logging through fs_context [ver #8]
From: Joe Perches <joe@perches.com>
To: David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date: Thu, 24 May 2018 18:48:13 -0700
In-Reply-To: <152720687323.9073.8203139324888988263.stgit@warthog.procyon.org.uk>
References: <152720672288.9073.9868393448836301272.stgit@warthog.procyon.org.uk>
         <152720687323.9073.8203139324888988263.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-05-25 at 01:07 +0100, David Howells wrote:
> Implement the ability for filesystems to log error, warning and
> informational messages through the fs_context.  These can be extracted by
> userspace by reading from an fd created by fsopen().
> 
> Error messages are prefixed with "e ", warnings with "w " and informational
> messages with "i ".
[]
> diff --git a/fs/fs_context.c b/fs/fs_context.c
[]
> +/**
> + * logfc - Log a message to a filesystem context
> + * @fc: The filesystem context to log to.
> + * @fmt: The format of the buffer.
> + */
> +void logfc(struct fs_context *fc, const char *fmt, ...)
> +{
> +	static const char store_failure[] = "OOM: Can't store error string";
> +	struct fc_log *log = fc->log;
> +	unsigned int logsize = ARRAY_SIZE(log->buffer);
> +	const char *p;
> +	va_list va;
> +	char *q;
> +	u8 freeable, index;
> +
> +	if (!log)
> +		return;
> +
> +	va_start(va, fmt);
> +	if (!strchr(fmt, '%')) {
> +		p = fmt;
> +		goto unformatted_string;
> +	}
> +	if (strcmp(fmt, "%s") == 0) {
> +		p = va_arg(va, const char *);
> +		goto unformatted_string;
> +	}
> +
> +	q = kvasprintf(GFP_KERNEL, fmt, va);
> +copied_string:
> +	if (!q)
> +		goto store_failure;
> +	freeable = 1;
> +	goto store_string;
> +
> +unformatted_string:
> +	if ((unsigned long)p >= (unsigned long)__start_rodata &&
> +	    (unsigned long)p <  (unsigned long)__end_rodata)
> +		goto const_string;
> +	if (within_module_core((unsigned long)p, log->owner))
> +		goto const_string;
> +	q = kstrdup(p, GFP_KERNEL);
> +	goto copied_string;
> +
> +store_failure:
> +	p = store_failure;
> +const_string:
> +	q = (char *)p;
> +	freeable = 0;
> +store_string:
> +	index = log->head & (logsize - 1);
> +	if ((int)log->head - (int)log->tail == 8) {
> +		/* The buffer is full, discard the oldest message */
> +		if (log->need_free & (1 << index))
> +			kfree(log->buffer[index]);
> +		log->tail++;
> +	}
> +
> +	log->buffer[index] = q;
> +	log->need_free &= ~(1 << index);
> +	log->need_free |= freeable << index;
> +	log->head++;
> +	va_end(va);
> +}
> +EXPORT_SYMBOL(logfc);

Perhaps this could be renamed to something more obviously
associated to fs_context

[]
> diff --git a/fs/fsopen.c b/fs/fsopen.c
[]
> @@ -159,7 +159,57 @@ static ssize_t fscontext_fs_write(struct file *file,
>  	goto err_unlock;
>  }
>  
> +/*
> + * Allow the user to read back any error, warning or informational messages.
> + */
> +static ssize_t fscontext_fs_read(struct file *file,
> +				 char __user *_buf, size_t len, loff_t *pos)
> +{
> +	struct fs_context *fc = file->private_data;
> +	struct fc_log *log = fc->log;
> +	struct inode *inode = file_inode(file);
> +	unsigned int logsize = ARRAY_SIZE(log->buffer);

logsize isn't modified, could be removed and ARRAY_SIZE used in-place.

> +	ssize_t ret;
> +	char *p;
> +	bool need_free;

It _looks_ like need_free isn't set by all codepaths, but
it doesn't need to be given the goto/return.

It also seems the the logic isn't straightforward here and
could be rewritten to be more obvious.

> +	int index, n;
> +
> +	ret = inode_lock_killable(inode);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = -ENODATA;
> +	if (log->head != log->tail) {
> +		index = log->tail & (logsize - 1);
> +		p = log->buffer[index];
> +		need_free = log->need_free & (1 << index);
> +		log->buffer[index] = NULL;
> +		log->need_free &= ~(1 << index);
> +		log->tail++;
> +		ret = 0;
> +	}
> +
> +	inode_unlock(inode);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = -EMSGSIZE;
> +	n = strlen(p);
> +	if (n > len)
> +		goto err_free;
> +	ret = -EFAULT;
> +	if (copy_to_user(_buf, p, n) != 0)
> +		goto err_free;
> +	ret = n;
> +
> +err_free:
> +	if (need_free)
> +		kfree(p);
> +	return ret;
> +}
> +
>  const struct file_operations fscontext_fs_fops = {
> +	.read		= fscontext_fs_read,
>  	.write		= fscontext_fs_write,
>  	.release	= fscontext_fs_release,
>  	.llseek		= no_llseek,
> @@ -330,6 +380,7 @@ SYSCALL_DEFINE5(fsopen, const char __user *, _fs_name, unsigned int, flags,
>  	struct file_system_type *fs_type;
>  	struct fs_context *fc;
>  	const char *fs_name;
> +	int ret;
>  
>  	if (!ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
> @@ -353,7 +404,18 @@ SYSCALL_DEFINE5(fsopen, const char __user *, _fs_name, unsigned int, flags,
>  
>  	fc->phase = FS_CONTEXT_CREATE_PARAMS;
>  
> +	ret = -ENOMEM;
> +	fc->log = kzalloc(sizeof(*fc->log), GFP_KERNEL);
> +	if (!fc->log)
> +		goto err_fc;
> +	refcount_set(&fc->log->usage, 1);
> +	fc->log->owner = fs_type->owner;
> +
>  	return fsopen_create_fd(fc, flags & FSOPEN_CLOEXEC);
> +
> +err_fc:
> +	put_fs_context(fc);
> +	return ret;
>  }

[]

> diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
> 
> @@ -117,4 +119,60 @@ extern int vfs_get_super(struct fs_context *fc,
>  
>  extern const struct file_operations fscontext_fs_fops;
>  
> +/*
> + * Mount error, warning and informational message logging.  This structure is
> + * shareable between a mount and a subordinate mount.
> + */
> +struct fc_log {
> +	refcount_t	usage;
> +	u8		head;		/* Insertion index in buffer[] */
> +	u8		tail;		/* Removal index in buffer[] */
> +	u8		need_free;	/* Mask of kfree'able items in buffer[] */
> +	struct module	*owner;		/* Owner module for strings that don't then need freeing */
> +	char		*buffer[8];
> +};
> +
> +extern __attribute__((format(printf, 2, 3)))

__printf(2, 3)

> +void logfc(struct fs_context *fc, const char *fmt, ...);
> +
> +/**
> + * infof - Store supplementary informational message
> + * @fc: The context in which to log the informational message
> + * @fmt: The format string
> + *
> + * Store the supplementary informational message for the process if the process
> + * has enabled the facility.
> + */
> +#define infof(fc, fmt, ...) ({ logfc(fc, "i "fmt, ## __VA_ARGS__); })

Why a statement expression macro and not just

#define infof(fc, fmt, ...)	logfc(fc, "i " fmt, ##__VA_ARGS__)

etc...
