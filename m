Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeFDJfG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 05:35:06 -0400
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171]:63584 "EHLO
        mgwkm04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbeFDJfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 05:35:04 -0400
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
To: "'Eric W. Biederman'" <ebiederm@xmission.com>
CC: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
        "'tj@kernel.org'" <tj@kernel.org>,
        "Okajima, Toshiyuki" <toshi.okajima@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'ebiederm@aristanetworks.com'" <ebiederm@aristanetworks.com>
Subject: RE: [CFT][PATCH] kernfs: Correct kernfs directory seeks.
Thread-Topic: [CFT][PATCH] kernfs: Correct kernfs directory seeks.
Thread-Index: AQHT+2vpI3mQ17S8REWGMo+9PpY1yqRP1x+A
Date: Mon, 4 Jun 2018 09:34:56 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E21B65E04E@G01JPEXMBYT03>
References: <33710E6CAA200E4583255F4FB666C4E21B63D491@G01JPEXMBYT03>
        <87wovhqex2.fsf@xmission.com> <87po17r9ek.fsf_-_@xmission.com>
In-Reply-To: <87po17r9ek.fsf_-_@xmission.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.5.2
x-shieldmailcheckerpolicyversion: FJ-ISEC-20170217-enc
x-shieldmailcheckermailid: 2aa364be22d0464b871d2944ff298089
x-originating-ip: [10.124.89.120]
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thanks for this patch, Eric.

