Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756563AbeBOXHs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:07:48 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756395AbeBOXHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:07:46 -0500
From: Steve Grubb <sgrubb@redhat.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH ghak8 ALT4 V4 1/3] audit: show partial pathname for entries with anonymous parents
Date: Thu, 15 Feb 2018 18:07:41 -0500
Message-ID: <2739042.dBRvusNJAk@x2>
Organization: Red Hat
In-Reply-To: <9a249968b7c994eaec1da8ae6d5bb48e385acf5c.1518411444.git.rgb@redhat.com>
References: <cover.1518411444.git.rgb@redhat.com> <9a249968b7c994eaec1da8ae6d5bb48e385acf5c.1518411444.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 12, 2018 12:02:21 AM EST Richard Guy Briggs wrote:
> Tracefs or debugfs were causing hundreds to thousands of null PATH
> records to be associated with the init_module and finit_module SYSCALL
> records on a few modules when the following rule was in place for
> startup:
>         -a always,exit -F arch=x86_64 -S init_module -F key=mod-load
> 
> This happens because the parent inode is not found in the task's
> audit_names list and hence treats it as anonymous.  This gives us no
> information other than a numerical device number for a device that may
> no longer be visible upon log inspeciton, and an inode number.
> 
> Fill in the partial known pathname from the filesystem mount point to
> the leaf node on previously null PATH records from entries that have an
> anonymous parent from the child dentry using dentry_path_raw().
> 
> Make the dentry argument of __audit_inode_child() non-const so that we
> can take a reference to it in the case of an anonymous parent with
> dget() and dget_parent() to be able to later print a partial path from
> the host filesystem rather than null.
> 
> Since all we are given is an inode of the parent and the dentry of the
> child, finding the path from the mount point to the root of the
> filesystem is more challenging that would involve searching all
> vfsmounts from "/" until a matching dentry is found for that
> filesystem's root dentry.  Even if one is found, there may be more than
> one mount point.  At this point the gain seems marginal since
> knowing the filesystem type and path are a significant help in tracking
> down the source of the PATH records and being able to address them.
> 
> Sample output:
> type=PROCTITLE msg=audit(1488317694.446:143):
> proctitle=2F7362696E2F6D6F6470726F6265002D71002D2D006E66737634 type=PATH
> msg=audit(1488317694.446:143): item=797
> name=events/nfs4/nfs4_setclientid/format inode=15969 dev=00:09
> mode=0100444 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:tracefs_t:s0
> nametype=CREATE cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0
> cap_fver=0 type=PATH msg=audit(1488317694.446:143): item=796
> name=events/nfs4/nfs4_setclientid inode=15964 dev=00:09 mode=040755 ouid=0
> ogid=0 rdev=00:00 obj=system_u:object_r:tracefs_t:s0 nametype=PARENT
> cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0 cap_fver=0 ...
> type=PATH msg=audit(1488317694.446:143): item=1 name=events/nfs4
> inode=15571 dev=00:09 mode=040755 ouid=0 ogid=0 rdev=00:00
> obj=system_u:object_r:tracefs_t:s0 nametype=CREATE cap_fp=0000000000000000
> cap_fi=0000000000000000 cap_fe=0 cap_fver=0 type=PATH
> msg=audit(1488317694.446:143): item=0 name=events inode=119 dev=00:09
> mode=040755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:tracefs_t:s0
> nametype=PARENT cap_fp=0000000000000000 cap_fi=0000000000000000 cap_fe=0
> cap_fver=0 type=KERN_MODULE msg=audit(1488317694.446:143): name="nfsv4"
> type=SYSCALL msg=audit(1488317694.446:143): arch=c000003e syscall=313
> success=yes exit=0 a0=1 a1=55d5a35ce106 a2=0 a3=1 items=798 ppid=6 pid=528
> auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0
> tty=(none) ses=4294967295 comm="modprobe" exe="/usr/bin/kmod"
> subj=system_u:system_r:insmod_t:s0 key="mod-load"

Thanks for the samples, but the event above fails the ausearch-test test 
suite. The "name" field in the PATH record is not properly escaped.

-Steve

