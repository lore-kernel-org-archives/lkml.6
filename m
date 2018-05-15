Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbeEONtQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 09:49:16 -0400
Received: from verein.lst.de ([213.95.11.211]:42016 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752038AbeEONtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 09:49:15 -0400
Date: Tue, 15 May 2018 15:53:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Howells <dhowells@redhat.com>
Cc: hch@lst.de, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] afs: Implement namespacing
Message-ID: <20180515135333.GA31296@lst.de>
References: <152513042072.13808.9692322366778075206.stgit@warthog.procyon.org.uk> <152513043985.13808.14819147732435024607.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152513043985.13808.14819147732435024607.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So the real question here is why afs needs a write callback as the first
user of /proc/net ever in a day and time were we've deprecated adding
new proc files.  This is a discussion that should be had with linux-fsdevel
and netdev in Cc.

On Tue, May 01, 2018 at 12:20:39AM +0100, David Howells wrote:
> Implement namespacing within AFS, but don't yet let mounts occur outside
> the init namespace.  An additional patch will be required propagate the
> network namespace across automounts.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  fs/afs/cell.c       |    4 
>  fs/afs/cmservice.c  |    2 
>  fs/afs/internal.h   |   43 +++--
>  fs/afs/main.c       |   33 +++-
>  fs/afs/netdevices.c |    6 -
>  fs/afs/proc.c       |  414 +++++++++++++--------------------------------------
>  fs/afs/rxrpc.c      |    2 
>  fs/afs/super.c      |   20 +-
>  8 files changed, 176 insertions(+), 348 deletions(-)
> 
> diff --git a/fs/afs/cell.c b/fs/afs/cell.c
> index fdf4c36cff79..a98a8a3d5544 100644
> --- a/fs/afs/cell.c
> +++ b/fs/afs/cell.c
> @@ -528,7 +528,7 @@ static int afs_activate_cell(struct afs_net *net, struct afs_cell *cell)
>  					     NULL, 0,
>  					     cell, 0, true);
>  #endif
> -	ret = afs_proc_cell_setup(net, cell);
> +	ret = afs_proc_cell_setup(cell);
>  	if (ret < 0)
>  		return ret;
>  	spin_lock(&net->proc_cells_lock);
> @@ -544,7 +544,7 @@ static void afs_deactivate_cell(struct afs_net *net, struct afs_cell *cell)
>  {
>  	_enter("%s", cell->name);
>  
> -	afs_proc_cell_remove(net, cell);
> +	afs_proc_cell_remove(cell);
>  
>  	spin_lock(&net->proc_cells_lock);
>  	list_del_init(&cell->proc_link);
> diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
> index 357de908df3a..4c89b1f4c02b 100644
> --- a/fs/afs/cmservice.c
> +++ b/fs/afs/cmservice.c
> @@ -550,7 +550,7 @@ static void SRXAFSCB_TellMeAboutYourself(struct work_struct *work)
>  	nifs = 0;
>  	ifs = kcalloc(32, sizeof(*ifs), GFP_KERNEL);
>  	if (ifs) {
> -		nifs = afs_get_ipv4_interfaces(ifs, 32, false);
> +		nifs = afs_get_ipv4_interfaces(call->net, ifs, 32, false);
>  		if (nifs < 0) {
>  			kfree(ifs);
>  			ifs = NULL;
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index f8086ec95e24..58f4de6390d0 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -22,6 +22,8 @@
>  #include <linux/backing-dev.h>
>  #include <linux/uuid.h>
>  #include <net/net_namespace.h>
> +#include <net/netns/generic.h>
> +#include <net/sock.h>
>  #include <net/af_rxrpc.h>
>  
>  #include "afs.h"
> @@ -40,7 +42,8 @@ struct afs_mount_params {
>  	afs_voltype_t		type;		/* type of volume requested */
>  	int			volnamesz;	/* size of volume name */
>  	const char		*volname;	/* name of volume to mount */
> -	struct afs_net		*net;		/* Network namespace in effect */
> +	struct net		*net_ns;	/* Network namespace in effect */
> +	struct afs_net		*net;		/* the AFS net namespace stuff */
>  	struct afs_cell		*cell;		/* cell in which to find volume */
>  	struct afs_volume	*volume;	/* volume record */
>  	struct key		*key;		/* key to use for secure mounting */
> @@ -189,7 +192,7 @@ struct afs_read {
>   * - there's one superblock per volume
>   */
>  struct afs_super_info {
> -	struct afs_net		*net;		/* Network namespace */
> +	struct net		*net_ns;	/* Network namespace */
>  	struct afs_cell		*cell;		/* The cell in which the volume resides */
>  	struct afs_volume	*volume;	/* volume record */
>  	bool			dyn_root;	/* True if dynamic root */
> @@ -210,7 +213,6 @@ struct afs_sysnames {
>  	char			*subs[AFS_NR_SYSNAME];
>  	refcount_t		usage;
>  	unsigned short		nr;
> -	short			error;
>  	char			blank[1];
>  };
>  
> @@ -218,6 +220,7 @@ struct afs_sysnames {
>   * AFS network namespace record.
>   */
>  struct afs_net {
> +	struct net		*net;		/* Backpointer to the owning net namespace */
>  	struct afs_uuid		uuid;
>  	bool			live;		/* F if this namespace is being removed */
>  
> @@ -280,7 +283,6 @@ struct afs_net {
>  };
>  
>  extern const char afs_init_sysname[];
> -extern struct afs_net __afs_net;// Dummy AFS network namespace; TODO: replace with real netns
>  
>  enum afs_cell_state {
>  	AFS_CELL_UNSET,
> @@ -787,34 +789,36 @@ extern int afs_drop_inode(struct inode *);
>   * main.c
>   */
>  extern struct workqueue_struct *afs_wq;
> +extern int afs_net_id;
>  
> -static inline struct afs_net *afs_d2net(struct dentry *dentry)
> +static inline struct afs_net *afs_net(struct net *net)
>  {
> -	return &__afs_net;
> +	return net_generic(net, afs_net_id);
>  }
>  
> -static inline struct afs_net *afs_i2net(struct inode *inode)
> +static inline struct afs_net *afs_sb2net(struct super_block *sb)
>  {
> -	return &__afs_net;
> +	return afs_net(AFS_FS_S(sb)->net_ns);
>  }
>  
> -static inline struct afs_net *afs_v2net(struct afs_vnode *vnode)
> +static inline struct afs_net *afs_d2net(struct dentry *dentry)
>  {
> -	return &__afs_net;
> +	return afs_sb2net(dentry->d_sb);
>  }
>  
> -static inline struct afs_net *afs_sock2net(struct sock *sk)
> +static inline struct afs_net *afs_i2net(struct inode *inode)
>  {
> -	return &__afs_net;
> +	return afs_sb2net(inode->i_sb);
>  }
>  
> -static inline struct afs_net *afs_get_net(struct afs_net *net)
> +static inline struct afs_net *afs_v2net(struct afs_vnode *vnode)
>  {
> -	return net;
> +	return afs_i2net(&vnode->vfs_inode);
>  }
>  
> -static inline void afs_put_net(struct afs_net *net)
> +static inline struct afs_net *afs_sock2net(struct sock *sk)
>  {
> +	return net_generic(sock_net(sk), afs_net_id);
>  }
>  
>  static inline void __afs_stat(atomic_t *s)
> @@ -842,15 +846,16 @@ extern void afs_mntpt_kill_timer(void);
>  /*
>   * netdevices.c
>   */
> -extern int afs_get_ipv4_interfaces(struct afs_interface *, size_t, bool);
> +extern int afs_get_ipv4_interfaces(struct afs_net *, struct afs_interface *,
> +				   size_t, bool);
>  
>  /*
>   * proc.c
>   */
>  extern int __net_init afs_proc_init(struct afs_net *);
>  extern void __net_exit afs_proc_cleanup(struct afs_net *);
> -extern int afs_proc_cell_setup(struct afs_net *, struct afs_cell *);
> -extern void afs_proc_cell_remove(struct afs_net *, struct afs_cell *);
> +extern int afs_proc_cell_setup(struct afs_cell *);
> +extern void afs_proc_cell_remove(struct afs_cell *);
>  extern void afs_put_sysnames(struct afs_sysnames *);
>  
>  /*
> @@ -983,7 +988,7 @@ extern bool afs_annotate_server_list(struct afs_server_list *, struct afs_server
>   * super.c
>   */
>  extern int __init afs_fs_init(void);
> -extern void __exit afs_fs_exit(void);
> +extern void afs_fs_exit(void);
>  
>  /*
>   * vlclient.c
> diff --git a/fs/afs/main.c b/fs/afs/main.c
> index d7560168b3bf..7d2c1354e2ca 100644
> --- a/fs/afs/main.c
> +++ b/fs/afs/main.c
> @@ -15,6 +15,7 @@
>  #include <linux/completion.h>
>  #include <linux/sched.h>
>  #include <linux/random.h>
> +#include <linux/proc_fs.h>
>  #define CREATE_TRACE_POINTS
>  #include "internal.h"
>  
> @@ -32,7 +33,7 @@ module_param(rootcell, charp, 0);
>  MODULE_PARM_DESC(rootcell, "root AFS cell name and VL server IP addr list");
>  
>  struct workqueue_struct *afs_wq;
> -struct afs_net __afs_net;
> +static struct proc_dir_entry *afs_proc_symlink;
>  
>  #if defined(CONFIG_ALPHA)
>  const char afs_init_sysname[] = "alpha_linux26";
> @@ -67,11 +68,13 @@ const char afs_init_sysname[] = "unknown_linux26";
>  /*
>   * Initialise an AFS network namespace record.
>   */
> -static int __net_init afs_net_init(struct afs_net *net)
> +static int __net_init afs_net_init(struct net *net_ns)
>  {
>  	struct afs_sysnames *sysnames;
> +	struct afs_net *net = afs_net(net_ns);
>  	int ret;
>  
> +	net->net = net_ns;
>  	net->live = true;
>  	generate_random_uuid((unsigned char *)&net->uuid);
>  
> @@ -142,8 +145,10 @@ static int __net_init afs_net_init(struct afs_net *net)
>  /*
>   * Clean up and destroy an AFS network namespace record.
>   */
> -static void __net_exit afs_net_exit(struct afs_net *net)
> +static void __net_exit afs_net_exit(struct net *net_ns)
>  {
> +	struct afs_net *net = afs_net(net_ns);
> +
>  	net->live = false;
>  	afs_cell_purge(net);
>  	afs_purge_servers(net);
> @@ -152,6 +157,13 @@ static void __net_exit afs_net_exit(struct afs_net *net)
>  	afs_put_sysnames(net->sysnames);
>  }
>  
> +static struct pernet_operations afs_net_ops = {
> +	.init	= afs_net_init,
> +	.exit	= afs_net_exit,
> +	.id	= &afs_net_id,
> +	.size	= sizeof(struct afs_net),
> +};
> +
>  /*
>   * initialise the AFS client FS module
>   */
> @@ -178,7 +190,7 @@ static int __init afs_init(void)
>  		goto error_cache;
>  #endif
>  
> -	ret = afs_net_init(&__afs_net);
> +	ret = register_pernet_subsys(&afs_net_ops);
>  	if (ret < 0)
>  		goto error_net;
>  
> @@ -187,10 +199,18 @@ static int __init afs_init(void)
>  	if (ret < 0)
>  		goto error_fs;
>  
> +	afs_proc_symlink = proc_symlink("fs/afs", NULL, "../self/net/afs");
> +	if (IS_ERR(afs_proc_symlink)) {
> +		ret = PTR_ERR(afs_proc_symlink);
> +		goto error_proc;
> +	}
> +
>  	return ret;
>  
> +error_proc:
> +	afs_fs_exit();
>  error_fs:
> -	afs_net_exit(&__afs_net);
> +	unregister_pernet_subsys(&afs_net_ops);
>  error_net:
>  #ifdef CONFIG_AFS_FSCACHE
>  	fscache_unregister_netfs(&afs_cache_netfs);
> @@ -219,8 +239,9 @@ static void __exit afs_exit(void)
>  {
>  	printk(KERN_INFO "kAFS: Red Hat AFS client v0.1 unregistering.\n");
>  
> +	proc_remove(afs_proc_symlink);
>  	afs_fs_exit();
> -	afs_net_exit(&__afs_net);
> +	unregister_pernet_subsys(&afs_net_ops);
>  #ifdef CONFIG_AFS_FSCACHE
>  	fscache_unregister_netfs(&afs_cache_netfs);
>  #endif
> diff --git a/fs/afs/netdevices.c b/fs/afs/netdevices.c
> index 50bd5bb1c4fb..2a009d1939d7 100644
> --- a/fs/afs/netdevices.c
> +++ b/fs/afs/netdevices.c
> @@ -17,8 +17,8 @@
>   * - maxbufs must be at least 1
>   * - returns the number of interface records in the buffer
>   */
> -int afs_get_ipv4_interfaces(struct afs_interface *bufs, size_t maxbufs,
> -			    bool wantloopback)
> +int afs_get_ipv4_interfaces(struct afs_net *net, struct afs_interface *bufs,
> +			    size_t maxbufs, bool wantloopback)
>  {
>  	struct net_device *dev;
>  	struct in_device *idev;
> @@ -27,7 +27,7 @@ int afs_get_ipv4_interfaces(struct afs_interface *bufs, size_t maxbufs,
>  	ASSERT(maxbufs > 0);
>  
>  	rtnl_lock();
> -	for_each_netdev(&init_net, dev) {
> +	for_each_netdev(net->net, dev) {
>  		if (dev->type == ARPHRD_LOOPBACK && !wantloopback)
>  			continue;
>  		idev = __in_dev_get_rtnl(dev);
> diff --git a/fs/afs/proc.c b/fs/afs/proc.c
> index 363383e9961f..9f748687d2c2 100644
> --- a/fs/afs/proc.c
> +++ b/fs/afs/proc.c
> @@ -17,14 +17,14 @@
>  #include <linux/uaccess.h>
>  #include "internal.h"
>  
> -static inline struct afs_net *afs_proc2net(struct file *f)
> +static inline struct afs_net *afs_seq2net(struct seq_file *m)
>  {
> -	return &__afs_net;
> +	return afs_net(seq_file_net(m));
>  }
>  
> -static inline struct afs_net *afs_seq2net(struct seq_file *m)
> +static inline struct afs_net *afs_seq2net_single(struct seq_file *m)
>  {
> -	return &__afs_net; // TODO: use seq_file_net(m)
> +	return afs_net(seq_file_single_net(m));
>  }
>  
>  /*
> @@ -75,28 +75,20 @@ static const struct seq_operations afs_proc_cells_ops = {
>   * handle writes to /proc/fs/afs/cells
>   * - to add cells: echo "add <cellname> <IP>[:<IP>][:<IP>]"
>   */
> -static ssize_t afs_proc_cells_write(struct file *file, const char __user *buf,
> -				    size_t size, loff_t *_pos)
> +static int afs_proc_cells_write(struct file *file, char *buf, size_t size)
>  {
> -	struct afs_net *net = afs_proc2net(file);
> -	char *kbuf, *name, *args;
> +	struct seq_file *m = file->private_data;
> +	struct afs_net *net = afs_seq2net(m);
> +	char *name, *args;
>  	int ret;
>  
> -	/* start by dragging the command into memory */
> -	if (size <= 1 || size >= PAGE_SIZE)
> -		return -EINVAL;
> -
> -	kbuf = memdup_user_nul(buf, size);
> -	if (IS_ERR(kbuf))
> -		return PTR_ERR(kbuf);
> -
>  	/* trim to first NL */
> -	name = memchr(kbuf, '\n', size);
> +	name = memchr(buf, '\n', size);
>  	if (name)
>  		*name = 0;
>  
>  	/* split into command, name and argslist */
> -	name = strchr(kbuf, ' ');
> +	name = strchr(buf, ' ');
>  	if (!name)
>  		goto inval;
>  	do {
> @@ -115,9 +107,9 @@ static ssize_t afs_proc_cells_write(struct file *file, const char __user *buf,
>  		goto inval;
>  
>  	/* determine command to perform */
> -	_debug("cmd=%s name=%s args=%s", kbuf, name, args);
> +	_debug("cmd=%s name=%s args=%s", buf, name, args);
>  
> -	if (strcmp(kbuf, "add") == 0) {
> +	if (strcmp(buf, "add") == 0) {
>  		struct afs_cell *cell;
>  
>  		cell = afs_lookup_cell(net, name, strlen(name), args, true);
> @@ -133,10 +125,9 @@ static ssize_t afs_proc_cells_write(struct file *file, const char __user *buf,
>  		goto inval;
>  	}
>  
> -	ret = size;
> +	ret = 0;
>  
>  done:
> -	kfree(kbuf);
>  	_leave(" = %d", ret);
>  	return ret;
>  
> @@ -146,68 +137,23 @@ static ssize_t afs_proc_cells_write(struct file *file, const char __user *buf,
>  	goto done;
>  }
>  
> -static int afs_proc_cells_open(struct inode *inode, struct file *file)
> -{
> -	struct seq_file *m;
> -	int ret;
> -
> -	ret = seq_open(file, &afs_proc_cells_ops);
> -	if (ret < 0)
> -		return ret;
> -
> -	m = file->private_data;
> -	m->private = PDE_DATA(inode);
> -	return 0;
> -}
> -
> -static const struct file_operations afs_proc_cells_fops = {
> -	.open		= afs_proc_cells_open,
> -	.read		= seq_read,
> -	.write		= afs_proc_cells_write,
> -	.llseek		= seq_lseek,
> -	.release	= seq_release,
> -};
> -
>  /*
> - * Read the name of the current workstation cell.
> + * Display the name of the current workstation cell.
>   */
> -static ssize_t afs_proc_rootcell_read(struct file *file, char __user *buf,
> -				      size_t size, loff_t *_pos)
> +static int afs_proc_rootcell_show(struct seq_file *m, void *v)
>  {
>  	struct afs_cell *cell;
> -	struct afs_net *net = afs_proc2net(file);
> -	unsigned int seq = 0;
> -	char name[AFS_MAXCELLNAME + 1];
> -	int len;
> -
> -	if (*_pos > 0)
> -		return 0;
> -	if (!net->ws_cell)
> -		return 0;
> -
> -	rcu_read_lock();
> -	do {
> -		read_seqbegin_or_lock(&net->cells_lock, &seq);
> -		len = 0;
> -		cell = rcu_dereference_raw(net->ws_cell);
> -		if (cell) {
> -			len = cell->name_len;
> -			memcpy(name, cell->name, len);
> -		}
> -	} while (need_seqretry(&net->cells_lock, seq));
> -	done_seqretry(&net->cells_lock, seq);
> -	rcu_read_unlock();
> -
> -	if (!len)
> -		return 0;
> -
> -	name[len++] = '\n';
> -	if (len > size)
> -		len = size;
> -	if (copy_to_user(buf, name, len) != 0)
> -		return -EFAULT;
> -	*_pos = 1;
> -	return len;
> +	struct afs_net *net;
> +
> +	net = afs_seq2net_single(m);
> +	if (net->ws_cell) {
> +		rcu_read_lock();
> +		cell = rcu_dereference(net->ws_cell);
> +		if (cell)
> +			seq_printf(m, "%s\n", cell->name);
> +		rcu_read_unlock();
> +	}
> +	return 0;
>  }
>  
>  /*
> @@ -216,52 +162,34 @@ static ssize_t afs_proc_rootcell_read(struct file *file, char __user *buf,
>   *
>   *	echo "cell.name:192.168.231.14" >/proc/fs/afs/rootcell
>   */
> -static ssize_t afs_proc_rootcell_write(struct file *file,
> -				       const char __user *buf,
> -				       size_t size, loff_t *_pos)
> +static int afs_proc_rootcell_write(struct file *file, char *buf, size_t size)
>  {
> -	struct afs_net *net = afs_proc2net(file);
> -	char *kbuf, *s;
> +	struct seq_file *m = file->private_data;
> +	struct afs_net *net = afs_seq2net_single(m);
> +	char *s;
>  	int ret;
>  
> -	/* start by dragging the command into memory */
> -	if (size <= 1 || size >= PAGE_SIZE)
> -		return -EINVAL;
> -
> -	kbuf = memdup_user_nul(buf, size);
> -	if (IS_ERR(kbuf))
> -		return PTR_ERR(kbuf);
> -
>  	ret = -EINVAL;
> -	if (kbuf[0] == '.')
> +	if (buf[0] == '.')
>  		goto out;
> -	if (memchr(kbuf, '/', size))
> +	if (memchr(buf, '/', size))
>  		goto out;
>  
>  	/* trim to first NL */
> -	s = memchr(kbuf, '\n', size);
> +	s = memchr(buf, '\n', size);
>  	if (s)
>  		*s = 0;
>  
>  	/* determine command to perform */
> -	_debug("rootcell=%s", kbuf);
> +	_debug("rootcell=%s", buf);
>  
> -	ret = afs_cell_init(net, kbuf);
> -	if (ret >= 0)
> -		ret = size;	/* consume everything, always */
> +	ret = afs_cell_init(net, buf);
>  
>  out:
> -	kfree(kbuf);
>  	_leave(" = %d", ret);
>  	return ret;
>  }
>  
> -static const struct file_operations afs_proc_rootcell_fops = {
> -	.read		= afs_proc_rootcell_read,
> -	.write		= afs_proc_rootcell_write,
> -	.llseek		= no_llseek,
> -};
> -
>  static const char afs_vol_types[3][3] = {
>  	[AFSVL_RWVOL]	= "RW",
>  	[AFSVL_ROVOL]	= "RO",
> @@ -273,8 +201,8 @@ static const char afs_vol_types[3][3] = {
>   */
>  static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
>  {
> -	struct afs_cell *cell = m->private;
>  	struct afs_volume *vol = list_entry(v, struct afs_volume, proc_link);
> +	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
>  
>  	/* Display header on line 1 */
>  	if (v == &cell->proc_volumes) {
> @@ -292,24 +220,24 @@ static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
>  static void *afs_proc_cell_volumes_start(struct seq_file *m, loff_t *_pos)
>  	__acquires(cell->proc_lock)
>  {
> -	struct afs_cell *cell = m->private;
> +	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
>  
>  	read_lock(&cell->proc_lock);
>  	return seq_list_start_head(&cell->proc_volumes, *_pos);
>  }
>  
> -static void *afs_proc_cell_volumes_next(struct seq_file *p, void *v,
> +static void *afs_proc_cell_volumes_next(struct seq_file *m, void *v,
>  					loff_t *_pos)
>  {
> -	struct afs_cell *cell = p->private;
> +	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
>  
>  	return seq_list_next(v, &cell->proc_volumes, _pos);
>  }
>  
> -static void afs_proc_cell_volumes_stop(struct seq_file *p, void *v)
> +static void afs_proc_cell_volumes_stop(struct seq_file *m, void *v)
>  	__releases(cell->proc_lock)
>  {
> -	struct afs_cell *cell = p->private;
> +	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
>  
>  	read_unlock(&cell->proc_lock);
>  }
> @@ -321,33 +249,6 @@ static const struct seq_operations afs_proc_cell_volumes_ops = {
>  	.show	= afs_proc_cell_volumes_show,
>  };
>  
> -static int afs_proc_cell_volumes_open(struct inode *inode, struct file *file)
> -{
> -	struct afs_cell *cell;
> -	struct seq_file *m;
> -	int ret;
> -
> -	cell = PDE_DATA(inode);
> -	if (!cell)
> -		return -ENOENT;
> -
> -	ret = seq_open(file, &afs_proc_cell_volumes_ops);
> -	if (ret < 0)
> -		return ret;
> -
> -	m = file->private_data;
> -	m->private = cell;
> -
> -	return 0;
> -}
> -
> -static const struct file_operations afs_proc_cell_volumes_fops = {
> -	.open		= afs_proc_cell_volumes_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= seq_release,
> -};
> -
>  /*
>   * Display the list of Volume Location servers we're using for a cell.
>   */
> @@ -370,7 +271,7 @@ static void *afs_proc_cell_vlservers_start(struct seq_file *m, loff_t *_pos)
>  	__acquires(rcu)
>  {
>  	struct afs_addr_list *alist;
> -	struct afs_cell *cell = m->private;
> +	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
>  	loff_t pos = *_pos;
>  
>  	rcu_read_lock();
> @@ -388,11 +289,11 @@ static void *afs_proc_cell_vlservers_start(struct seq_file *m, loff_t *_pos)
>  	return alist->addrs + pos;
>  }
>  
> -static void *afs_proc_cell_vlservers_next(struct seq_file *p, void *v,
> +static void *afs_proc_cell_vlservers_next(struct seq_file *m, void *v,
>  					  loff_t *_pos)
>  {
>  	struct afs_addr_list *alist;
> -	struct afs_cell *cell = p->private;
> +	struct afs_cell *cell = PDE_DATA(file_inode(m->file));
>  	loff_t pos;
>  
>  	alist = rcu_dereference(cell->vl_addrs);
> @@ -405,7 +306,7 @@ static void *afs_proc_cell_vlservers_next(struct seq_file *p, void *v,
>  	return alist->addrs + pos;
>  }
>  
> -static void afs_proc_cell_vlservers_stop(struct seq_file *p, void *v)
> +static void afs_proc_cell_vlservers_stop(struct seq_file *m, void *v)
>  	__releases(rcu)
>  {
>  	rcu_read_unlock();
> @@ -418,33 +319,6 @@ static const struct seq_operations afs_proc_cell_vlservers_ops = {
>  	.show	= afs_proc_cell_vlservers_show,
>  };
>  
> -static int afs_proc_cell_vlservers_open(struct inode *inode, struct file *file)
> -{
> -	struct afs_cell *cell;
> -	struct seq_file *m;
> -	int ret;
> -
> -	cell = PDE_DATA(inode);
> -	if (!cell)
> -		return -ENOENT;
> -
> -	ret = seq_open(file, &afs_proc_cell_vlservers_ops);
> -	if (ret<0)
> -		return ret;
> -
> -	m = file->private_data;
> -	m->private = cell;
> -
> -	return 0;
> -}
> -
> -static const struct file_operations afs_proc_cell_vlservers_fops = {
> -	.open		= afs_proc_cell_vlservers_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= seq_release,
> -};
> -
>  /*
>   * Display the list of fileservers we're using within a namespace.
>   */
> @@ -479,7 +353,7 @@ static void *afs_proc_servers_next(struct seq_file *m, void *v, loff_t *_pos)
>  	return seq_hlist_next_rcu(v, &afs_seq2net(m)->fs_proc, _pos);
>  }
>  
> -static void afs_proc_servers_stop(struct seq_file *p, void *v)
> +static void afs_proc_servers_stop(struct seq_file *m, void *v)
>  	__releases(rcu)
>  {
>  	rcu_read_unlock();
> @@ -492,18 +366,6 @@ static const struct seq_operations afs_proc_servers_ops = {
>  	.show	= afs_proc_servers_show,
>  };
>  
> -static int afs_proc_servers_open(struct inode *inode, struct file *file)
> -{
> -	return seq_open(file, &afs_proc_servers_ops);
> -}
> -
> -static const struct file_operations afs_proc_servers_fops = {
> -	.open		= afs_proc_servers_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= seq_release,
> -};
> -
>  /*
>   * Display the list of strings that may be substituted for the @sys pathname
>   * macro.
> @@ -523,10 +385,11 @@ static void *afs_proc_sysname_start(struct seq_file *m, loff_t *pos)
>  	__acquires(&net->sysnames_lock)
>  {
>  	struct afs_net *net = afs_seq2net(m);
> -	struct afs_sysnames *names = net->sysnames;
> +	struct afs_sysnames *names;
>  
>  	read_lock(&net->sysnames_lock);
>  
> +	names = net->sysnames;
>  	if (*pos >= names->nr)
>  		return NULL;
>  	return (void *)(unsigned long)(*pos + 1);
> @@ -561,35 +424,21 @@ static const struct seq_operations afs_proc_sysname_ops = {
>  /*
>   * Allow the @sys substitution to be configured.
>   */
> -static ssize_t afs_proc_sysname_write(struct file *file,
> -				      const char __user *buf,
> -				      size_t size, loff_t *_pos)
> +static int afs_proc_sysname_write(struct file *file, char *buf, size_t size)
>  {
> -	struct afs_sysnames *sysnames;
> +	struct afs_sysnames *sysnames, *kill;
>  	struct seq_file *m = file->private_data;
> -	char *kbuf = NULL, *s, *p, *sub;
> +	struct afs_net *net = afs_seq2net(m);
> +	char *s, *p, *sub;
>  	int ret, len;
>  
> -	sysnames = m->private;
> +	sysnames = kzalloc(sizeof(*sysnames), GFP_KERNEL);
>  	if (!sysnames)
> -		return -EINVAL;
> -	if (sysnames->error)
> -		return sysnames->error;
> -
> -	if (size >= PAGE_SIZE - 1) {
> -		sysnames->error = -EINVAL;
> -		return -EINVAL;
> -	}
> -	if (size == 0)
> -		return 0;
> -
> -	kbuf = memdup_user_nul(buf, size);
> -	if (IS_ERR(kbuf))
> -		return PTR_ERR(kbuf);
> -
> -	inode_lock(file_inode(file));
> +		return -ENOMEM;
> +	refcount_set(&sysnames->usage, 1);
> +	kill = sysnames;
>  
> -	p = kbuf;
> +	p = buf;
>  	while ((s = strsep(&p, " \t\n"))) {
>  		len = strlen(s);
>  		if (len == 0)
> @@ -630,16 +479,23 @@ static ssize_t afs_proc_sysname_write(struct file *file,
>  		sysnames->nr++;
>  	}
>  
> -	ret = size;	/* consume everything, always */
> +	if (sysnames->nr == 0) {
> +		sysnames->subs[0] = sysnames->blank;
> +		sysnames->nr++;
> +	}
> +
> +	write_lock(&net->sysnames_lock);
> +	kill = net->sysnames;
> +	net->sysnames = sysnames;
> +	write_unlock(&net->sysnames_lock);
> +	ret = 0;
>  out:
> -	inode_unlock(file_inode(file));
> -	kfree(kbuf);
> +	afs_put_sysnames(kill);
>  	return ret;
>  
>  invalid:
>  	ret = -EINVAL;
>  error:
> -	sysnames->error = ret;
>  	goto out;
>  }
>  
> @@ -655,75 +511,12 @@ void afs_put_sysnames(struct afs_sysnames *sysnames)
>  	}
>  }
>  
> -static int afs_proc_sysname_release(struct inode *inode, struct file *file)
> -{
> -	struct afs_sysnames *sysnames, *kill = NULL;
> -	struct seq_file *m = file->private_data;
> -	struct afs_net *net = afs_seq2net(m);
> -
> -	sysnames = m->private;
> -	if (sysnames) {
> -		if (!sysnames->error) {
> -			kill = sysnames;
> -			if (sysnames->nr == 0) {
> -				sysnames->subs[0] = sysnames->blank;
> -				sysnames->nr++;
> -			}
> -			write_lock(&net->sysnames_lock);
> -			kill = net->sysnames;
> -			net->sysnames = sysnames;
> -			write_unlock(&net->sysnames_lock);
> -		}
> -		afs_put_sysnames(kill);
> -	}
> -
> -	return seq_release(inode, file);
> -}
> -
> -/*
> - * Handle opening of /proc/fs/afs/sysname.  If it is opened for writing, we
> - * assume the caller wants to change the substitution list and we allocate a
> - * buffer to hold the list.
> - */
> -static int afs_proc_sysname_open(struct inode *inode, struct file *file)
> -{
> -	struct afs_sysnames *sysnames;
> -	struct seq_file *m;
> -	int ret;
> -
> -	ret = seq_open(file, &afs_proc_sysname_ops);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (file->f_mode & FMODE_WRITE) {
> -		sysnames = kzalloc(sizeof(*sysnames), GFP_KERNEL);
> -		if (!sysnames) {
> -			seq_release(inode, file);
> -			return -ENOMEM;
> -		}
> -
> -		refcount_set(&sysnames->usage, 1);
> -		m = file->private_data;
> -		m->private = sysnames;
> -	}
> -
> -	return 0;
> -}
> -
> -static const struct file_operations afs_proc_sysname_fops = {
> -	.open		= afs_proc_sysname_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= afs_proc_sysname_release,
> -	.write		= afs_proc_sysname_write,
> -};
> -
>  /*
>   * Display general per-net namespace statistics.
>   */
>  static int afs_proc_stats_show(struct seq_file *m, void *v)
>  {
> -	struct afs_net *net = afs_seq2net(m);
> +	struct afs_net *net = afs_seq2net_single(m);
>  
>  	seq_puts(m, "kAFS statistics\n");
>  
> @@ -749,38 +542,28 @@ static int afs_proc_stats_show(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> -/*
> - * Open "/proc/fs/afs/stats" to allow reading of the stat counters.
> - */
> -static int afs_proc_stats_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, afs_proc_stats_show, NULL);
> -}
> -
> -static const struct file_operations afs_proc_stats_fops = {
> -	.open		= afs_proc_stats_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release        = single_release,
> -};
> -
>  /*
>   * initialise /proc/fs/afs/<cell>/
>   */
> -int afs_proc_cell_setup(struct afs_net *net, struct afs_cell *cell)
> +int afs_proc_cell_setup(struct afs_cell *cell)
>  {
>  	struct proc_dir_entry *dir;
> +	struct afs_net *net = cell->net;
>  
>  	_enter("%p{%s},%p", cell, cell->name, net->proc_afs);
>  
> -	dir = proc_mkdir(cell->name, net->proc_afs);
> +	dir = proc_net_mkdir(net->net, cell->name, net->proc_afs);
>  	if (!dir)
>  		goto error_dir;
>  
> -	if (!proc_create_data("vlservers", 0, dir,
> -			      &afs_proc_cell_vlservers_fops, cell) ||
> -	    !proc_create_data("volumes", 0, dir,
> -			      &afs_proc_cell_volumes_fops, cell))
> +	if (!proc_create_net_data("vlservers", 0444, dir,
> +				  &afs_proc_cell_vlservers_ops,
> +				  sizeof(struct seq_net_private),
> +				  cell) ||
> +	    !proc_create_net_data("volumes", 0444, dir,
> +				  &afs_proc_cell_volumes_ops,
> +				  sizeof(struct seq_net_private),
> +				  cell))
>  		goto error_tree;
>  
>  	_leave(" = 0");
> @@ -796,12 +579,12 @@ int afs_proc_cell_setup(struct afs_net *net, struct afs_cell *cell)
>  /*
>   * remove /proc/fs/afs/<cell>/
>   */
> -void afs_proc_cell_remove(struct afs_net *net, struct afs_cell *cell)
> +void afs_proc_cell_remove(struct afs_cell *cell)
>  {
> -	_enter("");
> +	struct afs_net *net = cell->net;
>  
> +	_enter("");
>  	remove_proc_subtree(cell->name, net->proc_afs);
> -
>  	_leave("");
>  }
>  
> @@ -810,24 +593,39 @@ void afs_proc_cell_remove(struct afs_net *net, struct afs_cell *cell)
>   */
>  int afs_proc_init(struct afs_net *net)
>  {
> +	struct proc_dir_entry *p;
> +
>  	_enter("");
>  
> -	net->proc_afs = proc_mkdir("fs/afs", NULL);
> -	if (!net->proc_afs)
> +	p = proc_net_mkdir(net->net, "afs", net->net->proc_net);
> +	if (!p)
>  		goto error_dir;
>  
> -	if (!proc_create("cells", 0644, net->proc_afs, &afs_proc_cells_fops) ||
> -	    !proc_create("rootcell", 0644, net->proc_afs, &afs_proc_rootcell_fops) ||
> -	    !proc_create("servers", 0644, net->proc_afs, &afs_proc_servers_fops) ||
> -	    !proc_create("stats", 0644, net->proc_afs, &afs_proc_stats_fops) ||
> -	    !proc_create("sysname", 0644, net->proc_afs, &afs_proc_sysname_fops))
> +	if (!proc_create_net_data_write("cells", 0644, p,
> +					&afs_proc_cells_ops,
> +					afs_proc_cells_write,
> +					sizeof(struct seq_net_private),
> +					NULL) ||
> +	    !proc_create_net_single_write("rootcell", 0644, p,
> +					  afs_proc_rootcell_show,
> +					  afs_proc_rootcell_write,
> +					  NULL) ||
> +	    !proc_create_net("servers", 0444, p, &afs_proc_servers_ops,
> +			     sizeof(struct seq_net_private)) ||
> +	    !proc_create_net_single("stats", 0444, p, afs_proc_stats_show, NULL) ||
> +	    !proc_create_net_data_write("sysname", 0644, p,
> +					&afs_proc_sysname_ops,
> +					afs_proc_sysname_write,
> +					sizeof(struct seq_net_private),
> +					NULL))
>  		goto error_tree;
>  
> +	net->proc_afs = p;
>  	_leave(" = 0");
>  	return 0;
>  
>  error_tree:
> -	proc_remove(net->proc_afs);
> +	proc_remove(p);
>  error_dir:
>  	_leave(" = -ENOMEM");
>  	return -ENOMEM;
> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index 5c6263972ec9..e58fa0e15798 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
> @@ -45,7 +45,7 @@ int afs_open_socket(struct afs_net *net)
>  
>  	_enter("");
>  
> -	ret = sock_create_kern(&init_net, AF_RXRPC, SOCK_DGRAM, PF_INET6, &socket);
> +	ret = sock_create_kern(net->net, AF_RXRPC, SOCK_DGRAM, PF_INET6, &socket);
>  	if (ret < 0)
>  		goto error_1;
>  
> diff --git a/fs/afs/super.c b/fs/afs/super.c
> index 65081ec3c36e..593820372848 100644
> --- a/fs/afs/super.c
> +++ b/fs/afs/super.c
> @@ -48,6 +48,8 @@ struct file_system_type afs_fs_type = {
>  };
>  MODULE_ALIAS_FS("afs");
>  
> +int afs_net_id;
> +
>  static const struct super_operations afs_super_ops = {
>  	.statfs		= afs_statfs,
>  	.alloc_inode	= afs_alloc_inode,
> @@ -117,7 +119,7 @@ int __init afs_fs_init(void)
>  /*
>   * clean up the filesystem
>   */
> -void __exit afs_fs_exit(void)
> +void afs_fs_exit(void)
>  {
>  	_enter("");
>  
> @@ -351,7 +353,7 @@ static int afs_test_super(struct super_block *sb, void *data)
>  	struct afs_super_info *as1 = data;
>  	struct afs_super_info *as = AFS_FS_S(sb);
>  
> -	return (as->net == as1->net &&
> +	return (as->net_ns == as1->net_ns &&
>  		as->volume &&
>  		as->volume->vid == as1->volume->vid);
>  }
> @@ -437,7 +439,7 @@ static struct afs_super_info *afs_alloc_sbi(struct afs_mount_params *params)
>  
>  	as = kzalloc(sizeof(struct afs_super_info), GFP_KERNEL);
>  	if (as) {
> -		as->net = afs_get_net(params->net);
> +		as->net_ns = get_net(params->net_ns);
>  		if (params->dyn_root)
>  			as->dyn_root = true;
>  		else
> @@ -450,8 +452,8 @@ static void afs_destroy_sbi(struct afs_super_info *as)
>  {
>  	if (as) {
>  		afs_put_volume(as->cell, as->volume);
> -		afs_put_cell(as->net, as->cell);
> -		afs_put_net(as->net);
> +		afs_put_cell(afs_net(as->net_ns), as->cell);
> +		put_net(as->net_ns);
>  		kfree(as);
>  	}
>  }
> @@ -472,12 +474,13 @@ static struct dentry *afs_mount(struct file_system_type *fs_type,
>  	_enter(",,%s,%p", dev_name, options);
>  
>  	memset(&params, 0, sizeof(params));
> -	params.net = &__afs_net;
>  
>  	ret = -EINVAL;
>  	if (current->nsproxy->net_ns != &init_net)
>  		goto error;
> -
> +	params.net_ns = current->nsproxy->net_ns;
> +	params.net = afs_net(params.net_ns);
> +	
>  	/* parse the options and device name */
>  	if (options) {
>  		ret = afs_parse_options(&params, options, &dev_name);
> @@ -571,7 +574,8 @@ static void afs_kill_super(struct super_block *sb)
>  	 * deactivating the superblock.
>  	 */
>  	if (as->volume)
> -		afs_clear_callback_interests(as->net, as->volume->servers);
> +		afs_clear_callback_interests(afs_net(as->net_ns),
> +					     as->volume->servers);
>  	kill_anon_super(sb);
>  	if (as->volume)
>  		afs_deactivate_volume(as->volume);
---end quoted text---