> -----Original Message-----
> From: Eric W. Biederman [mailto:ebiederm@xmission.com]
> Sent: Monday, June 4, 2018 3:51 AM
> To: Hatayama, Daisuke <d.hatayama@jp.fujitsu.com>
> Cc: 'gregkh@linuxfoundation.org' <gregkh@linuxfoundation.org>;
> 'tj@kernel.org' <tj@kernel.org>; Okajima, Toshiyuki 
> <toshi.okajima@jp.fujitsu.com>; linux-kernel@vger.kernel.org;
> 'ebiederm@aristanetworks.com' <ebiederm@aristanetworks.com>
> Subject: [CFT][PATCH] kernfs: Correct kernfs directory seeks.
> 
> 
> Over the years two bugs have crept into the code that handled the last
> returned kernfs directory being deleted, and handled general seeking
> in kernfs directories.  The result is that reading the /sys/module
> directory while moduled are loading and unloading will sometimes
> skip over a module that was present for the entire duration of
> the directory read.
> 
> The first bug is that kernfs_dir_next_pos was advancing the position
> in the directory even when kernfs_dir_pos had found the starting
> kernfs directory entry was not usable.  In this case kernfs_dir_pos is
> guaranteed to return the directory entry past the starting directory
> entry, making it so that advancing the directory position is wrong.
> 
> The second bug is that kernfs_dir_pos when the saved kernfs_node
> did not validate, was not always returning a directory after
> the the target position, but was sometimes returning the directory
> entry just before the target position.
> 
> To correct these issues and to make the code easily readable and
> comprehensible several cleanups are made.
> 
> - A function kernfs_dir_next is factored out to make it straight-forward
>   to find the next node in a kernfs directory.
> 
> - A function kernfs_dir_skip_pos is factored out to skip over directory
>   entries that should not be shown to userspace.  This function is called
>   from kernfs_fop_readdir directly removing the complication of calling
>   it from the other directory advancement functions.
> 
> - The kernfs_put of the saved directory entry is moved from kernfs_dir_pos
>   to kernfs_fop_readdir.  Keeping it with the kernfs_get when it is saved
>   and ensuring the directory position advancment functions can reference
>   the saved node without complications.
> 
> - The function kernfs_dir_next_pos is modified to only advance the directory
>   position in the common case when kernfs_dir_pos validates and returns
>   the starting kernfs node.  For all other cases kernfs_dir_pos is guaranteed
>   to return a directory position in advance of the starting directory position.
> 
> - kernfs_dir_pos is given a significant make over.  It's essense remains the
>   same but some siginficant changes were made.
> 
>   + The offset is validated to be a valid hash value at the very beginning.
>     The validation is updated to handle the fact that neither 0 nor 1 are
>     valid hash values.
> 
>   + An extra test is added at the end of the rbtree lookup to ensure
>     the returned position is at or beyond the target position.
> 
>   + kernfs_name_compare is used during the rbtree lookup instead of just
> comparing
>     the hash.  This allows the the passed namespace parameter to be used, and
>     if it is available from the saved entry the old saved name as well.
> 
>   + The validation of the saved kernfs node now checks for two cases.
>     If the saved node is returnable.
>     If the name of the saved node is usable during lookup.
> 
> In net this should result in a easier to understand, and more correct
> version of directory traversal for kernfs directories.
>
> Reported-by: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
> Fixes: a406f75840e1 ("sysfs: use rb-tree for inode number lookup")
> Fixes: 1e5289c97bba ("sysfs: Cache the last sysfs_dirent to improve readdir
> scalability v2")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
> 
> Can you test this and please verify it fixes your issue?
>

I tried this patch on top of v4.17 but the system fails to boot
without detecting root disks by dracut like this:

    [  196.121294] dracut-initqueue[324]: Warning: dracut-initqueue timeout - starting timeout scripts
    [  196.672175] dracut-initqueue[324]: Warning: dracut-initqueue timeout - starting timeout scripts
    [  197.219519] dracut-initqueue[324]: Warning: dracut-initqueue timeout - starting timeout scripts
    [  197.768997] dracut-initqueue[324]: Warning: dracut-initqueue timeout - starting timeout scripts
    [  198.312498] dracut-initqueue[324]: Warning: dracut-initqueue timeout - starting timeout scripts
    [  198.856841] dracut-initqueue[324]: Warning: dracut-initqueue timeout - starting timeout scripts
    [  199.403190] dracut-initqueue[324]: Warning: dracut-initqueue timeout - starting timeout scripts
    [  199.945999] dracut-initqueue[324]: Warning: dracut-initqueue timeout - starting timeout scripts
    [  200.490281] dracut-initqueue[324]: Warning: dracut-initqueue timeout - starting timeout scripts
    [  201.071177] dracut-initqueue[324]: Warning: dracut-initqueue timeout - starting timeout scripts
    [  201.074958] dracut-initqueue[324]: Warning: Could not boot.
	     Starting Setup Virtual Console...
    [  OK  ] Started Setup Virtual Console.
    [  201.245921] audit: type=1130 audit(1528132266.260:12): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
	     [  201.256378] audit: type=1131 audit(1528132266.260:13): pid=1 uid=0 auid=4294967295 ses=4294967295 subj=kernel msg='unit=systemd-vconsole-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
    Starting Dracut Emergency Shell...
    Warning: /dev/fedora/root does not exist
    Warning: /dev/fedora/swap does not exist
    Warning: /dev/mapper/fedora-root does not exist

    Generating "/run/initramfs/rdsosreport.txt"


    Entering emergency mode. Exit the shell to continue.
    Type "journalctl" to view system logs.
    You might want to save "/run/initramfs/rdsosreport.txt" to a USB stick or /boot
    after mounting them and attach it to a bug report.


    dracut:/# ls /sys/module
    8139cp        dm_bufio        kernel       psmouse      ttm
    8139too       dm_mirror       keyboard     pstore       uhci_hcd
    8250          dm_mod          kgdboc       qemu_fw_cfg  usbcore
    acpi          dm_snapshot     kgdbts       qxl          usbhid
    acpiphp       drm             libahci      random       uv_nmi
    ahci          drm_kms_helper  libata       rcupdate     virtio
    ata_generic   dynamic_debug   md_mod       rcutree      virtio_console
    ata_piix      edac_core       mii          rng_core     virtio_pci
    battery       ehci_hcd        module       scsi_mod     virtio_ring
    block         fb              mousedev     serio_raw    vt
    button        firmware_class  pata_acpi    sg           watchdog
    configfs      fscrypto        pci_hotplug  slab_common  workqueue
    cpufreq       hid             pcie_aspm    spurious     xhci_hcd
    cpuidle       hid_magicmouse  pciehp       sr_mod       xz_dec
    crc32c_intel  hid_ntrig       pcmcia       srcutree     zswap
    cryptomgr     i8042           pcmcia_core  suspend
    debug_core    intel_idle      printk       sysrq
    devres        ipv6            processor    tcp_cubic
    dracut:/# lsmod
    Module                  Size  Used by
    qxl                    77824  1
    drm_kms_helper        196608  1
    ttm                   126976  1
    drm                   454656  4 qxl,ttm
    virtio_console         32768  0
    ata_generic            16384  0
    crc32c_intel           24576  0
    8139too                40960  0
    virtio_pci             28672  0
    8139cp                 32768  0
    virtio_ring            28672  2 virtio_pci
    serio_raw              16384  0
    pata_acpi              16384  0
    virtio                 16384  2 virtio_pci
    mii                    16384  2 8139too
    qemu_fw_cfg            16384  0
    dracut:/#

OTOH, there's no issue on the pure v4.17 kernel.

As above, ls /sys/module looks apparently good. But I guess any part of
behavior of getdentries() on sysfs must have changed, affecting the disk
detection...

and,

>  fs/kernfs/dir.c | 109
> ++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 67 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 89d1dc19340b..8148b5fec48d 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1584,53 +1584,75 @@ static int kernfs_dir_fop_release(struct inode *inode,
> struct file *filp)
>  	return 0;
>  }
> 
> +static struct kernfs_node *kernfs_dir_next(struct kernfs_node *pos)
> +{
> +	struct rb_node *node = rb_next(&pos->rb);
> +	return node ? rb_to_kn(node) : NULL;
> +}
> +
>  static struct kernfs_node *kernfs_dir_pos(const void *ns,
> -	struct kernfs_node *parent, loff_t hash, struct kernfs_node *pos)
> +	struct kernfs_node *parent, loff_t off, struct kernfs_node *saved)
>  {
> -	if (pos) {
> -		int valid = kernfs_active(pos) &&
> -			pos->parent == parent && hash == pos->hash;
> -		kernfs_put(pos);
> -		if (!valid)
> -			pos = NULL;
> -	}
> -	if (!pos && (hash > 1) && (hash < INT_MAX)) {
> -		struct rb_node *node = parent->dir.children.rb_node;
> -		while (node) {
> -			pos = rb_to_kn(node);
> -
> -			if (hash < pos->hash)
> -				node = node->rb_left;
> -			else if (hash > pos->hash)
> -				node = node->rb_right;
> -			else
> -				break;
> +	struct kernfs_node *pos;
> +	struct rb_node *node;
> +	unsigned int hash;
> +	const char *name = "";
> +
> +	/* Is off a valid name hash? */
> +	if ((off < 2) || (off >= INT_MAX))
> +		return NULL;
> +	hash = off;
> +
> +	/* Is the saved position usable? */
> +	if (saved) {
> +		/* Proper parent and hash? */
> +		if ((parent != saved->parent) || (saved->hash != hash)) {
> +			saved = NULL;

name is uninitialized in this path.

> +		} else {
> +			if (kernfs_active(saved))
> +				return saved;
> +			name = saved->name;
>  		}
>  	}
> -	/* Skip over entries which are dying/dead or in the wrong namespace
> */
> -	while (pos && (!kernfs_active(pos) || pos->ns != ns)) {
> -		struct rb_node *node = rb_next(&pos->rb);
> -		if (!node)
> -			pos = NULL;
> +
> +	/* Find the closest pos to the hash we are looking for */
> +	pos = NULL;
> +	node = parent->dir.children.rb_node;
> +	while (node) {
> +		int result;
> +
> +		pos = rb_to_kn(node);
> +		result = kernfs_name_compare(hash, name, ns, pos);
> +		if (result < 0)
> +			node = node->rb_left;
> +		else if (result > 0)
> +			node = node->rb_right;
>  		else
> -			pos = rb_to_kn(node);
> +			break;
>  	}
> +
> +	/* Ensure pos is at or beyond the target position */
> +	if (pos && (kernfs_name_compare(hash, name, ns, pos) < 0))
> +		pos = kernfs_dir_next(pos);
> +

Why not trying to find the final target object here?

Looking at the code, I think the operation needed here is to find the
smallest active object in the same namespace from the objects larger
than the saved object given as argument. The saved object appears to
be used as cache. I think dividing the process into kernfs_dir_pos()
is not necessary.

I mean like this:

# git diff
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8148b5f..eeffc8c 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1605,13 +1605,13 @@ static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)

        /* Is the saved position usable? */
        if (saved) {
+               name = saved->name;
                /* Proper parent and hash? */
                if ((parent != saved->parent) || (saved->hash != hash)) {
                        saved = NULL;
-               } else {
-                       if (kernfs_active(saved))
-                               return saved;
-                       name = saved->name;
+               } else if (kernfs_active(saved)) {
+                       pos = saved;
+                       goto skip;
                }
        }

@@ -1631,22 +1631,14 @@ static int kernfs_dir_fop_release(struct inode *inode, struct file *filp)
                        break;
        }

+skip:
        /* Ensure pos is at or beyond the target position */
-       if (pos && (kernfs_name_compare(hash, name, ns, pos) < 0))
+       if (pos && (kernfs_name_compare(hash, name, ns, pos) <= 0))
                pos = kernfs_dir_next(pos);

        return pos;
 }

-static struct kernfs_node *kernfs_dir_next_pos(const void *ns,
-       struct kernfs_node *parent, loff_t off, struct kernfs_node *start)
-{
-       struct kernfs_node *pos = kernfs_dir_pos(ns, parent, off, start);
-       if (likely(pos == start))
-               pos = kernfs_dir_next(pos);
-       return pos;
-}
-
 static struct kernfs_node *kernfs_dir_skip_pos(const void *ns,
                                               struct kernfs_node *pos)
 {
@@ -1672,7 +1664,7 @@ static int kernfs_fop_readdir(struct file *file, struct dir_context *ctx)

        for (pos = kernfs_dir_pos(ns, parent, ctx->pos, saved);
             (pos = kernfs_dir_skip_pos(ns, pos));
-            pos = kernfs_dir_next_pos(ns, parent, ctx->pos, pos)) {
+            pos = kernfs_dir_pos(ns, parent, ctx->pos, pos)) {
                const char *name = pos->name;
                unsigned int type = dt_type(pos);
                int len = strlen(name);

>  	return pos;
>  }
> 
>  static struct kernfs_node *kernfs_dir_next_pos(const void *ns,
> -	struct kernfs_node *parent, ino_t ino, struct kernfs_node *pos)
> +	struct kernfs_node *parent, loff_t off, struct kernfs_node *start)
>  {
> -	pos = kernfs_dir_pos(ns, parent, ino, pos);
> -	if (pos) {
> -		do {
> -			struct rb_node *node = rb_next(&pos->rb);
> -			if (!node)
> -				pos = NULL;
> -			else
> -				pos = rb_to_kn(node);
> -		} while (pos && (!kernfs_active(pos) || pos->ns != ns));
> -	}
> +	struct kernfs_node *pos = kernfs_dir_pos(ns, parent, off, start);
> +	if (likely(pos == start))
> +		pos = kernfs_dir_next(pos);
> +	return pos;
> +}
> +
> +static struct kernfs_node *kernfs_dir_skip_pos(const void *ns,
> +					       struct kernfs_node *pos)
> +{
> +	/* Skip entries we don't want to return to userspace */
> +	while (pos && !(kernfs_active(pos) && (pos->ns == ns)))
> +		pos = kernfs_dir_next(pos);
>  	return pos;
>  }
> 
> @@ -1638,7 +1660,7 @@ static int kernfs_fop_readdir(struct file *file, struct
> dir_context *ctx)
>  {
>  	struct dentry *dentry = file->f_path.dentry;
>  	struct kernfs_node *parent = kernfs_dentry_node(dentry);
> -	struct kernfs_node *pos = file->private_data;
> +	struct kernfs_node *pos, *saved = file->private_data;
>  	const void *ns = NULL;
> 
>  	if (!dir_emit_dots(file, ctx))
> @@ -1648,23 +1670,26 @@ static int kernfs_fop_readdir(struct file *file,
> struct dir_context *ctx)
>  	if (kernfs_ns_enabled(parent))
>  		ns = kernfs_info(dentry->d_sb)->ns;
> 
> -	for (pos = kernfs_dir_pos(ns, parent, ctx->pos, pos);
> -	     pos;
> +	for (pos = kernfs_dir_pos(ns, parent, ctx->pos, saved);
> +	     (pos = kernfs_dir_skip_pos(ns, pos));
>  	     pos = kernfs_dir_next_pos(ns, parent, ctx->pos, pos)) {
>  		const char *name = pos->name;
>  		unsigned int type = dt_type(pos);
>  		int len = strlen(name);
>  		ino_t ino = pos->id.ino;
> 
> -		ctx->pos = pos->hash;
> -		file->private_data = pos;
> -		kernfs_get(pos);
> +		kernfs_put(saved);
> +		saved = pos;
> +		ctx->pos = saved->hash;
> +		file->private_data = saved;
> +		kernfs_get(saved);
> 
>  		mutex_unlock(&kernfs_mutex);
>  		if (!dir_emit(ctx, name, len, ino, type))
>  			return 0;
>  		mutex_lock(&kernfs_mutex);
>  	}
> +	kernfs_put(saved);
>  	mutex_unlock(&kernfs_mutex);
>  	file->private_data = NULL;
>  	ctx->pos = INT_MAX;
> --
> 2.14.1
> 
>