> See: https://github.com/linux-audit/audit-kernel/issues/8
> Test case: https://github.com/linux-audit/audit-testsuite/issues/42
> 
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> 
> ---
> v4:
>   fix fullpath memleak
>   switch from log_format() to audit_log_untrustedstring()
>   remove leading / from pathname relative to unknown mount point
> 
> v3:
>   fix audit_buffer leak and dname error allocation leak audit_log_name
>   only put audit_name->dentry if it is being replaced
> 
> v2:
>   deconstify struct dentry*
>   add hex prefix to fstype
> ---
>  include/linux/audit.h |  8 ++++----
>  kernel/audit.c        | 28 +++++++++++++++++++++++++++-
>  kernel/audit.h        |  1 +
>  kernel/auditsc.c      |  8 +++++++-
>  4 files changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index af410d9..2020f1d 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -232,7 +232,7 @@ extern void __audit_inode(struct filename *name, const
> struct dentry *dentry, unsigned int flags);
>  extern void __audit_file(const struct file *);
>  extern void __audit_inode_child(struct inode *parent,
> -				const struct dentry *dentry,
> +				struct dentry *dentry,
>  				const unsigned char type);
>  extern void __audit_seccomp(unsigned long syscall, long signr, int code);
>  extern void __audit_ptrace(struct task_struct *t);
> @@ -297,7 +297,7 @@ static inline void audit_inode_parent_hidden(struct
> filename *name, AUDIT_INODE_PARENT | AUDIT_INODE_HIDDEN);
>  }
>  static inline void audit_inode_child(struct inode *parent,
> -				     const struct dentry *dentry,
> +				     struct dentry *dentry,
>  				     const unsigned char type) {
>  	if (unlikely(!audit_dummy_context()))
>  		__audit_inode_child(parent, dentry, type);
> @@ -481,7 +481,7 @@ static inline void __audit_inode(struct filename *name,
> unsigned int flags)
>  { }
>  static inline void __audit_inode_child(struct inode *parent,
> -					const struct dentry *dentry,
> +					struct dentry *dentry,
>  					const unsigned char type)
>  { }
>  static inline void audit_inode(struct filename *name,
> @@ -495,7 +495,7 @@ static inline void audit_inode_parent_hidden(struct
> filename *name, const struct dentry *dentry)
>  { }
>  static inline void audit_inode_child(struct inode *parent,
> -				     const struct dentry *dentry,
> +				     struct dentry *dentry,
>  				     const unsigned char type)
>  { }
>  static inline void audit_core_dumps(long signr)
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 227db99..0c8d5a8 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -72,6 +72,7 @@
>  #include <linux/freezer.h>
>  #include <linux/pid_namespace.h>
>  #include <net/netns/generic.h>
> +#include <linux/dcache.h>
> 
>  #include "audit.h"
> 
> @@ -2056,6 +2057,10 @@ void audit_copy_inode(struct audit_names *name,
> const struct dentry *dentry, name->gid   = inode->i_gid;
>  	name->rdev  = inode->i_rdev;
>  	security_inode_getsecid(inode, &name->osid);
> +	if (name->dentry) {
> +		dput(name->dentry);
> +		name->dentry = NULL;
> +	}
>  	audit_copy_fcaps(name, dentry);
>  }
> 
> @@ -2097,8 +2102,29 @@ void audit_log_name(struct audit_context *context,
> struct audit_names *n, audit_log_n_untrustedstring(ab, n->name->name,
>  						    n->name_len);
>  		}
> -	} else
> +	} else if (n->dentry) {
> +		char *fullpath;
> +		const char *fullpathp = NULL;
> +
> +		fullpath = kmalloc(PATH_MAX, GFP_KERNEL);
> +		if (fullpath) {
> +			fullpathp = dentry_path_raw(n->dentry, fullpath, PATH_MAX);
> +			if (IS_ERR(fullpathp)) {
> +				fullpathp = NULL;
> +			} else {
> +				while (*fullpathp == '/')
> +					fullpathp++;
> +				if (*fullpathp == 0)
> +					fullpathp = NULL;
> +			}
> +		}
> +		audit_log_format(ab, " name=");
> +		audit_log_untrustedstring(ab, fullpathp ?: "?");
> +		if (fullpath)
> +			kfree(fullpath);
> +	} else {
>  		audit_log_format(ab, " name=(null)");
> +	}
> 
>  	if (n->ino != AUDIT_INO_UNSET)
>  		audit_log_format(ab, " inode=%lu"
> diff --git a/kernel/audit.h b/kernel/audit.h
> index af5bc59..81f6865 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -85,6 +85,7 @@ struct audit_names {
> 
>  	unsigned long		ino;
>  	dev_t			dev;
> +	struct dentry		*dentry;
>  	umode_t			mode;
>  	kuid_t			uid;
>  	kgid_t			gid;
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index e80459f..b73ede0 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -75,6 +75,7 @@
>  #include <linux/uaccess.h>
>  #include <linux/fsnotify_backend.h>
>  #include <uapi/linux/limits.h>
> +#include <linux/dcache.h>
> 
>  #include "audit.h"
> 
> @@ -882,6 +883,8 @@ static inline void audit_free_names(struct
> audit_context *context) list_del(&n->list);
>  		if (n->name)
>  			putname(n->name);
> +		if (n->dentry)
> +			dput(n->dentry);
>  		if (n->should_free)
>  			kfree(n);
>  	}
> @@ -1862,7 +1865,7 @@ void __audit_file(const struct file *file)
>   * unsuccessful attempts.
>   */
>  void __audit_inode_child(struct inode *parent,
> -			 const struct dentry *dentry,
> +			 struct dentry *dentry,
>  			 const unsigned char type)
>  {
>  	struct audit_context *context = current->audit_context;
> @@ -1941,6 +1944,7 @@ void __audit_inode_child(struct inode *parent,
>  		if (!n)
>  			return;
>  		audit_copy_inode(n, NULL, parent);
> +		n->dentry = dget_parent(dentry);
>  	}
> 
>  	if (!found_child) {
> @@ -1962,6 +1966,8 @@ void __audit_inode_child(struct inode *parent,
>  		audit_copy_inode(found_child, dentry, inode);
>  	else
>  		found_child->ino = AUDIT_INO_UNSET;
> +	if (!found_parent)
> +		found_child->dentry = dget(dentry);
>  }
>  EXPORT_SYMBOL_GPL(__audit_inode_child);
