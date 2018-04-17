Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeDQRrS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:47:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752733AbeDQRrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:47:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4902170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 17 Apr 2018 14:47:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: perf probe line numbers + CONFIG_DEBUG_INFO_SPLIT=y
Message-ID: <20180417174701.GD3625@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

	I just tried building the kernel using:

CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_SPLIT=y
# CONFIG_DEBUG_INFO_DWARF4 is not set

	that info split looked interesting, and I thought that since we
use elfutils we'd get that for free somehow, so I tried getname_flags
and got the output at the end of this message, with these artifacts:

1) the function signature doesn't appear at the start of the '-L
getname_flags' output

2) offsets are not calculated, just the line numbers in fs/namei.c (it
matches the first line :130 with the first line number.

And then if I try adding a probe at some places, say line 202, to
collect the filename being brought from userspace to the kernel, it
fails:

[root@jouet perf]# perf probe "vfs_getname=getname_flags:202 pathname=result->name:string"
Probe point 'getname_flags:202' not found.
  Error: Failed to add events.
[root@jouet perf]#

If I just try putting the probe without renaming nor collecting vars, to
have a simpler probe request:

[root@jouet perf]# perf probe getname_flags:202 
Probe point 'getname_flags:202' not found.
  Error: Failed to add events.
[root@jouet perf]# 

Or even:

[root@jouet perf]# perf probe getname_flags
Failed to find scope of probe point.
getname_flags is out of .text, skip it.
  Error: Failed to add events.
[root@jouet perf]# 

[root@jouet perf]# grep getname_flags /proc/kallsyms 
ffffffffb329a5a0 T getname_flags
[root@jouet perf]#

I'll try with CONFIG_DEBUG_INFO_SPLIT not set, but have you ever got
such a report?

- Arnaldo

# perf probe -L getname_flags
</home/acme/git/linux/fs/namei.c:130>
    130  {
         	struct filename *result;
         	char *kname;
         	int len;
         	BUILD_BUG_ON(offsetof(struct filename, iname) % sizeof(long) != 0);
         
         	result = audit_reusename(filename);
    137  	if (result)
         		return result;
         
    140  	result = __getname();
    141  	if (unlikely(!result))
    142  		return ERR_PTR(-ENOMEM);
         
         	/*
         	 * First, try to embed the struct filename inside the names_cache
         	 * allocation
         	 */
    148  	kname = (char *)result->iname;
    149  	result->name = kname;
         
    151  	len = strncpy_from_user(kname, filename, EMBEDDED_NAME_MAX);
    152  	if (unlikely(len < 0)) {
    153  		__putname(result);
    154  		return ERR_PTR(len);
         	}
         
         	/*
         	 * Uh-oh. We have a name that's approaching PATH_MAX. Allocate a
         	 * separate struct filename so we can dedicate the entire
         	 * names_cache allocation for the pathname, and re-do the copy from
         	 * userland.
         	 */
    163  	if (unlikely(len == EMBEDDED_NAME_MAX)) {
         		const size_t size = offsetof(struct filename, iname[1]);
         		kname = (char *)result;
         
         		/*
         		 * size is chosen that way we to guarantee that
         		 * result->iname[0] is within the same object and that
         		 * kname can't be equal to result->iname, no matter what.
         		 */
         		result = kzalloc(size, GFP_KERNEL);
    173  		if (unlikely(!result)) {
    174  			__putname(kname);
    175  			return ERR_PTR(-ENOMEM);
         		}
    177  		result->name = kname;
    178  		len = strncpy_from_user(kname, filename, PATH_MAX);
    179  		if (unlikely(len < 0)) {
    180  			__putname(kname);
    181  			kfree(result);
    182  			return ERR_PTR(len);
         		}
    184  		if (unlikely(len == PATH_MAX)) {
    185  			__putname(kname);
    186  			kfree(result);
    187  			return ERR_PTR(-ENAMETOOLONG);
         		}
         	}
         
    191  	result->refcnt = 1;
         	/* The empty path is special. */
    193  	if (unlikely(!len)) {
    194  		if (empty)
    195  			*empty = 1;
    196  		if (!(flags & LOOKUP_EMPTY)) {
    197  			putname(result);
    198  			return ERR_PTR(-ENOENT);
         		}
         	}
         
    202  	result->uptr = filename;
    203  	result->aname = NULL;
         	audit_getname(result);
         	return result;
    206  }
         
         struct filename *
         getname(const char __user * filename)
    210  {
    211  	return getname_flags(filename, 0, NULL);
         }
         
         struct filename *
         getname_kernel(const char * filename)
    216  {
         	struct filename *result;
    218  	int len = strlen(filename) + 1;
         
    220  	result = __getname();
    221  	if (unlikely(!result))
    222  		return ERR_PTR(-ENOMEM);
         
    224  	if (len <= EMBEDDED_NAME_MAX) {
    225  		result->name = (char *)result->iname;
    226  	} else if (len <= PATH_MAX) {
         		const size_t size = offsetof(struct filename, iname[1]);
         		struct filename *tmp;
         
         		tmp = kmalloc(size, GFP_KERNEL);
    231  		if (unlikely(!tmp)) {
    232  			__putname(result);
    233  			return ERR_PTR(-ENOMEM);
         		}
    235  		tmp->name = (char *)result;
         		result = tmp;
         	} else {
    238  		__putname(result);
    239  		return ERR_PTR(-ENAMETOOLONG);
         	}
    241  	memcpy((char *)result->name, filename, len);
    242  	result->uptr = NULL;
    243  	result->aname = NULL;
    244  	result->refcnt = 1;
         	audit_getname(result);
         
         	return result;
    248  }
         
         void putname(struct filename *name)
    251  {
    252  	BUG_ON(name->refcnt <= 0);
         
    254  	if (--name->refcnt > 0)
         		return;
         
    257  	if (name->name != name->iname) {
    258  		__putname(name->name);
    259  		kfree(name);
         	} else
    261  		__putname(name);
    262  }
         
         static int check_acl(struct inode *inode, int mask)
         {
         #ifdef CONFIG_FS_POSIX_ACL
         	struct posix_acl *acl;
         
    269  	if (mask & MAY_NOT_BLOCK) {
    270  		acl = get_cached_acl_rcu(inode, ACL_TYPE_ACCESS);
    271  	        if (!acl)
         	                return -EAGAIN;
         		/* no ->get_acl() calls in RCU mode... */
    274  		if (is_uncached_acl(acl))
    275  			return -ECHILD;
    276  	        return posix_acl_permission(inode, acl, mask & ~MAY_NOT_BLOCK);
         	}
         
    279  	acl = get_acl(inode, ACL_TYPE_ACCESS);
    280  	if (IS_ERR(acl))
         		return PTR_ERR(acl);
    282  	if (acl) {
    283  	        int error = posix_acl_permission(inode, acl, mask);
         	        posix_acl_release(acl);
         	        return error;
         	}
         #endif
         
         	return -EAGAIN;
         }
         
         /*
          * This does the basic permission checking
          */
         static int acl_permission_check(struct inode *inode, int mask)
         {
    297  	unsigned int mode = inode->i_mode;
         
    299  	if (likely(uid_eq(current_fsuid(), inode->i_uid)))
    300  		mode >>= 6;
         	else {
    302  		if (IS_POSIXACL(inode) && (mode & S_IRWXG)) {
         			int error = check_acl(inode, mask);
    304  			if (error != -EAGAIN)
         				return error;
         		}
         
    308  		if (in_group_p(inode->i_gid))
    309  			mode >>= 3;
         	}
         
         	/*
         	 * If the DACs are ok we don't need any capability check.
         	 */
    315  	if ((mask & ~mode & (MAY_READ | MAY_WRITE | MAY_EXEC)) == 0)
    316  		return 0;
         	return -EACCES;
         }
         
         /**
          * generic_permission -  check for access rights on a Posix-like filesystem
          * @inode:	inode to check access rights for
          * @mask:	right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC, ...)
          *
          * Used to check for read/write/execute permissions on a file.
          * We use "fsuid" for this, letting us set arbitrary permissions
          * for filesystem access without changing the "normal" uids which
          * are used for other things.
          *
          * generic_permission is rcu-walk aware. It returns -ECHILD in case an rcu-walk
          * request cannot be satisfied (eg. requires blocking or too much complexity).
          * It would then be called again in ref-walk mode.
          */
         int generic_permission(struct inode *inode, int mask)
    335  {
         	int ret;
         
         	/*
         	 * Do the basic permission checks.
         	 */
         	ret = acl_permission_check(inode, mask);
    342  	if (ret != -EACCES)
         		return ret;
         
    345  	if (S_ISDIR(inode->i_mode)) {
         		/* DACs are overridable for directories */
    347  		if (!(mask & MAY_WRITE))
    348  			if (capable_wrt_inode_uidgid(inode,
         						     CAP_DAC_READ_SEARCH))
         				return 0;
         		if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
         			return 0;
    353  		return -EACCES;
         	}
         
         	/*
         	 * Searching includes executable on directories, else just read.
         	 */
    359  	mask &= MAY_READ | MAY_WRITE | MAY_EXEC;
    360  	if (mask == MAY_READ)
    361  		if (capable_wrt_inode_uidgid(inode, CAP_DAC_READ_SEARCH))
         			return 0;
         	/*
         	 * Read/write DACs are always overridable.
         	 * Executable DACs are overridable when there is
         	 * at least one exec bit set.
         	 */
    368  	if (!(mask & MAY_EXEC) || (inode->i_mode & S_IXUGO))
    369  		if (capable_wrt_inode_uidgid(inode, CAP_DAC_OVERRIDE))
         			return 0;
         
         	return -EACCES;
    373  }
         EXPORT_SYMBOL(generic_permission);
         
         /*
          * We _really_ want to just do "generic_permission()" without
          * even looking at the inode->i_op values. So we keep a cache
          * flag in inode->i_opflags, that says "this has not special
          * permission function, use the fast case".
          */
         static inline int do_inode_permission(struct inode *inode, int mask)
         {
    384  	if (unlikely(!(inode->i_opflags & IOP_FASTPERM))) {
    385  		if (likely(inode->i_op->permission))
    386  			return inode->i_op->permission(inode, mask);
         
         		/* This gets set once for the inode lifetime */
         		spin_lock(&inode->i_lock);
    390  		inode->i_opflags |= IOP_FASTPERM;
         		spin_unlock(&inode->i_lock);
         	}
    393  	return generic_permission(inode, mask);
         }
         
         /**
          * sb_permission - Check superblock-level permissions
          * @sb: Superblock of inode to check permission on
          * @inode: Inode to check permission on
          * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
          *
          * Separate out file-system wide checks from inode-specific permission checks.
          */
         static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
         {
    406  	if (unlikely(mask & MAY_WRITE)) {
    407  		umode_t mode = inode->i_mode;
         
         		/* Nobody gets write access to a read-only fs. */
    410  		if (sb_rdonly(sb) && (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)))
         			return -EROFS;
         	}
         	return 0;
         }
         
         /**
          * inode_permission - Check for access rights to a given inode
          * @inode: Inode to check permission on
          * @mask: Right to check for (%MAY_READ, %MAY_WRITE, %MAY_EXEC)
          *
          * Check for read/write/execute permissions on an inode.  We use fs[ug]id for
          * this, letting us set arbitrary permissions for filesystem access without
          * changing the "normal" UIDs which are used for other things.
          *
          * When checking for MAY_APPEND, MAY_WRITE must also be set in @mask.
          */
         int inode_permission(struct inode *inode, int mask)
    428  {
         	int retval;
         
         	retval = sb_permission(inode->i_sb, inode, mask);
         	if (retval)
         		return retval;
         
         	if (unlikely(mask & MAY_WRITE)) {
         		/*
         		 * Nobody gets write access to an immutable file.
         		 */
    439  		if (IS_IMMUTABLE(inode))
    440  			return -EPERM;
         
         		/*
         		 * Updating mtime will likely cause i_uid and i_gid to be
         		 * written back improperly if their true value is unknown
         		 * to the vfs.
         		 */
         		if (HAS_UNMAPPED_ID(inode))
    448  			return -EACCES;
         	}
         
         	retval = do_inode_permission(inode, mask);
    452  	if (retval)
         		return retval;
         
    455  	retval = devcgroup_inode_permission(inode, mask);
    456  	if (retval)
         		return retval;
         
    459  	return security_inode_permission(inode, mask);
    460  }
         EXPORT_SYMBOL(inode_permission);
         
         /**
          * path_get - get a reference to a path
          * @path: path to get the reference to
          *
          * Given a path increment the reference count to the dentry and the vfsmount.
          */
         void path_get(const struct path *path)
    470  {
    471  	mntget(path->mnt);
    472  	dget(path->dentry);
    473  }
         EXPORT_SYMBOL(path_get);
         
         /**
          * path_put - put a reference to a path
          * @path: path to put the reference to
          *
          * Given a path decrement the reference count to the dentry and the vfsmount.
          */
         void path_put(const struct path *path)
    483  {
    484  	dput(path->dentry);
    485  	mntput(path->mnt);
    486  }
         EXPORT_SYMBOL(path_put);
         
         #define EMBEDDED_LEVELS 2
         struct nameidata {
         	struct path	path;
         	struct qstr	last;
         	struct path	root;
         	struct inode	*inode; /* path.dentry.d_inode */
         	unsigned int	flags;
         	unsigned	seq, m_seq;
         	int		last_type;
         	unsigned	depth;
         	int		total_link_count;
         	struct saved {
         		struct path link;
         		struct delayed_call done;
         		const char *name;
         		unsigned seq;
         	} *stack, internal[EMBEDDED_LEVELS];
         	struct filename	*name;
         	struct nameidata *saved;
         	struct inode	*link_inode;
         	unsigned	root_seq;
         	int		dfd;
         } __randomize_layout;
         
         static void set_nameidata(struct nameidata *p, int dfd, struct filename *name)
         {
    515  	struct nameidata *old = current->nameidata;
    516  	p->stack = p->internal;
    517  	p->dfd = dfd;
    518  	p->name = name;
    519  	p->total_link_count = old ? old->total_link_count : 0;
    520  	p->saved = old;
    521  	current->nameidata = p;
         }
         
         static void restore_nameidata(void)
    525  {
    526  	struct nameidata *now = current->nameidata, *old = now->saved;
         
    528  	current->nameidata = old;
    529  	if (old)
    530  		old->total_link_count = now->total_link_count;
    531  	if (now->stack != now->internal)
    532  		kfree(now->stack);
    533  }
         
         static int __nd_alloc_stack(struct nameidata *nd)
    536  {
         	struct saved *p;
         
    539  	if (nd->flags & LOOKUP_RCU) {
         		p= kmalloc(MAXSYMLINKS * sizeof(struct saved),
         				  GFP_ATOMIC);
    542  		if (unlikely(!p))
    543  			return -ECHILD;
         	} else {
         		p= kmalloc(MAXSYMLINKS * sizeof(struct saved),
         				  GFP_KERNEL);
    547  		if (unlikely(!p))
    548  			return -ENOMEM;
         	}
    550  	memcpy(p, nd->internal, sizeof(nd->internal));
    551  	nd->stack = p;
    552  	return 0;
    553  }
         
         /**
          * path_connected - Verify that a path->dentry is below path->mnt.mnt_root
          * @path: nameidate to verify
          *
          * Rename can sometimes move a file or directory outside of a bind
          * mount, path_connected allows those cases to be detected.
          */
         static bool path_connected(const struct path *path)
    563  {
    564  	struct vfsmount *mnt = path->mnt;
    565  	struct super_block *sb = mnt->mnt_sb;
         
         	/* Bind mounts and multi-root filesystems can have disconnected paths */
    568  	if (!(sb->s_iflags & SB_I_MULTIROOT) && (mnt->mnt_root == sb->s_root))
         		return true;
         
    571  	return is_subdir(path->dentry, mnt->mnt_root);
    572  }
         
         static inline int nd_alloc_stack(struct nameidata *nd)
         {
    576  	if (likely(nd->depth != EMBEDDED_LEVELS))
         		return 0;
    578  	if (likely(nd->stack != nd->internal))
         		return 0;
    580  	return __nd_alloc_stack(nd);
         }
         
         static void drop_links(struct nameidata *nd)
         {
    585  	int i = nd->depth;
    586  	while (i--) {
    587  		struct saved *last = nd->stack + i;
         		do_delayed_call(&last->done);
         		clear_delayed_call(&last->done);
         	}
         }
         
         static void terminate_walk(struct nameidata *nd)
    594  {
         	drop_links(nd);
    596  	if (!(nd->flags & LOOKUP_RCU)) {
         		int i;
         		path_put(&nd->path);
    599  		for (i = 0; i < nd->depth; i++)
    600  			path_put(&nd->stack[i].link);
    601  		if (nd->root.mnt && !(nd->flags & LOOKUP_ROOT)) {
         			path_put(&nd->root);
    603  			nd->root.mnt = NULL;
         		}
         	} else {
    606  		nd->flags &= ~LOOKUP_RCU;
    607  		if (!(nd->flags & LOOKUP_ROOT))
    608  			nd->root.mnt = NULL;
         		rcu_read_unlock();
         	}
    611  	nd->depth = 0;
    612  }
         
         /* path_put is needed afterwards regardless of success or failure */
    615  static bool legitimize_path(struct nameidata *nd,
         			    struct path *path, unsigned seq)
         {
    618  	int res = __legitimize_mnt(path->mnt, nd->m_seq);
    619  	if (unlikely(res)) {
    620  		if (res > 0)
    621  			path->mnt = NULL;
    622  		path->dentry = NULL;
    623  		return false;
         	}
    625  	if (unlikely(!lockref_get_not_dead(&path->dentry->d_lockref))) {
         		path->dentry = NULL;
         		return false;
         	}
    629  	return !read_seqcount_retry(&path->dentry->d_seq, seq);
    630  }
         
         static bool legitimize_links(struct nameidata *nd)
    633  {
         	int i;
    635  	for (i = 0; i < nd->depth; i++) {
    636  		struct saved *last = nd->stack + i;
    637  		if (unlikely(!legitimize_path(nd, &last->link, last->seq))) {
         			drop_links(nd);
    639  			nd->depth = i + 1;
    640  			return false;
         		}
         	}
    643  	return true;
    644  }
         
         /*
          * Path walking has 2 modes, rcu-walk and ref-walk (see
          * Documentation/filesystems/path-lookup.txt).  In situations when we can't
          * continue in RCU mode, we attempt to drop out of rcu-walk mode and grab
          * normal reference counts on dentries and vfsmounts to transition to ref-walk
          * mode.  Refcounts are grabbed at the last known good point before rcu-walk
          * got stuck, so ref-walk may continue from there. If this is not successful
          * (eg. a seqcount has changed), then failure is returned and it's up to caller
          * to restart the path walk from the beginning in ref-walk mode.
          */
         
         /**
          * unlazy_walk - try to switch to ref-walk mode.
          * @nd: nameidata pathwalk data
          * Returns: 0 on success, -ECHILD on failure
          *
          * unlazy_walk attempts to legitimize the current nd->path and nd->root
          * for ref-walk mode.
          * Must be called from rcu-walk context.
          * Nothing should touch nameidata between unlazy_walk() failure and
          * terminate_walk().
          */
         static int unlazy_walk(struct nameidata *nd)
    669  {
    670  	struct dentry *parent = nd->path.dentry;
         
    672  	BUG_ON(!(nd->flags & LOOKUP_RCU));
         
    674  	nd->flags &= ~LOOKUP_RCU;
    675  	if (unlikely(!legitimize_links(nd)))
         		goto out2;
    677  	if (unlikely(!legitimize_path(nd, &nd->path, nd->seq)))
         		goto out1;
    679  	if (nd->root.mnt && !(nd->flags & LOOKUP_ROOT)) {
    680  		if (unlikely(!legitimize_path(nd, &nd->root, nd->root_seq)))
         			goto out;
         	}
         	rcu_read_unlock();
    684  	BUG_ON(nd->inode != parent->d_inode);
    685  	return 0;
         
         out2:
    688  	nd->path.mnt = NULL;
    689  	nd->path.dentry = NULL;
         out1:
    691  	if (!(nd->flags & LOOKUP_ROOT))
    692  		nd->root.mnt = NULL;
         out:
         	rcu_read_unlock();
    695  	return -ECHILD;
    696  }
         
         /**
          * unlazy_child - try to switch to ref-walk mode.
          * @nd: nameidata pathwalk data
          * @dentry: child of nd->path.dentry
          * @seq: seq number to check dentry against
          * Returns: 0 on success, -ECHILD on failure
          *
          * unlazy_child attempts to legitimize the current nd->path, nd->root and dentry
          * for ref-walk mode.  @dentry must be a path found by a do_lookup call on
          * @nd.  Must be called from rcu-walk context.
          * Nothing should touch nameidata between unlazy_child() failure and
          * terminate_walk().
          */
         static int unlazy_child(struct nameidata *nd, struct dentry *dentry, unsigned seq)
         {
    713  	BUG_ON(!(nd->flags & LOOKUP_RCU));
         
    715  	nd->flags &= ~LOOKUP_RCU;
    716  	if (unlikely(!legitimize_links(nd)))
         		goto out2;
    718  	if (unlikely(!legitimize_mnt(nd->path.mnt, nd->m_seq)))
         		goto out2;
    720  	if (unlikely(!lockref_get_not_dead(&nd->path.dentry->d_lockref)))
         		goto out1;
         
         	/*
         	 * We need to move both the parent and the dentry from the RCU domain
         	 * to be properly refcounted. And the sequence number in the dentry
         	 * validates *both* dentry counters, since we checked the sequence
         	 * number of the parent after we got the child sequence number. So we
         	 * know the parent must still be valid if the child sequence number is
         	 */
    730  	if (unlikely(!lockref_get_not_dead(&dentry->d_lockref)))
         		goto out;
    732  	if (unlikely(read_seqcount_retry(&dentry->d_seq, seq))) {
         		rcu_read_unlock();
    734  		dput(dentry);
         		goto drop_root_mnt;
         	}
         	/*
         	 * Sequence counts matched. Now make sure that the root is
         	 * still valid and get it if required.
         	 */
    741  	if (nd->root.mnt && !(nd->flags & LOOKUP_ROOT)) {
    742  		if (unlikely(!legitimize_path(nd, &nd->root, nd->root_seq))) {
         			rcu_read_unlock();
    744  			dput(dentry);
         			return -ECHILD;
         		}
         	}
         
         	rcu_read_unlock();
         	return 0;
         
         out2:
    753  	nd->path.mnt = NULL;
         out1:
    755  	nd->path.dentry = NULL;
         out:
         	rcu_read_unlock();
         drop_root_mnt:
    759  	if (!(nd->flags & LOOKUP_ROOT))
    760  		nd->root.mnt = NULL;
         	return -ECHILD;
         }
         
         static inline int d_revalidate(struct dentry *dentry, unsigned int flags)
         {
    766  	if (unlikely(dentry->d_flags & DCACHE_OP_REVALIDATE))
    767  		return dentry->d_op->d_revalidate(dentry, flags);
         	else
    769  		return 1;
         }
         
         /**
          * complete_walk - successful completion of path walk
          * @nd:  pointer nameidata
          *
          * If we had been in RCU mode, drop out of it and legitimize nd->path.
          * Revalidate the final result, unless we'd already done that during
          * the path walk or the filesystem doesn't ask for it.  Return 0 on
          * success, -error on failure.  In case of failure caller does not
          * need to drop nd->path.
          */
         static int complete_walk(struct nameidata *nd)
    783  {
    784  	struct dentry *dentry = nd->path.dentry;
         	int status;
         
    787  	if (nd->flags & LOOKUP_RCU) {
    788  		if (!(nd->flags & LOOKUP_ROOT))
    789  			nd->root.mnt = NULL;
    790  		if (unlikely(unlazy_walk(nd)))
    791  			return -ECHILD;
         	}
         
    794  	if (likely(!(nd->flags & LOOKUP_JUMPED)))
    795  		return 0;
         
    797  	if (likely(!(dentry->d_flags & DCACHE_OP_WEAK_REVALIDATE)))
         		return 0;
         
    800  	status = dentry->d_op->d_weak_revalidate(dentry, nd->flags);
    801  	if (status > 0)
         		return 0;
         
         	if (!status)
    805  		status = -ESTALE;
         
         	return status;
    808  }
         
         static void set_root(struct nameidata *nd)
    811  {
    812  	struct fs_struct *fs = current->fs;
         
    814  	if (nd->flags & LOOKUP_RCU) {
         		unsigned seq;
         
         		do {
         			seq = read_seqcount_begin(&fs->seq);
    819  			nd->root = fs->root;
    820  			nd->root_seq = __read_seqcount_begin(&nd->root.dentry->d_seq);
    821  		} while (read_seqcount_retry(&fs->seq, seq));
         	} else {
    823  		get_fs_root(fs, &nd->root);
         	}
    825  }
         
         static void path_put_conditional(struct path *path, struct nameidata *nd)
         {
    829  	dput(path->dentry);
    830  	if (path->mnt != nd->path.mnt)
    831  		mntput(path->mnt);
         }
         
         static inline void path_to_nameidata(const struct path *path,
         					struct nameidata *nd)
         {
    837  	if (!(nd->flags & LOOKUP_RCU)) {
    838  		dput(nd->path.dentry);
    839  		if (nd->path.mnt != path->mnt)
    840  			mntput(nd->path.mnt);
         	}
    842  	nd->path.mnt = path->mnt;
    843  	nd->path.dentry = path->dentry;
         }
         
         static int nd_jump_root(struct nameidata *nd)
    847  {
    848  	if (nd->flags & LOOKUP_RCU) {
         		struct dentry *d;
    850  		nd->path = nd->root;
    851  		d = nd->path.dentry;
    852  		nd->inode = d->d_inode;
    853  		nd->seq = nd->root_seq;
    854  		if (unlikely(read_seqcount_retry(&d->d_seq, nd->seq)))
    855  			return -ECHILD;
         	} else {
         		path_put(&nd->path);
    858  		nd->path = nd->root;
    859  		path_get(&nd->path);
    860  		nd->inode = nd->path.dentry->d_inode;
         	}
    862  	nd->flags |= LOOKUP_JUMPED;
    863  	return 0;
    864  }
         
         /*
          * Helper to directly jump to a known parsed path from ->get_link,
          * caller must have taken a reference to path beforehand.
          */
         void nd_jump_link(struct path *path)
    871  {
    872  	struct nameidata *nd = current->nameidata;
         	path_put(&nd->path);
         
    875  	nd->path = *path;
    876  	nd->inode = nd->path.dentry->d_inode;
    877  	nd->flags |= LOOKUP_JUMPED;
    878  }
         
         static inline void put_link(struct nameidata *nd)
         {
    882  	struct saved *last = nd->stack + --nd->depth;
         	do_delayed_call(&last->done);
    884  	if (!(nd->flags & LOOKUP_RCU))
         		path_put(&last->link);
         }
         
         int sysctl_protected_symlinks __read_mostly = 0;
         int sysctl_protected_hardlinks __read_mostly = 0;
         
         /**
          * may_follow_link - Check symlink following for unsafe situations
          * @nd: nameidata pathwalk data
          *
          * In the case of the sysctl_protected_symlinks sysctl being enabled,
          * CAP_DAC_OVERRIDE needs to be specifically ignored if the symlink is
          * in a sticky world-writable directory. This is to protect privileged
          * processes from failing races against path names that may change out
          * from under them by way of other users creating malicious symlinks.
          * It will permit symlinks to be followed only when outside a sticky
          * world-writable directory, or when the uid of the symlink and follower
          * match, or when the directory owner matches the symlink's owner.
          *
          * Returns 0 if following the symlink is allowed, -ve on error.
          */
         static inline int may_follow_link(struct nameidata *nd)
         {
         	const struct inode *inode;
         	const struct inode *parent;
         	kuid_t puid;
         
    912  	if (!sysctl_protected_symlinks)
         		return 0;
         
         	/* Allowed if owner and follower match. */
         	inode = nd->link_inode;
    917  	if (uid_eq(current_cred()->fsuid, inode->i_uid))
         		return 0;
         
         	/* Allowed if parent directory not sticky and world-writable. */
    921  	parent = nd->inode;
    922  	if ((parent->i_mode & (S_ISVTX|S_IWOTH)) != (S_ISVTX|S_IWOTH))
         		return 0;
         
         	/* Allowed if parent directory and link owner match. */
    926  	puid = parent->i_uid;
    927  	if (uid_valid(puid) && uid_eq(puid, inode->i_uid))
         		return 0;
         
    930  	if (nd->flags & LOOKUP_RCU)
         		return -ECHILD;
         
    933  	audit_inode(nd->name, nd->stack[0].link.dentry, 0);
    934  	audit_log_link_denied("follow_link");
         	return -EACCES;
         }
         
         /**
          * safe_hardlink_source - Check for safe hardlink conditions
          * @inode: the source inode to hardlink from
          *
          * Return false if at least one of the following conditions:
          *    - inode is not a regular file
          *    - inode is setuid
          *    - inode is setgid and group-exec
          *    - access failure for read and write
          *
          * Otherwise returns true.
          */
         static bool safe_hardlink_source(struct inode *inode)
         {
    952  	umode_t mode = inode->i_mode;
         
         	/* Special files should not get pinned to the filesystem. */
    955  	if (!S_ISREG(mode))
         		return false;
         
         	/* Setuid files should not get pinned to the filesystem. */
    959  	if (mode & S_ISUID)
         		return false;
         
         	/* Executable setgid files should not get pinned to the filesystem. */
    963  	if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP))
         		return false;
         
         	/* Hardlinking to unreadable or unwritable sources is dangerous. */
    967  	if (inode_permission(inode, MAY_READ | MAY_WRITE))
         		return false;
         
         	return true;
         }
         
         /**
          * may_linkat - Check permissions for creating a hardlink
          * @link: the source to hardlink from
          *
          * Block hardlink when all of:
          *  - sysctl_protected_hardlinks enabled
          *  - fsuid does not match inode
          *  - hardlink source is unsafe (see safe_hardlink_source() above)
          *  - not CAP_FOWNER in a namespace with the inode owner uid mapped
          *
          * Returns 0 if successful, -ve on error.
          */
         static int may_linkat(struct path *link)
         {
         	struct inode *inode;
         
    989  	if (!sysctl_protected_hardlinks)
         		return 0;
         
    992  	inode = link->dentry->d_inode;
         
         	/* Source inode owner (or CAP_FOWNER) can hardlink all they like,
         	 * otherwise, it must be a safe source.
         	 */
    997  	if (safe_hardlink_source(inode) || inode_owner_or_capable(inode))
         		return 0;
         
   1000  	audit_log_link_denied("linkat");
   1001  	return -EPERM;
         }
         
         static __always_inline
         const char *get_link(struct nameidata *nd)
         {
   1007  	struct saved *last = nd->stack + nd->depth - 1;
   1008  	struct dentry *dentry = last->link.dentry;
   1009  	struct inode *inode = nd->link_inode;
         	int error;
         	const char *res;
         
   1013  	if (!(nd->flags & LOOKUP_RCU)) {
   1014  		touch_atime(&last->link);
   1015  		cond_resched();
   1016  	} else if (atime_needs_update_rcu(&last->link, inode)) {
   1017  		if (unlikely(unlazy_walk(nd)))
   1018  			return ERR_PTR(-ECHILD);
   1019  		touch_atime(&last->link);
         	}
         
   1022  	error = security_inode_follow_link(dentry, inode,
         					   nd->flags & LOOKUP_RCU);
   1024  	if (unlikely(error))
   1025  		return ERR_PTR(error);
         
   1027  	nd->last_type = LAST_BIND;
   1028  	res = inode->i_link;
   1029  	if (!res) {
         		const char * (*get)(struct dentry *, struct inode *,
         				struct delayed_call *);
   1032  		get = inode->i_op->get_link;
   1033  		if (nd->flags & LOOKUP_RCU) {
   1034  			res = get(NULL, inode, &last->done);
   1035  			if (res == ERR_PTR(-ECHILD)) {
   1036  				if (unlikely(unlazy_walk(nd)))
         					return ERR_PTR(-ECHILD);
   1038  				res = get(dentry, inode, &last->done);
         			}
         		} else {
   1041  			res = get(dentry, inode, &last->done);
         		}
         		if (IS_ERR_OR_NULL(res))
         			return res;
         	}
   1046  	if (*res == '/') {
   1047  		if (!nd->root.mnt)
   1048  			set_root(nd);
   1049  		if (unlikely(nd_jump_root(nd)))
         			return ERR_PTR(-ECHILD);
   1051  		while (unlikely(*++res == '/'))
         			;
         	}
   1054  	if (!*res)
         		res = NULL;
         	return res;
         }
         
         /*
          * follow_up - Find the mountpoint of path's vfsmount
          *
          * Given a path, find the mountpoint of its source file system.
          * Replace @path with the path of the mountpoint in the parent mount.
          * Up is towards /.
          *
          * Return 1 if we went up a level and 0 if we were already at the
          * root.
          */
         int follow_up(struct path *path)
   1070  {
   1071  	struct mount *mnt = real_mount(path->mnt);
         	struct mount *parent;
         	struct dentry *mountpoint;
         
         	read_seqlock_excl(&mount_lock);
   1076  	parent = mnt->mnt_parent;
   1077  	if (parent == mnt) {
         		read_sequnlock_excl(&mount_lock);
   1079  		return 0;
         	}
   1081  	mntget(&parent->mnt);
   1082  	mountpoint = dget(mnt->mnt_mountpoint);
         	read_sequnlock_excl(&mount_lock);
   1084  	dput(path->dentry);
   1085  	path->dentry = mountpoint;
   1086  	mntput(path->mnt);
   1087  	path->mnt = &parent->mnt;
   1088  	return 1;
   1089  }
         EXPORT_SYMBOL(follow_up);
         
         /*
          * Perform an automount
          * - return -EISDIR to tell follow_managed() to stop and return the path we
          *   were called with.
          */
         static int follow_automount(struct path *path, struct nameidata *nd,
         			    bool *need_mntput)
         {
         	struct vfsmount *mnt;
         	int err;
         
   1103  	if (!path->dentry->d_op || !path->dentry->d_op->d_automount)
         		return -EREMOTE;
         
         	/* We don't want to mount if someone's just doing a stat -
         	 * unless they're stat'ing a directory and appended a '/' to
         	 * the name.
         	 *
         	 * We do, however, want to mount if someone wants to open or
         	 * create a file of any type under the mountpoint, wants to
         	 * traverse through the mountpoint or wants to open the
         	 * mounted directory.  Also, autofs may mark negative dentries
         	 * as being automount points.  These will need the attentions
         	 * of the daemon to instantiate them before they can be used.
         	 */
   1117  	if (!(nd->flags & (LOOKUP_PARENT | LOOKUP_DIRECTORY |
   1118  			   LOOKUP_OPEN | LOOKUP_CREATE | LOOKUP_AUTOMOUNT)) &&
         	    path->dentry->d_inode)
   1120  		return -EISDIR;
         
   1122  	nd->total_link_count++;
   1123  	if (nd->total_link_count >= 40)
   1124  		return -ELOOP;
         
   1126  	mnt = path->dentry->d_op->d_automount(path);
   1127  	if (IS_ERR(mnt)) {
         		/*
         		 * The filesystem is allowed to return -EISDIR here to indicate
         		 * it doesn't want to automount.  For instance, autofs would do
         		 * this so that its userspace daemon can mount on this dentry.
         		 *
         		 * However, we can only permit this if it's a terminal point in
         		 * the path being looked up; if it wasn't then the remainder of
         		 * the path is inaccessible and we should say so.
         		 */
   1137  		if (PTR_ERR(mnt) == -EISDIR && (nd->flags & LOOKUP_PARENT))
   1138  			return -EREMOTE;
   1139  		return PTR_ERR(mnt);
         	}
         
   1142  	if (!mnt) /* mount collision */
   1143  		return 0;
         
   1145  	if (!*need_mntput) {
         		/* lock_mount() may release path->mnt on error */
   1147  		mntget(path->mnt);
         		*need_mntput = true;
         	}
   1150  	err = finish_automount(mnt, path);
         
   1152  	switch (err) {
         	case -EBUSY:
         		/* Someone else made a mount here whilst we were busy */
   1155  		return 0;
         	case 0:
         		path_put(path);
   1158  		path->mnt = mnt;
   1159  		path->dentry = dget(mnt->mnt_root);
         		return 0;
         	default:
         		return err;
         	}
         
         }
         
         /*
          * Handle a dentry that is managed in some way.
          * - Flagged for transit management (autofs)
          * - Flagged as mountpoint
          * - Flagged as automount point
          *
          * This may only be called in refwalk mode.
          *
          * Serialization is taken care of in namespace.c
          */
         static int follow_managed(struct path *path, struct nameidata *nd)
   1178  {
   1179  	struct vfsmount *mnt = path->mnt; /* held by caller, must be left alone */
         	unsigned managed;
   1181  	bool need_mntput = false;
   1182  	int ret = 0;
         
         	/* Given that we're not holding a lock here, we retain the value in a
         	 * local variable for each dentry as we look at it so that we don't see
         	 * the components of that value change under us */
   1187  	while (managed = READ_ONCE(path->dentry->d_flags),
         	       managed &= DCACHE_MANAGED_DENTRY,
         	       unlikely(managed != 0)) {
         		/* Allow the filesystem to manage the transit without i_mutex
         		 * being held. */
   1192  		if (managed & DCACHE_MANAGE_TRANSIT) {
   1193  			BUG_ON(!path->dentry->d_op);
   1194  			BUG_ON(!path->dentry->d_op->d_manage);
   1195  			ret = path->dentry->d_op->d_manage(path, false);
   1196  			if (ret < 0)
         				break;
         		}
         
         		/* Transit to a mounted filesystem. */
   1201  		if (managed & DCACHE_MOUNTED) {
   1202  			struct vfsmount *mounted = lookup_mnt(path);
   1203  			if (mounted) {
   1204  				dput(path->dentry);
   1205  				if (need_mntput)
   1206  					mntput(path->mnt);
   1207  				path->mnt = mounted;
   1208  				path->dentry = dget(mounted->mnt_root);
         				need_mntput = true;
         				continue;
         			}
         
         			/* Something is mounted on this dentry in another
         			 * namespace and/or whatever was mounted there in this
         			 * namespace got unmounted before lookup_mnt() could
         			 * get it */
         		}
         
         		/* Handle an automount point */
   1220  		if (managed & DCACHE_NEED_AUTOMOUNT) {
         			ret = follow_automount(path, nd, &need_mntput);
   1222  			if (ret < 0)
         				break;
         			continue;
         		}
         
         		/* We didn't change the current path point */
         		break;
         	}
         
   1231  	if (need_mntput && path->mnt == mnt)
   1232  		mntput(path->mnt);
   1233  	if (ret == -EISDIR || !ret)
   1234  		ret = 1;
         	if (need_mntput)
   1236  		nd->flags |= LOOKUP_JUMPED;
   1237  	if (unlikely(ret < 0))
         		path_put_conditional(path, nd);
         	return ret;
   1240  }
         
         int follow_down_one(struct path *path)
   1243  {
         	struct vfsmount *mounted;
         
   1246  	mounted = lookup_mnt(path);
   1247  	if (mounted) {
   1248  		dput(path->dentry);
   1249  		mntput(path->mnt);
   1250  		path->mnt = mounted;
   1251  		path->dentry = dget(mounted->mnt_root);
   1252  		return 1;
         	}
         	return 0;
   1255  }
         EXPORT_SYMBOL(follow_down_one);
         
         static inline int managed_dentry_rcu(const struct path *path)
         {
   1260  	return (path->dentry->d_flags & DCACHE_MANAGE_TRANSIT) ?
   1261  		path->dentry->d_op->d_manage(path, true) : 0;
         }
         
         /*
          * Try to skip to top of mountpoint pile in rcuwalk mode.  Fail if
          * we meet a managed dentry that would need blocking.
          */
   1268  static bool __follow_mount_rcu(struct nameidata *nd, struct path *path,
         			       struct inode **inode, unsigned *seqp)
         {
         	for (;;) {
         		struct mount *mounted;
         		/*
         		 * Don't forget we might have a non-mountpoint managed dentry
         		 * that wants to block transit.
         		 */
   1277  		switch (managed_dentry_rcu(path)) {
         		case -ECHILD:
         		default:
         			return false;
         		case -EISDIR:
   1282  			return true;
         		case 0:
         			break;
         		}
         
   1287  		if (!d_mountpoint(path->dentry))
         			return !(path->dentry->d_flags & DCACHE_NEED_AUTOMOUNT);
         
   1290  		mounted = __lookup_mnt(path->mnt, path->dentry);
   1291  		if (!mounted)
         			break;
   1293  		path->mnt = &mounted->mnt;
   1294  		path->dentry = mounted->mnt.mnt_root;
   1295  		nd->flags |= LOOKUP_JUMPED;
   1296  		*seqp = read_seqcount_begin(&path->dentry->d_seq);
         		/*
         		 * Update the inode too. We don't need to re-check the
         		 * dentry sequence number here after this d_inode read,
         		 * because a mount-point is always pinned.
         		 */
   1302  		*inode = path->dentry->d_inode;
         	}
   1304  	return !read_seqretry(&mount_lock, nd->m_seq) &&
   1305  		!(path->dentry->d_flags & DCACHE_NEED_AUTOMOUNT);
   1306  }
         
         static int follow_dotdot_rcu(struct nameidata *nd)
         {
   1310  	struct inode *inode = nd->inode;
         
         	while (1) {
         		if (path_equal(&nd->path, &nd->root))
         			break;
   1315  		if (nd->path.dentry != nd->path.mnt->mnt_root) {
         			struct dentry *old = nd->path.dentry;
   1317  			struct dentry *parent = old->d_parent;
         			unsigned seq;
         
   1320  			inode = parent->d_inode;
         			seq = read_seqcount_begin(&parent->d_seq);
   1322  			if (unlikely(read_seqcount_retry(&old->d_seq, nd->seq)))
   1323  				return -ECHILD;
   1324  			nd->path.dentry = parent;
   1325  			nd->seq = seq;
   1326  			if (unlikely(!path_connected(&nd->path)))
   1327  				return -ENOENT;
         			break;
         		} else {
         			struct mount *mnt = real_mount(nd->path.mnt);
   1331  			struct mount *mparent = mnt->mnt_parent;
   1332  			struct dentry *mountpoint = mnt->mnt_mountpoint;
   1333  			struct inode *inode2 = mountpoint->d_inode;
         			unsigned seq = read_seqcount_begin(&mountpoint->d_seq);
   1335  			if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
         				return -ECHILD;
   1337  			if (&mparent->mnt == nd->path.mnt)
         				break;
         			/* we know that mountpoint was pinned */
   1340  			nd->path.dentry = mountpoint;
   1341  			nd->path.mnt = &mparent->mnt;
   1342  			inode = inode2;
   1343  			nd->seq = seq;
         		}
         	}
   1346  	while (unlikely(d_mountpoint(nd->path.dentry))) {
         		struct mount *mounted;
   1348  		mounted = __lookup_mnt(nd->path.mnt, nd->path.dentry);
   1349  		if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
         			return -ECHILD;
   1351  		if (!mounted)
         			break;
   1353  		nd->path.mnt = &mounted->mnt;
   1354  		nd->path.dentry = mounted->mnt.mnt_root;
   1355  		inode = nd->path.dentry->d_inode;
   1356  		nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
         	}
   1358  	nd->inode = inode;
   1359  	return 0;
         }
         
         /*
          * Follow down to the covering mount currently visible to userspace.  At each
          * point, the filesystem owning that dentry may be queried as to whether the
          * caller is permitted to proceed or not.
          */
         int follow_down(struct path *path)
   1368  {
         	unsigned managed;
         	int ret;
         
   1372  	while (managed = READ_ONCE(path->dentry->d_flags),
         	       unlikely(managed & DCACHE_MANAGED_DENTRY)) {
         		/* Allow the filesystem to manage the transit without i_mutex
         		 * being held.
         		 *
         		 * We indicate to the filesystem if someone is trying to mount
         		 * something here.  This gives autofs the chance to deny anyone
         		 * other than its daemon the right to mount on its
         		 * superstructure.
         		 *
         		 * The filesystem may sleep at this point.
         		 */
   1384  		if (managed & DCACHE_MANAGE_TRANSIT) {
   1385  			BUG_ON(!path->dentry->d_op);
   1386  			BUG_ON(!path->dentry->d_op->d_manage);
   1387  			ret = path->dentry->d_op->d_manage(path, false);
   1388  			if (ret < 0)
   1389  				return ret == -EISDIR ? 0 : ret;
         		}
         
         		/* Transit to a mounted filesystem. */
   1393  		if (managed & DCACHE_MOUNTED) {
   1394  			struct vfsmount *mounted = lookup_mnt(path);
   1395  			if (!mounted)
         				break;
   1397  			dput(path->dentry);
   1398  			mntput(path->mnt);
   1399  			path->mnt = mounted;
   1400  			path->dentry = dget(mounted->mnt_root);
         			continue;
         		}
         
         		/* Don't handle automount points here */
         		break;
         	}
   1407  	return 0;
   1408  }
         EXPORT_SYMBOL(follow_down);
         
         /*
          * Skip to top of mountpoint pile in refwalk mode for follow_dotdot()
          */
         static void follow_mount(struct path *path)
   1415  {
   1416  	while (d_mountpoint(path->dentry)) {
   1417  		struct vfsmount *mounted = lookup_mnt(path);
   1418  		if (!mounted)
         			break;
   1420  		dput(path->dentry);
   1421  		mntput(path->mnt);
   1422  		path->mnt = mounted;
   1423  		path->dentry = dget(mounted->mnt_root);
         	}
   1425  }
         
         static int path_parent_directory(struct path *path)
   1428  {
   1429  	struct dentry *old = path->dentry;
         	/* rare case of legitimate dget_parent()... */
   1431  	path->dentry = dget_parent(path->dentry);
   1432  	dput(old);
   1433  	if (unlikely(!path_connected(path)))
         		return -ENOENT;
   1435  	return 0;
   1436  }
         
         static int follow_dotdot(struct nameidata *nd)
         {
         	while(1) {
   1441  		if (nd->path.dentry == nd->root.dentry &&
         		    nd->path.mnt == nd->root.mnt) {
         			break;
         		}
   1445  		if (nd->path.dentry != nd->path.mnt->mnt_root) {
   1446  			int ret = path_parent_directory(&nd->path);
   1447  			if (ret)
         				return ret;
         			break;
         		}
   1451  		if (!follow_up(&nd->path))
         			break;
         	}
   1454  	follow_mount(&nd->path);
   1455  	nd->inode = nd->path.dentry->d_inode;
   1456  	return 0;
         }
         
         /*
          * This looks up the name in dcache and possibly revalidates the found dentry.
          * NULL is returned if the dentry does not exist in the cache.
          */
         static struct dentry *lookup_dcache(const struct qstr *name,
         				    struct dentry *dir,
         				    unsigned int flags)
   1466  {
   1467  	struct dentry *dentry = d_lookup(dir, name);
   1468  	if (dentry) {
         		int error = d_revalidate(dentry, flags);
   1470  		if (unlikely(error <= 0)) {
   1471  			if (!error)
   1472  				d_invalidate(dentry);
   1473  			dput(dentry);
   1474  			return ERR_PTR(error);
         		}
         	}
         	return dentry;
   1478  }
         
         /*
          * Parent directory has inode locked exclusive.  This is one
          * and only case when ->lookup() gets called on non in-lookup
          * dentries - as the matter of fact, this only gets called
          * when directory is guaranteed to have no in-lookup children
          * at all.
          */
         static struct dentry *__lookup_hash(const struct qstr *name,
         		struct dentry *base, unsigned int flags)
   1489  {
   1490  	struct dentry *dentry = lookup_dcache(name, base, flags);
         	struct dentry *old;
   1492  	struct inode *dir = base->d_inode;
         
   1494  	if (dentry)
         		return dentry;
         
         	/* Don't create child dentry for a dead directory. */
   1498  	if (unlikely(IS_DEADDIR(dir)))
   1499  		return ERR_PTR(-ENOENT);
         
   1501  	dentry = d_alloc(base, name);
   1502  	if (unlikely(!dentry))
   1503  		return ERR_PTR(-ENOMEM);
         
   1505  	old = dir->i_op->lookup(dir, dentry, flags);
   1506  	if (unlikely(old)) {
   1507  		dput(dentry);
         		dentry = old;
         	}
         	return dentry;
   1511  }
         
         static int lookup_fast(struct nameidata *nd,
         		       struct path *path, struct inode **inode,
         		       unsigned *seqp)
   1516  {
   1517  	struct vfsmount *mnt = nd->path.mnt;
   1518  	struct dentry *dentry, *parent = nd->path.dentry;
         	int status = 1;
         	int err;
         
         	/*
         	 * Rename seqlock is not required here because in the off chance
         	 * of a false negative due to a concurrent rename, the caller is
         	 * going to fall back to non-racy lookup.
         	 */
   1527  	if (nd->flags & LOOKUP_RCU) {
         		unsigned seq;
         		bool negative;
   1530  		dentry = __d_lookup_rcu(parent, &nd->last, &seq);
   1531  		if (unlikely(!dentry)) {
   1532  			if (unlazy_walk(nd))
   1533  				return -ECHILD;
         			return 0;
         		}
         
         		/*
         		 * This sequence count validates that the inode matches
         		 * the dentry name information from lookup.
         		 */
   1541  		*inode = d_backing_inode(dentry);
         		negative = d_is_negative(dentry);
   1543  		if (unlikely(read_seqcount_retry(&dentry->d_seq, seq)))
         			return -ECHILD;
         
         		/*
         		 * This sequence count validates that the parent had no
         		 * changes while we did the lookup of the dentry above.
         		 *
         		 * The memory barrier in read_seqcount_begin of child is
         		 *  enough, we can use __read_seqcount_retry here.
         		 */
   1553  		if (unlikely(__read_seqcount_retry(&parent->d_seq, nd->seq)))
         			return -ECHILD;
         
   1556  		*seqp = seq;
         		status = d_revalidate(dentry, nd->flags);
   1558  		if (likely(status > 0)) {
         			/*
         			 * Note: do negative dentry check after revalidation in
         			 * case that drops it.
         			 */
   1563  			if (unlikely(negative))
         				return -ENOENT;
   1565  			path->mnt = mnt;
   1566  			path->dentry = dentry;
   1567  			if (likely(__follow_mount_rcu(nd, path, inode, seqp)))
   1568  				return 1;
         		}
   1570  		if (unlazy_child(nd, dentry, seq))
   1571  			return -ECHILD;
   1572  		if (unlikely(status == -ECHILD))
         			/* we'd been told to redo it in non-rcu mode */
         			status = d_revalidate(dentry, nd->flags);
         	} else {
   1576  		dentry = __d_lookup(parent, &nd->last);
   1577  		if (unlikely(!dentry))
   1578  			return 0;
         		status = d_revalidate(dentry, nd->flags);
         	}
   1581  	if (unlikely(status <= 0)) {
   1582  		if (!status)
   1583  			d_invalidate(dentry);
   1584  		dput(dentry);
   1585  		return status;
         	}
   1587  	if (unlikely(d_is_negative(dentry))) {
   1588  		dput(dentry);
   1589  		return -ENOENT;
         	}
         
   1592  	path->mnt = mnt;
   1593  	path->dentry = dentry;
   1594  	err = follow_managed(path, nd);
   1595  	if (likely(err > 0))
   1596  		*inode = d_backing_inode(path->dentry);
         	return err;
   1598  }
         
         /* Fast lookup failed, do it the slow way */
         static struct dentry *__lookup_slow(const struct qstr *name,
         				    struct dentry *dir,
         				    unsigned int flags)
   1604  {
         	struct dentry *dentry, *old;
   1606  	struct inode *inode = dir->d_inode;
   1607  	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
         
         	/* Don't go there if it's already dead */
   1610  	if (unlikely(IS_DEADDIR(inode)))
   1611  		return ERR_PTR(-ENOENT);
         again:
   1613  	dentry = d_alloc_parallel(dir, name, &wq);
   1614  	if (IS_ERR(dentry))
         		return dentry;
   1616  	if (unlikely(!d_in_lookup(dentry))) {
   1617  		if (!(flags & LOOKUP_NO_REVAL)) {
         			int error = d_revalidate(dentry, flags);
   1619  			if (unlikely(error <= 0)) {
   1620  				if (!error) {
   1621  					d_invalidate(dentry);
   1622  					dput(dentry);
   1623  					goto again;
         				}
   1625  				dput(dentry);
   1626  				dentry = ERR_PTR(error);
         			}
         		}
         	} else {
   1630  		old = inode->i_op->lookup(inode, dentry, flags);
         		d_lookup_done(dentry);
   1632  		if (unlikely(old)) {
   1633  			dput(dentry);
         			dentry = old;
         		}
         	}
         	return dentry;
   1638  }
         
         static struct dentry *lookup_slow(const struct qstr *name,
         				  struct dentry *dir,
         				  unsigned int flags)
   1643  {
         	struct inode *inode = dir->d_inode;
         	struct dentry *res;
         	inode_lock_shared(inode);
   1647  	res = __lookup_slow(name, dir, flags);
         	inode_unlock_shared(inode);
         	return res;
   1650  }
         
         static inline int may_lookup(struct nameidata *nd)
         {
   1654  	if (nd->flags & LOOKUP_RCU) {
   1655  		int err = inode_permission(nd->inode, MAY_EXEC|MAY_NOT_BLOCK);
   1656  		if (err != -ECHILD)
         			return err;
   1658  		if (unlazy_walk(nd))
         			return -ECHILD;
         	}
   1661  	return inode_permission(nd->inode, MAY_EXEC);
         }
         
         static inline int handle_dots(struct nameidata *nd, int type)
         {
   1666  	if (type == LAST_DOTDOT) {
   1667  		if (!nd->root.mnt)
   1668  			set_root(nd);
   1669  		if (nd->flags & LOOKUP_RCU) {
         			return follow_dotdot_rcu(nd);
         		} else
         			return follow_dotdot(nd);
         	}
   1674  	return 0;
         }
         
         static int pick_link(struct nameidata *nd, struct path *link,
         		     struct inode *inode, unsigned seq)
   1679  {
         	int error;
         	struct saved *last;
   1682  	if (unlikely(nd->total_link_count++ >= MAXSYMLINKS)) {
         		path_to_nameidata(link, nd);
   1684  		return -ELOOP;
         	}
   1686  	if (!(nd->flags & LOOKUP_RCU)) {
   1687  		if (link->mnt == nd->path.mnt)
   1688  			mntget(link->mnt);
         	}
         	error = nd_alloc_stack(nd);
   1691  	if (unlikely(error)) {
   1692  		if (error == -ECHILD) {
   1693  			if (unlikely(!legitimize_path(nd, link, seq))) {
         				drop_links(nd);
   1695  				nd->depth = 0;
   1696  				nd->flags &= ~LOOKUP_RCU;
   1697  				nd->path.mnt = NULL;
   1698  				nd->path.dentry = NULL;
   1699  				if (!(nd->flags & LOOKUP_ROOT))
   1700  					nd->root.mnt = NULL;
         				rcu_read_unlock();
   1702  			} else if (likely(unlazy_walk(nd)) == 0)
         				error = nd_alloc_stack(nd);
         		}
   1705  		if (error) {
         			path_put(link);
   1707  			return error;
         		}
         	}
         
   1711  	last = nd->stack + nd->depth++;
   1712  	last->link = *link;
         	clear_delayed_call(&last->done);
   1714  	nd->link_inode = inode;
   1715  	last->seq = seq;
   1716  	return 1;
   1717  }
         
         enum {WALK_FOLLOW = 1, WALK_MORE = 2};
         
         /*
          * Do we need to follow links? We _really_ want to be able
          * to do this check without having to look at inode->i_op,
          * so we keep a cache of "no, this doesn't need follow_link"
          * for the common case.
          */
         static inline int step_into(struct nameidata *nd, struct path *path,
         			    int flags, struct inode *inode, unsigned seq)
         {
   1730  	if (!(flags & WALK_MORE) && nd->depth)
         		put_link(nd);
   1732  	if (likely(!d_is_symlink(path->dentry)) ||
   1733  	   !(flags & WALK_FOLLOW || nd->flags & LOOKUP_FOLLOW)) {
         		/* not a symlink or should not follow */
         		path_to_nameidata(path, nd);
   1736  		nd->inode = inode;
   1737  		nd->seq = seq;
         		return 0;
         	}
         	/* make sure that d_is_symlink above matches inode */
   1741  	if (nd->flags & LOOKUP_RCU) {
   1742  		if (read_seqcount_retry(&path->dentry->d_seq, seq))
   1743  			return -ECHILD;
         	}
   1745  	return pick_link(nd, path, inode, seq);
         }
         
         static int walk_component(struct nameidata *nd, int flags)
   1749  {
         	struct path path;
         	struct inode *inode;
         	unsigned seq;
         	int err;
         	/*
         	 * "." and ".." are special - ".." especially so because it has
         	 * to be able to know about the current root directory and
         	 * parent relationships.
         	 */
   1759  	if (unlikely(nd->last_type != LAST_NORM)) {
         		err = handle_dots(nd, nd->last_type);
   1761  		if (!(flags & WALK_MORE) && nd->depth)
         			put_link(nd);
         		return err;
         	}
   1765  	err = lookup_fast(nd, &path, &inode, &seq);
   1766  	if (unlikely(err <= 0)) {
   1767  		if (err < 0)
         			return err;
   1769  		path.dentry = lookup_slow(&nd->last, nd->path.dentry,
         					  nd->flags);
   1771  		if (IS_ERR(path.dentry))
         			return PTR_ERR(path.dentry);
         
   1774  		path.mnt = nd->path.mnt;
   1775  		err = follow_managed(&path, nd);
   1776  		if (unlikely(err < 0))
         			return err;
         
   1779  		if (unlikely(d_is_negative(path.dentry))) {
         			path_to_nameidata(&path, nd);
   1781  			return -ENOENT;
         		}
         
   1784  		seq = 0;	/* we are already out of RCU mode */
   1785  		inode = d_backing_inode(path.dentry);
         	}
         
         	return step_into(nd, &path, flags, inode, seq);
   1789  }
         
         /*
          * We can do the critical dentry name comparison and hashing
          * operations one word at a time, but we are limited to:
          *
          * - Architectures with fast unaligned word accesses. We could
          *   do a "get_unaligned()" if this helps and is sufficiently
          *   fast.
          *
          * - non-CONFIG_DEBUG_PAGEALLOC configurations (so that we
          *   do not trap on the (extremely unlikely) case of a page
          *   crossing operation.
          *
          * - Furthermore, we need an efficient 64-bit compile for the
          *   64-bit case in order to generate the "number of bytes in
          *   the final mask". Again, that could be replaced with a
          *   efficient population count instruction or similar.
          */
         #ifdef CONFIG_DCACHE_WORD_ACCESS
         
         #include <asm/word-at-a-time.h>
         
         #ifdef HASH_MIX
         
         /* Architecture provides HASH_MIX and fold_hash() in <asm/hash.h> */
         
         #elif defined(CONFIG_64BIT)
         /*
          * Register pressure in the mixing function is an issue, particularly
          * on 32-bit x86, but almost any function requires one state value and
          * one temporary.  Instead, use a function designed for two state values
          * and no temporaries.
          *
          * This function cannot create a collision in only two iterations, so
          * we have two iterations to achieve avalanche.  In those two iterations,
          * we have six layers of mixing, which is enough to spread one bit's
          * influence out to 2^6 = 64 state bits.
          *
          * Rotate constants are scored by considering either 64 one-bit input
          * deltas or 64*63/2 = 2016 two-bit input deltas, and finding the
          * probability of that delta causing a change to each of the 128 output
          * bits, using a sample of random initial states.
          *
          * The Shannon entropy of the computed probabilities is then summed
          * to produce a score.  Ideally, any input change has a 50% chance of
          * toggling any given output bit.
          *
          * Mixing scores (in bits) for (12,45):
          * Input delta: 1-bit      2-bit
          * 1 round:     713.3    42542.6
          * 2 rounds:   2753.7   140389.8
          * 3 rounds:   5954.1   233458.2
          * 4 rounds:   7862.6   256672.2
          * Perfect:    8192     258048
          *            (64*128) (64*63/2 * 128)
          */
         #define HASH_MIX(x, y, a)	\
         	(	x ^= (a),	\
         	y ^= x,	x = rol64(x,12),\
         	x += y,	y = rol64(y,45),\
         	y *= 9			)
         
         /*
          * Fold two longs into one 32-bit hash value.  This must be fast, but
          * latency isn't quite as critical, as there is a fair bit of additional
          * work done before the hash value is used.
          */
         static inline unsigned int fold_hash(unsigned long x, unsigned long y)
         {
   1859  	y ^= x * GOLDEN_RATIO_64;
   1860  	y *= GOLDEN_RATIO_64;
   1861  	return y >> 32;
         }
         
         #else	/* 32-bit case */
         
         /*
          * Mixing scores (in bits) for (7,20):
          * Input delta: 1-bit      2-bit
          * 1 round:     330.3     9201.6
          * 2 rounds:   1246.4    25475.4
          * 3 rounds:   1907.1    31295.1
          * 4 rounds:   2042.3    31718.6
          * Perfect:    2048      31744
          *            (32*64)   (32*31/2 * 64)
          */
         #define HASH_MIX(x, y, a)	\
         	(	x ^= (a),	\
         	y ^= x,	x = rol32(x, 7),\
         	x += y,	y = rol32(y,20),\
         	y *= 9			)
         
         static inline unsigned int fold_hash(unsigned long x, unsigned long y)
         {
         	/* Use arch-optimized multiply if one exists */
         	return __hash_32(y ^ __hash_32(x));
         }
         
         #endif
         
         /*
          * Return the hash of a string of known length.  This is carfully
          * designed to match hash_name(), which is the more critical function.
          * In particular, we must end by hashing a final word containing 0..7
          * payload bytes, to match the way that hash_name() iterates until it
          * finds the delimiter after the name.
          */
         unsigned int full_name_hash(const void *salt, const char *name, unsigned int len)
   1898  {
   1899  	unsigned long a, x = 0, y = (unsigned long)salt;
         
         	for (;;) {
   1902  		if (!len)
         			goto done;
         		a = load_unaligned_zeropad(name);
   1905  		if (len < sizeof(unsigned long))
         			break;
   1907  		HASH_MIX(x, y, a);
   1908  		name += sizeof(unsigned long);
         		len -= sizeof(unsigned long);
         	}
   1911  	x ^= a & bytemask_from_count(len);
         done:
         	return fold_hash(x, y);
   1914  }
         EXPORT_SYMBOL(full_name_hash);
         
         /* Return the "hash_len" (hash and length) of a null-terminated string */
         u64 hashlen_string(const void *salt, const char *name)
   1919  {
   1920  	unsigned long a = 0, x = 0, y = (unsigned long)salt;
         	unsigned long adata, mask, len;
         	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
         
   1924  	len = 0;
   1925  	goto inside;
         
         	do {
   1928  		HASH_MIX(x, y, a);
   1929  		len += sizeof(unsigned long);
         inside:
         		a = load_unaligned_zeropad(name+len);
   1932  	} while (!has_zero(a, &adata, &constants));
         
         	adata = prep_zero_mask(a, adata, &constants);
         	mask = create_zero_mask(adata);
   1936  	x ^= a & zero_bytemask(mask);
         
   1938  	return hashlen_create(fold_hash(x, y), len + find_zero(mask));
   1939  }
         EXPORT_SYMBOL(hashlen_string);
         
         /*
          * Calculate the length and hash of the path component, and
          * return the "hash_len" as the result.
          */
         static inline u64 hash_name(const void *salt, const char *name)
         {
   1948  	unsigned long a = 0, b, x = 0, y = (unsigned long)salt;
         	unsigned long adata, bdata, mask, len;
         	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
         
   1952  	len = 0;
         	goto inside;
         
         	do {
   1956  		HASH_MIX(x, y, a);
   1957  		len += sizeof(unsigned long);
         inside:
         		a = load_unaligned_zeropad(name+len);
   1960  		b = a ^ REPEAT_BYTE('/');
   1961  	} while (!(has_zero(a, &adata, &constants) | has_zero(b, &bdata, &constants)));
         
         	adata = prep_zero_mask(a, adata, &constants);
         	bdata = prep_zero_mask(b, bdata, &constants);
         	mask = create_zero_mask(adata | bdata);
   1966  	x ^= a & zero_bytemask(mask);
         
   1968  	return hashlen_create(fold_hash(x, y), len + find_zero(mask));
         }
         
         #else	/* !CONFIG_DCACHE_WORD_ACCESS: Slow, byte-at-a-time version */
         
         /* Return the hash of a string of known length */
         unsigned int full_name_hash(const void *salt, const char *name, unsigned int len)
         {
         	unsigned long hash = init_name_hash(salt);
         	while (len--)
         		hash = partial_name_hash((unsigned char)*name++, hash);
         	return end_name_hash(hash);
         }
         EXPORT_SYMBOL(full_name_hash);
         
         /* Return the "hash_len" (hash and length) of a null-terminated string */
         u64 hashlen_string(const void *salt, const char *name)
         {
         	unsigned long hash = init_name_hash(salt);
         	unsigned long len = 0, c;
         
         	c = (unsigned char)*name;
         	while (c) {
         		len++;
         		hash = partial_name_hash(c, hash);
         		c = (unsigned char)name[len];
         	}
         	return hashlen_create(end_name_hash(hash), len);
         }
         EXPORT_SYMBOL(hashlen_string);
         
         /*
          * We know there's a real path component here of at least
          * one character.
          */
         static inline u64 hash_name(const void *salt, const char *name)
         {
         	unsigned long hash = init_name_hash(salt);
         	unsigned long len = 0, c;
         
         	c = (unsigned char)*name;
         	do {
         		len++;
         		hash = partial_name_hash(c, hash);
         		c = (unsigned char)name[len];
         	} while (c && c != '/');
         	return hashlen_create(end_name_hash(hash), len);
         }
         
         #endif
         
         /*
          * Name resolution.
          * This is the basic name resolution function, turning a pathname into
          * the final dentry. We expect 'base' to be positive and a directory.
          *
          * Returns 0 and nd will have valid dentry and mnt on success.
          * Returns error and drops reference to input namei data on failure.
          */
         static int link_path_walk(const char *name, struct nameidata *nd)
   2028  {
         	int err;
         
   2031  	while (*name=='/')
   2032  		name++;
   2033  	if (!*name)
   2034  		return 0;
         
         	/* At this point we know we have a real path component. */
         	for(;;) {
         		u64 hash_len;
         		int type;
         
         		err = may_lookup(nd);
   2042  		if (err)
         			return err;
         
   2045  		hash_len = hash_name(nd->path.dentry, name);
         
         		type = LAST_NORM;
   2048  		if (name[0] == '.') switch (hashlen_len(hash_len)) {
         			case 2:
   2050  				if (name[1] == '.') {
   2051  					type = LAST_DOTDOT;
   2052  					nd->flags |= LOOKUP_JUMPED;
         				}
         				break;
         			case 1:
   2056  				type = LAST_DOT;
         		}
         		if (likely(type == LAST_NORM)) {
         			struct dentry *parent = nd->path.dentry;
   2060  			nd->flags &= ~LOOKUP_JUMPED;
   2061  			if (unlikely(parent->d_flags & DCACHE_OP_HASH)) {
   2062  				struct qstr this = { { .hash_len = hash_len }, .name = name };
   2063  				err = parent->d_op->d_hash(parent, &this);
   2064  				if (err < 0)
         					return err;
   2066  				hash_len = this.hash_len;
   2067  				name = this.name;
         			}
         		}
         
   2071  		nd->last.hash_len = hash_len;
   2072  		nd->last.name = name;
   2073  		nd->last_type = type;
         
   2075  		name += hashlen_len(hash_len);
   2076  		if (!*name)
         			goto OK;
         		/*
         		 * If it wasn't NUL, we know it was '/'. Skip that
         		 * slash, and continue until no more slashes.
         		 */
         		do {
   2083  			name++;
   2084  		} while (unlikely(*name == '/'));
   2085  		if (unlikely(!*name)) {
         OK:
         			/* pathname body, done */
   2088  			if (!nd->depth)
         				return 0;
   2090  			name = nd->stack[nd->depth - 1].name;
         			/* trailing symlink, done */
   2092  			if (!name)
         				return 0;
         			/* last component of nested symlink */
   2095  			err = walk_component(nd, WALK_FOLLOW);
         		} else {
         			/* not the last component */
   2098  			err = walk_component(nd, WALK_FOLLOW | WALK_MORE);
         		}
   2100  		if (err < 0)
         			return err;
         
   2103  		if (err) {
         			const char *s = get_link(nd);
         
   2106  			if (IS_ERR(s))
   2107  				return PTR_ERR(s);
         			err = 0;
   2109  			if (unlikely(!s)) {
         				/* jumped */
         				put_link(nd);
         			} else {
   2113  				nd->stack[nd->depth - 1].name = name;
         				name = s;
   2115  				continue;
         			}
         		}
   2118  		if (unlikely(!d_can_lookup(nd->path.dentry))) {
   2119  			if (nd->flags & LOOKUP_RCU) {
   2120  				if (unlazy_walk(nd))
         					return -ECHILD;
         			}
   2123  			return -ENOTDIR;
         		}
         	}
   2126  }
         
         static const char *path_init(struct nameidata *nd, unsigned flags)
   2129  {
   2130  	const char *s = nd->name->name;
         
   2132  	if (!*s)
   2133  		flags &= ~LOOKUP_RCU;
         
   2135  	nd->last_type = LAST_ROOT; /* if there are only slashes... */
   2136  	nd->flags = flags | LOOKUP_JUMPED | LOOKUP_PARENT;
         	nd->depth = 0;
   2138  	if (flags & LOOKUP_ROOT) {
   2139  		struct dentry *root = nd->root.dentry;
   2140  		struct inode *inode = root->d_inode;
   2141  		if (*s && unlikely(!d_can_lookup(root)))
         			return ERR_PTR(-ENOTDIR);
   2143  		nd->path = nd->root;
   2144  		nd->inode = inode;
   2145  		if (flags & LOOKUP_RCU) {
         			rcu_read_lock();
   2147  			nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
   2148  			nd->root_seq = nd->seq;
   2149  			nd->m_seq = read_seqbegin(&mount_lock);
         		} else {
   2151  			path_get(&nd->path);
         		}
         		return s;
         	}
         
   2156  	nd->root.mnt = NULL;
   2157  	nd->path.mnt = NULL;
   2158  	nd->path.dentry = NULL;
         
   2160  	nd->m_seq = read_seqbegin(&mount_lock);
   2161  	if (*s == '/') {
         		if (flags & LOOKUP_RCU)
         			rcu_read_lock();
   2164  		set_root(nd);
   2165  		if (likely(!nd_jump_root(nd)))
         			return s;
   2167  		nd->root.mnt = NULL;
         		rcu_read_unlock();
   2169  		return ERR_PTR(-ECHILD);
   2170  	} else if (nd->dfd == AT_FDCWD) {
   2171  		if (flags & LOOKUP_RCU) {
   2172  			struct fs_struct *fs = current->fs;
         			unsigned seq;
         
         			rcu_read_lock();
         
         			do {
         				seq = read_seqcount_begin(&fs->seq);
   2179  				nd->path = fs->pwd;
   2180  				nd->inode = nd->path.dentry->d_inode;
   2181  				nd->seq = __read_seqcount_begin(&nd->path.dentry->d_seq);
   2182  			} while (read_seqcount_retry(&fs->seq, seq));
         		} else {
   2184  			get_fs_pwd(current->fs, &nd->path);
   2185  			nd->inode = nd->path.dentry->d_inode;
         		}
         		return s;
         	} else {
         		/* Caller must check execute permissions on the starting path component */
         		struct fd f = fdget_raw(nd->dfd);
         		struct dentry *dentry;
         
   2193  		if (!f.file)
   2194  			return ERR_PTR(-EBADF);
         
   2196  		dentry = f.file->f_path.dentry;
         
   2198  		if (*s) {
   2199  			if (!d_can_lookup(dentry)) {
         				fdput(f);
   2201  				return ERR_PTR(-ENOTDIR);
         			}
         		}
         
   2205  		nd->path = f.file->f_path;
   2206  		if (flags & LOOKUP_RCU) {
         			rcu_read_lock();
   2208  			nd->inode = nd->path.dentry->d_inode;
   2209  			nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
         		} else {
   2211  			path_get(&nd->path);
   2212  			nd->inode = nd->path.dentry->d_inode;
         		}
         		fdput(f);
         		return s;
         	}
   2217  }
         
         static const char *trailing_symlink(struct nameidata *nd)
   2220  {
         	const char *s;
         	int error = may_follow_link(nd);
         	if (unlikely(error))
         		return ERR_PTR(error);
   2225  	nd->flags |= LOOKUP_PARENT;
   2226  	nd->stack[0].name = NULL;
         	s = get_link(nd);
   2228  	return s ? s : "";
   2229  }
         
         static inline int lookup_last(struct nameidata *nd)
         {
   2233  	if (nd->last_type == LAST_NORM && nd->last.name[nd->last.len])
   2234  		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
         
   2236  	nd->flags &= ~LOOKUP_PARENT;
   2237  	return walk_component(nd, 0);
         }
         
         static int handle_lookup_down(struct nameidata *nd)
         {
   2242  	struct path path = nd->path;
   2243  	struct inode *inode = nd->inode;
   2244  	unsigned seq = nd->seq;
         	int err;
         
   2247  	if (nd->flags & LOOKUP_RCU) {
         		/*
         		 * don't bother with unlazy_walk on failure - we are
         		 * at the very beginning of walk, so we lose nothing
         		 * if we simply redo everything in non-RCU mode
         		 */
   2253  		if (unlikely(!__follow_mount_rcu(nd, &path, &inode, &seq)))
   2254  			return -ECHILD;
         	} else {
   2256  		dget(path.dentry);
   2257  		err = follow_managed(&path, nd);
   2258  		if (unlikely(err < 0))
         			return err;
   2260  		inode = d_backing_inode(path.dentry);
   2261  		seq = 0;
         	}
         	path_to_nameidata(&path, nd);
   2264  	nd->inode = inode;
   2265  	nd->seq = seq;
         	return 0;
         }
         
         /* Returns 0 and nd will be valid on success; Retuns error, otherwise. */
         static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path)
   2271  {
   2272  	const char *s = path_init(nd, flags);
         	int err;
         
   2275  	if (IS_ERR(s))
         		return PTR_ERR(s);
         
   2278  	if (unlikely(flags & LOOKUP_DOWN)) {
         		err = handle_lookup_down(nd);
         		if (unlikely(err < 0)) {
         			terminate_walk(nd);
         			return err;
         		}
         	}
         
   2286  	while (!(err = link_path_walk(s, nd))
   2287  		&& ((err = lookup_last(nd)) > 0)) {
   2288  		s = trailing_symlink(nd);
   2289  		if (IS_ERR(s)) {
         			err = PTR_ERR(s);
         			break;
         		}
         	}
   2294  	if (!err)
   2295  		err = complete_walk(nd);
         
   2297  	if (!err && nd->flags & LOOKUP_DIRECTORY)
   2298  		if (!d_can_lookup(nd->path.dentry))
   2299  			err = -ENOTDIR;
         	if (!err) {
   2301  		*path = nd->path;
   2302  		nd->path.mnt = NULL;
   2303  		nd->path.dentry = NULL;
         	}
   2305  	terminate_walk(nd);
         	return err;
   2307  }
         
         static int filename_lookup(int dfd, struct filename *name, unsigned flags,
         			   struct path *path, struct path *root)
   2311  {
         	int retval;
         	struct nameidata nd;
   2314  	if (IS_ERR(name))
   2315  		return PTR_ERR(name);
   2316  	if (unlikely(root)) {
   2317  		nd.root = *root;
   2318  		flags |= LOOKUP_ROOT;
         	}
         	set_nameidata(&nd, dfd, name);
   2321  	retval = path_lookupat(&nd, flags | LOOKUP_RCU, path);
   2322  	if (unlikely(retval == -ECHILD))
   2323  		retval = path_lookupat(&nd, flags, path);
   2324  	if (unlikely(retval == -ESTALE))
   2325  		retval = path_lookupat(&nd, flags | LOOKUP_REVAL, path);
         
   2327  	if (likely(!retval))
         		audit_inode(name, path->dentry, flags & LOOKUP_PARENT);
   2329  	restore_nameidata();
   2330  	putname(name);
         	return retval;
   2332  }
         
         /* Returns 0 and nd will be valid on success; Retuns error, otherwise. */
         static int path_parentat(struct nameidata *nd, unsigned flags,
         				struct path *parent)
   2337  {
   2338  	const char *s = path_init(nd, flags);
         	int err;
   2340  	if (IS_ERR(s))
   2341  		return PTR_ERR(s);
   2342  	err = link_path_walk(s, nd);
   2343  	if (!err)
   2344  		err = complete_walk(nd);
   2345  	if (!err) {
   2346  		*parent = nd->path;
   2347  		nd->path.mnt = NULL;
   2348  		nd->path.dentry = NULL;
         	}
   2350  	terminate_walk(nd);
         	return err;
   2352  }
         
         static struct filename *filename_parentat(int dfd, struct filename *name,
         				unsigned int flags, struct path *parent,
         				struct qstr *last, int *type)
   2357  {
         	int retval;
         	struct nameidata nd;
         
   2361  	if (IS_ERR(name))
         		return name;
         	set_nameidata(&nd, dfd, name);
   2364  	retval = path_parentat(&nd, flags | LOOKUP_RCU, parent);
   2365  	if (unlikely(retval == -ECHILD))
   2366  		retval = path_parentat(&nd, flags, parent);
   2367  	if (unlikely(retval == -ESTALE))
   2368  		retval = path_parentat(&nd, flags | LOOKUP_REVAL, parent);
   2369  	if (likely(!retval)) {
   2370  		*last = nd.last;
   2371  		*type = nd.last_type;
         		audit_inode(name, parent->dentry, LOOKUP_PARENT);
         	} else {
   2374  		putname(name);
   2375  		name = ERR_PTR(retval);
         	}
   2377  	restore_nameidata();
         	return name;
   2379  }
         
         /* does lookup, returns the object with parent locked */
         struct dentry *kern_path_locked(const char *name, struct path *path)
   2383  {
         	struct filename *filename;
         	struct dentry *d;
         	struct qstr last;
         	int type;
         
   2389  	filename = filename_parentat(AT_FDCWD, getname_kernel(name), 0, path,
         				    &last, &type);
   2391  	if (IS_ERR(filename))
   2392  		return ERR_CAST(filename);
   2393  	if (unlikely(type != LAST_NORM)) {
         		path_put(path);
   2395  		putname(filename);
   2396  		return ERR_PTR(-EINVAL);
         	}
         	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
   2399  	d = __lookup_hash(&last, path->dentry, 0);
   2400  	if (IS_ERR(d)) {
   2401  		inode_unlock(path->dentry->d_inode);
         		path_put(path);
         	}
   2404  	putname(filename);
         	return d;
   2406  }
         
         int kern_path(const char *name, unsigned int flags, struct path *path)
   2409  {
   2410  	return filename_lookup(AT_FDCWD, getname_kernel(name),
         			       flags, path, NULL);
   2412  }
         EXPORT_SYMBOL(kern_path);
         
         /**
          * vfs_path_lookup - lookup a file path relative to a dentry-vfsmount pair
          * @dentry:  pointer to dentry of the base directory
          * @mnt: pointer to vfs mount of the base directory
          * @name: pointer to file name
          * @flags: lookup flags
          * @path: pointer to struct path to fill
          */
         int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
         		    const char *name, unsigned int flags,
         		    struct path *path)
   2426  {
   2427  	struct path root = {.mnt = mnt, .dentry = dentry};
         	/* the first argument of filename_lookup() is ignored with root */
   2429  	return filename_lookup(AT_FDCWD, getname_kernel(name),
         			       flags , path, &root);
   2431  }
         EXPORT_SYMBOL(vfs_path_lookup);
         
         static int lookup_one_len_common(const char *name, struct dentry *base,
         				 int len, struct qstr *this)
   2436  {
   2437  	this->name = name;
   2438  	this->len = len;
   2439  	this->hash = full_name_hash(base, name, len);
   2440  	if (!len)
   2441  		return -EACCES;
         
   2443  	if (unlikely(name[0] == '.')) {
   2444  		if (len < 2 || (len == 2 && name[1] == '.'))
         			return -EACCES;
         	}
         
   2448  	while (len--) {
   2449  		unsigned int c = *(const unsigned char *)name++;
   2450  		if (c == '/' || c == '\0')
         			return -EACCES;
         	}
         	/*
         	 * See if the low-level filesystem might want
         	 * to use its own hash..
         	 */
   2457  	if (base->d_flags & DCACHE_OP_HASH) {
   2458  		int err = base->d_op->d_hash(base, this);
   2459  		if (err < 0)
         			return err;
         	}
         
   2463  	return inode_permission(base->d_inode, MAY_EXEC);
   2464  }
         
         /**
          * lookup_one_len - filesystem helper to lookup single pathname component
          * @name:	pathname component to lookup
          * @base:	base directory to lookup from
          * @len:	maximum length @len should be interpreted to
          *
          * Note that this routine is purely a helper for filesystem usage and should
          * not be called by generic code.
          *
          * The caller must hold base->i_mutex.
          */
         struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
   2478  {
         	struct dentry *dentry;
         	struct qstr this;
         	int err;
         
   2483  	WARN_ON_ONCE(!inode_is_locked(base->d_inode));
         
   2485  	err = lookup_one_len_common(name, base, len, &this);
   2486  	if (err)
   2487  		return ERR_PTR(err);
         
   2489  	dentry = lookup_dcache(&this, base, 0);
   2490  	return dentry ? dentry : __lookup_slow(&this, base, 0);
   2491  }
         EXPORT_SYMBOL(lookup_one_len);
         
         /**
          * lookup_one_len_unlocked - filesystem helper to lookup single pathname component
          * @name:	pathname component to lookup
          * @base:	base directory to lookup from
          * @len:	maximum length @len should be interpreted to
          *
          * Note that this routine is purely a helper for filesystem usage and should
          * not be called by generic code.
          *
          * Unlike lookup_one_len, it should be called without the parent
          * i_mutex held, and will take the i_mutex itself if necessary.
          */
         struct dentry *lookup_one_len_unlocked(const char *name,
         				       struct dentry *base, int len)
   2508  {
         	struct qstr this;
         	int err;
         	struct dentry *ret;
         
   2513  	err = lookup_one_len_common(name, base, len, &this);
   2514  	if (err)
   2515  		return ERR_PTR(err);
         
   2517  	ret = lookup_dcache(&this, base, 0);
   2518  	if (!ret)
   2519  		ret = lookup_slow(&this, base, 0);
         	return ret;
   2521  }
         EXPORT_SYMBOL(lookup_one_len_unlocked);
         
         #ifdef CONFIG_UNIX98_PTYS
         int path_pts(struct path *path)
   2526  {
         	/* Find something mounted on "pts" in the same directory as
         	 * the input path.
         	 */
         	struct dentry *child, *parent;
         	struct qstr this;
         	int ret;
         
   2534  	ret = path_parent_directory(path);
   2535  	if (ret)
         		return ret;
         
   2538  	parent = path->dentry;
   2539  	this.name = "pts";
   2540  	this.len = 3;
   2541  	child = d_hash_and_lookup(parent, &this);
   2542  	if (!child)
   2543  		return -ENOENT;
         
   2545  	path->dentry = child;
   2546  	dput(parent);
   2547  	follow_mount(path);
   2548  	return 0;
   2549  }
         #endif
         
         int user_path_at_empty(int dfd, const char __user *name, unsigned flags,
         		 struct path *path, int *empty)
   2554  {
   2555  	return filename_lookup(dfd, getname_flags(name, flags, empty),
         			       flags, path, NULL);
   2557  }
         EXPORT_SYMBOL(user_path_at_empty);
         
         /**
          * mountpoint_last - look up last component for umount
          * @nd:   pathwalk nameidata - currently pointing at parent directory of "last"
          *
          * This is a special lookup_last function just for umount. In this case, we
          * need to resolve the path without doing any revalidation.
          *
          * The nameidata should be the result of doing a LOOKUP_PARENT pathwalk. Since
          * mountpoints are always pinned in the dcache, their ancestors are too. Thus,
          * in almost all cases, this lookup will be served out of the dcache. The only
          * cases where it won't are if nd->last refers to a symlink or the path is
          * bogus and it doesn't exist.
          *
          * Returns:
          * -error: if there was an error during lookup. This includes -ENOENT if the
          *         lookup found a negative dentry.
          *
          * 0:      if we successfully resolved nd->last and found it to not to be a
          *         symlink that needs to be followed.
          *
          * 1:      if we successfully resolved nd->last and found it to be a symlink
          *         that needs to be followed.
          */
         static int
         mountpoint_last(struct nameidata *nd)
         {
         	int error = 0;
   2587  	struct dentry *dir = nd->path.dentry;
         	struct path path;
         
         	/* If we're in rcuwalk, drop out of it to handle last component */
   2591  	if (nd->flags & LOOKUP_RCU) {
   2592  		if (unlazy_walk(nd))
         			return -ECHILD;
         	}
         
   2596  	nd->flags &= ~LOOKUP_PARENT;
         
   2598  	if (unlikely(nd->last_type != LAST_NORM)) {
         		error = handle_dots(nd, nd->last_type);
         		if (error)
         			return error;
   2602  		path.dentry = dget(nd->path.dentry);
         	} else {
   2604  		path.dentry = d_lookup(dir, &nd->last);
   2605  		if (!path.dentry) {
         			/*
         			 * No cached dentry. Mounted dentries are pinned in the
         			 * cache, so that means that this dentry is probably
         			 * a symlink or the path doesn't actually point
         			 * to a mounted dentry.
         			 */
   2612  			path.dentry = lookup_slow(&nd->last, dir,
         					     nd->flags | LOOKUP_NO_REVAL);
   2614  			if (IS_ERR(path.dentry))
         				return PTR_ERR(path.dentry);
         		}
         	}
   2618  	if (d_is_negative(path.dentry)) {
   2619  		dput(path.dentry);
   2620  		return -ENOENT;
         	}
   2622  	path.mnt = nd->path.mnt;
   2623  	return step_into(nd, &path, 0, d_backing_inode(path.dentry), 0);
         }
         
         /**
          * path_mountpoint - look up a path to be umounted
          * @nd:		lookup context
          * @flags:	lookup flags
          * @path:	pointer to container for result
          *
          * Look up the given name, but don't attempt to revalidate the last component.
          * Returns 0 and "path" will be valid on success; Returns error otherwise.
          */
         static int
         path_mountpoint(struct nameidata *nd, unsigned flags, struct path *path)
   2637  {
   2638  	const char *s = path_init(nd, flags);
         	int err;
   2640  	if (IS_ERR(s))
   2641  		return PTR_ERR(s);
   2642  	while (!(err = link_path_walk(s, nd)) &&
         		(err = mountpoint_last(nd)) > 0) {
   2644  		s = trailing_symlink(nd);
   2645  		if (IS_ERR(s)) {
         			err = PTR_ERR(s);
         			break;
         		}
         	}
   2650  	if (!err) {
   2651  		*path = nd->path;
   2652  		nd->path.mnt = NULL;
   2653  		nd->path.dentry = NULL;
   2654  		follow_mount(path);
         	}
   2656  	terminate_walk(nd);
         	return err;
   2658  }
         
         static int
         filename_mountpoint(int dfd, struct filename *name, struct path *path,
         			unsigned int flags)
   2663  {
         	struct nameidata nd;
         	int error;
   2666  	if (IS_ERR(name))
   2667  		return PTR_ERR(name);
         	set_nameidata(&nd, dfd, name);
   2669  	error = path_mountpoint(&nd, flags | LOOKUP_RCU, path);
   2670  	if (unlikely(error == -ECHILD))
   2671  		error = path_mountpoint(&nd, flags, path);
   2672  	if (unlikely(error == -ESTALE))
   2673  		error = path_mountpoint(&nd, flags | LOOKUP_REVAL, path);
   2674  	if (likely(!error))
         		audit_inode(name, path->dentry, 0);
   2676  	restore_nameidata();
   2677  	putname(name);
         	return error;
   2679  }
         
         /**
          * user_path_mountpoint_at - lookup a path from userland in order to umount it
          * @dfd:	directory file descriptor
          * @name:	pathname from userland
          * @flags:	lookup flags
          * @path:	pointer to container to hold result
          *
          * A umount is a special case for path walking. We're not actually interested
          * in the inode in this situation, and ESTALE errors can be a problem. We
          * simply want track down the dentry and vfsmount attached at the mountpoint
          * and avoid revalidating the last component.
          *
          * Returns 0 and populates "path" on success.
          */
         int
         user_path_mountpoint_at(int dfd, const char __user *name, unsigned int flags,
         			struct path *path)
   2698  {
   2699  	return filename_mountpoint(dfd, getname(name), path, flags);
   2700  }
         
         int
         kern_path_mountpoint(int dfd, const char *name, struct path *path,
         			unsigned int flags)
   2705  {
   2706  	return filename_mountpoint(dfd, getname_kernel(name), path, flags);
   2707  }
         EXPORT_SYMBOL(kern_path_mountpoint);
         
         int __check_sticky(struct inode *dir, struct inode *inode)
   2711  {
   2712  	kuid_t fsuid = current_fsuid();
         
   2714  	if (uid_eq(inode->i_uid, fsuid))
   2715  		return 0;
   2716  	if (uid_eq(dir->i_uid, fsuid))
         		return 0;
   2718  	return !capable_wrt_inode_uidgid(inode, CAP_FOWNER);
   2719  }
         EXPORT_SYMBOL(__check_sticky);
         
         /*
          *	Check whether we can remove a link victim from directory dir, check
          *  whether the type of victim is right.
          *  1. We can't do it if dir is read-only (done in permission())
          *  2. We should have write and exec permissions on dir
          *  3. We can't remove anything from append-only dir
          *  4. We can't do anything with immutable dir (done in permission())
          *  5. If the sticky bit on dir is set we should either
          *	a. be owner of dir, or
          *	b. be owner of victim, or
          *	c. have CAP_FOWNER capability
          *  6. If the victim is append-only or immutable we can't do antyhing with
          *     links pointing to it.
          *  7. If the victim has an unknown uid or gid we can't change the inode.
          *  8. If we were asked to remove a directory and victim isn't one - ENOTDIR.
          *  9. If we were asked to remove a non-directory and victim isn't one - EISDIR.
          * 10. We can't remove a root or mountpoint.
          * 11. We don't allow removal of NFS sillyrenamed files; it's handled by
          *     nfs_async_unlink().
          */
         static int may_delete(struct inode *dir, struct dentry *victim, bool isdir)
   2743  {
   2744  	struct inode *inode = d_backing_inode(victim);
         	int error;
         
   2747  	if (d_is_negative(victim))
   2748  		return -ENOENT;
   2749  	BUG_ON(!inode);
         
   2751  	BUG_ON(victim->d_parent->d_inode != dir);
         	audit_inode_child(dir, victim, AUDIT_TYPE_CHILD_DELETE);
         
   2754  	error = inode_permission(dir, MAY_WRITE | MAY_EXEC);
   2755  	if (error)
         		return error;
   2757  	if (IS_APPEND(dir))
   2758  		return -EPERM;
         
   2760  	if (check_sticky(dir, inode) || IS_APPEND(inode) ||
   2761  	    IS_IMMUTABLE(inode) || IS_SWAPFILE(inode) || HAS_UNMAPPED_ID(inode))
         		return -EPERM;
   2763  	if (isdir) {
         		if (!d_is_dir(victim))
   2765  			return -ENOTDIR;
   2766  		if (IS_ROOT(victim))
         			return -EBUSY;
         	} else if (d_is_dir(victim))
   2769  		return -EISDIR;
   2770  	if (IS_DEADDIR(dir))
         		return -ENOENT;
         	if (victim->d_flags & DCACHE_NFSFS_RENAMED)
   2773  		return -EBUSY;
         	return 0;
   2775  }
         
         /*	Check whether we can create an object with dentry child in directory
          *  dir.
          *  1. We can't do it if child already exists (open has special treatment for
          *     this case, but since we are inlined it's OK)
          *  2. We can't do it if dir is read-only (done in permission())
          *  3. We can't do it if the fs can't represent the fsuid or fsgid.
          *  4. We should have write and exec permissions on dir
          *  5. We can't do it if dir is immutable (done in permission())
          */
         static inline int may_create(struct inode *dir, struct dentry *child)
         {
         	struct user_namespace *s_user_ns;
         	audit_inode_child(dir, child, AUDIT_TYPE_CHILD_CREATE);
   2790  	if (child->d_inode)
   2791  		return -EEXIST;
   2792  	if (IS_DEADDIR(dir))
   2793  		return -ENOENT;
   2794  	s_user_ns = dir->i_sb->s_user_ns;
   2795  	if (!kuid_has_mapping(s_user_ns, current_fsuid()) ||
         	    !kgid_has_mapping(s_user_ns, current_fsgid()))
   2797  		return -EOVERFLOW;
   2798  	return inode_permission(dir, MAY_WRITE | MAY_EXEC);
         }
         
         /*
          * p1 and p2 should be directories on the same fs.
          */
         struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
   2805  {
         	struct dentry *p;
         
   2808  	if (p1 == p2) {
         		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
   2810  		return NULL;
         	}
         
   2813  	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
         
   2815  	p = d_ancestor(p2, p1);
   2816  	if (p) {
         		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
         		inode_lock_nested(p1->d_inode, I_MUTEX_CHILD);
         		return p;
         	}
         
   2822  	p = d_ancestor(p1, p2);
         	if (p) {
         		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
         		inode_lock_nested(p2->d_inode, I_MUTEX_CHILD);
         		return p;
         	}
         
         	inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
         	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
         	return NULL;
   2832  }
         EXPORT_SYMBOL(lock_rename);
         
         void unlock_rename(struct dentry *p1, struct dentry *p2)
   2836  {
         	inode_unlock(p1->d_inode);
   2838  	if (p1 != p2) {
         		inode_unlock(p2->d_inode);
   2840  		mutex_unlock(&p1->d_sb->s_vfs_rename_mutex);
         	}
   2842  }
         EXPORT_SYMBOL(unlock_rename);
         
         int vfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
         		bool want_excl)
   2847  {
         	int error = may_create(dir, dentry);
   2849  	if (error)
         		return error;
         
   2852  	if (!dir->i_op->create)
   2853  		return -EACCES;	/* shouldn't it be ENOSYS? */
         	mode &= S_IALLUGO;
   2855  	mode |= S_IFREG;
   2856  	error = security_inode_create(dir, dentry, mode);
   2857  	if (error)
         		return error;
   2859  	error = dir->i_op->create(dir, dentry, mode, want_excl);
   2860  	if (!error)
         		fsnotify_create(dir, dentry);
         	return error;
   2863  }
         EXPORT_SYMBOL(vfs_create);
         
         int vfs_mkobj(struct dentry *dentry, umode_t mode,
         		int (*f)(struct dentry *, umode_t, void *),
         		void *arg)
   2869  {
   2870  	struct inode *dir = dentry->d_parent->d_inode;
         	int error = may_create(dir, dentry);
   2872  	if (error)
         		return error;
         
         	mode &= S_IALLUGO;
   2876  	mode |= S_IFREG;
   2877  	error = security_inode_create(dir, dentry, mode);
   2878  	if (error)
         		return error;
   2880  	error = f(dentry, mode, arg);
   2881  	if (!error)
         		fsnotify_create(dir, dentry);
         	return error;
   2884  }
         EXPORT_SYMBOL(vfs_mkobj);
         
         bool may_open_dev(const struct path *path)
   2888  {
   2889  	return !(path->mnt->mnt_flags & MNT_NODEV) &&
   2890  		!(path->mnt->mnt_sb->s_iflags & SB_I_NODEV);
   2891  }
         
         static int may_open(const struct path *path, int acc_mode, int flag)
   2894  {
         	struct dentry *dentry = path->dentry;
   2896  	struct inode *inode = dentry->d_inode;
         	int error;
         
   2899  	if (!inode)
   2900  		return -ENOENT;
         
   2902  	switch (inode->i_mode & S_IFMT) {
         	case S_IFLNK:
   2904  		return -ELOOP;
         	case S_IFDIR:
   2906  		if (acc_mode & MAY_WRITE)
   2907  			return -EISDIR;
         		break;
         	case S_IFBLK:
         	case S_IFCHR:
         		if (!may_open_dev(path))
   2912  			return -EACCES;
         		/*FALLTHRU*/
         	case S_IFIFO:
         	case S_IFSOCK:
   2916  		flag &= ~O_TRUNC;
         		break;
         	}
         
   2920  	error = inode_permission(inode, MAY_OPEN | acc_mode);
   2921  	if (error)
         		return error;
         
         	/*
         	 * An append-only file must be opened in append mode for writing.
         	 */
   2927  	if (IS_APPEND(inode)) {
   2928  		if  ((flag & O_ACCMODE) != O_RDONLY && !(flag & O_APPEND))
   2929  			return -EPERM;
   2930  		if (flag & O_TRUNC)
         			return -EPERM;
         	}
         
         	/* O_NOATIME can only be set by the owner or superuser */
   2935  	if (flag & O_NOATIME && !inode_owner_or_capable(inode))
         		return -EPERM;
         
         	return 0;
   2939  }
         
         static int handle_truncate(struct file *filp)
         {
         	const struct path *path = &filp->f_path;
   2944  	struct inode *inode = path->dentry->d_inode;
         	int error = get_write_access(inode);
         	if (error)
         		return error;
         	/*
         	 * Refuse to truncate files with mandatory locks held on them.
         	 */
         	error = locks_verify_locked(filp);
         	if (!error)
         		error = security_path_truncate(path);
         	if (!error) {
   2955  		error = do_truncate(path->dentry, 0,
         				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
         				    filp);
         	}
         	put_write_access(inode);
         	return error;
         }
         
         static inline int open_to_namei_flags(int flag)
         {
   2965  	if ((flag & O_ACCMODE) == 3)
   2966  		flag--;
         	return flag;
         }
         
         static int may_o_create(const struct path *dir, struct dentry *dentry, umode_t mode)
         {
         	struct user_namespace *s_user_ns;
         	int error = security_path_mknod(dir, dentry, mode, 0);
         	if (error)
         		return error;
         
   2977  	s_user_ns = dir->dentry->d_sb->s_user_ns;
   2978  	if (!kuid_has_mapping(s_user_ns, current_fsuid()) ||
         	    !kgid_has_mapping(s_user_ns, current_fsgid()))
   2980  		return -EOVERFLOW;
         
   2982  	error = inode_permission(dir->dentry->d_inode, MAY_WRITE | MAY_EXEC);
   2983  	if (error)
         		return error;
         
   2986  	return security_inode_create(dir->dentry->d_inode, dentry, mode);
         }
         
         /*
          * Attempt to atomically look up, create and open a file from a negative
          * dentry.
          *
          * Returns 0 if successful.  The file will have been created and attached to
          * @file by the filesystem calling finish_open().
          *
          * Returns 1 if the file was looked up only or didn't need creating.  The
          * caller will need to perform the open themselves.  @path will have been
          * updated to point to the new dentry.  This may be negative.
          *
          * Returns an error code otherwise.
          */
         static int atomic_open(struct nameidata *nd, struct dentry *dentry,
         			struct path *path, struct file *file,
         			const struct open_flags *op,
         			int open_flag, umode_t mode,
         			int *opened)
         {
         	struct dentry *const DENTRY_NOT_SET = (void *) -1UL;
   3009  	struct inode *dir =  nd->path.dentry->d_inode;
         	int error;
         
   3012  	if (!(~open_flag & (O_EXCL | O_CREAT)))	/* both O_EXCL and O_CREAT */
   3013  		open_flag &= ~O_TRUNC;
         
         	if (nd->flags & LOOKUP_DIRECTORY)
   3016  		open_flag |= O_DIRECTORY;
         
   3018  	file->f_path.dentry = DENTRY_NOT_SET;
   3019  	file->f_path.mnt = nd->path.mnt;
   3020  	error = dir->i_op->atomic_open(dir, dentry, file,
         				       open_to_namei_flags(open_flag),
         				       mode, opened);
         	d_lookup_done(dentry);
   3024  	if (!error) {
         		/*
         		 * We didn't have the inode before the open, so check open
         		 * permission here.
         		 */
   3029  		int acc_mode = op->acc_mode;
   3030  		if (*opened & FILE_CREATED) {
   3031  			WARN_ON(!(open_flag & O_CREAT));
         			fsnotify_create(dir, dentry);
         			acc_mode = 0;
         		}
   3035  		error = may_open(&file->f_path, acc_mode, open_flag);
   3036  		if (WARN_ON(error > 0))
   3037  			error = -EINVAL;
   3038  	} else if (error > 0) {
   3039  		if (WARN_ON(file->f_path.dentry == DENTRY_NOT_SET)) {
   3040  			error = -EIO;
         		} else {
   3042  			if (file->f_path.dentry) {
   3043  				dput(dentry);
   3044  				dentry = file->f_path.dentry;
         			}
   3046  			if (*opened & FILE_CREATED)
         				fsnotify_create(dir, dentry);
   3048  			if (unlikely(d_is_negative(dentry))) {
         				error = -ENOENT;
         			} else {
         				path->dentry = dentry;
         				path->mnt = nd->path.mnt;
         				return 1;
         			}
         		}
         	}
   3057  	dput(dentry);
         	return error;
         }
         
         /*
          * Look up and maybe create and open the last component.
          *
          * Must be called with i_mutex held on parent.
          *
          * Returns 0 if the file was successfully atomically created (if necessary) and
          * opened.  In this case the file will be returned attached to @file.
          *
          * Returns 1 if the file was not completely opened at this time, though lookups
          * and creations will have been performed and the dentry returned in @path will
          * be positive upon return if O_CREAT was specified.  If O_CREAT wasn't
          * specified then a negative dentry may be returned.
          *
          * An error code is returned otherwise.
          *
          * FILE_CREATE will be set in @*opened if the dentry was created and will be
          * cleared otherwise prior to returning.
          */
         static int lookup_open(struct nameidata *nd, struct path *path,
         			struct file *file,
         			const struct open_flags *op,
         			bool got_write, int *opened)
         {
   3084  	struct dentry *dir = nd->path.dentry;
   3085  	struct inode *dir_inode = dir->d_inode;
   3086  	int open_flag = op->open_flag;
         	struct dentry *dentry;
         	int error, create_error = 0;
   3089  	umode_t mode = op->mode;
   3090  	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
         
   3092  	if (unlikely(IS_DEADDIR(dir_inode)))
   3093  		return -ENOENT;
         
   3095  	*opened &= ~FILE_CREATED;
   3096  	dentry = d_lookup(dir, &nd->last);
         	for (;;) {
   3098  		if (!dentry) {
   3099  			dentry = d_alloc_parallel(dir, &nd->last, &wq);
   3100  			if (IS_ERR(dentry))
   3101  				return PTR_ERR(dentry);
         		}
   3103  		if (d_in_lookup(dentry))
         			break;
         
         		error = d_revalidate(dentry, nd->flags);
   3107  		if (likely(error > 0))
         			break;
   3109  		if (error)
         			goto out_dput;
   3111  		d_invalidate(dentry);
   3112  		dput(dentry);
         		dentry = NULL;
         	}
   3115  	if (dentry->d_inode) {
         		/* Cached positive dentry: will open in f_op->open */
         		goto out_no_open;
         	}
         
         	/*
         	 * Checking write permission is tricky, bacuse we don't know if we are
         	 * going to actually need it: O_CREAT opens should work as long as the
         	 * file exists.  But checking existence breaks atomicity.  The trick is
         	 * to check access and if not granted clear O_CREAT from the flags.
         	 *
         	 * Another problem is returing the "right" error value (e.g. for an
         	 * O_EXCL open we want to return EEXIST not EROFS).
         	 */
   3129  	if (open_flag & O_CREAT) {
   3130  		if (!IS_POSIXACL(dir->d_inode))
   3131  			mode &= ~current_umask();
   3132  		if (unlikely(!got_write)) {
   3133  			create_error = -EROFS;
   3134  			open_flag &= ~O_CREAT;
   3135  			if (open_flag & (O_EXCL | O_TRUNC))
         				goto no_open;
         			/* No side effects, safe to clear O_CREAT */
         		} else {
   3139  			create_error = may_o_create(&nd->path, dentry, mode);
   3140  			if (create_error) {
   3141  				open_flag &= ~O_CREAT;
   3142  				if (open_flag & O_EXCL)
         					goto no_open;
         			}
         		}
   3146  	} else if ((open_flag & (O_TRUNC|O_WRONLY|O_RDWR)) &&
         		   unlikely(!got_write)) {
         		/*
         		 * No O_CREATE -> atomicity not a requirement -> fall
         		 * back to lookup + open
         		 */
         		goto no_open;
         	}
         
   3155  	if (dir_inode->i_op->atomic_open) {
         		error = atomic_open(nd, dentry, path, file, op, open_flag,
         				    mode, opened);
   3158  		if (unlikely(error == -ENOENT) && create_error)
         			error = create_error;
         		return error;
         	}
         
         no_open:
   3164  	if (d_in_lookup(dentry)) {
   3165  		struct dentry *res = dir_inode->i_op->lookup(dir_inode, dentry,
         							     nd->flags);
         		d_lookup_done(dentry);
   3168  		if (unlikely(res)) {
   3169  			if (IS_ERR(res)) {
         				error = PTR_ERR(res);
         				goto out_dput;
         			}
   3173  			dput(dentry);
         			dentry = res;
         		}
         	}
         
         	/* Negative dentry, just create the file */
   3179  	if (!dentry->d_inode && (open_flag & O_CREAT)) {
   3180  		*opened |= FILE_CREATED;
         		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
   3182  		if (!dir_inode->i_op->create) {
   3183  			error = -EACCES;
         			goto out_dput;
         		}
   3186  		error = dir_inode->i_op->create(dir_inode, dentry, mode,
         						open_flag & O_EXCL);
   3188  		if (error)
         			goto out_dput;
         		fsnotify_create(dir_inode, dentry);
         	}
   3192  	if (unlikely(create_error) && !dentry->d_inode) {
         		error = create_error;
         		goto out_dput;
         	}
         out_no_open:
   3197  	path->dentry = dentry;
   3198  	path->mnt = nd->path.mnt;
         	return 1;
         
         out_dput:
   3202  	dput(dentry);
         	return error;
         }
         
         /*
          * Handle the last step of open()
          */
         static int do_last(struct nameidata *nd,
         		   struct file *file, const struct open_flags *op,
         		   int *opened)
         {
   3213  	struct dentry *dir = nd->path.dentry;
   3214  	int open_flag = op->open_flag;
   3215  	bool will_truncate = (open_flag & O_TRUNC) != 0;
   3216  	bool got_write = false;
   3217  	int acc_mode = op->acc_mode;
         	unsigned seq;
         	struct inode *inode;
         	struct path path;
         	int error;
         
   3223  	nd->flags &= ~LOOKUP_PARENT;
   3224  	nd->flags |= op->intent;
         
   3226  	if (nd->last_type != LAST_NORM) {
         		error = handle_dots(nd, nd->last_type);
         		if (unlikely(error))
         			return error;
         		goto finish_open;
         	}
         
   3233  	if (!(open_flag & O_CREAT)) {
   3234  		if (nd->last.name[nd->last.len])
   3235  			nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
         		/* we _can_ be in RCU mode here */
   3237  		error = lookup_fast(nd, &path, &inode, &seq);
   3238  		if (likely(error > 0))
         			goto finish_lookup;
         
   3241  		if (error < 0)
         			return error;
         
   3244  		BUG_ON(nd->inode != dir->d_inode);
   3245  		BUG_ON(nd->flags & LOOKUP_RCU);
         	} else {
         		/* create side of things */
         		/*
         		 * This will *only* deal with leaving RCU mode - LOOKUP_JUMPED
         		 * has been cleared when we got to the last component we are
         		 * about to look up
         		 */
   3253  		error = complete_walk(nd);
   3254  		if (error)
         			return error;
         
         		audit_inode(nd->name, dir, LOOKUP_PARENT);
         		/* trailing slashes? */
   3259  		if (unlikely(nd->last.name[nd->last.len]))
         			return -EISDIR;
         	}
         
   3263  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
   3264  		error = mnt_want_write(nd->path.mnt);
   3265  		if (!error)
         			got_write = true;
         		/*
         		 * do _not_ fail yet - we might not need that or fail with
         		 * a different error; let lookup_open() decide; we'll be
         		 * dropping this one anyway.
         		 */
         	}
         	if (open_flag & O_CREAT)
         		inode_lock(dir->d_inode);
         	else
         		inode_lock_shared(dir->d_inode);
         	error = lookup_open(nd, &path, file, op, got_write, opened);
   3278  	if (open_flag & O_CREAT)
         		inode_unlock(dir->d_inode);
         	else
         		inode_unlock_shared(dir->d_inode);
         
   3283  	if (error <= 0) {
   3284  		if (error)
         			goto out;
         
   3287  		if ((*opened & FILE_CREATED) ||
   3288  		    !S_ISREG(file_inode(file)->i_mode))
         			will_truncate = false;
         
         		audit_inode(nd->name, file->f_path.dentry, 0);
         		goto opened;
         	}
         
   3295  	if (*opened & FILE_CREATED) {
         		/* Don't check for write permission, don't truncate */
   3297  		open_flag &= ~O_TRUNC;
   3298  		will_truncate = false;
   3299  		acc_mode = 0;
         		path_to_nameidata(&path, nd);
         		goto finish_open_created;
         	}
         
         	/*
         	 * If atomic_open() acquired write access it is dropped now due to
         	 * possible mount and symlink following (this might be optimized away if
         	 * necessary...)
         	 */
   3309  	if (got_write) {
   3310  		mnt_drop_write(nd->path.mnt);
         		got_write = false;
         	}
         
   3314  	error = follow_managed(&path, nd);
   3315  	if (unlikely(error < 0))
         		return error;
         
   3318  	if (unlikely(d_is_negative(path.dentry))) {
         		path_to_nameidata(&path, nd);
         		return -ENOENT;
         	}
         
         	/*
         	 * create/update audit record if it already exists.
         	 */
         	audit_inode(nd->name, path.dentry, 0);
         
   3328  	if (unlikely((open_flag & (O_EXCL | O_CREAT)) == (O_EXCL | O_CREAT))) {
         		path_to_nameidata(&path, nd);
   3330  		return -EEXIST;
         	}
         
   3333  	seq = 0;	/* out of RCU mode, so the value doesn't matter */
   3334  	inode = d_backing_inode(path.dentry);
         finish_lookup:
         	error = step_into(nd, &path, 0, inode, seq);
   3337  	if (unlikely(error))
         		return error;
         finish_open:
         	/* Why this, you ask?  _Now_ we might have grown LOOKUP_JUMPED... */
   3341  	error = complete_walk(nd);
   3342  	if (error)
         		return error;
   3344  	audit_inode(nd->name, nd->path.dentry, 0);
   3345  	error = -EISDIR;
   3346  	if ((open_flag & O_CREAT) && d_is_dir(nd->path.dentry))
         		goto out;
   3348  	error = -ENOTDIR;
   3349  	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
         		goto out;
   3351  	if (!d_is_reg(nd->path.dentry))
   3352  		will_truncate = false;
         
   3354  	if (will_truncate) {
   3355  		error = mnt_want_write(nd->path.mnt);
   3356  		if (error)
         			goto out;
   3358  		got_write = true;
         	}
         finish_open_created:
   3361  	error = may_open(&nd->path, acc_mode, open_flag);
   3362  	if (error)
         		goto out;
   3364  	BUG_ON(*opened & FILE_OPENED); /* once it's opened, it's opened */
   3365  	error = vfs_open(&nd->path, file, current_cred());
   3366  	if (error)
         		goto out;
   3368  	*opened |= FILE_OPENED;
         opened:
         	error = ima_file_check(file, op->acc_mode, *opened);
   3371  	if (!error && will_truncate)
         		error = handle_truncate(file);
         out:
   3374  	if (unlikely(error) && (*opened & FILE_OPENED))
   3375  		fput(file);
   3376  	if (unlikely(error > 0)) {
   3377  		WARN_ON(1);
   3378  		error = -EINVAL;
         	}
   3380  	if (got_write)
   3381  		mnt_drop_write(nd->path.mnt);
         	return error;
         }
         
         struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode, int open_flag)
   3386  {
   3387  	struct dentry *child = NULL;
   3388  	struct inode *dir = dentry->d_inode;
         	struct inode *inode;
         	int error;
         
         	/* we want directory to be writable */
   3393  	error = inode_permission(dir, MAY_WRITE | MAY_EXEC);
   3394  	if (error)
         		goto out_err;
         	error = -EOPNOTSUPP;
   3397  	if (!dir->i_op->tmpfile)
         		goto out_err;
         	error = -ENOMEM;
   3400  	child = d_alloc(dentry, &slash_name);
   3401  	if (unlikely(!child))
         		goto out_err;
   3403  	error = dir->i_op->tmpfile(dir, child, mode);
   3404  	if (error)
         		goto out_err;
         	error = -ENOENT;
   3407  	inode = child->d_inode;
   3408  	if (unlikely(!inode))
         		goto out_err;
   3410  	if (!(open_flag & O_EXCL)) {
         		spin_lock(&inode->i_lock);
   3412  		inode->i_state |= I_LINKABLE;
         		spin_unlock(&inode->i_lock);
         	}
         	return child;
         
   3417  out_err:
   3418  	dput(child);
         	return ERR_PTR(error);
   3420  }
         EXPORT_SYMBOL(vfs_tmpfile);
         
         static int do_tmpfile(struct nameidata *nd, unsigned flags,
         		const struct open_flags *op,
         		struct file *file, int *opened)
         {
         	struct dentry *child;
         	struct path path;
   3429  	int error = path_lookupat(nd, flags | LOOKUP_DIRECTORY, &path);
   3430  	if (unlikely(error))
         		return error;
   3432  	error = mnt_want_write(path.mnt);
   3433  	if (unlikely(error))
         		goto out;
   3435  	child = vfs_tmpfile(path.dentry, op->mode, op->open_flag);
   3436  	error = PTR_ERR(child);
   3437  	if (IS_ERR(child))
         		goto out2;
   3439  	dput(path.dentry);
   3440  	path.dentry = child;
         	audit_inode(nd->name, child, 0);
         	/* Don't check for other permissions, the inode was just created */
   3443  	error = may_open(&path, 0, op->open_flag);
   3444  	if (error)
         		goto out2;
   3446  	file->f_path.mnt = path.mnt;
   3447  	error = finish_open(file, child, NULL, opened);
         	if (error)
         		goto out2;
         out2:
   3451  	mnt_drop_write(path.mnt);
         out:
         	path_put(&path);
         	return error;
         }
         
         static int do_o_path(struct nameidata *nd, unsigned flags, struct file *file)
         {
         	struct path path;
   3460  	int error = path_lookupat(nd, flags, &path);
   3461  	if (!error) {
         		audit_inode(nd->name, path.dentry, 0);
   3463  		error = vfs_open(&path, file, current_cred());
         		path_put(&path);
         	}
         	return error;
         }
         
         static struct file *path_openat(struct nameidata *nd,
         			const struct open_flags *op, unsigned flags)
   3471  {
         	const char *s;
         	struct file *file;
   3474  	int opened = 0;
         	int error;
         
   3477  	file = get_empty_filp();
   3478  	if (IS_ERR(file))
         		return file;
         
   3481  	file->f_flags = op->open_flag;
         
   3483  	if (unlikely(file->f_flags & __O_TMPFILE)) {
         		error = do_tmpfile(nd, flags, op, file, &opened);
   3485  		goto out2;
         	}
         
   3488  	if (unlikely(file->f_flags & O_PATH)) {
         		error = do_o_path(nd, flags, file);
   3490  		if (!error)
         			opened |= FILE_OPENED;
         		goto out2;
         	}
         
   3495  	s = path_init(nd, flags);
   3496  	if (IS_ERR(s)) {
   3497  		put_filp(file);
   3498  		return ERR_CAST(s);
         	}
   3500  	while (!(error = link_path_walk(s, nd)) &&
         		(error = do_last(nd, file, op, &opened)) > 0) {
   3502  		nd->flags &= ~(LOOKUP_OPEN|LOOKUP_CREATE|LOOKUP_EXCL);
   3503  		s = trailing_symlink(nd);
   3504  		if (IS_ERR(s)) {
   3505  			error = PTR_ERR(s);
         			break;
         		}
         	}
   3509  	terminate_walk(nd);
         out2:
   3511  	if (!(opened & FILE_OPENED)) {
   3512  		BUG_ON(!error);
   3513  		put_filp(file);
         	}
   3515  	if (unlikely(error)) {
   3516  		if (error == -EOPENSTALE) {
   3517  			if (flags & LOOKUP_RCU)
         				error = -ECHILD;
         			else
         				error = -ESTALE;
         		}
         		file = ERR_PTR(error);
         	}
         	return file;
   3525  }
         
         struct file *do_filp_open(int dfd, struct filename *pathname,
         		const struct open_flags *op)
   3529  {
         	struct nameidata nd;
   3531  	int flags = op->lookup_flags;
         	struct file *filp;
         
         	set_nameidata(&nd, dfd, pathname);
   3535  	filp = path_openat(&nd, op, flags | LOOKUP_RCU);
   3536  	if (unlikely(filp == ERR_PTR(-ECHILD)))
   3537  		filp = path_openat(&nd, op, flags);
   3538  	if (unlikely(filp == ERR_PTR(-ESTALE)))
   3539  		filp = path_openat(&nd, op, flags | LOOKUP_REVAL);
   3540  	restore_nameidata();
         	return filp;
   3542  }
         
         struct file *do_file_open_root(struct dentry *dentry, struct vfsmount *mnt,
         		const char *name, const struct open_flags *op)
   3546  {
         	struct nameidata nd;
         	struct file *file;
         	struct filename *filename;
   3550  	int flags = op->lookup_flags | LOOKUP_ROOT;
         
   3552  	nd.root.mnt = mnt;
   3553  	nd.root.dentry = dentry;
         
   3555  	if (d_is_symlink(dentry) && op->intent & LOOKUP_OPEN)
   3556  		return ERR_PTR(-ELOOP);
         
   3558  	filename = getname_kernel(name);
   3559  	if (IS_ERR(filename))
   3560  		return ERR_CAST(filename);
         
         	set_nameidata(&nd, -1, filename);
   3563  	file = path_openat(&nd, op, flags | LOOKUP_RCU);
   3564  	if (unlikely(file == ERR_PTR(-ECHILD)))
   3565  		file = path_openat(&nd, op, flags);
   3566  	if (unlikely(file == ERR_PTR(-ESTALE)))
   3567  		file = path_openat(&nd, op, flags | LOOKUP_REVAL);
   3568  	restore_nameidata();
   3569  	putname(filename);
         	return file;
   3571  }
         
         static struct dentry *filename_create(int dfd, struct filename *name,
         				struct path *path, unsigned int lookup_flags)
   3575  {
   3576  	struct dentry *dentry = ERR_PTR(-EEXIST);
         	struct qstr last;
         	int type;
         	int err2;
         	int error;
         	bool is_dir = (lookup_flags & LOOKUP_DIRECTORY);
         
         	/*
         	 * Note that only LOOKUP_REVAL and LOOKUP_DIRECTORY matter here. Any
         	 * other flags passed in are ignored!
         	 */
   3587  	lookup_flags &= LOOKUP_REVAL;
         
   3589  	name = filename_parentat(dfd, name, lookup_flags, path, &last, &type);
   3590  	if (IS_ERR(name))
   3591  		return ERR_CAST(name);
         
         	/*
         	 * Yucky last component or no last component at all?
         	 * (foo/., foo/.., /////)
         	 */
   3597  	if (unlikely(type != LAST_NORM))
         		goto out;
         
         	/* don't fail immediately if it's r/o, at least try to report other errors */
   3601  	err2 = mnt_want_write(path->mnt);
         	/*
         	 * Do the final lookup.
         	 */
   3605  	lookup_flags |= LOOKUP_CREATE | LOOKUP_EXCL;
   3606  	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
   3607  	dentry = __lookup_hash(&last, path->dentry, lookup_flags);
   3608  	if (IS_ERR(dentry))
         		goto unlock;
         
         	error = -EEXIST;
   3612  	if (d_is_positive(dentry))
         		goto fail;
         
         	/*
         	 * Special case - lookup gave negative, but... we had foo/bar/
         	 * From the vfs_mknod() POV we just have a negative dentry -
         	 * all is fine. Let's be bastards - you had / on the end, you've
         	 * been asking for (non-existent) directory. -ENOENT for you.
         	 */
   3621  	if (unlikely(!is_dir && last.name[last.len])) {
         		error = -ENOENT;
         		goto fail;
         	}
   3625  	if (unlikely(err2)) {
         		error = err2;
         		goto fail;
         	}
         	putname(name);
         	return dentry;
   3631  fail:
   3632  	dput(dentry);
   3633  	dentry = ERR_PTR(error);
         unlock:
   3635  	inode_unlock(path->dentry->d_inode);
   3636  	if (!err2)
   3637  		mnt_drop_write(path->mnt);
         out:
         	path_put(path);
   3640  	putname(name);
         	return dentry;
   3642  }
         
         struct dentry *kern_path_create(int dfd, const char *pathname,
         				struct path *path, unsigned int lookup_flags)
   3646  {
   3647  	return filename_create(dfd, getname_kernel(pathname),
         				path, lookup_flags);
   3649  }
         EXPORT_SYMBOL(kern_path_create);
         
         void done_path_create(struct path *path, struct dentry *dentry)
   3653  {
   3654  	dput(dentry);
   3655  	inode_unlock(path->dentry->d_inode);
   3656  	mnt_drop_write(path->mnt);
         	path_put(path);
   3658  }
         EXPORT_SYMBOL(done_path_create);
         
         inline struct dentry *user_path_create(int dfd, const char __user *pathname,
         				struct path *path, unsigned int lookup_flags)
   3663  {
   3664  	return filename_create(dfd, getname(pathname), path, lookup_flags);
   3665  }
         EXPORT_SYMBOL(user_path_create);
         
         int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
   3669  {
         	int error = may_create(dir, dentry);
         
   3672  	if (error)
         		return error;
         
   3675  	if ((S_ISCHR(mode) || S_ISBLK(mode)) && !capable(CAP_MKNOD))
   3676  		return -EPERM;
         
   3678  	if (!dir->i_op->mknod)
         		return -EPERM;
         
         	error = devcgroup_inode_mknod(mode, dev);
   3682  	if (error)
         		return error;
         
   3685  	error = security_inode_mknod(dir, dentry, mode, dev);
   3686  	if (error)
         		return error;
         
   3689  	error = dir->i_op->mknod(dir, dentry, mode, dev);
   3690  	if (!error)
         		fsnotify_create(dir, dentry);
         	return error;
   3693  }
         EXPORT_SYMBOL(vfs_mknod);
         
         static int may_mknod(umode_t mode)
         {
   3698  	switch (mode & S_IFMT) {
         	case S_IFREG:
         	case S_IFCHR:
         	case S_IFBLK:
         	case S_IFIFO:
         	case S_IFSOCK:
         	case 0: /* zero mode translates to S_IFREG */
         		return 0;
         	case S_IFDIR:
         		return -EPERM;
         	default:
         		return -EINVAL;
         	}
         }
         
         long do_mknodat(int dfd, const char __user *filename, umode_t mode,
         		unsigned int dev)
   3715  {
         	struct dentry *dentry;
         	struct path path;
         	int error;
   3719  	unsigned int lookup_flags = 0;
         
         	error = may_mknod(mode);
         	if (error)
         		return error;
         retry:
         	dentry = user_path_create(dfd, filename, &path, lookup_flags);
   3726  	if (IS_ERR(dentry))
         		return PTR_ERR(dentry);
         
   3729  	if (!IS_POSIXACL(path.dentry->d_inode))
   3730  		mode &= ~current_umask();
   3731  	error = security_path_mknod(&path, dentry, mode, dev);
         	if (error)
         		goto out;
   3734  	switch (mode & S_IFMT) {
         		case 0: case S_IFREG:
   3736  			error = vfs_create(path.dentry->d_inode,dentry,mode,true);
         			if (!error)
         				ima_post_path_mknod(dentry);
         			break;
         		case S_IFCHR: case S_IFBLK:
   3741  			error = vfs_mknod(path.dentry->d_inode,dentry,mode,
         					new_decode_dev(dev));
         			break;
         		case S_IFIFO: case S_IFSOCK:
   3745  			error = vfs_mknod(path.dentry->d_inode,dentry,mode,0);
         			break;
         	}
         out:
   3749  	done_path_create(&path, dentry);
   3750  	if (retry_estale(error, lookup_flags)) {
   3751  		lookup_flags |= LOOKUP_REVAL;
         		goto retry;
         	}
         	return error;
   3755  }
         
   3757  SYSCALL_DEFINE4(mknodat, int, dfd, const char __user *, filename, umode_t, mode,
         		unsigned int, dev)
         {
   3760  	return do_mknodat(dfd, filename, mode, dev);
         }
         
   3763  SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, dev)
         {
   3765  	return do_mknodat(AT_FDCWD, filename, mode, dev);
         }
         
         int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
   3769  {
         	int error = may_create(dir, dentry);
   3771  	unsigned max_links = dir->i_sb->s_max_links;
         
   3773  	if (error)
         		return error;
         
   3776  	if (!dir->i_op->mkdir)
   3777  		return -EPERM;
         
         	mode &= (S_IRWXUGO|S_ISVTX);
   3780  	error = security_inode_mkdir(dir, dentry, mode);
   3781  	if (error)
         		return error;
         
   3784  	if (max_links && dir->i_nlink >= max_links)
   3785  		return -EMLINK;
         
   3787  	error = dir->i_op->mkdir(dir, dentry, mode);
   3788  	if (!error)
         		fsnotify_mkdir(dir, dentry);
         	return error;
   3791  }
         EXPORT_SYMBOL(vfs_mkdir);
         
         long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
   3795  {
         	struct dentry *dentry;
         	struct path path;
         	int error;
   3799  	unsigned int lookup_flags = LOOKUP_DIRECTORY;
         
         retry:
         	dentry = user_path_create(dfd, pathname, &path, lookup_flags);
   3803  	if (IS_ERR(dentry))
         		return PTR_ERR(dentry);
         
   3806  	if (!IS_POSIXACL(path.dentry->d_inode))
   3807  		mode &= ~current_umask();
   3808  	error = security_path_mkdir(&path, dentry, mode);
         	if (!error)
   3810  		error = vfs_mkdir(path.dentry->d_inode, dentry, mode);
   3811  	done_path_create(&path, dentry);
   3812  	if (retry_estale(error, lookup_flags)) {
   3813  		lookup_flags |= LOOKUP_REVAL;
         		goto retry;
         	}
         	return error;
   3817  }
         
   3819  SYSCALL_DEFINE3(mkdirat, int, dfd, const char __user *, pathname, umode_t, mode)
         {
   3821  	return do_mkdirat(dfd, pathname, mode);
         }
         
   3824  SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
         {
   3826  	return do_mkdirat(AT_FDCWD, pathname, mode);
         }
         
         int vfs_rmdir(struct inode *dir, struct dentry *dentry)
   3830  {
   3831  	int error = may_delete(dir, dentry, 1);
         
   3833  	if (error)
         		return error;
         
   3836  	if (!dir->i_op->rmdir)
   3837  		return -EPERM;
         
         	dget(dentry);
         	inode_lock(dentry->d_inode);
         
   3842  	error = -EBUSY;
   3843  	if (is_local_mountpoint(dentry))
         		goto out;
         
   3846  	error = security_inode_rmdir(dir, dentry);
   3847  	if (error)
         		goto out;
         
   3850  	shrink_dcache_parent(dentry);
   3851  	error = dir->i_op->rmdir(dir, dentry);
   3852  	if (error)
         		goto out;
         
   3855  	dentry->d_inode->i_flags |= S_DEAD;
         	dont_mount(dentry);
         	detach_mounts(dentry);
         
         out:
         	inode_unlock(dentry->d_inode);
   3861  	dput(dentry);
         	if (!error)
   3863  		d_delete(dentry);
         	return error;
   3865  }
         EXPORT_SYMBOL(vfs_rmdir);
         
         long do_rmdir(int dfd, const char __user *pathname)
   3869  {
         	int error = 0;
         	struct filename *name;
         	struct dentry *dentry;
         	struct path path;
         	struct qstr last;
         	int type;
   3876  	unsigned int lookup_flags = 0;
         retry:
   3878  	name = filename_parentat(dfd, getname(pathname), lookup_flags,
         				&path, &last, &type);
   3880  	if (IS_ERR(name))
   3881  		return PTR_ERR(name);
         
   3883  	switch (type) {
         	case LAST_DOTDOT:
         		error = -ENOTEMPTY;
         		goto exit1;
         	case LAST_DOT:
         		error = -EINVAL;
         		goto exit1;
         	case LAST_ROOT:
         		error = -EBUSY;
         		goto exit1;
         	}
         
   3895  	error = mnt_want_write(path.mnt);
   3896  	if (error)
         		goto exit1;
         
   3899  	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
   3900  	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
         	error = PTR_ERR(dentry);
   3902  	if (IS_ERR(dentry))
         		goto exit2;
   3904  	if (!dentry->d_inode) {
         		error = -ENOENT;
         		goto exit3;
         	}
         	error = security_path_rmdir(&path, dentry);
         	if (error)
         		goto exit3;
   3911  	error = vfs_rmdir(path.dentry->d_inode, dentry);
         exit3:
   3913  	dput(dentry);
         exit2:
   3915  	inode_unlock(path.dentry->d_inode);
   3916  	mnt_drop_write(path.mnt);
         exit1:
         	path_put(&path);
   3919  	putname(name);
         	if (retry_estale(error, lookup_flags)) {
   3921  		lookup_flags |= LOOKUP_REVAL;
         		goto retry;
         	}
         	return error;
   3925  }
         
   3927  SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
         {
   3929  	return do_rmdir(AT_FDCWD, pathname);
         }
         
         /**
          * vfs_unlink - unlink a filesystem object
          * @dir:	parent directory
          * @dentry:	victim
          * @delegated_inode: returns victim inode, if the inode is delegated.
          *
          * The caller must hold dir->i_mutex.
          *
          * If vfs_unlink discovers a delegation, it will return -EWOULDBLOCK and
          * return a reference to the inode in delegated_inode.  The caller
          * should then break the delegation on that inode and retry.  Because
          * breaking a delegation may take a long time, the caller should drop
          * dir->i_mutex before doing so.
          *
          * Alternatively, a caller may pass NULL for delegated_inode.  This may
          * be appropriate for callers that expect the underlying filesystem not
          * to be NFS exported.
          */
         int vfs_unlink(struct inode *dir, struct dentry *dentry, struct inode **delegated_inode)
   3951  {
   3952  	struct inode *target = dentry->d_inode;
   3953  	int error = may_delete(dir, dentry, 0);
         
   3955  	if (error)
         		return error;
         
   3958  	if (!dir->i_op->unlink)
   3959  		return -EPERM;
         
         	inode_lock(target);
   3962  	if (is_local_mountpoint(dentry))
   3963  		error = -EBUSY;
         	else {
   3965  		error = security_inode_unlink(dir, dentry);
   3966  		if (!error) {
         			error = try_break_deleg(target, delegated_inode);
   3968  			if (error)
         				goto out;
   3970  			error = dir->i_op->unlink(dir, dentry);
   3971  			if (!error) {
         				dont_mount(dentry);
         				detach_mounts(dentry);
         			}
         		}
         	}
         out:
         	inode_unlock(target);
         
         	/* We don't d_delete() NFS sillyrenamed files--they still exist. */
   3981  	if (!error && !(dentry->d_flags & DCACHE_NFSFS_RENAMED)) {
         		fsnotify_link_count(target);
   3983  		d_delete(dentry);
         	}
         
         	return error;
   3987  }
         EXPORT_SYMBOL(vfs_unlink);
         
         /*
          * Make sure that the actual truncation of the file will occur outside its
          * directory's i_mutex.  Truncate can take a long time if there is a lot of
          * writeout happening, and we don't want to prevent access to the directory
          * while waiting on the I/O.
          */
         long do_unlinkat(int dfd, struct filename *name)
   3997  {
         	int error;
         	struct dentry *dentry;
         	struct path path;
         	struct qstr last;
         	int type;
         	struct inode *inode = NULL;
   4004  	struct inode *delegated_inode = NULL;
   4005  	unsigned int lookup_flags = 0;
         retry:
   4007  	name = filename_parentat(dfd, name, lookup_flags, &path, &last, &type);
   4008  	if (IS_ERR(name))
   4009  		return PTR_ERR(name);
         
         	error = -EISDIR;
   4012  	if (type != LAST_NORM)
         		goto exit1;
         
   4015  	error = mnt_want_write(path.mnt);
   4016  	if (error)
         		goto exit1;
         retry_deleg:
   4019  	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
   4020  	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
   4021  	error = PTR_ERR(dentry);
   4022  	if (!IS_ERR(dentry)) {
         		/* Why not before? Because we want correct error value */
   4024  		if (last.name[last.len])
         			goto slashes;
   4026  		inode = dentry->d_inode;
   4027  		if (d_is_negative(dentry))
         			goto slashes;
   4029  		ihold(inode);
         		error = security_path_unlink(&path, dentry);
         		if (error)
         			goto exit2;
   4033  		error = vfs_unlink(path.dentry->d_inode, dentry, &delegated_inode);
         exit2:
   4035  		dput(dentry);
         	}
   4037  	inode_unlock(path.dentry->d_inode);
   4038  	if (inode)
   4039  		iput(inode);	/* truncate the inode here */
         	inode = NULL;
   4041  	if (delegated_inode) {
         		error = break_deleg_wait(&delegated_inode);
   4043  		if (!error)
         			goto retry_deleg;
         	}
   4046  	mnt_drop_write(path.mnt);
         exit1:
         	path_put(&path);
   4049  	if (retry_estale(error, lookup_flags)) {
   4050  		lookup_flags |= LOOKUP_REVAL;
         		inode = NULL;
         		goto retry;
         	}
   4054  	putname(name);
         	return error;
         
         slashes:
   4058  	if (d_is_negative(dentry))
   4059  		error = -ENOENT;
         	else if (d_is_dir(dentry))
   4061  		error = -EISDIR;
         	else
   4063  		error = -ENOTDIR;
         	goto exit2;
   4065  }
         
   4067  SYSCALL_DEFINE3(unlinkat, int, dfd, const char __user *, pathname, int, flag)
         {
   4069  	if ((flag & ~AT_REMOVEDIR) != 0)
         		return -EINVAL;
         
   4072  	if (flag & AT_REMOVEDIR)
   4073  		return do_rmdir(dfd, pathname);
         
   4075  	return do_unlinkat(dfd, getname(pathname));
         }
         
   4078  SYSCALL_DEFINE1(unlink, const char __user *, pathname)
         {
   4080  	return do_unlinkat(AT_FDCWD, getname(pathname));
         }
         
         int vfs_symlink(struct inode *dir, struct dentry *dentry, const char *oldname)
   4084  {
         	int error = may_create(dir, dentry);
         
   4087  	if (error)
         		return error;
         
   4090  	if (!dir->i_op->symlink)
   4091  		return -EPERM;
         
   4093  	error = security_inode_symlink(dir, dentry, oldname);
   4094  	if (error)
         		return error;
         
   4097  	error = dir->i_op->symlink(dir, dentry, oldname);
   4098  	if (!error)
         		fsnotify_create(dir, dentry);
         	return error;
   4101  }
         EXPORT_SYMBOL(vfs_symlink);
         
         long do_symlinkat(const char __user *oldname, int newdfd,
         		  const char __user *newname)
   4106  {
         	int error;
         	struct filename *from;
         	struct dentry *dentry;
         	struct path path;
         	unsigned int lookup_flags = 0;
         
         	from = getname(oldname);
   4114  	if (IS_ERR(from))
         		return PTR_ERR(from);
         retry:
         	dentry = user_path_create(newdfd, newname, &path, lookup_flags);
   4118  	error = PTR_ERR(dentry);
   4119  	if (IS_ERR(dentry))
         		goto out_putname;
         
         	error = security_path_symlink(&path, dentry, from->name);
         	if (!error)
   4124  		error = vfs_symlink(path.dentry->d_inode, dentry, from->name);
   4125  	done_path_create(&path, dentry);
         	if (retry_estale(error, lookup_flags)) {
   4127  		lookup_flags |= LOOKUP_REVAL;
         		goto retry;
         	}
         out_putname:
   4131  	putname(from);
   4132  	return error;
   4133  }
         
   4135  SYSCALL_DEFINE3(symlinkat, const char __user *, oldname,
         		int, newdfd, const char __user *, newname)
         {
   4138  	return do_symlinkat(oldname, newdfd, newname);
         }
         
   4141  SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newname)
         {
   4143  	return do_symlinkat(oldname, AT_FDCWD, newname);
         }
         
         /**
          * vfs_link - create a new link
          * @old_dentry:	object to be linked
          * @dir:	new parent
          * @new_dentry:	where to create the new link
          * @delegated_inode: returns inode needing a delegation break
          *
          * The caller must hold dir->i_mutex
          *
          * If vfs_link discovers a delegation on the to-be-linked file in need
          * of breaking, it will return -EWOULDBLOCK and return a reference to the
          * inode in delegated_inode.  The caller should then break the delegation
          * and retry.  Because breaking a delegation may take a long time, the
          * caller should drop the i_mutex before doing so.
          *
          * Alternatively, a caller may pass NULL for delegated_inode.  This may
          * be appropriate for callers that expect the underlying filesystem not
          * to be NFS exported.
          */
         int vfs_link(struct dentry *old_dentry, struct inode *dir, struct dentry *new_dentry, struct inode **delegated_inode)
   4166  {
   4167  	struct inode *inode = old_dentry->d_inode;
   4168  	unsigned max_links = dir->i_sb->s_max_links;
         	int error;
         
   4171  	if (!inode)
         		return -ENOENT;
         
         	error = may_create(dir, new_dentry);
   4175  	if (error)
         		return error;
         
   4178  	if (dir->i_sb != inode->i_sb)
   4179  		return -EXDEV;
         
         	/*
         	 * A link to an append-only or immutable file cannot be created.
         	 */
   4184  	if (IS_APPEND(inode) || IS_IMMUTABLE(inode))
   4185  		return -EPERM;
         	/*
         	 * Updating the link count will likely cause i_uid and i_gid to
         	 * be writen back improperly if their true value is unknown to
         	 * the vfs.
         	 */
         	if (HAS_UNMAPPED_ID(inode))
         		return -EPERM;
   4193  	if (!dir->i_op->link)
         		return -EPERM;
   4195  	if (S_ISDIR(inode->i_mode))
         		return -EPERM;
         
   4198  	error = security_inode_link(old_dentry, dir, new_dentry);
   4199  	if (error)
         		return error;
         
         	inode_lock(inode);
         	/* Make sure we don't allow creating hardlink to an unlinked file */
   4204  	if (inode->i_nlink == 0 && !(inode->i_state & I_LINKABLE))
   4205  		error =  -ENOENT;
   4206  	else if (max_links && inode->i_nlink >= max_links)
   4207  		error = -EMLINK;
         	else {
         		error = try_break_deleg(inode, delegated_inode);
   4210  		if (!error)
   4211  			error = dir->i_op->link(old_dentry, dir, new_dentry);
         	}
         
   4214  	if (!error && (inode->i_state & I_LINKABLE)) {
         		spin_lock(&inode->i_lock);
   4216  		inode->i_state &= ~I_LINKABLE;
         		spin_unlock(&inode->i_lock);
         	}
         	inode_unlock(inode);
         	if (!error)
         		fsnotify_link(dir, inode, new_dentry);
         	return error;
   4223  }
         EXPORT_SYMBOL(vfs_link);
         
         /*
          * Hardlinks are often used in delicate situations.  We avoid
          * security-related surprises by not following symlinks on the
          * newname.  --KAB
          *
          * We don't follow them on the oldname either to be compatible
          * with linux 2.0, and to avoid hard-linking to directories
          * and other special files.  --ADM
          */
         int do_linkat(int olddfd, const char __user *oldname, int newdfd,
         	      const char __user *newname, int flags)
   4237  {
         	struct dentry *new_dentry;
         	struct path old_path, new_path;
   4240  	struct inode *delegated_inode = NULL;
         	int how = 0;
         	int error;
         
   4244  	if ((flags & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH)) != 0)
   4245  		return -EINVAL;
         	/*
         	 * To use null names we require CAP_DAC_READ_SEARCH
         	 * This ensures that not everyone will be able to create
         	 * handlink using the passed filedescriptor.
         	 */
   4251  	if (flags & AT_EMPTY_PATH) {
   4252  		if (!capable(CAP_DAC_READ_SEARCH))
   4253  			return -ENOENT;
   4254  		how = LOOKUP_EMPTY;
         	}
         
         	if (flags & AT_SYMLINK_FOLLOW)
   4258  		how |= LOOKUP_FOLLOW;
         retry:
         	error = user_path_at(olddfd, oldname, how, &old_path);
   4261  	if (error)
         		return error;
         
   4264  	new_dentry = user_path_create(newdfd, newname, &new_path,
         					(how & LOOKUP_REVAL));
         	error = PTR_ERR(new_dentry);
   4267  	if (IS_ERR(new_dentry))
         		goto out;
         
   4270  	error = -EXDEV;
   4271  	if (old_path.mnt != new_path.mnt)
         		goto out_dput;
         	error = may_linkat(&old_path);
         	if (unlikely(error))
         		goto out_dput;
         	error = security_path_link(old_path.dentry, &new_path, new_dentry);
         	if (error)
         		goto out_dput;
   4279  	error = vfs_link(old_path.dentry, new_path.dentry->d_inode, new_dentry, &delegated_inode);
         out_dput:
   4281  	done_path_create(&new_path, new_dentry);
   4282  	if (delegated_inode) {
         		error = break_deleg_wait(&delegated_inode);
   4284  		if (!error) {
         			path_put(&old_path);
         			goto retry;
         		}
         	}
         	if (retry_estale(error, how)) {
         		path_put(&old_path);
   4291  		how |= LOOKUP_REVAL;
   4292  		goto retry;
         	}
         out:
         	path_put(&old_path);
         
   4297  	return error;
   4298  }
         
   4300  SYSCALL_DEFINE5(linkat, int, olddfd, const char __user *, oldname,
         		int, newdfd, const char __user *, newname, int, flags)
         {
   4303  	return do_linkat(olddfd, oldname, newdfd, newname, flags);
         }
         
   4306  SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname)
         {
   4308  	return do_linkat(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
         }
         
         /**
          * vfs_rename - rename a filesystem object
          * @old_dir:	parent of source
          * @old_dentry:	source
          * @new_dir:	parent of destination
          * @new_dentry:	destination
          * @delegated_inode: returns an inode needing a delegation break
          * @flags:	rename flags
          *
          * The caller must hold multiple mutexes--see lock_rename()).
          *
          * If vfs_rename discovers a delegation in need of breaking at either
          * the source or destination, it will return -EWOULDBLOCK and return a
          * reference to the inode in delegated_inode.  The caller should then
          * break the delegation and retry.  Because breaking a delegation may
          * take a long time, the caller should drop all locks before doing
          * so.
          *
          * Alternatively, a caller may pass NULL for delegated_inode.  This may
          * be appropriate for callers that expect the underlying filesystem not
          * to be NFS exported.
          *
          * The worst of all namespace operations - renaming directory. "Perverted"
          * doesn't even start to describe it. Somebody in UCB had a heck of a trip...
          * Problems:
          *
          *	a) we can get into loop creation.
          *	b) race potential - two innocent renames can create a loop together.
          *	   That's where 4.4 screws up. Current fix: serialization on
          *	   sb->s_vfs_rename_mutex. We might be more accurate, but that's another
          *	   story.
          *	c) we have to lock _four_ objects - parents and victim (if it exists),
          *	   and source (if it is not a directory).
          *	   And that - after we got ->i_mutex on parents (until then we don't know
          *	   whether the target exists).  Solution: try to be smart with locking
          *	   order for inodes.  We rely on the fact that tree topology may change
          *	   only under ->s_vfs_rename_mutex _and_ that parent of the object we
          *	   move will be locked.  Thus we can rank directories by the tree
          *	   (ancestors first) and rank all non-directories after them.
          *	   That works since everybody except rename does "lock parent, lookup,
          *	   lock child" and rename is under ->s_vfs_rename_mutex.
          *	   HOWEVER, it relies on the assumption that any object with ->lookup()
          *	   has no more than 1 dentry.  If "hybrid" objects will ever appear,
          *	   we'd better make sure that there's no link(2) for them.
          *	d) conversion from fhandle to dentry may come in the wrong moment - when
          *	   we are removing the target. Solution: we will have to grab ->i_mutex
          *	   in the fhandle_to_dentry code. [FIXME - current nfsfh.c relies on
          *	   ->i_mutex on parents, which works but leads to some truly excessive
          *	   locking].
          */
         int vfs_rename(struct inode *old_dir, struct dentry *old_dentry,
         	       struct inode *new_dir, struct dentry *new_dentry,
         	       struct inode **delegated_inode, unsigned int flags)
   4364  {
         	int error;
         	bool is_dir = d_is_dir(old_dentry);
   4367  	struct inode *source = old_dentry->d_inode;
   4368  	struct inode *target = new_dentry->d_inode;
   4369  	bool new_is_dir = false;
   4370  	unsigned max_links = new_dir->i_sb->s_max_links;
         	struct name_snapshot old_name;
         
   4373  	if (source == target)
   4374  		return 0;
         
   4376  	error = may_delete(old_dir, old_dentry, is_dir);
   4377  	if (error)
         		return error;
         
   4380  	if (!target) {
         		error = may_create(new_dir, new_dentry);
         	} else {
         		new_is_dir = d_is_dir(new_dentry);
         
   4385  		if (!(flags & RENAME_EXCHANGE))
   4386  			error = may_delete(new_dir, new_dentry, is_dir);
         		else
   4388  			error = may_delete(new_dir, new_dentry, new_is_dir);
         	}
   4390  	if (error)
         		return error;
         
   4393  	if (!old_dir->i_op->rename)
   4394  		return -EPERM;
         
         	/*
         	 * If we are going to change the parent - check write permissions,
         	 * we'll need to flip '..'.
         	 */
   4400  	if (new_dir != old_dir) {
   4401  		if (is_dir) {
   4402  			error = inode_permission(source, MAY_WRITE);
   4403  			if (error)
         				return error;
         		}
   4406  		if ((flags & RENAME_EXCHANGE) && new_is_dir) {
   4407  			error = inode_permission(target, MAY_WRITE);
   4408  			if (error)
         				return error;
         		}
         	}
         
   4413  	error = security_inode_rename(old_dir, old_dentry, new_dir, new_dentry,
         				      flags);
   4415  	if (error)
         		return error;
         
   4418  	take_dentry_name_snapshot(&old_name, old_dentry);
         	dget(new_dentry);
   4420  	if (!is_dir || (flags & RENAME_EXCHANGE))
   4421  		lock_two_nondirectories(source, target);
   4422  	else if (target)
         		inode_lock(target);
         
   4425  	error = -EBUSY;
   4426  	if (is_local_mountpoint(old_dentry) || is_local_mountpoint(new_dentry))
         		goto out;
         
   4429  	if (max_links && new_dir != old_dir) {
   4430  		error = -EMLINK;
   4431  		if (is_dir && !new_is_dir && new_dir->i_nlink >= max_links)
         			goto out;
   4433  		if ((flags & RENAME_EXCHANGE) && !is_dir && new_is_dir &&
         		    old_dir->i_nlink >= max_links)
         			goto out;
         	}
   4437  	if (is_dir && !(flags & RENAME_EXCHANGE) && target)
   4438  		shrink_dcache_parent(new_dentry);
         	if (!is_dir) {
         		error = try_break_deleg(source, delegated_inode);
   4441  		if (error)
         			goto out;
         	}
   4444  	if (target && !new_is_dir) {
         		error = try_break_deleg(target, delegated_inode);
   4446  		if (error)
         			goto out;
         	}
   4449  	error = old_dir->i_op->rename(old_dir, old_dentry,
         				       new_dir, new_dentry, flags);
   4451  	if (error)
         		goto out;
         
   4454  	if (!(flags & RENAME_EXCHANGE) && target) {
   4455  		if (is_dir)
   4456  			target->i_flags |= S_DEAD;
         		dont_mount(new_dentry);
         		detach_mounts(new_dentry);
         	}
   4460  	if (!(old_dir->i_sb->s_type->fs_flags & FS_RENAME_DOES_D_MOVE)) {
         		if (!(flags & RENAME_EXCHANGE))
   4462  			d_move(old_dentry, new_dentry);
         		else
   4464  			d_exchange(old_dentry, new_dentry);
         	}
         out:
   4467  	if (!is_dir || (flags & RENAME_EXCHANGE))
   4468  		unlock_two_nondirectories(source, target);
   4469  	else if (target)
         		inode_unlock(target);
   4471  	dput(new_dentry);
         	if (!error) {
   4473  		fsnotify_move(old_dir, new_dir, old_name.name, is_dir,
   4474  			      !(flags & RENAME_EXCHANGE) ? target : NULL, old_dentry);
   4475  		if (flags & RENAME_EXCHANGE) {
   4476  			fsnotify_move(new_dir, old_dir, old_dentry->d_name.name,
         				      new_is_dir, NULL, new_dentry);
         		}
         	}
   4480  	release_dentry_name_snapshot(&old_name);
         
   4482  	return error;
   4483  }
         EXPORT_SYMBOL(vfs_rename);
         
         static int do_renameat2(int olddfd, const char __user *oldname, int newdfd,
         			const char __user *newname, unsigned int flags)
   4488  {
         	struct dentry *old_dentry, *new_dentry;
         	struct dentry *trap;
         	struct path old_path, new_path;
         	struct qstr old_last, new_last;
         	int old_type, new_type;
   4494  	struct inode *delegated_inode = NULL;
         	struct filename *from;
         	struct filename *to;
   4497  	unsigned int lookup_flags = 0, target_flags = LOOKUP_RENAME_TARGET;
         	bool should_retry = false;
         	int error;
         
   4501  	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
   4502  		return -EINVAL;
         
   4504  	if ((flags & (RENAME_NOREPLACE | RENAME_WHITEOUT)) &&
         	    (flags & RENAME_EXCHANGE))
         		return -EINVAL;
         
   4508  	if ((flags & RENAME_WHITEOUT) && !capable(CAP_MKNOD))
   4509  		return -EPERM;
         
   4511  	if (flags & RENAME_EXCHANGE)
         		target_flags = 0;
         
   4514  retry:
   4515  	from = filename_parentat(olddfd, getname(oldname), lookup_flags,
         				&old_path, &old_last, &old_type);
   4517  	if (IS_ERR(from)) {
   4518  		error = PTR_ERR(from);
   4519  		goto exit;
         	}
         
   4522  	to = filename_parentat(newdfd, getname(newname), lookup_flags,
         				&new_path, &new_last, &new_type);
   4524  	if (IS_ERR(to)) {
   4525  		error = PTR_ERR(to);
         		goto exit1;
         	}
         
   4529  	error = -EXDEV;
   4530  	if (old_path.mnt != new_path.mnt)
         		goto exit2;
         
   4533  	error = -EBUSY;
   4534  	if (old_type != LAST_NORM)
         		goto exit2;
         
   4537  	if (flags & RENAME_NOREPLACE)
   4538  		error = -EEXIST;
   4539  	if (new_type != LAST_NORM)
         		goto exit2;
         
   4542  	error = mnt_want_write(old_path.mnt);
   4543  	if (error)
         		goto exit2;
         
         retry_deleg:
   4547  	trap = lock_rename(new_path.dentry, old_path.dentry);
         
   4549  	old_dentry = __lookup_hash(&old_last, old_path.dentry, lookup_flags);
   4550  	error = PTR_ERR(old_dentry);
   4551  	if (IS_ERR(old_dentry))
         		goto exit3;
         	/* source must exist */
   4554  	error = -ENOENT;
   4555  	if (d_is_negative(old_dentry))
         		goto exit4;
   4557  	new_dentry = __lookup_hash(&new_last, new_path.dentry, lookup_flags | target_flags);
   4558  	error = PTR_ERR(new_dentry);
   4559  	if (IS_ERR(new_dentry))
         		goto exit4;
   4561  	error = -EEXIST;
   4562  	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry))
         		goto exit5;
   4564  	if (flags & RENAME_EXCHANGE) {
   4565  		error = -ENOENT;
   4566  		if (d_is_negative(new_dentry))
         			goto exit5;
         
         		if (!d_is_dir(new_dentry)) {
         			error = -ENOTDIR;
   4571  			if (new_last.name[new_last.len])
         				goto exit5;
         		}
         	}
         	/* unless the source is a directory trailing slashes give -ENOTDIR */
         	if (!d_is_dir(old_dentry)) {
   4577  		error = -ENOTDIR;
   4578  		if (old_last.name[old_last.len])
         			goto exit5;
   4580  		if (!(flags & RENAME_EXCHANGE) && new_last.name[new_last.len])
         			goto exit5;
         	}
         	/* source should not be ancestor of target */
   4584  	error = -EINVAL;
   4585  	if (old_dentry == trap)
         		goto exit5;
         	/* target should not be an ancestor of source */
         	if (!(flags & RENAME_EXCHANGE))
   4589  		error = -ENOTEMPTY;
   4590  	if (new_dentry == trap)
         		goto exit5;
         
         	error = security_path_rename(&old_path, old_dentry,
         				     &new_path, new_dentry, flags);
         	if (error)
         		goto exit5;
   4597  	error = vfs_rename(old_path.dentry->d_inode, old_dentry,
         			   new_path.dentry->d_inode, new_dentry,
         			   &delegated_inode, flags);
         exit5:
   4601  	dput(new_dentry);
         exit4:
   4603  	dput(old_dentry);
         exit3:
   4605  	unlock_rename(new_path.dentry, old_path.dentry);
   4606  	if (delegated_inode) {
         		error = break_deleg_wait(&delegated_inode);
   4608  		if (!error)
         			goto retry_deleg;
         	}
   4611  	mnt_drop_write(old_path.mnt);
         exit2:
         	if (retry_estale(error, lookup_flags))
         		should_retry = true;
         	path_put(&new_path);
   4616  	putname(to);
         exit1:
         	path_put(&old_path);
   4619  	putname(from);
   4620  	if (should_retry) {
         		should_retry = false;
   4622  		lookup_flags |= LOOKUP_REVAL;
         		goto retry;
         	}
         exit:
         	return error;
   4627  }
         
   4629  SYSCALL_DEFINE5(renameat2, int, olddfd, const char __user *, oldname,
         		int, newdfd, const char __user *, newname, unsigned int, flags)
         {
   4632  	return do_renameat2(olddfd, oldname, newdfd, newname, flags);
         }
         
   4635  SYSCALL_DEFINE4(renameat, int, olddfd, const char __user *, oldname,
         		int, newdfd, const char __user *, newname)
         {
   4638  	return do_renameat2(olddfd, oldname, newdfd, newname, 0);
         }
         
   4641  SYSCALL_DEFINE2(rename, const char __user *, oldname, const char __user *, newname)
         {
   4643  	return do_renameat2(AT_FDCWD, oldname, AT_FDCWD, newname, 0);
         }
         
         int vfs_whiteout(struct inode *dir, struct dentry *dentry)
   4647  {
         	int error = may_create(dir, dentry);
   4649  	if (error)
         		return error;
         
   4652  	if (!dir->i_op->mknod)
   4653  		return -EPERM;
         
   4655  	return dir->i_op->mknod(dir, dentry,
         				S_IFCHR | WHITEOUT_MODE, WHITEOUT_DEV);
   4657  }
         EXPORT_SYMBOL(vfs_whiteout);
         
         int readlink_copy(char __user *buffer, int buflen, const char *link)
   4661  {
   4662  	int len = PTR_ERR(link);
   4663  	if (IS_ERR(link))
         		goto out;
         
   4666  	len = strlen(link);
         	if (len > (unsigned) buflen)
         		len = buflen;
   4669  	if (copy_to_user(buffer, link, len))
   4670  		len = -EFAULT;
         out:
         	return len;
   4673  }
         
         /*
          * A helper for ->readlink().  This should be used *ONLY* for symlinks that
          * have ->get_link() not calling nd_jump_link().  Using (or not using) it
          * for any given inode is up to filesystem.
          */
         static int generic_readlink(struct dentry *dentry, char __user *buffer,
         			    int buflen)
         {
   4683  	DEFINE_DELAYED_CALL(done);
         	struct inode *inode = d_inode(dentry);
   4685  	const char *link = inode->i_link;
         	int res;
         
   4688  	if (!link) {
   4689  		link = inode->i_op->get_link(dentry, inode, &done);
   4690  		if (IS_ERR(link))
   4691  			return PTR_ERR(link);
         	}
   4693  	res = readlink_copy(buffer, buflen, link);
         	do_delayed_call(&done);
         	return res;
         }
         
         /**
          * vfs_readlink - copy symlink body into userspace buffer
          * @dentry: dentry on which to get symbolic link
          * @buffer: user memory pointer
          * @buflen: size of buffer
          *
          * Does not touch atime.  That's up to the caller if necessary
          *
          * Does not call security hook.
          */
         int vfs_readlink(struct dentry *dentry, char __user *buffer, int buflen)
   4709  {
   4710  	struct inode *inode = d_inode(dentry);
         
   4712  	if (unlikely(!(inode->i_opflags & IOP_DEFAULT_READLINK))) {
   4713  		if (unlikely(inode->i_op->readlink))
   4714  			return inode->i_op->readlink(dentry, buffer, buflen);
         
   4716  		if (!d_is_symlink(dentry))
   4717  			return -EINVAL;
         
         		spin_lock(&inode->i_lock);
   4720  		inode->i_opflags |= IOP_DEFAULT_READLINK;
         		spin_unlock(&inode->i_lock);
         	}
         
         	return generic_readlink(dentry, buffer, buflen);
   4725  }
         EXPORT_SYMBOL(vfs_readlink);
         
         /**
          * vfs_get_link - get symlink body
          * @dentry: dentry on which to get symbolic link
          * @done: caller needs to free returned data with this
          *
          * Calls security hook and i_op->get_link() on the supplied inode.
          *
          * It does not touch atime.  That's up to the caller if necessary.
          *
          * Does not work on "special" symlinks like /proc/$$/fd/N
          */
         const char *vfs_get_link(struct dentry *dentry, struct delayed_call *done)
   4740  {
         	const char *res = ERR_PTR(-EINVAL);
   4742  	struct inode *inode = d_inode(dentry);
         
   4744  	if (d_is_symlink(dentry)) {
   4745  		res = ERR_PTR(security_inode_readlink(dentry));
   4746  		if (!res)
   4747  			res = inode->i_op->get_link(dentry, inode, done);
         	}
         	return res;
   4750  }
         EXPORT_SYMBOL(vfs_get_link);
         
         /* get the link contents into pagecache */
         const char *page_get_link(struct dentry *dentry, struct inode *inode,
         			  struct delayed_call *callback)
   4756  {
         	char *kaddr;
         	struct page *page;
   4759  	struct address_space *mapping = inode->i_mapping;
         
   4761  	if (!dentry) {
         		page = find_get_page(mapping, 0);
   4763  		if (!page)
         			return ERR_PTR(-ECHILD);
         		if (!PageUptodate(page)) {
         			put_page(page);
   4767  			return ERR_PTR(-ECHILD);
         		}
         	} else {
         		page = read_mapping_page(mapping, 0, NULL);
   4771  		if (IS_ERR(page))
         			return (char*)page;
         	}
         	set_delayed_call(callback, page_put_link, page);
   4775  	BUG_ON(mapping_gfp_mask(mapping) & __GFP_HIGHMEM);
         	kaddr = page_address(page);
         	nd_terminate_link(kaddr, inode->i_size, PAGE_SIZE - 1);
         	return kaddr;
   4779  }
         
         EXPORT_SYMBOL(page_get_link);
         
         void page_put_link(void *arg)
   4784  {
         	put_page(arg);
   4786  }
         EXPORT_SYMBOL(page_put_link);
         
         int page_readlink(struct dentry *dentry, char __user *buffer, int buflen)
   4790  {
   4791  	DEFINE_DELAYED_CALL(done);
   4792  	int res = readlink_copy(buffer, buflen,
         				page_get_link(dentry, d_inode(dentry),
         					      &done));
         	do_delayed_call(&done);
         	return res;
   4797  }
         EXPORT_SYMBOL(page_readlink);
         
         /*
          * The nofs argument instructs pagecache_write_begin to pass AOP_FLAG_NOFS
          */
         int __page_symlink(struct inode *inode, const char *symname, int len, int nofs)
   4804  {
   4805  	struct address_space *mapping = inode->i_mapping;
         	struct page *page;
         	void *fsdata;
         	int err;
   4809  	unsigned int flags = 0;
         	if (nofs)
         		flags |= AOP_FLAG_NOFS;
         
         retry:
   4814  	err = pagecache_write_begin(NULL, mapping, 0, len-1,
         				flags, &page, &fsdata);
   4816  	if (err)
         		goto fail;
         
   4819  	memcpy(page_address(page), symname, len-1);
         
   4821  	err = pagecache_write_end(NULL, mapping, 0, len-1, len-1,
         							page, fsdata);
   4823  	if (err < 0)
         		goto fail;
   4825  	if (err < len-1)
         		goto retry;
         
         	mark_inode_dirty(inode);
   4829  	return 0;
         fail:
         	return err;
   4832  }
         EXPORT_SYMBOL(__page_symlink);
         
         int page_symlink(struct inode *inode, const char *symname, int len)
   4836  {
   4837  	return __page_symlink(inode, symname, len,
         			!mapping_gfp_constraint(inode->i_mapping, __GFP_FS));
         }
         EXPORT_SYMBOL(page_symlink);
