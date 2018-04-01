Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753150AbeDACka (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 22:40:30 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:39677 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbeDACk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 22:40:26 -0400
X-Google-Smtp-Source: AIpwx49Ji0pO9FESntAgpA676VCzpw5s+cOrfz8q/z72XBy0ECs/G/74vCIdU9AHjrvH0Bf11RAkNA==
Date: Sun, 1 Apr 2018 02:40:18 +0000
From: Sargun Dhillon <sargun@sargun.me>
To: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: penguin-kernel@i-love.sakura.ne.jp, keescook@chromium.org,
        igor.stoppa@huawei.com, casey@schaufler-ca.com, jmorris@namei.org,
        sds@tycho.nsa.gov, paul@paul-moore.com, plautrba@redhat.com
Subject: [PATCH] security: Split out hook definitions into lsm_hook_types.h
Message-ID: <20180401024015.GA13870@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves all of the LSM hooks type information into a separate file,
lsm_hook_types.h. This enables us to use this file, along with macros
to generate the security_hook_heads struct, as well as the security
hooks union without having to duplicate definitions.

Since the fall-back hooks still require some logic (dispatching
to commoncap, nulling out some buffer, etc..), they still must
be created manually.

This will be useful for further datastructures which want to use
the set of security hooks in a completely unrolled way, along
with the type information there within.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 include/linux/lsm_hook_types.h | 1695 ++++++++++++++++++++++++++++++++++
 include/linux/lsm_hooks.h      | 1946 +---------------------------------------
 include/linux/security.h       |  416 ++-------
 kernel/time/time.c             |    6 +-
 security/security.c            |    2 +-
 5 files changed, 1783 insertions(+), 2282 deletions(-)
 create mode 100644 include/linux/lsm_hook_types.h

diff --git a/include/linux/lsm_hook_types.h b/include/linux/lsm_hook_types.h
new file mode 100644
index 000000000000..c94adbd8a536
--- /dev/null
+++ b/include/linux/lsm_hook_types.h
@@ -0,0 +1,1695 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Security hooks for program execution operations.
+ * internal file - only add hooks definitions here
+ *
+ * This is used to generate the LSM-facing APIs in lsm_hooks.h, as well as the
+ * API definitions called upon by the rest of the kernel in kernel.
+ *
+ * Typically, these APIs are the same, so it's okay to just use the VOID_HOOK,
+ * or INT_HOOK macros. When these are different, use the _EXT, and _INT suffixed
+ * version of the macro to differentiate the version generated for other parts
+ * of the kernel to call versus the LSM callbacks.
+ *
+ * @bprm_set_creds:
+ *	Save security information in the bprm->security field, typically based
+ *	on information about the bprm->file, for later use by the apply_creds
+ *	hook.  This hook may also optionally check permissions (e.g. for
+ *	transitions between security domains).
+ *	This hook may be called multiple times during a single execve, e.g. for
+ *	interpreters.  The hook can tell whether it has already been called by
+ *	checking to see if @bprm->security is non-NULL.  If so, then the hook
+ *	may decide either to retain the security information saved earlier or
+ *	to replace it.  The hook must set @bprm->secureexec to 1 if a "secure
+ *	exec" has happened as a result of this hook call.  The flag is used to
+ *	indicate the need for a sanitized execution environment, and is also
+ *	passed in the ELF auxiliary table on the initial stack to indicate
+ *	whether libc should enable secure mode.
+ *	@bprm contains the linux_binprm structure.
+ *	Return 0 if the hook is successful and permission is granted.
+ * @bprm_check_security:
+ *	This hook mediates the point when a search for a binary handler will
+ *	begin.  It allows a check the @bprm->security value which is set in the
+ *	preceding set_creds call.  The primary difference from set_creds is
+ *	that the argv list and envp list are reliably available in @bprm.  This
+ *	hook may be called multiple times during a single execve; and in each
+ *	pass set_creds is called first.
+ *	@bprm contains the linux_binprm structure.
+ *	Return 0 if the hook is successful and permission is granted.
+ * @bprm_committing_creds:
+ *	Prepare to install the new security attributes of a process being
+ *	transformed by an execve operation, based on the old credentials
+ *	pointed to by @current->cred and the information set in @bprm->cred by
+ *	the bprm_set_creds hook.  @bprm points to the linux_binprm structure.
+ *	This hook is a good place to perform state changes on the process such
+ *	as closing open file descriptors to which access will no longer be
+ *	granted when the attributes are changed.  This is called immediately
+ *	before commit_creds().
+ * @bprm_committed_creds:
+ *	Tidy up after the installation of the new security attributes of a
+ *	process being transformed by an execve operation.  The new credentials
+ *	have, by this point, been set to @current->cred.  @bprm points to the
+ *	linux_binprm structure.  This hook is a good place to perform state
+ *	changes on the process such as clearing out non-inheritable signal
+ *	state.  This is called immediately after commit_creds().
+ *
+ * Security hooks for filesystem operations.
+ *
+ * @sb_alloc_security:
+ *	Allocate and attach a security structure to the sb->s_security field.
+ *	The s_security field is initialized to NULL when the structure is
+ *	allocated.
+ *	@sb contains the super_block structure to be modified.
+ *	Return 0 if operation was successful.
+ * @sb_free_security:
+ *	Deallocate and clear the sb->s_security field.
+ *	@sb contains the super_block structure to be modified.
+ * @sb_statfs:
+ *	Check permission before obtaining filesystem statistics for the @mnt
+ *	mountpoint.
+ *	@dentry is a handle on the superblock for the filesystem.
+ *	Return 0 if permission is granted.
+ * @sb_mount:
+ *	Check permission before an object specified by @dev_name is mounted on
+ *	the mount point named by @nd.  For an ordinary mount, @dev_name
+ *	identifies a device if the file system type requires a device.  For a
+ *	remount (@flags & MS_REMOUNT), @dev_name is irrelevant.  For a
+ *	loopback/bind mount (@flags & MS_BIND), @dev_name identifies the
+ *	pathname of the object being mounted.
+ *	@dev_name contains the name for object being mounted.
+ *	@path contains the path for mount point object.
+ *	@type contains the filesystem type.
+ *	@flags contains the mount flags.
+ *	@data contains the filesystem-specific data.
+ *	Return 0 if permission is granted.
+ * @sb_copy_data:
+ *	Allow mount option data to be copied prior to parsing by the filesystem,
+ *	so that the security module can extract security-specific mount
+ *	options cleanly (a filesystem may modify the data e.g. with strsep()).
+ *	This also allows the original mount data to be stripped of security-
+ *	specific options to avoid having to make filesystems aware of them.
+ *	@type the type of filesystem being mounted.
+ *	@orig the original mount data copied from userspace.
+ *	@copy copied data which will be passed to the security module.
+ *	Returns 0 if the copy was successful.
+ * @sb_remount:
+ *	Extracts security system specific mount options and verifies no changes
+ *	are being made to those options.
+ *	@sb superblock being remounted
+ *	@data contains the filesystem-specific data.
+ *	Return 0 if permission is granted.
+ * @sb_umount:
+ *	Check permission before the @mnt file system is unmounted.
+ *	@mnt contains the mounted file system.
+ *	@flags contains the unmount flags, e.g. MNT_FORCE.
+ *	Return 0 if permission is granted.
+ * @sb_pivotroot:
+ *	Check permission before pivoting the root filesystem.
+ *	@old_path contains the path for the new location of the
+ *	current root (put_old).
+ *	@new_path contains the path for the new root (new_root).
+ *	Return 0 if permission is granted.
+ * @sb_set_mnt_opts:
+ *	Set the security relevant mount options used for a superblock
+ *	@sb the superblock to set security mount options for
+ *	@opts binary data structure containing all lsm mount data
+ * @sb_clone_mnt_opts:
+ *	Copy all security options from a given superblock to another
+ *	@oldsb old superblock which contain information to clone
+ *	@newsb new superblock which needs filled in
+ * @sb_parse_opts_str:
+ *	Parse a string of security data filling in the opts structure
+ *	@options string containing all mount options known by the LSM
+ *	@opts binary data structure usable by the LSM
+ * @dentry_init_security:
+ *	Compute a context for a dentry as the inode is not yet available
+ *	since NFSv4 has no label backed by an EA anyway.
+ *	@dentry dentry to use in calculating the context.
+ *	@mode mode used to determine resource type.
+ *	@name name of the last path component used to create file
+ *	@ctx pointer to place the pointer to the resulting context in.
+ *	@ctxlen point to place the length of the resulting context.
+ * @dentry_create_files_as:
+ *	Compute a context for a dentry as the inode is not yet available
+ *	and set that context in passed in creds so that new files are
+ *	created using that context. Context is calculated using the
+ *	passed in creds and not the creds of the caller.
+ *	@dentry dentry to use in calculating the context.
+ *	@mode mode used to determine resource type.
+ *	@name name of the last path component used to create file
+ *	@old creds which should be used for context calculation
+ *	@new creds to modify
+ *
+ *
+ * Security hooks for inode operations.
+ *
+ * @inode_alloc_security:
+ *	Allocate and attach a security structure to @inode->i_security.  The
+ *	i_security field is initialized to NULL when the inode structure is
+ *	allocated.
+ *	@inode contains the inode structure.
+ *	Return 0 if operation was successful.
+ * @inode_free_security:
+ *	@inode contains the inode structure.
+ *	Deallocate the inode security structure and set @inode->i_security to
+ *	NULL.
+ * @inode_init_security:
+ *	Obtain the security attribute name suffix and value to set on a newly
+ *	created inode and set up the incore security field for the new inode.
+ *	This hook is called by the fs code as part of the inode creation
+ *	transaction and provides for atomic labeling of the inode, unlike
+ *	the post_create/mkdir/... hooks called by the VFS.  The hook function
+ *	is expected to allocate the name and value via kmalloc, with the caller
+ *	being responsible for calling kfree after using them.
+ *	If the security module does not use security attributes or does
+ *	not wish to put a security attribute on this particular inode,
+ *	then it should return -EOPNOTSUPP to skip this processing.
+ *	@inode contains the inode structure of the newly created inode.
+ *	@dir contains the inode structure of the parent directory.
+ *	@qstr contains the last path component of the new object
+ *	@name will be set to the allocated name suffix (e.g. selinux).
+ *	@value will be set to the allocated attribute value.
+ *	@len will be set to the length of the value.
+ *	Returns 0 if @name and @value have been successfully set,
+ *	-EOPNOTSUPP if no security attribute is needed, or
+ *	-ENOMEM on memory allocation failure.
+ * @inode_create:
+ *	Check permission to create a regular file.
+ *	@dir contains inode structure of the parent of the new file.
+ *	@dentry contains the dentry structure for the file to be created.
+ *	@mode contains the file mode of the file to be created.
+ *	Return 0 if permission is granted.
+ * @inode_link:
+ *	Check permission before creating a new hard link to a file.
+ *	@old_dentry contains the dentry structure for an existing
+ *	link to the file.
+ *	@dir contains the inode structure of the parent directory
+ *	of the new link.
+ *	@new_dentry contains the dentry structure for the new link.
+ *	Return 0 if permission is granted.
+ * @path_link:
+ *	Check permission before creating a new hard link to a file.
+ *	@old_dentry contains the dentry structure for an existing link
+ *	to the file.
+ *	@new_dir contains the path structure of the parent directory of
+ *	the new link.
+ *	@new_dentry contains the dentry structure for the new link.
+ *	Return 0 if permission is granted.
+ * @inode_unlink:
+ *	Check the permission to remove a hard link to a file.
+ *	@dir contains the inode structure of parent directory of the file.
+ *	@dentry contains the dentry structure for file to be unlinked.
+ *	Return 0 if permission is granted.
+ * @path_unlink:
+ *	Check the permission to remove a hard link to a file.
+ *	@dir contains the path structure of parent directory of the file.
+ *	@dentry contains the dentry structure for file to be unlinked.
+ *	Return 0 if permission is granted.
+ * @inode_symlink:
+ *	Check the permission to create a symbolic link to a file.
+ *	@dir contains the inode structure of parent directory of
+ *	the symbolic link.
+ *	@dentry contains the dentry structure of the symbolic link.
+ *	@old_name contains the pathname of file.
+ *	Return 0 if permission is granted.
+ * @path_symlink:
+ *	Check the permission to create a symbolic link to a file.
+ *	@dir contains the path structure of parent directory of
+ *	the symbolic link.
+ *	@dentry contains the dentry structure of the symbolic link.
+ *	@old_name contains the pathname of file.
+ *	Return 0 if permission is granted.
+ * @inode_mkdir:
+ *	Check permissions to create a new directory in the existing directory
+ *	associated with inode structure @dir.
+ *	@dir contains the inode structure of parent of the directory
+ *	to be created.
+ *	@dentry contains the dentry structure of new directory.
+ *	@mode contains the mode of new directory.
+ *	Return 0 if permission is granted.
+ * @path_mkdir:
+ *	Check permissions to create a new directory in the existing directory
+ *	associated with path structure @path.
+ *	@dir contains the path structure of parent of the directory
+ *	to be created.
+ *	@dentry contains the dentry structure of new directory.
+ *	@mode contains the mode of new directory.
+ *	Return 0 if permission is granted.
+ * @inode_rmdir:
+ *	Check the permission to remove a directory.
+ *	@dir contains the inode structure of parent of the directory
+ *	to be removed.
+ *	@dentry contains the dentry structure of directory to be removed.
+ *	Return 0 if permission is granted.
+ * @path_rmdir:
+ *	Check the permission to remove a directory.
+ *	@dir contains the path structure of parent of the directory to be
+ *	removed.
+ *	@dentry contains the dentry structure of directory to be removed.
+ *	Return 0 if permission is granted.
+ * @inode_mknod:
+ *	Check permissions when creating a special file (or a socket or a fifo
+ *	file created via the mknod system call).  Note that if mknod operation
+ *	is being done for a regular file, then the create hook will be called
+ *	and not this hook.
+ *	@dir contains the inode structure of parent of the new file.
+ *	@dentry contains the dentry structure of the new file.
+ *	@mode contains the mode of the new file.
+ *	@dev contains the device number.
+ *	Return 0 if permission is granted.
+ * @path_mknod:
+ *	Check permissions when creating a file. Note that this hook is called
+ *	even if mknod operation is being done for a regular file.
+ *	@dir contains the path structure of parent of the new file.
+ *	@dentry contains the dentry structure of the new file.
+ *	@mode contains the mode of the new file.
+ *	@dev contains the undecoded device number. Use new_decode_dev() to get
+ *	the decoded device number.
+ *	Return 0 if permission is granted.
+ * @inode_rename:
+ *	Check for permission to rename a file or directory.
+ *	@old_dir contains the inode structure for parent of the old link.
+ *	@old_dentry contains the dentry structure of the old link.
+ *	@new_dir contains the inode structure for parent of the new link.
+ *	@new_dentry contains the dentry structure of the new link.
+ *	Return 0 if permission is granted.
+ * @path_rename:
+ *	Check for permission to rename a file or directory.
+ *	@old_dir contains the path structure for parent of the old link.
+ *	@old_dentry contains the dentry structure of the old link.
+ *	@new_dir contains the path structure for parent of the new link.
+ *	@new_dentry contains the dentry structure of the new link.
+ *	Return 0 if permission is granted.
+ * @path_chmod:
+ *	Check for permission to change DAC's permission of a file or directory.
+ *	@dentry contains the dentry structure.
+ *	@mnt contains the vfsmnt structure.
+ *	@mode contains DAC's mode.
+ *	Return 0 if permission is granted.
+ * @path_chown:
+ *	Check for permission to change owner/group of a file or directory.
+ *	@path contains the path structure.
+ *	@uid contains new owner's ID.
+ *	@gid contains new group's ID.
+ *	Return 0 if permission is granted.
+ * @path_chroot:
+ *	Check for permission to change root directory.
+ *	@path contains the path structure.
+ *	Return 0 if permission is granted.
+ * @inode_readlink:
+ *	Check the permission to read the symbolic link.
+ *	@dentry contains the dentry structure for the file link.
+ *	Return 0 if permission is granted.
+ * @inode_follow_link:
+ *	Check permission to follow a symbolic link when looking up a pathname.
+ *	@dentry contains the dentry structure for the link.
+ *	@inode contains the inode, which itself is not stable in RCU-walk
+ *	@rcu indicates whether we are in RCU-walk mode.
+ *	Return 0 if permission is granted.
+ * @inode_permission:
+ *	Check permission before accessing an inode.  This hook is called by the
+ *	existing Linux permission function, so a security module can use it to
+ *	provide additional checking for existing Linux permission checks.
+ *	Notice that this hook is called when a file is opened (as well as many
+ *	other operations), whereas the file_security_ops permission hook is
+ *	called when the actual read/write operations are performed.
+ *	@inode contains the inode structure to check.
+ *	@mask contains the permission mask.
+ *	Return 0 if permission is granted.
+ * @inode_setattr:
+ *	Check permission before setting file attributes.  Note that the kernel
+ *	call to notify_change is performed from several locations, whenever
+ *	file attributes change (such as when a file is truncated, chown/chmod
+ *	operations, transferring disk quotas, etc).
+ *	@dentry contains the dentry structure for the file.
+ *	@attr is the iattr structure containing the new file attributes.
+ *	Return 0 if permission is granted.
+ * @path_truncate:
+ *	Check permission before truncating a file.
+ *	@path contains the path structure for the file.
+ *	Return 0 if permission is granted.
+ * @inode_getattr:
+ *	Check permission before obtaining file attributes.
+ *	@path contains the path structure for the file.
+ *	Return 0 if permission is granted.
+ * @inode_setxattr:
+ *	Check permission before setting the extended attributes
+ *	@value identified by @name for @dentry.
+ *	Return 0 if permission is granted.
+ * @inode_post_setxattr:
+ *	Update inode security field after successful setxattr operation.
+ *	@value identified by @name for @dentry.
+ * @inode_getxattr:
+ *	Check permission before obtaining the extended attributes
+ *	identified by @name for @dentry.
+ *	Return 0 if permission is granted.
+ * @inode_listxattr:
+ *	Check permission before obtaining the list of extended attribute
+ *	names for @dentry.
+ *	Return 0 if permission is granted.
+ * @inode_removexattr:
+ *	Check permission before removing the extended attribute
+ *	identified by @name for @dentry.
+ *	Return 0 if permission is granted.
+ * @inode_getsecurity:
+ *	Retrieve a copy of the extended attribute representation of the
+ *	security label associated with @name for @inode via @buffer.  Note that
+ *	@name is the remainder of the attribute name after the security prefix
+ *	has been removed. @alloc is used to specify of the call should return a
+ *	value via the buffer or just the value length Return size of buffer on
+ *	success.
+ * @inode_setsecurity:
+ *	Set the security label associated with @name for @inode from the
+ *	extended attribute value @value.  @size indicates the size of the
+ *	@value in bytes.  @flags may be XATTR_CREATE, XATTR_REPLACE, or 0.
+ *	Note that @name is the remainder of the attribute name after the
+ *	security. prefix has been removed.
+ *	Return 0 on success.
+ * @inode_listsecurity:
+ *	Copy the extended attribute names for the security labels
+ *	associated with @inode into @buffer.  The maximum size of @buffer
+ *	is specified by @buffer_size.  @buffer may be NULL to request
+ *	the size of the buffer required.
+ *	Returns number of bytes used/required on success.
+ * @inode_need_killpriv:
+ *	Called when an inode has been changed.
+ *	@dentry is the dentry being changed.
+ *	Return <0 on error to abort the inode change operation.
+ *	Return 0 if inode_killpriv does not need to be called.
+ *	Return >0 if inode_killpriv does need to be called.
+ * @inode_killpriv:
+ *	The setuid bit is being removed.  Remove similar security labels.
+ *	Called with the dentry->d_inode->i_mutex held.
+ *	@dentry is the dentry being changed.
+ *	Return 0 on success.  If error is returned, then the operation
+ *	causing setuid bit removal is failed.
+ * @inode_getsecid:
+ *	Get the secid associated with the node.
+ *	@inode contains a pointer to the inode.
+ *	@secid contains a pointer to the location where result will be saved.
+ *	In case of failure, @secid will be set to zero.
+ * @inode_copy_up:
+ *	A file is about to be copied up from lower layer to upper layer of
+ *	overlay filesystem. Security module can prepare a set of new creds
+ *	and modify as need be and return new creds. Caller will switch to
+ *	new creds temporarily to create new file and release newly allocated
+ *	creds.
+ *	@src indicates the union dentry of file that is being copied up.
+ *	@new pointer to pointer to return newly allocated creds.
+ *	Returns 0 on success or a negative error code on error.
+ * @inode_copy_up_xattr:
+ *	Filter the xattrs being copied up when a unioned file is copied
+ *	up from a lower layer to the union/overlay layer.
+ *	@name indicates the name of the xattr.
+ *	Returns 0 to accept the xattr, 1 to discard the xattr, -EOPNOTSUPP if
+ *	security module does not know about attribute or a negative error code
+ *	to abort the copy up. Note that the caller is responsible for reading
+ *	and writing the xattrs as this hook is merely a filter.
+ *
+ * Security hooks for file operations
+ *
+ * @file_permission:
+ *	Check file permissions before accessing an open file.  This hook is
+ *	called by various operations that read or write files.  A security
+ *	module can use this hook to perform additional checking on these
+ *	operations, e.g.  to revalidate permissions on use to support privilege
+ *	bracketing or policy changes.  Notice that this hook is used when the
+ *	actual read/write operations are performed, whereas the
+ *	inode_security_ops hook is called when a file is opened (as well as
+ *	many other operations).
+ *	Caveat:  Although this hook can be used to revalidate permissions for
+ *	various system call operations that read or write files, it does not
+ *	address the revalidation of permissions for memory-mapped files.
+ *	Security modules must handle this separately if they need such
+ *	revalidation.
+ *	@file contains the file structure being accessed.
+ *	@mask contains the requested permissions.
+ *	Return 0 if permission is granted.
+ * @file_alloc_security:
+ *	Allocate and attach a security structure to the file->f_security field.
+ *	The security field is initialized to NULL when the structure is first
+ *	created.
+ *	@file contains the file structure to secure.
+ *	Return 0 if the hook is successful and permission is granted.
+ * @file_free_security:
+ *	Deallocate and free any security structures stored in file->f_security.
+ *	@file contains the file structure being modified.
+ * @file_ioctl:
+ *	@file contains the file structure.
+ *	@cmd contains the operation to perform.
+ *	@arg contains the operational arguments.
+ *	Check permission for an ioctl operation on @file.  Note that @arg
+ *	sometimes represents a user space pointer; in other cases, it may be a
+ *	simple integer value.  When @arg represents a user space pointer, it
+ *	should never be used by the security module.
+ *	Return 0 if permission is granted.
+ * @mmap_addr :
+ *	Check permissions for a mmap operation at @addr.
+ *	@addr contains virtual address that will be used for the operation.
+ *	Return 0 if permission is granted.
+ * @mmap_file :
+ *	Check permissions for a mmap operation.  The @file may be NULL, e.g.
+ *	if mapping anonymous memory.
+ *	@file contains the file structure for file to map (may be NULL).
+ *	@reqprot contains the protection requested by the application.
+ *	@prot contains the protection that will be applied by the kernel.
+ *	@flags contains the operational flags.
+ *	Return 0 if permission is granted.
+ * @file_mprotect:
+ *	Check permissions before changing memory access permissions.
+ *	@vma contains the memory region to modify.
+ *	@reqprot contains the protection requested by the application.
+ *	@prot contains the protection that will be applied by the kernel.
+ *	Return 0 if permission is granted.
+ * @file_lock:
+ *	Check permission before performing file locking operations.
+ *	Note: this hook mediates both flock and fcntl style locks.
+ *	@file contains the file structure.
+ *	@cmd contains the posix-translated lock operation to perform
+ *	(e.g. F_RDLCK, F_WRLCK).
+ *	Return 0 if permission is granted.
+ * @file_fcntl:
+ *	Check permission before allowing the file operation specified by @cmd
+ *	from being performed on the file @file.  Note that @arg sometimes
+ *	represents a user space pointer; in other cases, it may be a simple
+ *	integer value.  When @arg represents a user space pointer, it should
+ *	never be used by the security module.
+ *	@file contains the file structure.
+ *	@cmd contains the operation to be performed.
+ *	@arg contains the operational arguments.
+ *	Return 0 if permission is granted.
+ * @file_set_fowner:
+ *	Save owner security information (typically from current->security) in
+ *	file->f_security for later use by the send_sigiotask hook.
+ *	@file contains the file structure to update.
+ *	Return 0 on success.
+ * @file_send_sigiotask:
+ *	Check permission for the file owner @fown to send SIGIO or SIGURG to the
+ *	process @tsk.  Note that this hook is sometimes called from interrupt.
+ *	Note that the fown_struct, @fown, is never outside the context of a
+ *	struct file, so the file structure (and associated security information)
+ *	can always be obtained: container_of(fown, struct file, f_owner)
+ *	@tsk contains the structure of task receiving signal.
+ *	@fown contains the file owner information.
+ *	@sig is the signal that will be sent.  When 0, kernel sends SIGIO.
+ *	Return 0 if permission is granted.
+ * @file_receive:
+ *	This hook allows security modules to control the ability of a process
+ *	to receive an open file descriptor via socket IPC.
+ *	@file contains the file structure being received.
+ *	Return 0 if permission is granted.
+ * @file_open:
+ *	Save open-time permission checking state for later use upon
+ *	file_permission, and recheck access if anything has changed
+ *	since inode_permission.
+ *
+ * Security hooks for task operations.
+ *
+ * @task_alloc:
+ *	@task task being allocated.
+ *	@clone_flags contains the flags indicating what should be shared.
+ *	Handle allocation of task-related resources.
+ *	Returns a zero on success, negative values on failure.
+ * @task_free:
+ *	@task task about to be freed.
+ *	Handle release of task-related resources. (Note that this can be called
+ *	from interrupt context.)
+ * @cred_alloc_blank:
+ *	@cred points to the credentials.
+ *	@gfp indicates the atomicity of any memory allocations.
+ *	Only allocate sufficient memory and attach to @cred such that
+ *	cred_transfer() will not get ENOMEM.
+ * @cred_free:
+ *	@cred points to the credentials.
+ *	Deallocate and clear the cred->security field in a set of credentials.
+ * @cred_prepare:
+ *	@new points to the new credentials.
+ *	@old points to the original credentials.
+ *	@gfp indicates the atomicity of any memory allocations.
+ *	Prepare a new set of credentials by copying the data from the old set.
+ * @cred_transfer:
+ *	@new points to the new credentials.
+ *	@old points to the original credentials.
+ *	Transfer data from original creds to new creds
+ * @kernel_act_as:
+ *	Set the credentials for a kernel service to act as (subjective context).
+ *	@new points to the credentials to be modified.
+ *	@secid specifies the security ID to be set
+ *	The current task must be the one that nominated @secid.
+ *	Return 0 if successful.
+ * @kernel_create_files_as:
+ *	Set the file creation context in a set of credentials to be the same as
+ *	the objective context of the specified inode.
+ *	@new points to the credentials to be modified.
+ *	@inode points to the inode to use as a reference.
+ *	The current task must be the one that nominated @inode.
+ *	Return 0 if successful.
+ * @kernel_module_request:
+ *	Ability to trigger the kernel to automatically upcall to userspace for
+ *	userspace to load a kernel module with the given name.
+ *	@kmod_name name of the module requested by the kernel
+ *	Return 0 if successful.
+ * @kernel_read_file:
+ *	Read a file specified by userspace.
+ *	@file contains the file structure pointing to the file being read
+ *	by the kernel.
+ *	@id kernel read file identifier
+ *	Return 0 if permission is granted.
+ * @kernel_post_read_file:
+ *	Read a file specified by userspace.
+ *	@file contains the file structure pointing to the file being read
+ *	by the kernel.
+ *	@buf pointer to buffer containing the file contents.
+ *	@size length of the file contents.
+ *	@id kernel read file identifier
+ *	Return 0 if permission is granted.
+ * @task_fix_setuid:
+ *	Update the module's state after setting one or more of the user
+ *	identity attributes of the current process.  The @flags parameter
+ *	indicates which of the set*uid system calls invoked this hook.  If
+ *	@new is the set of credentials that will be installed.  Modifications
+ *	should be made to this rather than to @current->cred.
+ *	@old is the set of credentials that are being replaces
+ *	@flags contains one of the LSM_SETID_* values.
+ *	Return 0 on success.
+ * @task_setpgid:
+ *	Check permission before setting the process group identifier of the
+ *	process @p to @pgid.
+ *	@p contains the task_struct for process being modified.
+ *	@pgid contains the new pgid.
+ *	Return 0 if permission is granted.
+ * @task_getpgid:
+ *	Check permission before getting the process group identifier of the
+ *	process @p.
+ *	@p contains the task_struct for the process.
+ *	Return 0 if permission is granted.
+ * @task_getsid:
+ *	Check permission before getting the session identifier of the process
+ *	@p.
+ *	@p contains the task_struct for the process.
+ *	Return 0 if permission is granted.
+ * @task_getsecid:
+ *	Retrieve the security identifier of the process @p.
+ *	@p contains the task_struct for the process and place is into @secid.
+ *	In case of failure, @secid will be set to zero.
+ *
+ * @task_setnice:
+ *	Check permission before setting the nice value of @p to @nice.
+ *	@p contains the task_struct of process.
+ *	@nice contains the new nice value.
+ *	Return 0 if permission is granted.
+ * @task_setioprio
+ *	Check permission before setting the ioprio value of @p to @ioprio.
+ *	@p contains the task_struct of process.
+ *	@ioprio contains the new ioprio value
+ *	Return 0 if permission is granted.
+ * @task_getioprio
+ *	Check permission before getting the ioprio value of @p.
+ *	@p contains the task_struct of process.
+ *	Return 0 if permission is granted.
+ * @task_prlimit:
+ *	Check permission before getting and/or setting the resource limits of
+ *	another task.
+ *	@cred points to the cred structure for the current task.
+ *	@tcred points to the cred structure for the target task.
+ *	@flags contains the LSM_PRLIMIT_* flag bits indicating whether the
+ *	resource limits are being read, modified, or both.
+ *	Return 0 if permission is granted.
+ * @task_setrlimit:
+ *	Check permission before setting the resource limits of process @p
+ *	for @resource to @new_rlim.  The old resource limit values can
+ *	be examined by dereferencing (p->signal->rlim + resource).
+ *	@p points to the task_struct for the target task's group leader.
+ *	@resource contains the resource whose limit is being set.
+ *	@new_rlim contains the new limits for @resource.
+ *	Return 0 if permission is granted.
+ * @task_setscheduler:
+ *	Check permission before setting scheduling policy and/or parameters of
+ *	process @p based on @policy and @lp.
+ *	@p contains the task_struct for process.
+ *	@policy contains the scheduling policy.
+ *	@lp contains the scheduling parameters.
+ *	Return 0 if permission is granted.
+ * @task_getscheduler:
+ *	Check permission before obtaining scheduling information for process
+ *	@p.
+ *	@p contains the task_struct for process.
+ *	Return 0 if permission is granted.
+ * @task_movememory
+ *	Check permission before moving memory owned by process @p.
+ *	@p contains the task_struct for process.
+ *	Return 0 if permission is granted.
+ * @task_kill:
+ *	Check permission before sending signal @sig to @p.  @info can be NULL,
+ *	the constant 1, or a pointer to a siginfo structure.  If @info is 1 or
+ *	SI_FROMKERNEL(info) is true, then the signal should be viewed as coming
+ *	from the kernel and should typically be permitted.
+ *	SIGIO signals are handled separately by the send_sigiotask hook in
+ *	file_security_ops.
+ *	@p contains the task_struct for process.
+ *	@info contains the signal information.
+ *	@sig contains the signal value.
+ *	@secid contains the sid of the process where the signal originated
+ *	Return 0 if permission is granted.
+ * @task_prctl:
+ *	Check permission before performing a process control operation on the
+ *	current process.
+ *	@option contains the operation.
+ *	@arg2 contains a argument.
+ *	@arg3 contains a argument.
+ *	@arg4 contains a argument.
+ *	@arg5 contains a argument.
+ *	Return -ENOSYS if no-one wanted to handle this op, any other value to
+ *	cause prctl() to return immediately with that value.
+ * @task_to_inode:
+ *	Set the security attributes for an inode based on an associated task's
+ *	security attributes, e.g. for /proc/pid inodes.
+ *	@p contains the task_struct for the task.
+ *	@inode contains the inode structure for the inode.
+ *
+ * Security hooks for Netlink messaging.
+ *
+ * @netlink_send:
+ *	Save security information for a netlink message so that permission
+ *	checking can be performed when the message is processed.  The security
+ *	information can be saved using the eff_cap field of the
+ *	netlink_skb_parms structure.  Also may be used to provide fine
+ *	grained control over message transmission.
+ *	@sk associated sock of task sending the message.
+ *	@skb contains the sk_buff structure for the netlink message.
+ *	Return 0 if the information was successfully saved and message
+ *	is allowed to be transmitted.
+ *
+ * Security hooks for Unix domain networking.
+ *
+ * @unix_stream_connect:
+ *	Check permissions before establishing a Unix domain stream connection
+ *	between @sock and @other.
+ *	@sock contains the sock structure.
+ *	@other contains the peer sock structure.
+ *	@newsk contains the new sock structure.
+ *	Return 0 if permission is granted.
+ * @unix_may_send:
+ *	Check permissions before connecting or sending datagrams from @sock to
+ *	@other.
+ *	@sock contains the socket structure.
+ *	@other contains the peer socket structure.
+ *	Return 0 if permission is granted.
+ *
+ * The @unix_stream_connect and @unix_may_send hooks were necessary because
+ * Linux provides an alternative to the conventional file name space for Unix
+ * domain sockets.  Whereas binding and connecting to sockets in the file name
+ * space is mediated by the typical file permissions (and caught by the mknod
+ * and permission hooks in inode_security_ops), binding and connecting to
+ * sockets in the abstract name space is completely unmediated.  Sufficient
+ * control of Unix domain sockets in the abstract name space isn't possible
+ * using only the socket layer hooks, since we need to know the actual target
+ * socket, which is not looked up until we are inside the af_unix code.
+ *
+ * Security hooks for socket operations.
+ *
+ * @socket_create:
+ *	Check permissions prior to creating a new socket.
+ *	@family contains the requested protocol family.
+ *	@type contains the requested communications type.
+ *	@protocol contains the requested protocol.
+ *	@kern set to 1 if a kernel socket.
+ *	Return 0 if permission is granted.
+ * @socket_post_create:
+ *	This hook allows a module to update or allocate a per-socket security
+ *	structure. Note that the security field was not added directly to the
+ *	socket structure, but rather, the socket security information is stored
+ *	in the associated inode.  Typically, the inode alloc_security hook will
+ *	allocate and and attach security information to
+ *	sock->inode->i_security.  This hook may be used to update the
+ *	sock->inode->i_security field with additional information that wasn't
+ *	available when the inode was allocated.
+ *	@sock contains the newly created socket structure.
+ *	@family contains the requested protocol family.
+ *	@type contains the requested communications type.
+ *	@protocol contains the requested protocol.
+ *	@kern set to 1 if a kernel socket.
+ * @socket_bind:
+ *	Check permission before socket protocol layer bind operation is
+ *	performed and the socket @sock is bound to the address specified in the
+ *	@address parameter.
+ *	@sock contains the socket structure.
+ *	@address contains the address to bind to.
+ *	@addrlen contains the length of address.
+ *	Return 0 if permission is granted.
+ * @socket_connect:
+ *	Check permission before socket protocol layer connect operation
+ *	attempts to connect socket @sock to a remote address, @address.
+ *	@sock contains the socket structure.
+ *	@address contains the address of remote endpoint.
+ *	@addrlen contains the length of address.
+ *	Return 0 if permission is granted.
+ * @socket_listen:
+ *	Check permission before socket protocol layer listen operation.
+ *	@sock contains the socket structure.
+ *	@backlog contains the maximum length for the pending connection queue.
+ *	Return 0 if permission is granted.
+ * @socket_accept:
+ *	Check permission before accepting a new connection.  Note that the new
+ *	socket, @newsock, has been created and some information copied to it,
+ *	but the accept operation has not actually been performed.
+ *	@sock contains the listening socket structure.
+ *	@newsock contains the newly created server socket for connection.
+ *	Return 0 if permission is granted.
+ * @socket_sendmsg:
+ *	Check permission before transmitting a message to another socket.
+ *	@sock contains the socket structure.
+ *	@msg contains the message to be transmitted.
+ *	@size contains the size of message.
+ *	Return 0 if permission is granted.
+ * @socket_recvmsg:
+ *	Check permission before receiving a message from a socket.
+ *	@sock contains the socket structure.
+ *	@msg contains the message structure.
+ *	@size contains the size of message structure.
+ *	@flags contains the operational flags.
+ *	Return 0 if permission is granted.
+ * @socket_getsockname:
+ *	Check permission before the local address (name) of the socket object
+ *	@sock is retrieved.
+ *	@sock contains the socket structure.
+ *	Return 0 if permission is granted.
+ * @socket_getpeername:
+ *	Check permission before the remote address (name) of a socket object
+ *	@sock is retrieved.
+ *	@sock contains the socket structure.
+ *	Return 0 if permission is granted.
+ * @socket_getsockopt:
+ *	Check permissions before retrieving the options associated with socket
+ *	@sock.
+ *	@sock contains the socket structure.
+ *	@level contains the protocol level to retrieve option from.
+ *	@optname contains the name of option to retrieve.
+ *	Return 0 if permission is granted.
+ * @socket_setsockopt:
+ *	Check permissions before setting the options associated with socket
+ *	@sock.
+ *	@sock contains the socket structure.
+ *	@level contains the protocol level to set options for.
+ *	@optname contains the name of the option to set.
+ *	Return 0 if permission is granted.
+ * @socket_shutdown:
+ *	Checks permission before all or part of a connection on the socket
+ *	@sock is shut down.
+ *	@sock contains the socket structure.
+ *	@how contains the flag indicating how future sends and receives
+ *	are handled.
+ *	Return 0 if permission is granted.
+ * @socket_sock_rcv_skb:
+ *	Check permissions on incoming network packets.  This hook is distinct
+ *	from Netfilter's IP input hooks since it is the first time that the
+ *	incoming sk_buff @skb has been associated with a particular socket, @sk.
+ *	Must not sleep inside this hook because some callers hold spinlocks.
+ *	@sk contains the sock (not socket) associated with the incoming sk_buff.
+ *	@skb contains the incoming network data.
+ * @socket_getpeersec_stream:
+ *	This hook allows the security module to provide peer socket security
+ *	state for unix or connected tcp sockets to userspace via getsockopt
+ *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
+ *	socket is associated with an ipsec SA.
+ *	@sock is the local socket.
+ *	@optval userspace memory where the security state is to be copied.
+ *	@optlen userspace int where the module should copy the actual length
+ *	of the security state.
+ *	@len as input is the maximum length to copy to userspace provided
+ *	by the caller.
+ *	Return 0 if all is well, otherwise, typical getsockopt return
+ *	values.
+ * @socket_getpeersec_dgram:
+ *	This hook allows the security module to provide peer socket security
+ *	state for udp sockets on a per-packet basis to userspace via
+ *	getsockopt SO_GETPEERSEC.  The application must first have indicated
+ *	the IP_PASSSEC option via getsockopt.  It can then retrieve the
+ *	security state returned by this hook for a packet via the SCM_SECURITY
+ *	ancillary message type.
+ *	@skb is the skbuff for the packet being queried
+ *	@secdata is a pointer to a buffer in which to copy the security data
+ *	@seclen is the maximum length for @secdata
+ *	Return 0 on success, error on failure.
+ * @sk_alloc_security:
+ *	Allocate and attach a security structure to the sk->sk_security field,
+ *	which is used to copy security attributes between local stream sockets.
+ * @sk_free_security:
+ *	Deallocate security structure.
+ * @sk_clone_security:
+ *	Clone/copy security structure.
+ * @sk_getsecid:
+ *	Retrieve the LSM-specific secid for the sock to enable caching
+ *	of network authorizations.
+ * @sock_graft:
+ *	Sets the socket's isec sid to the sock's sid.
+ * @inet_conn_request:
+ *	Sets the openreq's sid to socket's sid with MLS portion taken
+ *	from peer sid.
+ * @inet_csk_clone:
+ *	Sets the new child socket's sid to the openreq sid.
+ * @inet_conn_established:
+ *	Sets the connection's peersid to the secmark on skb.
+ * @secmark_relabel_packet:
+ *	check if the process should be allowed to relabel packets to
+ *	the given secid
+ * @security_secmark_refcount_inc
+ *	tells the LSM to increment the number of secmark labeling rules loaded
+ * @security_secmark_refcount_dec
+ *	tells the LSM to decrement the number of secmark labeling rules loaded
+ * @req_classify_flow:
+ *	Sets the flow's sid to the openreq sid.
+ * @tun_dev_alloc_security:
+ *	This hook allows a module to allocate a security structure for a TUN
+ *	device.
+ *	@security pointer to a security structure pointer.
+ *	Returns a zero on success, negative values on failure.
+ * @tun_dev_free_security:
+ *	This hook allows a module to free the security structure for a TUN
+ *	device.
+ *	@security pointer to the TUN device's security structure
+ * @tun_dev_create:
+ *	Check permissions prior to creating a new TUN device.
+ * @tun_dev_attach_queue:
+ *	Check permissions prior to attaching to a TUN device queue.
+ *	@security pointer to the TUN device's security structure.
+ * @tun_dev_attach:
+ *	This hook can be used by the module to update any security state
+ *	associated with the TUN device's sock structure.
+ *	@sk contains the existing sock structure.
+ *	@security pointer to the TUN device's security structure.
+ * @tun_dev_open:
+ *	This hook can be used by the module to update any security state
+ *	associated with the TUN device's security structure.
+ *	@security pointer to the TUN devices's security structure.
+ *
+ * Security hooks for Infiniband
+ *
+ * @ib_pkey_access:
+ *	Check permission to access a pkey when modifing a QP.
+ *	@subnet_prefix the subnet prefix of the port being used.
+ *	@pkey the pkey to be accessed.
+ *	@sec pointer to a security structure.
+ * @ib_endport_manage_subnet:
+ *	Check permissions to send and receive SMPs on a end port.
+ *	@dev_name the IB device name (i.e. mlx4_0).
+ *	@port_num the port number.
+ *	@sec pointer to a security structure.
+ * @ib_alloc_security:
+ *	Allocate a security structure for Infiniband objects.
+ *	@sec pointer to a security structure pointer.
+ *	Returns 0 on success, non-zero on failure
+ * @ib_free_security:
+ *	Deallocate an Infiniband security structure.
+ *	@sec contains the security structure to be freed.
+ *
+ * Security hooks for XFRM operations.
+ *
+ * @xfrm_policy_alloc_security:
+ *	@ctxp is a pointer to the xfrm_sec_ctx being added to Security Policy
+ *	Database used by the XFRM system.
+ *	@sec_ctx contains the security context information being provided by
+ *	the user-level policy update program (e.g., setkey).
+ *	Allocate a security structure to the xp->security field; the security
+ *	field is initialized to NULL when the xfrm_policy is allocated.
+ *	Return 0 if operation was successful (memory to allocate, legal context)
+ *	@gfp is to specify the context for the allocation
+ * @xfrm_policy_clone_security:
+ *	@old_ctx contains an existing xfrm_sec_ctx.
+ *	@new_ctxp contains a new xfrm_sec_ctx being cloned from old.
+ *	Allocate a security structure in new_ctxp that contains the
+ *	information from the old_ctx structure.
+ *	Return 0 if operation was successful (memory to allocate).
+ * @xfrm_policy_free_security:
+ *	@ctx contains the xfrm_sec_ctx
+ *	Deallocate xp->security.
+ * @xfrm_policy_delete_security:
+ *	@ctx contains the xfrm_sec_ctx.
+ *	Authorize deletion of xp->security.
+ * @xfrm_state_alloc:
+ *	@x contains the xfrm_state being added to the Security Association
+ *	Database by the XFRM system.
+ *	@sec_ctx contains the security context information being provided by
+ *	the user-level SA generation program (e.g., setkey or racoon).
+ *	Allocate a security structure to the x->security field; the security
+ *	field is initialized to NULL when the xfrm_state is allocated. Set the
+ *	context to correspond to sec_ctx. Return 0 if operation was successful
+ *	(memory to allocate, legal context).
+ * @xfrm_state_alloc_acquire:
+ *	@x contains the xfrm_state being added to the Security Association
+ *	Database by the XFRM system.
+ *	@polsec contains the policy's security context.
+ *	@secid contains the secid from which to take the mls portion of the
+ *	context.
+ *	Allocate a security structure to the x->security field; the security
+ *	field is initialized to NULL when the xfrm_state is allocated. Set the
+ *	context to correspond to secid. Return 0 if operation was successful
+ *	(memory to allocate, legal context).
+ * @xfrm_state_free_security:
+ *	@x contains the xfrm_state.
+ *	Deallocate x->security.
+ * @xfrm_state_delete_security:
+ *	@x contains the xfrm_state.
+ *	Authorize deletion of x->security.
+ * @xfrm_policy_lookup:
+ *	@ctx contains the xfrm_sec_ctx for which the access control is being
+ *	checked.
+ *	@fl_secid contains the flow security label that is used to authorize
+ *	access to the policy xp.
+ *	@dir contains the direction of the flow (input or output).
+ *	Check permission when a flow selects a xfrm_policy for processing
+ *	XFRMs on a packet.  The hook is called when selecting either a
+ *	per-socket policy or a generic xfrm policy.
+ *	Return 0 if permission is granted, -ESRCH otherwise, or -errno
+ *	on other errors.
+ * @xfrm_state_pol_flow_match:
+ *	@x contains the state to match.
+ *	@xp contains the policy to check for a match.
+ *	@fl contains the flow to check for a match.
+ *	Return 1 if there is a match.
+ * @xfrm_decode_session:
+ *	@skb points to skb to decode.
+ *	@secid points to the flow key secid to set.
+ *	@ckall says if all xfrms used should be checked for same secid.
+ *	Return 0 if ckall is zero or all xfrms used have the same secid.
+ *
+ * Security hooks affecting all Key Management operations
+ *
+ * @key_alloc:
+ *	Permit allocation of a key and assign security data. Note that key does
+ *	not have a serial number assigned at this point.
+ *	@key points to the key.
+ *	@flags is the allocation flags
+ *	Return 0 if permission is granted, -ve error otherwise.
+ * @key_free:
+ *	Notification of destruction; free security data.
+ *	@key points to the key.
+ *	No return value.
+ * @key_permission:
+ *	See whether a specific operational right is granted to a process on a
+ *	key.
+ *	@key_ref refers to the key (key pointer + possession attribute bit).
+ *	@cred points to the credentials to provide the context against which to
+ *	evaluate the security data on the key.
+ *	@perm describes the combination of permissions required of this key.
+ *	Return 0 if permission is granted, -ve error otherwise.
+ * @key_getsecurity:
+ *	Get a textual representation of the security context attached to a key
+ *	for the purposes of honouring KEYCTL_GETSECURITY.  This function
+ *	allocates the storage for the NUL-terminated string and the caller
+ *	should free it.
+ *	@key points to the key to be queried.
+ *	@_buffer points to a pointer that should be set to point to the
+ *	resulting string (if no label or an error occurs).
+ *	Return the length of the string (including terminating NUL) or -ve if
+ *	an error.
+ *	May also return 0 (and a NULL buffer pointer) if there is no label.
+ *
+ * Security hooks affecting all System V IPC operations.
+ *
+ * @ipc_permission:
+ *	Check permissions for access to IPC
+ *	@ipcp contains the kernel IPC permission structure
+ *	@flag contains the desired (requested) permission set
+ *	Return 0 if permission is granted.
+ * @ipc_getsecid:
+ *	Get the secid associated with the ipc object.
+ *	@ipcp contains the kernel IPC permission structure.
+ *	@secid contains a pointer to the location where result will be saved.
+ *	In case of failure, @secid will be set to zero.
+ *
+ * Security hooks for individual messages held in System V IPC message queues
+ * @msg_msg_alloc_security:
+ *	Allocate and attach a security structure to the msg->security field.
+ *	The security field is initialized to NULL when the structure is first
+ *	created.
+ *	@msg contains the message structure to be modified.
+ *	Return 0 if operation was successful and permission is granted.
+ * @msg_msg_free_security:
+ *	Deallocate the security structure for this message.
+ *	@msg contains the message structure to be modified.
+ *
+ * Security hooks for System V IPC Message Queues
+ *
+ * @msg_queue_alloc_security:
+ *	Allocate and attach a security structure to the
+ *	msq->q_perm.security field. The security field is initialized to
+ *	NULL when the structure is first created.
+ *	@msq contains the message queue structure to be modified.
+ *	Return 0 if operation was successful and permission is granted.
+ * @msg_queue_free_security:
+ *	Deallocate security structure for this message queue.
+ *	@msq contains the message queue structure to be modified.
+ * @msg_queue_associate:
+ *	Check permission when a message queue is requested through the
+ *	msgget system call.  This hook is only called when returning the
+ *	message queue identifier for an existing message queue, not when a
+ *	new message queue is created.
+ *	@msq contains the message queue to act upon.
+ *	@msqflg contains the operation control flags.
+ *	Return 0 if permission is granted.
+ * @msg_queue_msgctl:
+ *	Check permission when a message control operation specified by @cmd
+ *	is to be performed on the message queue @msq.
+ *	The @msq may be NULL, e.g. for IPC_INFO or MSG_INFO.
+ *	@msq contains the message queue to act upon.  May be NULL.
+ *	@cmd contains the operation to be performed.
+ *	Return 0 if permission is granted.
+ * @msg_queue_msgsnd:
+ *	Check permission before a message, @msg, is enqueued on the message
+ *	queue, @msq.
+ *	@msq contains the message queue to send message to.
+ *	@msg contains the message to be enqueued.
+ *	@msqflg contains operational flags.
+ *	Return 0 if permission is granted.
+ * @msg_queue_msgrcv:
+ *	Check permission before a message, @msg, is removed from the message
+ *	queue, @msq.  The @target task structure contains a pointer to the
+ *	process that will be receiving the message (not equal to the current
+ *	process when inline receives are being performed).
+ *	@msq contains the message queue to retrieve message from.
+ *	@msg contains the message destination.
+ *	@target contains the task structure for recipient process.
+ *	@type contains the type of message requested.
+ *	@mode contains the operational flags.
+ *	Return 0 if permission is granted.
+ *
+ * Security hooks for System V Shared Memory Segments
+ *
+ * @shm_alloc_security:
+ *	Allocate and attach a security structure to the shp->shm_perm.security
+ *	field.  The security field is initialized to NULL when the structure is
+ *	first created.
+ *	@shp contains the shared memory structure to be modified.
+ *	Return 0 if operation was successful and permission is granted.
+ * @shm_free_security:
+ *	Deallocate the security struct for this memory segment.
+ *	@shp contains the shared memory structure to be modified.
+ * @shm_associate:
+ *	Check permission when a shared memory region is requested through the
+ *	shmget system call.  This hook is only called when returning the shared
+ *	memory region identifier for an existing region, not when a new shared
+ *	memory region is created.
+ *	@shp contains the shared memory structure to be modified.
+ *	@shmflg contains the operation control flags.
+ *	Return 0 if permission is granted.
+ * @shm_shmctl:
+ *	Check permission when a shared memory control operation specified by
+ *	@cmd is to be performed on the shared memory region @shp.
+ *	The @shp may be NULL, e.g. for IPC_INFO or SHM_INFO.
+ *	@shp contains shared memory structure to be modified.
+ *	@cmd contains the operation to be performed.
+ *	Return 0 if permission is granted.
+ * @shm_shmat:
+ *	Check permissions prior to allowing the shmat system call to attach the
+ *	shared memory segment @shp to the data segment of the calling process.
+ *	The attaching address is specified by @shmaddr.
+ *	@shp contains the shared memory structure to be modified.
+ *	@shmaddr contains the address to attach memory region to.
+ *	@shmflg contains the operational flags.
+ *	Return 0 if permission is granted.
+ *
+ * Security hooks for System V Semaphores
+ *
+ * @sem_alloc_security:
+ *	Allocate and attach a security structure to the sma->sem_perm.security
+ *	field.  The security field is initialized to NULL when the structure is
+ *	first created.
+ *	@sma contains the semaphore structure
+ *	Return 0 if operation was successful and permission is granted.
+ * @sem_free_security:
+ *	deallocate security struct for this semaphore
+ *	@sma contains the semaphore structure.
+ * @sem_associate:
+ *	Check permission when a semaphore is requested through the semget
+ *	system call.  This hook is only called when returning the semaphore
+ *	identifier for an existing semaphore, not when a new one must be
+ *	created.
+ *	@sma contains the semaphore structure.
+ *	@semflg contains the operation control flags.
+ *	Return 0 if permission is granted.
+ * @sem_semctl:
+ *	Check permission when a semaphore operation specified by @cmd is to be
+ *	performed on the semaphore @sma.  The @sma may be NULL, e.g. for
+ *	IPC_INFO or SEM_INFO.
+ *	@sma contains the semaphore structure.  May be NULL.
+ *	@cmd contains the operation to be performed.
+ *	Return 0 if permission is granted.
+ * @sem_semop:
+ *	Check permissions before performing operations on members of the
+ *	semaphore set @sma.  If the @alter flag is nonzero, the semaphore set
+ *	may be modified.
+ *	@sma contains the semaphore structure.
+ *	@sops contains the operations to perform.
+ *	@nsops contains the number of operations to perform.
+ *	@alter contains the flag indicating whether changes are to be made.
+ *	Return 0 if permission is granted.
+ *
+ * @binder_set_context_mgr:
+ *	Check whether @mgr is allowed to be the binder context manager.
+ *	@mgr contains the task_struct for the task being registered.
+ *	Return 0 if permission is granted.
+ * @binder_transaction:
+ *	Check whether @from is allowed to invoke a binder transaction call
+ *	to @to.
+ *	@from contains the task_struct for the sending task.
+ *	@to contains the task_struct for the receiving task.
+ * @binder_transfer_binder:
+ *	Check whether @from is allowed to transfer a binder reference to @to.
+ *	@from contains the task_struct for the sending task.
+ *	@to contains the task_struct for the receiving task.
+ * @binder_transfer_file:
+ *	Check whether @from is allowed to transfer @file to @to.
+ *	@from contains the task_struct for the sending task.
+ *	@file contains the struct file being transferred.
+ *	@to contains the task_struct for the receiving task.
+ *
+ * @ptrace_access_check:
+ *	Check permission before allowing the current process to trace the
+ *	@child process.
+ *	Security modules may also want to perform a process tracing check
+ *	during an execve in the set_security or apply_creds hooks of
+ *	tracing check during an execve in the bprm_set_creds hook of
+ *	binprm_security_ops if the process is being traced and its security
+ *	attributes would be changed by the execve.
+ *	@child contains the task_struct structure for the target process.
+ *	@mode contains the PTRACE_MODE flags indicating the form of access.
+ *	Return 0 if permission is granted.
+ * @ptrace_traceme:
+ *	Check that the @parent process has sufficient permission to trace the
+ *	current process before allowing the current process to present itself
+ *	to the @parent process for tracing.
+ *	@parent contains the task_struct structure for debugger process.
+ *	Return 0 if permission is granted.
+ * @capget:
+ *	Get the @effective, @inheritable, and @permitted capability sets for
+ *	the @target process.  The hook may also perform permission checking to
+ *	determine if the current process is allowed to see the capability sets
+ *	of the @target process.
+ *	@target contains the task_struct structure for target process.
+ *	@effective contains the effective capability set.
+ *	@inheritable contains the inheritable capability set.
+ *	@permitted contains the permitted capability set.
+ *	Return 0 if the capability sets were successfully obtained.
+ * @capset:
+ *	Set the @effective, @inheritable, and @permitted capability sets for
+ *	the current process.
+ *	@new contains the new credentials structure for target process.
+ *	@old contains the current credentials structure for target process.
+ *	@effective contains the effective capability set.
+ *	@inheritable contains the inheritable capability set.
+ *	@permitted contains the permitted capability set.
+ *	Return 0 and update @new if permission is granted.
+ * @capable:
+ *	Check whether the @tsk process has the @cap capability in the indicated
+ *	credentials.
+ *	@cred contains the credentials to use.
+ *	@ns contains the user namespace we want the capability in
+ *	@cap contains the capability <include/linux/capability.h>.
+ *	@audit contains whether to write an audit message or not
+ *	Return 0 if the capability is granted for @tsk.
+ * @syslog:
+ *	Check permission before accessing the kernel message ring or changing
+ *	logging to the console.
+ *	See the syslog(2) manual page for an explanation of the @type values.
+ *	@type contains the type of action.
+ *	@from_file indicates the context of action (if it came from /proc).
+ *	Return 0 if permission is granted.
+ * @settime:
+ *	Check permission to change the system time.
+ *	struct timespec64 is defined in include/linux/time64.h and timezone
+ *	is defined in include/linux/time.h
+ *	@ts contains new time
+ *	@tz contains new timezone
+ *	Return 0 if permission is granted.
+ * @vm_enough_memory:
+ *	Check permissions for allocating a new virtual mapping.
+ *	@mm contains the mm struct it is being added to.
+ *	@pages contains the number of pages.
+ *	Return 0 if permission is granted.
+ *
+ * @ismaclabel:
+ *	Check if the extended attribute specified by @name
+ *	represents a MAC label. Returns 1 if name is a MAC
+ *	attribute otherwise returns 0.
+ *	@name full extended attribute name to check against
+ *	LSM as a MAC label.
+ *
+ * @secid_to_secctx:
+ *	Convert secid to security context.  If secdata is NULL the length of
+ *	the result will be returned in seclen, but no secdata will be returned.
+ *	This does mean that the length could change between calls to check the
+ *	length and the next call which actually allocates and returns the
+ *	secdata.
+ *	@secid contains the security ID.
+ *	@secdata contains the pointer that stores the converted security
+ *	context.
+ *	@seclen pointer which contains the length of the data
+ * @secctx_to_secid:
+ *	Convert security context to secid.
+ *	@secid contains the pointer to the generated security ID.
+ *	@secdata contains the security context.
+ *
+ * @release_secctx:
+ *	Release the security context.
+ *	@secdata contains the security context.
+ *	@seclen contains the length of the security context.
+ *
+ * Security hooks for Audit
+ *
+ * @audit_rule_init:
+ *	Allocate and initialize an LSM audit rule structure.
+ *	@field contains the required Audit action.
+ *	Fields flags are defined in include/linux/audit.h
+ *	@op contains the operator the rule uses.
+ *	@rulestr contains the context where the rule will be applied to.
+ *	@lsmrule contains a pointer to receive the result.
+ *	Return 0 if @lsmrule has been successfully set,
+ *	-EINVAL in case of an invalid rule.
+ *
+ * @audit_rule_known:
+ *	Specifies whether given @rule contains any fields related to
+ *	current LSM.
+ *	@rule contains the audit rule of interest.
+ *	Return 1 in case of relation found, 0 otherwise.
+ *
+ * @audit_rule_match:
+ *	Determine if given @secid matches a rule previously approved
+ *	by @audit_rule_known.
+ *	@secid contains the security id in question.
+ *	@field contains the field which relates to current LSM.
+ *	@op contains the operator that will be used for matching.
+ *	@rule points to the audit rule that will be checked against.
+ *	@actx points to the audit context associated with the check.
+ *	Return 1 if secid matches the rule, 0 if it does not, -ERRNO on failure.
+ *
+ * @audit_rule_free:
+ *	Deallocate the LSM audit rule structure previously allocated by
+ *	audit_rule_init.
+ *	@rule contains the allocated rule
+ *
+ * @inode_invalidate_secctx:
+ *	Notify the security module that it must revalidate the security context
+ *	of an inode.
+ *
+ * @inode_notifysecctx:
+ *	Notify the security module of what the security context of an inode
+ *	should be.  Initializes the incore security context managed by the
+ *	security module for this inode.  Example usage:  NFS client invokes
+ *	this hook to initialize the security context in its incore inode to the
+ *	value provided by the server for the file when the server returned the
+ *	file's attributes to the client.
+ *
+ *	Must be called with inode->i_mutex locked.
+ *
+ *	@inode we wish to set the security context of.
+ *	@ctx contains the string which we wish to set in the inode.
+ *	@ctxlen contains the length of @ctx.
+ *
+ * @inode_setsecctx:
+ *	Change the security context of an inode.  Updates the
+ *	incore security context managed by the security module and invokes the
+ *	fs code as needed (via __vfs_setxattr_noperm) to update any backing
+ *	xattrs that represent the context.  Example usage:  NFS server invokes
+ *	this hook to change the security context in its incore inode and on the
+ *	backing filesystem to a value provided by the client on a SETATTR
+ *	operation.
+ *
+ *	Must be called with inode->i_mutex locked.
+ *
+ *	@dentry contains the inode we wish to set the security context of.
+ *	@ctx contains the string which we wish to set in the inode.
+ *	@ctxlen contains the length of @ctx.
+ *
+ * @inode_getsecctx:
+ *	On success, returns 0 and fills out @ctx and @ctxlen with the security
+ *	context for the given @inode.
+ *
+ *	@inode we wish to get the security context of.
+ *	@ctx is a pointer in which to place the allocated security context.
+ *	@ctxlen points to the place to put the length of @ctx.
+ *
+ * Security hooks for using the eBPF maps and programs functionalities through
+ * eBPF syscalls.
+ *
+ * @bpf:
+ *	Do a initial check for all bpf syscalls after the attribute is copied
+ *	into the kernel. The actual security module can implement their own
+ *	rules to check the specific cmd they need.
+ *
+ * @bpf_map:
+ *	Do a check when the kernel generate and return a file descriptor for
+ *	eBPF maps.
+ *
+ *	@map: bpf map that we want to access
+ *	@mask: the access flags
+ *
+ * @bpf_prog:
+ *	Do a check when the kernel generate and return a file descriptor for
+ *	eBPF programs.
+ *
+ *	@prog: bpf prog that userspace want to use.
+ *
+ * @bpf_map_alloc_security:
+ *	Initialize the security field inside bpf map.
+ *
+ * @bpf_map_free_security:
+ *	Clean up the security information stored inside bpf map.
+ *
+ * @bpf_prog_alloc_security:
+ *	Initialize the security field inside bpf program.
+ *
+ * @bpf_prog_free_security:
+ *	Clean up the security information stored inside bpf prog.
+ *
+ */
+
+#define INT_HOOK_SEC_SUFFIX(name, ...)	\
+	INT_HOOK_INT(name ## _security, __VA_ARGS__)	\
+	INT_HOOK_EXT(name, __VA_ARGS__)
+
+#define VOID_HOOK_SEC_SUFFIX(name, ...)	\
+	VOID_HOOK_INT(name ## _security, __VA_ARGS__)	\
+	VOID_HOOK_EXT(name, __VA_ARGS__)
+
+INT_HOOK(binder_set_context_mgr, struct task_struct *mgr);
+INT_HOOK(binder_transaction, struct task_struct *from, struct task_struct *to);
+INT_HOOK(binder_transfer_binder, struct task_struct *from,
+	 struct task_struct *to);
+INT_HOOK(binder_transfer_file, struct task_struct *from, struct task_struct *to,
+	 struct file *file);
+INT_HOOK(ptrace_access_check, struct task_struct *child, unsigned int mode);
+INT_HOOK(ptrace_traceme, struct task_struct *parent);
+INT_HOOK(capget, struct task_struct *target, kernel_cap_t *effective,
+	 kernel_cap_t *inheritable, kernel_cap_t *permitted);
+INT_HOOK(capset, struct cred *new, const struct cred *old,
+	 const kernel_cap_t *effective, const kernel_cap_t *inheritable,
+	 const kernel_cap_t *permitted);
+INT_HOOK_INT(capable, const struct cred *cred, struct user_namespace *ns,
+	     int cap, int audit);
+INT_HOOK_EXT(capable, const struct cred *cred, struct user_namespace *ns,
+	     int cap);
+INT_HOOK_EXT(capable_noaudit, const struct cred *cred,
+	     struct user_namespace *ns, int cap);
+INT_HOOK(quotactl, int cmds, int type, int id, struct super_block *sb);
+INT_HOOK(quota_on, struct dentry *dentry);
+INT_HOOK(syslog, int type);
+INT_HOOK(settime, const struct timespec64 *ts, const struct timezone *tz);
+INT_HOOK_INT(vm_enough_memory, struct mm_struct *mm, long pages);
+INT_HOOK_EXT(vm_enough_memory_mm, struct mm_struct *mm, long pages);
+INT_HOOK(bprm_set_creds, struct linux_binprm *bprm);
+INT_HOOK_SEC_SUFFIX(bprm_check, struct linux_binprm *bprm);
+VOID_HOOK(bprm_committing_creds, struct linux_binprm *bprm);
+VOID_HOOK(bprm_committed_creds, struct linux_binprm *bprm);
+INT_HOOK_SEC_SUFFIX(sb_alloc, struct super_block *sb);
+VOID_HOOK_SEC_SUFFIX(sb_free, struct super_block *sb);
+INT_HOOK(sb_copy_data, char *orig, char *copy);
+INT_HOOK(sb_remount, struct super_block *sb, void *data);
+INT_HOOK(sb_kern_mount, struct super_block *sb, int flags, void *data);
+INT_HOOK(sb_show_options, struct seq_file *m, struct super_block *sb);
+INT_HOOK(sb_statfs, struct dentry *dentry);
+INT_HOOK(sb_mount, const char *dev_name, const struct path *path,
+	 const char *type, unsigned long flags, void *data);
+INT_HOOK(sb_umount, struct vfsmount *mnt, int flags);
+INT_HOOK(sb_pivotroot, const struct path *old_path,
+	 const struct path *new_path);
+INT_HOOK(sb_set_mnt_opts, struct super_block *sb,
+	 struct security_mnt_opts *opts, unsigned long kern_flags,
+	 unsigned long *set_kern_flags);
+INT_HOOK(sb_clone_mnt_opts, const struct super_block *oldsb,
+	 struct super_block *newsb, unsigned long kern_flags,
+	 unsigned long *set_kern_flags);
+INT_HOOK(sb_parse_opts_str, char *options, struct security_mnt_opts *opts);
+INT_HOOK(dentry_init_security, struct dentry *dentry, int mode,
+	 const struct qstr *name, void **ctx, u32 *ctxlen);
+INT_HOOK(dentry_create_files_as, struct dentry *dentry, int mode,
+	 struct qstr *name, const struct cred *old, struct cred *new);
+
+#ifdef CONFIG_SECURITY_PATH
+INT_HOOK(path_unlink, const struct path *dir, struct dentry *dentry);
+INT_HOOK(path_mkdir, const struct path *dir, struct dentry *dentry,
+	 umode_t mode);
+INT_HOOK(path_rmdir, const struct path *dir, struct dentry *dentry);
+INT_HOOK(path_mknod, const struct path *dir, struct dentry *dentry,
+	 umode_t mode, unsigned int dev);
+INT_HOOK(path_truncate, const struct path *path);
+INT_HOOK(path_symlink, const struct path *dir, struct dentry *dentry,
+	 const char *old_name);
+INT_HOOK(path_link, struct dentry *old_dentry, const struct path *new_dir,
+	 struct dentry *new_dentry);
+INT_HOOK_INT(path_rename, const struct path *old_dir, struct dentry *old_dentry,
+	     const struct path *new_dir, struct dentry *new_dentry);
+INT_HOOK_EXT(path_rename, const struct path *old_dir, struct dentry *old_dentry,
+	     const struct path *new_dir, struct dentry *new_dentry,
+	     unsigned int flags);
+INT_HOOK(path_chmod, const struct path *path, umode_t mode);
+INT_HOOK(path_chown, const struct path *path, kuid_t uid, kgid_t gid);
+INT_HOOK(path_chroot, const struct path *path);
+#endif
+
+INT_HOOK_SEC_SUFFIX(inode_alloc, struct inode *inode);
+VOID_HOOK_SEC_SUFFIX(inode_free, struct inode *inode);
+INT_HOOK_INT(inode_init_security, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, const char **name, void **value,
+	     size_t *len);
+INT_HOOK_EXT(inode_init_security, struct inode *inode, struct inode *dir,
+	     const struct qstr *qstr, const initxattrs initxattrs,
+	     void *fs_data);
+INT_HOOK(inode_create, struct inode *dir, struct dentry *dentry, umode_t mode);
+INT_HOOK(inode_link, struct dentry *old_dentry, struct inode *dir,
+	 struct dentry *new_dentry);
+INT_HOOK(inode_unlink, struct inode *dir, struct dentry *dentry);
+INT_HOOK(inode_symlink, struct inode *dir, struct dentry *dentry,
+	 const char *old_name);
+INT_HOOK(inode_mkdir, struct inode *dir, struct dentry *dentry,
+	 umode_t mode);
+INT_HOOK(inode_rmdir, struct inode *dir, struct dentry *dentry);
+INT_HOOK(inode_mknod, struct inode *dir, struct dentry *dentry, umode_t mode,
+	 dev_t dev);
+INT_HOOK_INT(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
+	     struct inode *new_dir, struct dentry *new_dentry);
+INT_HOOK_EXT(inode_rename, struct inode *old_dir, struct dentry *old_dentry,
+	     struct inode *new_dir, struct dentry *new_dentry,
+	     unsigned int flags);
+INT_HOOK(inode_readlink, struct dentry *dentry);
+INT_HOOK(inode_follow_link, struct dentry *dentry, struct inode *inode,
+	 bool rcu);
+INT_HOOK(inode_permission, struct inode *inode, int mask);
+INT_HOOK(inode_setattr, struct dentry *dentry, struct iattr *attr);
+INT_HOOK(inode_getattr, const struct path *path);
+INT_HOOK(inode_setxattr, struct dentry *dentry, const char *name,
+	 const void *value, size_t size, int flags);
+VOID_HOOK(inode_post_setxattr, struct dentry *dentry, const char *name,
+	 const void *value, size_t size, int flags);
+INT_HOOK(inode_getxattr, struct dentry *dentry, const char *name);
+INT_HOOK(inode_listxattr, struct dentry *dentry);
+INT_HOOK(inode_removexattr, struct dentry *dentry, const char *name);
+INT_HOOK(inode_need_killpriv, struct dentry *dentry);
+INT_HOOK(inode_killpriv, struct dentry *dentry);
+INT_HOOK(inode_getsecurity, struct inode *inode, const char *name,
+	 void **buffer, bool alloc);
+INT_HOOK(inode_setsecurity, struct inode *inode, const char *name,
+	 const void *value, size_t size, int flags);
+INT_HOOK(inode_listsecurity, struct inode *inode, char *buffer,
+	 size_t buffer_size);
+VOID_HOOK(inode_getsecid, struct inode *inode, u32 *secid);
+INT_HOOK(inode_copy_up, struct dentry *src, struct cred **new);
+INT_HOOK(inode_copy_up_xattr, const char *name);
+INT_HOOK(file_permission, struct file *file, int mask);
+INT_HOOK_SEC_SUFFIX(file_alloc, struct file *file);
+VOID_HOOK_SEC_SUFFIX(file_free, struct file *file);
+INT_HOOK(file_ioctl, struct file *file, unsigned int cmd, unsigned long arg);
+INT_HOOK(mmap_addr, unsigned long addr);
+INT_HOOK_INT(mmap_file, struct file *file, unsigned long reqprot,
+	     unsigned long prot, unsigned long flags);
+INT_HOOK_EXT(mmap_file, struct file *file, unsigned long prot,
+	     unsigned long flags);
+INT_HOOK(file_mprotect, struct vm_area_struct *vma, unsigned long reqprot,
+	 unsigned long prot);
+INT_HOOK(file_lock, struct file *file, unsigned int cmd);
+INT_HOOK(file_fcntl, struct file *file, unsigned int cmd,
+	 unsigned long arg);
+VOID_HOOK(file_set_fowner, struct file *file);
+INT_HOOK(file_send_sigiotask, struct task_struct *tsk,
+	 struct fown_struct *fown, int sig);
+INT_HOOK(file_receive, struct file *file);
+INT_HOOK(file_open, struct file *file, const struct cred *cred);
+INT_HOOK(task_alloc, struct task_struct *task, unsigned long clone_flags);
+VOID_HOOK(task_free, struct task_struct *task);
+INT_HOOK(cred_alloc_blank, struct cred *cred, gfp_t gfp);
+VOID_HOOK(cred_free, struct cred *cred);
+INT_HOOK_INT(cred_prepare, struct cred *new, const struct cred *old, gfp_t gfp);
+INT_HOOK_EXT(prepare_creds, struct cred *new, const struct cred *old,
+	     gfp_t gfp);
+VOID_HOOK_INT(cred_transfer, struct cred *new, const struct cred *old);
+VOID_HOOK_EXT(transfer_creds, struct cred *new, const struct cred *old);
+INT_HOOK(kernel_act_as, struct cred *new, u32 secid);
+INT_HOOK(kernel_create_files_as, struct cred *new, struct inode *inode);
+INT_HOOK(kernel_module_request, char *kmod_name);
+INT_HOOK(kernel_read_file, struct file *file, enum kernel_read_file_id id);
+INT_HOOK(kernel_post_read_file, struct file *file, char *buf, loff_t size,
+	 enum kernel_read_file_id id);
+INT_HOOK(task_fix_setuid, struct cred *new, const struct cred *old, int flags);
+INT_HOOK(task_setpgid, struct task_struct *p, pid_t pgid);
+INT_HOOK(task_getpgid, struct task_struct *p);
+INT_HOOK(task_getsid, struct task_struct *p);
+VOID_HOOK(task_getsecid, struct task_struct *p, u32 *secid);
+INT_HOOK(task_setnice, struct task_struct *p, int nice);
+INT_HOOK(task_setioprio, struct task_struct *p, int ioprio);
+INT_HOOK(task_getioprio, struct task_struct *p);
+INT_HOOK(task_prlimit, const struct cred *cred, const struct cred *tcred,
+	 unsigned int flags);
+INT_HOOK(task_setrlimit, struct task_struct *p, unsigned int resource,
+	 struct rlimit *new_rlim);
+INT_HOOK(task_setscheduler, struct task_struct *p);
+INT_HOOK(task_getscheduler, struct task_struct *p);
+INT_HOOK(task_movememory, struct task_struct *p);
+INT_HOOK(task_kill, struct task_struct *p, struct siginfo *info, int sig,
+	 u32 secid);
+INT_HOOK(task_prctl, int option, unsigned long arg2, unsigned long arg3,
+	 unsigned long arg4, unsigned long arg5);
+VOID_HOOK(task_to_inode, struct task_struct *p, struct inode *inode);
+INT_HOOK(ipc_permission, struct kern_ipc_perm *ipcp, short flag);
+VOID_HOOK(ipc_getsecid, struct kern_ipc_perm *ipcp, u32 *secid);
+INT_HOOK_SEC_SUFFIX(msg_msg_alloc, struct msg_msg *msg);
+VOID_HOOK_SEC_SUFFIX(msg_msg_free, struct msg_msg *msg);
+INT_HOOK_SEC_SUFFIX(msg_queue_alloc, struct msg_queue *msq);
+VOID_HOOK_SEC_SUFFIX(msg_queue_free, struct msg_queue *msq);
+INT_HOOK(msg_queue_associate, struct msg_queue *msq, int msqflg);
+INT_HOOK(msg_queue_msgctl, struct msg_queue *msq, int cmd);
+INT_HOOK(msg_queue_msgsnd, struct msg_queue *msq, struct msg_msg *msg,
+	 int msqflg);
+INT_HOOK(msg_queue_msgrcv, struct msg_queue *msq, struct msg_msg *msg,
+	 struct task_struct *target, long type, int mode);
+INT_HOOK_SEC_SUFFIX(shm_alloc, struct shmid_kernel *shp);
+VOID_HOOK_SEC_SUFFIX(shm_free, struct shmid_kernel *shp);
+INT_HOOK(shm_associate, struct shmid_kernel *shp, int shmflg);
+INT_HOOK(shm_shmctl, struct shmid_kernel *shp, int cmd);
+INT_HOOK(shm_shmat, struct shmid_kernel *shp, char __user *shmaddr, int shmflg);
+INT_HOOK_SEC_SUFFIX(sem_alloc, struct sem_array *sma);
+VOID_HOOK_SEC_SUFFIX(sem_free, struct sem_array *sma);
+INT_HOOK(sem_associate, struct sem_array *sma, int semflg);
+INT_HOOK(sem_semctl, struct sem_array *sma, int cmd);
+INT_HOOK(sem_semop, struct sem_array *sma, struct sembuf *sops,
+	 unsigned nsops, int alter);
+INT_HOOK(netlink_send, struct sock *sk, struct sk_buff *skb);
+VOID_HOOK(d_instantiate, struct dentry *dentry, struct inode *inode);
+INT_HOOK(getprocattr, struct task_struct *p, char *name, char **value);
+INT_HOOK(setprocattr, const char *name, void *value, size_t size);
+INT_HOOK(ismaclabel, const char *name);
+INT_HOOK(secid_to_secctx, u32 secid, char **secdata, u32 *seclen);
+INT_HOOK(secctx_to_secid, const char *secdata, u32 seclen, u32 *secid);
+VOID_HOOK(release_secctx, char *secdata, u32 seclen);
+VOID_HOOK(inode_invalidate_secctx, struct inode *inode);
+INT_HOOK(inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen);
+INT_HOOK(inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen);
+INT_HOOK(inode_getsecctx, struct inode *inode, void **ctx, u32 *ctxlen);
+
+#ifdef CONFIG_SECURITY_NETWORK
+INT_HOOK(unix_stream_connect, struct sock *sock, struct sock *other,
+	 struct sock *newsk);
+INT_HOOK(unix_may_send, struct socket *sock, struct socket *other);
+INT_HOOK(socket_create, int family, int type, int protocol, int kern);
+INT_HOOK(socket_post_create, struct socket *sock, int family, int type,
+	 int protocol, int kern);
+INT_HOOK(socket_bind, struct socket *sock, struct sockaddr *address,
+	 int addrlen);
+INT_HOOK(socket_connect, struct socket *sock, struct sockaddr *address,
+	 int addrlen);
+INT_HOOK(socket_listen, struct socket *sock, int backlog);
+INT_HOOK(socket_accept, struct socket *sock, struct socket *newsock);
+INT_HOOK(socket_sendmsg, struct socket *sock, struct msghdr *msg, int size);
+INT_HOOK(socket_recvmsg, struct socket *sock, struct msghdr *msg, int size,
+	 int flags);
+INT_HOOK(socket_getsockname, struct socket *sock);
+INT_HOOK(socket_getpeername, struct socket *sock);
+INT_HOOK(socket_getsockopt, struct socket *sock, int level, int optname);
+INT_HOOK(socket_setsockopt, struct socket *sock, int level, int optname);
+INT_HOOK(socket_shutdown, struct socket *sock, int how);
+INT_HOOK_EXT(sock_rcv_skb, struct sock *sk, struct sk_buff *skb);
+INT_HOOK(socket_sock_rcv_skb, struct sock *sk, struct sk_buff *skb);
+INT_HOOK(socket_getpeersec_stream, struct socket *sock, char __user *optval,
+	 int __user *optlen, unsigned len);
+INT_HOOK(socket_getpeersec_dgram, struct socket *sock, struct sk_buff *skb,
+	 u32 *secid);
+INT_HOOK_SEC_SUFFIX(sk_alloc, struct sock *sk, int family,
+		    gfp_t priority);
+VOID_HOOK_SEC_SUFFIX(sk_free, struct sock *sk);
+VOID_HOOK_SEC_SUFFIX(sk_clone, const struct sock *sk, struct sock *newsk);
+/* sk_getsecid is exposed externally as sk_classify_flow */
+VOID_HOOK_INT(sk_getsecid, struct sock *sk, u32 *secid);
+VOID_HOOK_EXT(sk_classify_flow, struct sock *sk, struct flowi *fl);
+
+VOID_HOOK(sock_graft, struct sock *sk, struct socket *parent);
+INT_HOOK(inet_conn_request, struct sock *sk, struct sk_buff *skb,
+	 struct request_sock *req);
+VOID_HOOK(inet_csk_clone, struct sock *newsk, const struct request_sock *req);
+VOID_HOOK(inet_conn_established, struct sock *sk, struct sk_buff *skb);
+INT_HOOK(secmark_relabel_packet, u32 secid);
+VOID_HOOK(secmark_refcount_inc, void);
+VOID_HOOK(secmark_refcount_dec, void);
+VOID_HOOK(req_classify_flow, const struct request_sock *req, struct flowi *fl);
+INT_HOOK(tun_dev_alloc_security, void **security);
+VOID_HOOK(tun_dev_free_security, void *security);
+INT_HOOK(tun_dev_create, void);
+INT_HOOK(tun_dev_attach_queue, void *security);
+INT_HOOK(tun_dev_attach, struct sock *sk, void *security);
+INT_HOOK(tun_dev_open, void *security);
+#endif	/* CONFIG_SECURITY_NETWORK */
+
+#ifdef CONFIG_SECURITY_INFINIBAND
+INT_HOOK(ib_pkey_access, void *sec, u64 subnet_prefix, u16 pkey);
+INT_HOOK(ib_endport_manage_subnet, void *sec, const char *dev_name,
+	 u8 port_num);
+INT_HOOK(ib_alloc_security, void **sec);
+VOID_HOOK(ib_free_security, void *sec);
+#endif	/* CONFIG_SECURITY_INFINIBAND */
+
+#ifdef CONFIG_SECURITY_NETWORK_XFRM
+INT_HOOK_SEC_SUFFIX(xfrm_policy_alloc, struct xfrm_sec_ctx **ctxp,
+		    struct xfrm_user_sec_ctx *sec_ctx, gfp_t gfp);
+INT_HOOK_SEC_SUFFIX(xfrm_policy_clone, struct xfrm_sec_ctx *old_ctx,
+		    struct xfrm_sec_ctx **new_ctx);
+VOID_HOOK_SEC_SUFFIX(xfrm_policy_free, struct xfrm_sec_ctx *ctx);
+INT_HOOK_SEC_SUFFIX(xfrm_policy_delete, struct xfrm_sec_ctx *ctx);
+INT_HOOK(xfrm_state_alloc, struct xfrm_state *x,
+	 struct xfrm_user_sec_ctx *sec_ctx);
+INT_HOOK(xfrm_state_alloc_acquire, struct xfrm_state *x,
+	 struct xfrm_sec_ctx *polsec, u32 secid);
+VOID_HOOK_SEC_SUFFIX(xfrm_state_free, struct xfrm_state *x);
+INT_HOOK_SEC_SUFFIX(xfrm_state_delete, struct xfrm_state *x);
+INT_HOOK(xfrm_policy_lookup, struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir);
+INT_HOOK(xfrm_state_pol_flow_match, struct xfrm_state *x,
+	 struct xfrm_policy *xp, const struct flowi *fl);
+INT_HOOK_INT(xfrm_decode_session, struct sk_buff *skb, u32 *secid, int ckall);
+INT_HOOK_EXT(xfrm_decode_session, struct sk_buff *skb, u32 *secid);
+VOID_HOOK_EXT(skb_classify_flow, struct sk_buff *skb, struct flowi *fl);
+#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
+
+/* key management security hooks */
+#ifdef CONFIG_KEYS
+INT_HOOK(key_alloc, struct key *key, const struct cred *cred,
+	 unsigned long flags);
+VOID_HOOK(key_free, struct key *key);
+INT_HOOK(key_permission, key_ref_t key_ref, const struct cred *cred,
+	 unsigned perm);
+INT_HOOK(key_getsecurity, struct key *key, char **_buffer);
+#endif	/* CONFIG_KEYS */
+
+#ifdef CONFIG_AUDIT
+INT_HOOK(audit_rule_init, u32 field, u32 op, char *rulestr, void **lsmrule);
+INT_HOOK(audit_rule_known, struct audit_krule *krule);
+INT_HOOK(audit_rule_match, u32 secid, u32 field, u32 op, void *lsmrule,
+	 struct audit_context *actx);
+VOID_HOOK(audit_rule_free, void *lsmrule);
+#endif /* CONFIG_AUDIT */
+
+#ifdef CONFIG_BPF_SYSCALL
+INT_HOOK(bpf, int cmd, union bpf_attr *attr, unsigned int size);
+INT_HOOK(bpf_map, struct bpf_map *map, fmode_t fmode);
+INT_HOOK(bpf_prog, struct bpf_prog *prog);
+INT_HOOK_SEC_SUFFIX(bpf_map_alloc, struct bpf_map *map);
+VOID_HOOK_SEC_SUFFIX(bpf_map_free, struct bpf_map *map);
+INT_HOOK_SEC_SUFFIX(bpf_prog_alloc, struct bpf_prog_aux *aux);
+VOID_HOOK_SEC_SUFFIX(bpf_prog_free, struct bpf_prog_aux *aux);
+#endif /* CONFIG_BPF_SYSCALL */
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 09bc60fb35f1..fbd50fd9e687 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -29,1932 +29,34 @@
 #include <linux/init.h>
 #include <linux/rculist.h>
 
-/**
- * union security_list_options - Linux Security Module hook function list
- *
- * Security hooks for program execution operations.
- *
- * @bprm_set_creds:
- *	Save security information in the bprm->security field, typically based
- *	on information about the bprm->file, for later use by the apply_creds
- *	hook.  This hook may also optionally check permissions (e.g. for
- *	transitions between security domains).
- *	This hook may be called multiple times during a single execve, e.g. for
- *	interpreters.  The hook can tell whether it has already been called by
- *	checking to see if @bprm->security is non-NULL.  If so, then the hook
- *	may decide either to retain the security information saved earlier or
- *	to replace it.  The hook must set @bprm->secureexec to 1 if a "secure
- *	exec" has happened as a result of this hook call.  The flag is used to
- *	indicate the need for a sanitized execution environment, and is also
- *	passed in the ELF auxiliary table on the initial stack to indicate
- *	whether libc should enable secure mode.
- *	@bprm contains the linux_binprm structure.
- *	Return 0 if the hook is successful and permission is granted.
- * @bprm_check_security:
- *	This hook mediates the point when a search for a binary handler will
- *	begin.  It allows a check the @bprm->security value which is set in the
- *	preceding set_creds call.  The primary difference from set_creds is
- *	that the argv list and envp list are reliably available in @bprm.  This
- *	hook may be called multiple times during a single execve; and in each
- *	pass set_creds is called first.
- *	@bprm contains the linux_binprm structure.
- *	Return 0 if the hook is successful and permission is granted.
- * @bprm_committing_creds:
- *	Prepare to install the new security attributes of a process being
- *	transformed by an execve operation, based on the old credentials
- *	pointed to by @current->cred and the information set in @bprm->cred by
- *	the bprm_set_creds hook.  @bprm points to the linux_binprm structure.
- *	This hook is a good place to perform state changes on the process such
- *	as closing open file descriptors to which access will no longer be
- *	granted when the attributes are changed.  This is called immediately
- *	before commit_creds().
- * @bprm_committed_creds:
- *	Tidy up after the installation of the new security attributes of a
- *	process being transformed by an execve operation.  The new credentials
- *	have, by this point, been set to @current->cred.  @bprm points to the
- *	linux_binprm structure.  This hook is a good place to perform state
- *	changes on the process such as clearing out non-inheritable signal
- *	state.  This is called immediately after commit_creds().
- *
- * Security hooks for filesystem operations.
- *
- * @sb_alloc_security:
- *	Allocate and attach a security structure to the sb->s_security field.
- *	The s_security field is initialized to NULL when the structure is
- *	allocated.
- *	@sb contains the super_block structure to be modified.
- *	Return 0 if operation was successful.
- * @sb_free_security:
- *	Deallocate and clear the sb->s_security field.
- *	@sb contains the super_block structure to be modified.
- * @sb_statfs:
- *	Check permission before obtaining filesystem statistics for the @mnt
- *	mountpoint.
- *	@dentry is a handle on the superblock for the filesystem.
- *	Return 0 if permission is granted.
- * @sb_mount:
- *	Check permission before an object specified by @dev_name is mounted on
- *	the mount point named by @nd.  For an ordinary mount, @dev_name
- *	identifies a device if the file system type requires a device.  For a
- *	remount (@flags & MS_REMOUNT), @dev_name is irrelevant.  For a
- *	loopback/bind mount (@flags & MS_BIND), @dev_name identifies the
- *	pathname of the object being mounted.
- *	@dev_name contains the name for object being mounted.
- *	@path contains the path for mount point object.
- *	@type contains the filesystem type.
- *	@flags contains the mount flags.
- *	@data contains the filesystem-specific data.
- *	Return 0 if permission is granted.
- * @sb_copy_data:
- *	Allow mount option data to be copied prior to parsing by the filesystem,
- *	so that the security module can extract security-specific mount
- *	options cleanly (a filesystem may modify the data e.g. with strsep()).
- *	This also allows the original mount data to be stripped of security-
- *	specific options to avoid having to make filesystems aware of them.
- *	@type the type of filesystem being mounted.
- *	@orig the original mount data copied from userspace.
- *	@copy copied data which will be passed to the security module.
- *	Returns 0 if the copy was successful.
- * @sb_remount:
- *	Extracts security system specific mount options and verifies no changes
- *	are being made to those options.
- *	@sb superblock being remounted
- *	@data contains the filesystem-specific data.
- *	Return 0 if permission is granted.
- * @sb_umount:
- *	Check permission before the @mnt file system is unmounted.
- *	@mnt contains the mounted file system.
- *	@flags contains the unmount flags, e.g. MNT_FORCE.
- *	Return 0 if permission is granted.
- * @sb_pivotroot:
- *	Check permission before pivoting the root filesystem.
- *	@old_path contains the path for the new location of the
- *	current root (put_old).
- *	@new_path contains the path for the new root (new_root).
- *	Return 0 if permission is granted.
- * @sb_set_mnt_opts:
- *	Set the security relevant mount options used for a superblock
- *	@sb the superblock to set security mount options for
- *	@opts binary data structure containing all lsm mount data
- * @sb_clone_mnt_opts:
- *	Copy all security options from a given superblock to another
- *	@oldsb old superblock which contain information to clone
- *	@newsb new superblock which needs filled in
- * @sb_parse_opts_str:
- *	Parse a string of security data filling in the opts structure
- *	@options string containing all mount options known by the LSM
- *	@opts binary data structure usable by the LSM
- * @dentry_init_security:
- *	Compute a context for a dentry as the inode is not yet available
- *	since NFSv4 has no label backed by an EA anyway.
- *	@dentry dentry to use in calculating the context.
- *	@mode mode used to determine resource type.
- *	@name name of the last path component used to create file
- *	@ctx pointer to place the pointer to the resulting context in.
- *	@ctxlen point to place the length of the resulting context.
- * @dentry_create_files_as:
- *	Compute a context for a dentry as the inode is not yet available
- *	and set that context in passed in creds so that new files are
- *	created using that context. Context is calculated using the
- *	passed in creds and not the creds of the caller.
- *	@dentry dentry to use in calculating the context.
- *	@mode mode used to determine resource type.
- *	@name name of the last path component used to create file
- *	@old creds which should be used for context calculation
- *	@new creds to modify
- *
- *
- * Security hooks for inode operations.
- *
- * @inode_alloc_security:
- *	Allocate and attach a security structure to @inode->i_security.  The
- *	i_security field is initialized to NULL when the inode structure is
- *	allocated.
- *	@inode contains the inode structure.
- *	Return 0 if operation was successful.
- * @inode_free_security:
- *	@inode contains the inode structure.
- *	Deallocate the inode security structure and set @inode->i_security to
- *	NULL.
- * @inode_init_security:
- *	Obtain the security attribute name suffix and value to set on a newly
- *	created inode and set up the incore security field for the new inode.
- *	This hook is called by the fs code as part of the inode creation
- *	transaction and provides for atomic labeling of the inode, unlike
- *	the post_create/mkdir/... hooks called by the VFS.  The hook function
- *	is expected to allocate the name and value via kmalloc, with the caller
- *	being responsible for calling kfree after using them.
- *	If the security module does not use security attributes or does
- *	not wish to put a security attribute on this particular inode,
- *	then it should return -EOPNOTSUPP to skip this processing.
- *	@inode contains the inode structure of the newly created inode.
- *	@dir contains the inode structure of the parent directory.
- *	@qstr contains the last path component of the new object
- *	@name will be set to the allocated name suffix (e.g. selinux).
- *	@value will be set to the allocated attribute value.
- *	@len will be set to the length of the value.
- *	Returns 0 if @name and @value have been successfully set,
- *	-EOPNOTSUPP if no security attribute is needed, or
- *	-ENOMEM on memory allocation failure.
- * @inode_create:
- *	Check permission to create a regular file.
- *	@dir contains inode structure of the parent of the new file.
- *	@dentry contains the dentry structure for the file to be created.
- *	@mode contains the file mode of the file to be created.
- *	Return 0 if permission is granted.
- * @inode_link:
- *	Check permission before creating a new hard link to a file.
- *	@old_dentry contains the dentry structure for an existing
- *	link to the file.
- *	@dir contains the inode structure of the parent directory
- *	of the new link.
- *	@new_dentry contains the dentry structure for the new link.
- *	Return 0 if permission is granted.
- * @path_link:
- *	Check permission before creating a new hard link to a file.
- *	@old_dentry contains the dentry structure for an existing link
- *	to the file.
- *	@new_dir contains the path structure of the parent directory of
- *	the new link.
- *	@new_dentry contains the dentry structure for the new link.
- *	Return 0 if permission is granted.
- * @inode_unlink:
- *	Check the permission to remove a hard link to a file.
- *	@dir contains the inode structure of parent directory of the file.
- *	@dentry contains the dentry structure for file to be unlinked.
- *	Return 0 if permission is granted.
- * @path_unlink:
- *	Check the permission to remove a hard link to a file.
- *	@dir contains the path structure of parent directory of the file.
- *	@dentry contains the dentry structure for file to be unlinked.
- *	Return 0 if permission is granted.
- * @inode_symlink:
- *	Check the permission to create a symbolic link to a file.
- *	@dir contains the inode structure of parent directory of
- *	the symbolic link.
- *	@dentry contains the dentry structure of the symbolic link.
- *	@old_name contains the pathname of file.
- *	Return 0 if permission is granted.
- * @path_symlink:
- *	Check the permission to create a symbolic link to a file.
- *	@dir contains the path structure of parent directory of
- *	the symbolic link.
- *	@dentry contains the dentry structure of the symbolic link.
- *	@old_name contains the pathname of file.
- *	Return 0 if permission is granted.
- * @inode_mkdir:
- *	Check permissions to create a new directory in the existing directory
- *	associated with inode structure @dir.
- *	@dir contains the inode structure of parent of the directory
- *	to be created.
- *	@dentry contains the dentry structure of new directory.
- *	@mode contains the mode of new directory.
- *	Return 0 if permission is granted.
- * @path_mkdir:
- *	Check permissions to create a new directory in the existing directory
- *	associated with path structure @path.
- *	@dir contains the path structure of parent of the directory
- *	to be created.
- *	@dentry contains the dentry structure of new directory.
- *	@mode contains the mode of new directory.
- *	Return 0 if permission is granted.
- * @inode_rmdir:
- *	Check the permission to remove a directory.
- *	@dir contains the inode structure of parent of the directory
- *	to be removed.
- *	@dentry contains the dentry structure of directory to be removed.
- *	Return 0 if permission is granted.
- * @path_rmdir:
- *	Check the permission to remove a directory.
- *	@dir contains the path structure of parent of the directory to be
- *	removed.
- *	@dentry contains the dentry structure of directory to be removed.
- *	Return 0 if permission is granted.
- * @inode_mknod:
- *	Check permissions when creating a special file (or a socket or a fifo
- *	file created via the mknod system call).  Note that if mknod operation
- *	is being done for a regular file, then the create hook will be called
- *	and not this hook.
- *	@dir contains the inode structure of parent of the new file.
- *	@dentry contains the dentry structure of the new file.
- *	@mode contains the mode of the new file.
- *	@dev contains the device number.
- *	Return 0 if permission is granted.
- * @path_mknod:
- *	Check permissions when creating a file. Note that this hook is called
- *	even if mknod operation is being done for a regular file.
- *	@dir contains the path structure of parent of the new file.
- *	@dentry contains the dentry structure of the new file.
- *	@mode contains the mode of the new file.
- *	@dev contains the undecoded device number. Use new_decode_dev() to get
- *	the decoded device number.
- *	Return 0 if permission is granted.
- * @inode_rename:
- *	Check for permission to rename a file or directory.
- *	@old_dir contains the inode structure for parent of the old link.
- *	@old_dentry contains the dentry structure of the old link.
- *	@new_dir contains the inode structure for parent of the new link.
- *	@new_dentry contains the dentry structure of the new link.
- *	Return 0 if permission is granted.
- * @path_rename:
- *	Check for permission to rename a file or directory.
- *	@old_dir contains the path structure for parent of the old link.
- *	@old_dentry contains the dentry structure of the old link.
- *	@new_dir contains the path structure for parent of the new link.
- *	@new_dentry contains the dentry structure of the new link.
- *	Return 0 if permission is granted.
- * @path_chmod:
- *	Check for permission to change DAC's permission of a file or directory.
- *	@dentry contains the dentry structure.
- *	@mnt contains the vfsmnt structure.
- *	@mode contains DAC's mode.
- *	Return 0 if permission is granted.
- * @path_chown:
- *	Check for permission to change owner/group of a file or directory.
- *	@path contains the path structure.
- *	@uid contains new owner's ID.
- *	@gid contains new group's ID.
- *	Return 0 if permission is granted.
- * @path_chroot:
- *	Check for permission to change root directory.
- *	@path contains the path structure.
- *	Return 0 if permission is granted.
- * @inode_readlink:
- *	Check the permission to read the symbolic link.
- *	@dentry contains the dentry structure for the file link.
- *	Return 0 if permission is granted.
- * @inode_follow_link:
- *	Check permission to follow a symbolic link when looking up a pathname.
- *	@dentry contains the dentry structure for the link.
- *	@inode contains the inode, which itself is not stable in RCU-walk
- *	@rcu indicates whether we are in RCU-walk mode.
- *	Return 0 if permission is granted.
- * @inode_permission:
- *	Check permission before accessing an inode.  This hook is called by the
- *	existing Linux permission function, so a security module can use it to
- *	provide additional checking for existing Linux permission checks.
- *	Notice that this hook is called when a file is opened (as well as many
- *	other operations), whereas the file_security_ops permission hook is
- *	called when the actual read/write operations are performed.
- *	@inode contains the inode structure to check.
- *	@mask contains the permission mask.
- *	Return 0 if permission is granted.
- * @inode_setattr:
- *	Check permission before setting file attributes.  Note that the kernel
- *	call to notify_change is performed from several locations, whenever
- *	file attributes change (such as when a file is truncated, chown/chmod
- *	operations, transferring disk quotas, etc).
- *	@dentry contains the dentry structure for the file.
- *	@attr is the iattr structure containing the new file attributes.
- *	Return 0 if permission is granted.
- * @path_truncate:
- *	Check permission before truncating a file.
- *	@path contains the path structure for the file.
- *	Return 0 if permission is granted.
- * @inode_getattr:
- *	Check permission before obtaining file attributes.
- *	@path contains the path structure for the file.
- *	Return 0 if permission is granted.
- * @inode_setxattr:
- *	Check permission before setting the extended attributes
- *	@value identified by @name for @dentry.
- *	Return 0 if permission is granted.
- * @inode_post_setxattr:
- *	Update inode security field after successful setxattr operation.
- *	@value identified by @name for @dentry.
- * @inode_getxattr:
- *	Check permission before obtaining the extended attributes
- *	identified by @name for @dentry.
- *	Return 0 if permission is granted.
- * @inode_listxattr:
- *	Check permission before obtaining the list of extended attribute
- *	names for @dentry.
- *	Return 0 if permission is granted.
- * @inode_removexattr:
- *	Check permission before removing the extended attribute
- *	identified by @name for @dentry.
- *	Return 0 if permission is granted.
- * @inode_getsecurity:
- *	Retrieve a copy of the extended attribute representation of the
- *	security label associated with @name for @inode via @buffer.  Note that
- *	@name is the remainder of the attribute name after the security prefix
- *	has been removed. @alloc is used to specify of the call should return a
- *	value via the buffer or just the value length Return size of buffer on
- *	success.
- * @inode_setsecurity:
- *	Set the security label associated with @name for @inode from the
- *	extended attribute value @value.  @size indicates the size of the
- *	@value in bytes.  @flags may be XATTR_CREATE, XATTR_REPLACE, or 0.
- *	Note that @name is the remainder of the attribute name after the
- *	security. prefix has been removed.
- *	Return 0 on success.
- * @inode_listsecurity:
- *	Copy the extended attribute names for the security labels
- *	associated with @inode into @buffer.  The maximum size of @buffer
- *	is specified by @buffer_size.  @buffer may be NULL to request
- *	the size of the buffer required.
- *	Returns number of bytes used/required on success.
- * @inode_need_killpriv:
- *	Called when an inode has been changed.
- *	@dentry is the dentry being changed.
- *	Return <0 on error to abort the inode change operation.
- *	Return 0 if inode_killpriv does not need to be called.
- *	Return >0 if inode_killpriv does need to be called.
- * @inode_killpriv:
- *	The setuid bit is being removed.  Remove similar security labels.
- *	Called with the dentry->d_inode->i_mutex held.
- *	@dentry is the dentry being changed.
- *	Return 0 on success.  If error is returned, then the operation
- *	causing setuid bit removal is failed.
- * @inode_getsecid:
- *	Get the secid associated with the node.
- *	@inode contains a pointer to the inode.
- *	@secid contains a pointer to the location where result will be saved.
- *	In case of failure, @secid will be set to zero.
- * @inode_copy_up:
- *	A file is about to be copied up from lower layer to upper layer of
- *	overlay filesystem. Security module can prepare a set of new creds
- *	and modify as need be and return new creds. Caller will switch to
- *	new creds temporarily to create new file and release newly allocated
- *	creds.
- *	@src indicates the union dentry of file that is being copied up.
- *	@new pointer to pointer to return newly allocated creds.
- *	Returns 0 on success or a negative error code on error.
- * @inode_copy_up_xattr:
- *	Filter the xattrs being copied up when a unioned file is copied
- *	up from a lower layer to the union/overlay layer.
- *	@name indicates the name of the xattr.
- *	Returns 0 to accept the xattr, 1 to discard the xattr, -EOPNOTSUPP if
- *	security module does not know about attribute or a negative error code
- *	to abort the copy up. Note that the caller is responsible for reading
- *	and writing the xattrs as this hook is merely a filter.
- *
- * Security hooks for file operations
- *
- * @file_permission:
- *	Check file permissions before accessing an open file.  This hook is
- *	called by various operations that read or write files.  A security
- *	module can use this hook to perform additional checking on these
- *	operations, e.g.  to revalidate permissions on use to support privilege
- *	bracketing or policy changes.  Notice that this hook is used when the
- *	actual read/write operations are performed, whereas the
- *	inode_security_ops hook is called when a file is opened (as well as
- *	many other operations).
- *	Caveat:  Although this hook can be used to revalidate permissions for
- *	various system call operations that read or write files, it does not
- *	address the revalidation of permissions for memory-mapped files.
- *	Security modules must handle this separately if they need such
- *	revalidation.
- *	@file contains the file structure being accessed.
- *	@mask contains the requested permissions.
- *	Return 0 if permission is granted.
- * @file_alloc_security:
- *	Allocate and attach a security structure to the file->f_security field.
- *	The security field is initialized to NULL when the structure is first
- *	created.
- *	@file contains the file structure to secure.
- *	Return 0 if the hook is successful and permission is granted.
- * @file_free_security:
- *	Deallocate and free any security structures stored in file->f_security.
- *	@file contains the file structure being modified.
- * @file_ioctl:
- *	@file contains the file structure.
- *	@cmd contains the operation to perform.
- *	@arg contains the operational arguments.
- *	Check permission for an ioctl operation on @file.  Note that @arg
- *	sometimes represents a user space pointer; in other cases, it may be a
- *	simple integer value.  When @arg represents a user space pointer, it
- *	should never be used by the security module.
- *	Return 0 if permission is granted.
- * @mmap_addr :
- *	Check permissions for a mmap operation at @addr.
- *	@addr contains virtual address that will be used for the operation.
- *	Return 0 if permission is granted.
- * @mmap_file :
- *	Check permissions for a mmap operation.  The @file may be NULL, e.g.
- *	if mapping anonymous memory.
- *	@file contains the file structure for file to map (may be NULL).
- *	@reqprot contains the protection requested by the application.
- *	@prot contains the protection that will be applied by the kernel.
- *	@flags contains the operational flags.
- *	Return 0 if permission is granted.
- * @file_mprotect:
- *	Check permissions before changing memory access permissions.
- *	@vma contains the memory region to modify.
- *	@reqprot contains the protection requested by the application.
- *	@prot contains the protection that will be applied by the kernel.
- *	Return 0 if permission is granted.
- * @file_lock:
- *	Check permission before performing file locking operations.
- *	Note: this hook mediates both flock and fcntl style locks.
- *	@file contains the file structure.
- *	@cmd contains the posix-translated lock operation to perform
- *	(e.g. F_RDLCK, F_WRLCK).
- *	Return 0 if permission is granted.
- * @file_fcntl:
- *	Check permission before allowing the file operation specified by @cmd
- *	from being performed on the file @file.  Note that @arg sometimes
- *	represents a user space pointer; in other cases, it may be a simple
- *	integer value.  When @arg represents a user space pointer, it should
- *	never be used by the security module.
- *	@file contains the file structure.
- *	@cmd contains the operation to be performed.
- *	@arg contains the operational arguments.
- *	Return 0 if permission is granted.
- * @file_set_fowner:
- *	Save owner security information (typically from current->security) in
- *	file->f_security for later use by the send_sigiotask hook.
- *	@file contains the file structure to update.
- *	Return 0 on success.
- * @file_send_sigiotask:
- *	Check permission for the file owner @fown to send SIGIO or SIGURG to the
- *	process @tsk.  Note that this hook is sometimes called from interrupt.
- *	Note that the fown_struct, @fown, is never outside the context of a
- *	struct file, so the file structure (and associated security information)
- *	can always be obtained: container_of(fown, struct file, f_owner)
- *	@tsk contains the structure of task receiving signal.
- *	@fown contains the file owner information.
- *	@sig is the signal that will be sent.  When 0, kernel sends SIGIO.
- *	Return 0 if permission is granted.
- * @file_receive:
- *	This hook allows security modules to control the ability of a process
- *	to receive an open file descriptor via socket IPC.
- *	@file contains the file structure being received.
- *	Return 0 if permission is granted.
- * @file_open:
- *	Save open-time permission checking state for later use upon
- *	file_permission, and recheck access if anything has changed
- *	since inode_permission.
- *
- * Security hooks for task operations.
- *
- * @task_alloc:
- *	@task task being allocated.
- *	@clone_flags contains the flags indicating what should be shared.
- *	Handle allocation of task-related resources.
- *	Returns a zero on success, negative values on failure.
- * @task_free:
- *	@task task about to be freed.
- *	Handle release of task-related resources. (Note that this can be called
- *	from interrupt context.)
- * @cred_alloc_blank:
- *	@cred points to the credentials.
- *	@gfp indicates the atomicity of any memory allocations.
- *	Only allocate sufficient memory and attach to @cred such that
- *	cred_transfer() will not get ENOMEM.
- * @cred_free:
- *	@cred points to the credentials.
- *	Deallocate and clear the cred->security field in a set of credentials.
- * @cred_prepare:
- *	@new points to the new credentials.
- *	@old points to the original credentials.
- *	@gfp indicates the atomicity of any memory allocations.
- *	Prepare a new set of credentials by copying the data from the old set.
- * @cred_transfer:
- *	@new points to the new credentials.
- *	@old points to the original credentials.
- *	Transfer data from original creds to new creds
- * @kernel_act_as:
- *	Set the credentials for a kernel service to act as (subjective context).
- *	@new points to the credentials to be modified.
- *	@secid specifies the security ID to be set
- *	The current task must be the one that nominated @secid.
- *	Return 0 if successful.
- * @kernel_create_files_as:
- *	Set the file creation context in a set of credentials to be the same as
- *	the objective context of the specified inode.
- *	@new points to the credentials to be modified.
- *	@inode points to the inode to use as a reference.
- *	The current task must be the one that nominated @inode.
- *	Return 0 if successful.
- * @kernel_module_request:
- *	Ability to trigger the kernel to automatically upcall to userspace for
- *	userspace to load a kernel module with the given name.
- *	@kmod_name name of the module requested by the kernel
- *	Return 0 if successful.
- * @kernel_read_file:
- *	Read a file specified by userspace.
- *	@file contains the file structure pointing to the file being read
- *	by the kernel.
- *	@id kernel read file identifier
- *	Return 0 if permission is granted.
- * @kernel_post_read_file:
- *	Read a file specified by userspace.
- *	@file contains the file structure pointing to the file being read
- *	by the kernel.
- *	@buf pointer to buffer containing the file contents.
- *	@size length of the file contents.
- *	@id kernel read file identifier
- *	Return 0 if permission is granted.
- * @task_fix_setuid:
- *	Update the module's state after setting one or more of the user
- *	identity attributes of the current process.  The @flags parameter
- *	indicates which of the set*uid system calls invoked this hook.  If
- *	@new is the set of credentials that will be installed.  Modifications
- *	should be made to this rather than to @current->cred.
- *	@old is the set of credentials that are being replaces
- *	@flags contains one of the LSM_SETID_* values.
- *	Return 0 on success.
- * @task_setpgid:
- *	Check permission before setting the process group identifier of the
- *	process @p to @pgid.
- *	@p contains the task_struct for process being modified.
- *	@pgid contains the new pgid.
- *	Return 0 if permission is granted.
- * @task_getpgid:
- *	Check permission before getting the process group identifier of the
- *	process @p.
- *	@p contains the task_struct for the process.
- *	Return 0 if permission is granted.
- * @task_getsid:
- *	Check permission before getting the session identifier of the process
- *	@p.
- *	@p contains the task_struct for the process.
- *	Return 0 if permission is granted.
- * @task_getsecid:
- *	Retrieve the security identifier of the process @p.
- *	@p contains the task_struct for the process and place is into @secid.
- *	In case of failure, @secid will be set to zero.
- *
- * @task_setnice:
- *	Check permission before setting the nice value of @p to @nice.
- *	@p contains the task_struct of process.
- *	@nice contains the new nice value.
- *	Return 0 if permission is granted.
- * @task_setioprio
- *	Check permission before setting the ioprio value of @p to @ioprio.
- *	@p contains the task_struct of process.
- *	@ioprio contains the new ioprio value
- *	Return 0 if permission is granted.
- * @task_getioprio
- *	Check permission before getting the ioprio value of @p.
- *	@p contains the task_struct of process.
- *	Return 0 if permission is granted.
- * @task_prlimit:
- *	Check permission before getting and/or setting the resource limits of
- *	another task.
- *	@cred points to the cred structure for the current task.
- *	@tcred points to the cred structure for the target task.
- *	@flags contains the LSM_PRLIMIT_* flag bits indicating whether the
- *	resource limits are being read, modified, or both.
- *	Return 0 if permission is granted.
- * @task_setrlimit:
- *	Check permission before setting the resource limits of process @p
- *	for @resource to @new_rlim.  The old resource limit values can
- *	be examined by dereferencing (p->signal->rlim + resource).
- *	@p points to the task_struct for the target task's group leader.
- *	@resource contains the resource whose limit is being set.
- *	@new_rlim contains the new limits for @resource.
- *	Return 0 if permission is granted.
- * @task_setscheduler:
- *	Check permission before setting scheduling policy and/or parameters of
- *	process @p based on @policy and @lp.
- *	@p contains the task_struct for process.
- *	@policy contains the scheduling policy.
- *	@lp contains the scheduling parameters.
- *	Return 0 if permission is granted.
- * @task_getscheduler:
- *	Check permission before obtaining scheduling information for process
- *	@p.
- *	@p contains the task_struct for process.
- *	Return 0 if permission is granted.
- * @task_movememory
- *	Check permission before moving memory owned by process @p.
- *	@p contains the task_struct for process.
- *	Return 0 if permission is granted.
- * @task_kill:
- *	Check permission before sending signal @sig to @p.  @info can be NULL,
- *	the constant 1, or a pointer to a siginfo structure.  If @info is 1 or
- *	SI_FROMKERNEL(info) is true, then the signal should be viewed as coming
- *	from the kernel and should typically be permitted.
- *	SIGIO signals are handled separately by the send_sigiotask hook in
- *	file_security_ops.
- *	@p contains the task_struct for process.
- *	@info contains the signal information.
- *	@sig contains the signal value.
- *	@secid contains the sid of the process where the signal originated
- *	Return 0 if permission is granted.
- * @task_prctl:
- *	Check permission before performing a process control operation on the
- *	current process.
- *	@option contains the operation.
- *	@arg2 contains a argument.
- *	@arg3 contains a argument.
- *	@arg4 contains a argument.
- *	@arg5 contains a argument.
- *	Return -ENOSYS if no-one wanted to handle this op, any other value to
- *	cause prctl() to return immediately with that value.
- * @task_to_inode:
- *	Set the security attributes for an inode based on an associated task's
- *	security attributes, e.g. for /proc/pid inodes.
- *	@p contains the task_struct for the task.
- *	@inode contains the inode structure for the inode.
- *
- * Security hooks for Netlink messaging.
- *
- * @netlink_send:
- *	Save security information for a netlink message so that permission
- *	checking can be performed when the message is processed.  The security
- *	information can be saved using the eff_cap field of the
- *	netlink_skb_parms structure.  Also may be used to provide fine
- *	grained control over message transmission.
- *	@sk associated sock of task sending the message.
- *	@skb contains the sk_buff structure for the netlink message.
- *	Return 0 if the information was successfully saved and message
- *	is allowed to be transmitted.
- *
- * Security hooks for Unix domain networking.
- *
- * @unix_stream_connect:
- *	Check permissions before establishing a Unix domain stream connection
- *	between @sock and @other.
- *	@sock contains the sock structure.
- *	@other contains the peer sock structure.
- *	@newsk contains the new sock structure.
- *	Return 0 if permission is granted.
- * @unix_may_send:
- *	Check permissions before connecting or sending datagrams from @sock to
- *	@other.
- *	@sock contains the socket structure.
- *	@other contains the peer socket structure.
- *	Return 0 if permission is granted.
- *
- * The @unix_stream_connect and @unix_may_send hooks were necessary because
- * Linux provides an alternative to the conventional file name space for Unix
- * domain sockets.  Whereas binding and connecting to sockets in the file name
- * space is mediated by the typical file permissions (and caught by the mknod
- * and permission hooks in inode_security_ops), binding and connecting to
- * sockets in the abstract name space is completely unmediated.  Sufficient
- * control of Unix domain sockets in the abstract name space isn't possible
- * using only the socket layer hooks, since we need to know the actual target
- * socket, which is not looked up until we are inside the af_unix code.
- *
- * Security hooks for socket operations.
- *
- * @socket_create:
- *	Check permissions prior to creating a new socket.
- *	@family contains the requested protocol family.
- *	@type contains the requested communications type.
- *	@protocol contains the requested protocol.
- *	@kern set to 1 if a kernel socket.
- *	Return 0 if permission is granted.
- * @socket_post_create:
- *	This hook allows a module to update or allocate a per-socket security
- *	structure. Note that the security field was not added directly to the
- *	socket structure, but rather, the socket security information is stored
- *	in the associated inode.  Typically, the inode alloc_security hook will
- *	allocate and and attach security information to
- *	sock->inode->i_security.  This hook may be used to update the
- *	sock->inode->i_security field with additional information that wasn't
- *	available when the inode was allocated.
- *	@sock contains the newly created socket structure.
- *	@family contains the requested protocol family.
- *	@type contains the requested communications type.
- *	@protocol contains the requested protocol.
- *	@kern set to 1 if a kernel socket.
- * @socket_bind:
- *	Check permission before socket protocol layer bind operation is
- *	performed and the socket @sock is bound to the address specified in the
- *	@address parameter.
- *	@sock contains the socket structure.
- *	@address contains the address to bind to.
- *	@addrlen contains the length of address.
- *	Return 0 if permission is granted.
- * @socket_connect:
- *	Check permission before socket protocol layer connect operation
- *	attempts to connect socket @sock to a remote address, @address.
- *	@sock contains the socket structure.
- *	@address contains the address of remote endpoint.
- *	@addrlen contains the length of address.
- *	Return 0 if permission is granted.
- * @socket_listen:
- *	Check permission before socket protocol layer listen operation.
- *	@sock contains the socket structure.
- *	@backlog contains the maximum length for the pending connection queue.
- *	Return 0 if permission is granted.
- * @socket_accept:
- *	Check permission before accepting a new connection.  Note that the new
- *	socket, @newsock, has been created and some information copied to it,
- *	but the accept operation has not actually been performed.
- *	@sock contains the listening socket structure.
- *	@newsock contains the newly created server socket for connection.
- *	Return 0 if permission is granted.
- * @socket_sendmsg:
- *	Check permission before transmitting a message to another socket.
- *	@sock contains the socket structure.
- *	@msg contains the message to be transmitted.
- *	@size contains the size of message.
- *	Return 0 if permission is granted.
- * @socket_recvmsg:
- *	Check permission before receiving a message from a socket.
- *	@sock contains the socket structure.
- *	@msg contains the message structure.
- *	@size contains the size of message structure.
- *	@flags contains the operational flags.
- *	Return 0 if permission is granted.
- * @socket_getsockname:
- *	Check permission before the local address (name) of the socket object
- *	@sock is retrieved.
- *	@sock contains the socket structure.
- *	Return 0 if permission is granted.
- * @socket_getpeername:
- *	Check permission before the remote address (name) of a socket object
- *	@sock is retrieved.
- *	@sock contains the socket structure.
- *	Return 0 if permission is granted.
- * @socket_getsockopt:
- *	Check permissions before retrieving the options associated with socket
- *	@sock.
- *	@sock contains the socket structure.
- *	@level contains the protocol level to retrieve option from.
- *	@optname contains the name of option to retrieve.
- *	Return 0 if permission is granted.
- * @socket_setsockopt:
- *	Check permissions before setting the options associated with socket
- *	@sock.
- *	@sock contains the socket structure.
- *	@level contains the protocol level to set options for.
- *	@optname contains the name of the option to set.
- *	Return 0 if permission is granted.
- * @socket_shutdown:
- *	Checks permission before all or part of a connection on the socket
- *	@sock is shut down.
- *	@sock contains the socket structure.
- *	@how contains the flag indicating how future sends and receives
- *	are handled.
- *	Return 0 if permission is granted.
- * @socket_sock_rcv_skb:
- *	Check permissions on incoming network packets.  This hook is distinct
- *	from Netfilter's IP input hooks since it is the first time that the
- *	incoming sk_buff @skb has been associated with a particular socket, @sk.
- *	Must not sleep inside this hook because some callers hold spinlocks.
- *	@sk contains the sock (not socket) associated with the incoming sk_buff.
- *	@skb contains the incoming network data.
- * @socket_getpeersec_stream:
- *	This hook allows the security module to provide peer socket security
- *	state for unix or connected tcp sockets to userspace via getsockopt
- *	SO_GETPEERSEC.  For tcp sockets this can be meaningful if the
- *	socket is associated with an ipsec SA.
- *	@sock is the local socket.
- *	@optval userspace memory where the security state is to be copied.
- *	@optlen userspace int where the module should copy the actual length
- *	of the security state.
- *	@len as input is the maximum length to copy to userspace provided
- *	by the caller.
- *	Return 0 if all is well, otherwise, typical getsockopt return
- *	values.
- * @socket_getpeersec_dgram:
- *	This hook allows the security module to provide peer socket security
- *	state for udp sockets on a per-packet basis to userspace via
- *	getsockopt SO_GETPEERSEC.  The application must first have indicated
- *	the IP_PASSSEC option via getsockopt.  It can then retrieve the
- *	security state returned by this hook for a packet via the SCM_SECURITY
- *	ancillary message type.
- *	@skb is the skbuff for the packet being queried
- *	@secdata is a pointer to a buffer in which to copy the security data
- *	@seclen is the maximum length for @secdata
- *	Return 0 on success, error on failure.
- * @sk_alloc_security:
- *	Allocate and attach a security structure to the sk->sk_security field,
- *	which is used to copy security attributes between local stream sockets.
- * @sk_free_security:
- *	Deallocate security structure.
- * @sk_clone_security:
- *	Clone/copy security structure.
- * @sk_getsecid:
- *	Retrieve the LSM-specific secid for the sock to enable caching
- *	of network authorizations.
- * @sock_graft:
- *	Sets the socket's isec sid to the sock's sid.
- * @inet_conn_request:
- *	Sets the openreq's sid to socket's sid with MLS portion taken
- *	from peer sid.
- * @inet_csk_clone:
- *	Sets the new child socket's sid to the openreq sid.
- * @inet_conn_established:
- *	Sets the connection's peersid to the secmark on skb.
- * @secmark_relabel_packet:
- *	check if the process should be allowed to relabel packets to
- *	the given secid
- * @security_secmark_refcount_inc
- *	tells the LSM to increment the number of secmark labeling rules loaded
- * @security_secmark_refcount_dec
- *	tells the LSM to decrement the number of secmark labeling rules loaded
- * @req_classify_flow:
- *	Sets the flow's sid to the openreq sid.
- * @tun_dev_alloc_security:
- *	This hook allows a module to allocate a security structure for a TUN
- *	device.
- *	@security pointer to a security structure pointer.
- *	Returns a zero on success, negative values on failure.
- * @tun_dev_free_security:
- *	This hook allows a module to free the security structure for a TUN
- *	device.
- *	@security pointer to the TUN device's security structure
- * @tun_dev_create:
- *	Check permissions prior to creating a new TUN device.
- * @tun_dev_attach_queue:
- *	Check permissions prior to attaching to a TUN device queue.
- *	@security pointer to the TUN device's security structure.
- * @tun_dev_attach:
- *	This hook can be used by the module to update any security state
- *	associated with the TUN device's sock structure.
- *	@sk contains the existing sock structure.
- *	@security pointer to the TUN device's security structure.
- * @tun_dev_open:
- *	This hook can be used by the module to update any security state
- *	associated with the TUN device's security structure.
- *	@security pointer to the TUN devices's security structure.
- *
- * Security hooks for Infiniband
- *
- * @ib_pkey_access:
- *	Check permission to access a pkey when modifing a QP.
- *	@subnet_prefix the subnet prefix of the port being used.
- *	@pkey the pkey to be accessed.
- *	@sec pointer to a security structure.
- * @ib_endport_manage_subnet:
- *	Check permissions to send and receive SMPs on a end port.
- *	@dev_name the IB device name (i.e. mlx4_0).
- *	@port_num the port number.
- *	@sec pointer to a security structure.
- * @ib_alloc_security:
- *	Allocate a security structure for Infiniband objects.
- *	@sec pointer to a security structure pointer.
- *	Returns 0 on success, non-zero on failure
- * @ib_free_security:
- *	Deallocate an Infiniband security structure.
- *	@sec contains the security structure to be freed.
- *
- * Security hooks for XFRM operations.
- *
- * @xfrm_policy_alloc_security:
- *	@ctxp is a pointer to the xfrm_sec_ctx being added to Security Policy
- *	Database used by the XFRM system.
- *	@sec_ctx contains the security context information being provided by
- *	the user-level policy update program (e.g., setkey).
- *	Allocate a security structure to the xp->security field; the security
- *	field is initialized to NULL when the xfrm_policy is allocated.
- *	Return 0 if operation was successful (memory to allocate, legal context)
- *	@gfp is to specify the context for the allocation
- * @xfrm_policy_clone_security:
- *	@old_ctx contains an existing xfrm_sec_ctx.
- *	@new_ctxp contains a new xfrm_sec_ctx being cloned from old.
- *	Allocate a security structure in new_ctxp that contains the
- *	information from the old_ctx structure.
- *	Return 0 if operation was successful (memory to allocate).
- * @xfrm_policy_free_security:
- *	@ctx contains the xfrm_sec_ctx
- *	Deallocate xp->security.
- * @xfrm_policy_delete_security:
- *	@ctx contains the xfrm_sec_ctx.
- *	Authorize deletion of xp->security.
- * @xfrm_state_alloc:
- *	@x contains the xfrm_state being added to the Security Association
- *	Database by the XFRM system.
- *	@sec_ctx contains the security context information being provided by
- *	the user-level SA generation program (e.g., setkey or racoon).
- *	Allocate a security structure to the x->security field; the security
- *	field is initialized to NULL when the xfrm_state is allocated. Set the
- *	context to correspond to sec_ctx. Return 0 if operation was successful
- *	(memory to allocate, legal context).
- * @xfrm_state_alloc_acquire:
- *	@x contains the xfrm_state being added to the Security Association
- *	Database by the XFRM system.
- *	@polsec contains the policy's security context.
- *	@secid contains the secid from which to take the mls portion of the
- *	context.
- *	Allocate a security structure to the x->security field; the security
- *	field is initialized to NULL when the xfrm_state is allocated. Set the
- *	context to correspond to secid. Return 0 if operation was successful
- *	(memory to allocate, legal context).
- * @xfrm_state_free_security:
- *	@x contains the xfrm_state.
- *	Deallocate x->security.
- * @xfrm_state_delete_security:
- *	@x contains the xfrm_state.
- *	Authorize deletion of x->security.
- * @xfrm_policy_lookup:
- *	@ctx contains the xfrm_sec_ctx for which the access control is being
- *	checked.
- *	@fl_secid contains the flow security label that is used to authorize
- *	access to the policy xp.
- *	@dir contains the direction of the flow (input or output).
- *	Check permission when a flow selects a xfrm_policy for processing
- *	XFRMs on a packet.  The hook is called when selecting either a
- *	per-socket policy or a generic xfrm policy.
- *	Return 0 if permission is granted, -ESRCH otherwise, or -errno
- *	on other errors.
- * @xfrm_state_pol_flow_match:
- *	@x contains the state to match.
- *	@xp contains the policy to check for a match.
- *	@fl contains the flow to check for a match.
- *	Return 1 if there is a match.
- * @xfrm_decode_session:
- *	@skb points to skb to decode.
- *	@secid points to the flow key secid to set.
- *	@ckall says if all xfrms used should be checked for same secid.
- *	Return 0 if ckall is zero or all xfrms used have the same secid.
- *
- * Security hooks affecting all Key Management operations
- *
- * @key_alloc:
- *	Permit allocation of a key and assign security data. Note that key does
- *	not have a serial number assigned at this point.
- *	@key points to the key.
- *	@flags is the allocation flags
- *	Return 0 if permission is granted, -ve error otherwise.
- * @key_free:
- *	Notification of destruction; free security data.
- *	@key points to the key.
- *	No return value.
- * @key_permission:
- *	See whether a specific operational right is granted to a process on a
- *	key.
- *	@key_ref refers to the key (key pointer + possession attribute bit).
- *	@cred points to the credentials to provide the context against which to
- *	evaluate the security data on the key.
- *	@perm describes the combination of permissions required of this key.
- *	Return 0 if permission is granted, -ve error otherwise.
- * @key_getsecurity:
- *	Get a textual representation of the security context attached to a key
- *	for the purposes of honouring KEYCTL_GETSECURITY.  This function
- *	allocates the storage for the NUL-terminated string and the caller
- *	should free it.
- *	@key points to the key to be queried.
- *	@_buffer points to a pointer that should be set to point to the
- *	resulting string (if no label or an error occurs).
- *	Return the length of the string (including terminating NUL) or -ve if
- *	an error.
- *	May also return 0 (and a NULL buffer pointer) if there is no label.
- *
- * Security hooks affecting all System V IPC operations.
- *
- * @ipc_permission:
- *	Check permissions for access to IPC
- *	@ipcp contains the kernel IPC permission structure
- *	@flag contains the desired (requested) permission set
- *	Return 0 if permission is granted.
- * @ipc_getsecid:
- *	Get the secid associated with the ipc object.
- *	@ipcp contains the kernel IPC permission structure.
- *	@secid contains a pointer to the location where result will be saved.
- *	In case of failure, @secid will be set to zero.
- *
- * Security hooks for individual messages held in System V IPC message queues
- * @msg_msg_alloc_security:
- *	Allocate and attach a security structure to the msg->security field.
- *	The security field is initialized to NULL when the structure is first
- *	created.
- *	@msg contains the message structure to be modified.
- *	Return 0 if operation was successful and permission is granted.
- * @msg_msg_free_security:
- *	Deallocate the security structure for this message.
- *	@msg contains the message structure to be modified.
- *
- * Security hooks for System V IPC Message Queues
- *
- * @msg_queue_alloc_security:
- *	Allocate and attach a security structure to the
- *	msq->q_perm.security field. The security field is initialized to
- *	NULL when the structure is first created.
- *	@msq contains the message queue structure to be modified.
- *	Return 0 if operation was successful and permission is granted.
- * @msg_queue_free_security:
- *	Deallocate security structure for this message queue.
- *	@msq contains the message queue structure to be modified.
- * @msg_queue_associate:
- *	Check permission when a message queue is requested through the
- *	msgget system call.  This hook is only called when returning the
- *	message queue identifier for an existing message queue, not when a
- *	new message queue is created.
- *	@msq contains the message queue to act upon.
- *	@msqflg contains the operation control flags.
- *	Return 0 if permission is granted.
- * @msg_queue_msgctl:
- *	Check permission when a message control operation specified by @cmd
- *	is to be performed on the message queue @msq.
- *	The @msq may be NULL, e.g. for IPC_INFO or MSG_INFO.
- *	@msq contains the message queue to act upon.  May be NULL.
- *	@cmd contains the operation to be performed.
- *	Return 0 if permission is granted.
- * @msg_queue_msgsnd:
- *	Check permission before a message, @msg, is enqueued on the message
- *	queue, @msq.
- *	@msq contains the message queue to send message to.
- *	@msg contains the message to be enqueued.
- *	@msqflg contains operational flags.
- *	Return 0 if permission is granted.
- * @msg_queue_msgrcv:
- *	Check permission before a message, @msg, is removed from the message
- *	queue, @msq.  The @target task structure contains a pointer to the
- *	process that will be receiving the message (not equal to the current
- *	process when inline receives are being performed).
- *	@msq contains the message queue to retrieve message from.
- *	@msg contains the message destination.
- *	@target contains the task structure for recipient process.
- *	@type contains the type of message requested.
- *	@mode contains the operational flags.
- *	Return 0 if permission is granted.
- *
- * Security hooks for System V Shared Memory Segments
- *
- * @shm_alloc_security:
- *	Allocate and attach a security structure to the shp->shm_perm.security
- *	field.  The security field is initialized to NULL when the structure is
- *	first created.
- *	@shp contains the shared memory structure to be modified.
- *	Return 0 if operation was successful and permission is granted.
- * @shm_free_security:
- *	Deallocate the security struct for this memory segment.
- *	@shp contains the shared memory structure to be modified.
- * @shm_associate:
- *	Check permission when a shared memory region is requested through the
- *	shmget system call.  This hook is only called when returning the shared
- *	memory region identifier for an existing region, not when a new shared
- *	memory region is created.
- *	@shp contains the shared memory structure to be modified.
- *	@shmflg contains the operation control flags.
- *	Return 0 if permission is granted.
- * @shm_shmctl:
- *	Check permission when a shared memory control operation specified by
- *	@cmd is to be performed on the shared memory region @shp.
- *	The @shp may be NULL, e.g. for IPC_INFO or SHM_INFO.
- *	@shp contains shared memory structure to be modified.
- *	@cmd contains the operation to be performed.
- *	Return 0 if permission is granted.
- * @shm_shmat:
- *	Check permissions prior to allowing the shmat system call to attach the
- *	shared memory segment @shp to the data segment of the calling process.
- *	The attaching address is specified by @shmaddr.
- *	@shp contains the shared memory structure to be modified.
- *	@shmaddr contains the address to attach memory region to.
- *	@shmflg contains the operational flags.
- *	Return 0 if permission is granted.
- *
- * Security hooks for System V Semaphores
- *
- * @sem_alloc_security:
- *	Allocate and attach a security structure to the sma->sem_perm.security
- *	field.  The security field is initialized to NULL when the structure is
- *	first created.
- *	@sma contains the semaphore structure
- *	Return 0 if operation was successful and permission is granted.
- * @sem_free_security:
- *	deallocate security struct for this semaphore
- *	@sma contains the semaphore structure.
- * @sem_associate:
- *	Check permission when a semaphore is requested through the semget
- *	system call.  This hook is only called when returning the semaphore
- *	identifier for an existing semaphore, not when a new one must be
- *	created.
- *	@sma contains the semaphore structure.
- *	@semflg contains the operation control flags.
- *	Return 0 if permission is granted.
- * @sem_semctl:
- *	Check permission when a semaphore operation specified by @cmd is to be
- *	performed on the semaphore @sma.  The @sma may be NULL, e.g. for
- *	IPC_INFO or SEM_INFO.
- *	@sma contains the semaphore structure.  May be NULL.
- *	@cmd contains the operation to be performed.
- *	Return 0 if permission is granted.
- * @sem_semop:
- *	Check permissions before performing operations on members of the
- *	semaphore set @sma.  If the @alter flag is nonzero, the semaphore set
- *	may be modified.
- *	@sma contains the semaphore structure.
- *	@sops contains the operations to perform.
- *	@nsops contains the number of operations to perform.
- *	@alter contains the flag indicating whether changes are to be made.
- *	Return 0 if permission is granted.
- *
- * @binder_set_context_mgr:
- *	Check whether @mgr is allowed to be the binder context manager.
- *	@mgr contains the task_struct for the task being registered.
- *	Return 0 if permission is granted.
- * @binder_transaction:
- *	Check whether @from is allowed to invoke a binder transaction call
- *	to @to.
- *	@from contains the task_struct for the sending task.
- *	@to contains the task_struct for the receiving task.
- * @binder_transfer_binder:
- *	Check whether @from is allowed to transfer a binder reference to @to.
- *	@from contains the task_struct for the sending task.
- *	@to contains the task_struct for the receiving task.
- * @binder_transfer_file:
- *	Check whether @from is allowed to transfer @file to @to.
- *	@from contains the task_struct for the sending task.
- *	@file contains the struct file being transferred.
- *	@to contains the task_struct for the receiving task.
- *
- * @ptrace_access_check:
- *	Check permission before allowing the current process to trace the
- *	@child process.
- *	Security modules may also want to perform a process tracing check
- *	during an execve in the set_security or apply_creds hooks of
- *	tracing check during an execve in the bprm_set_creds hook of
- *	binprm_security_ops if the process is being traced and its security
- *	attributes would be changed by the execve.
- *	@child contains the task_struct structure for the target process.
- *	@mode contains the PTRACE_MODE flags indicating the form of access.
- *	Return 0 if permission is granted.
- * @ptrace_traceme:
- *	Check that the @parent process has sufficient permission to trace the
- *	current process before allowing the current process to present itself
- *	to the @parent process for tracing.
- *	@parent contains the task_struct structure for debugger process.
- *	Return 0 if permission is granted.
- * @capget:
- *	Get the @effective, @inheritable, and @permitted capability sets for
- *	the @target process.  The hook may also perform permission checking to
- *	determine if the current process is allowed to see the capability sets
- *	of the @target process.
- *	@target contains the task_struct structure for target process.
- *	@effective contains the effective capability set.
- *	@inheritable contains the inheritable capability set.
- *	@permitted contains the permitted capability set.
- *	Return 0 if the capability sets were successfully obtained.
- * @capset:
- *	Set the @effective, @inheritable, and @permitted capability sets for
- *	the current process.
- *	@new contains the new credentials structure for target process.
- *	@old contains the current credentials structure for target process.
- *	@effective contains the effective capability set.
- *	@inheritable contains the inheritable capability set.
- *	@permitted contains the permitted capability set.
- *	Return 0 and update @new if permission is granted.
- * @capable:
- *	Check whether the @tsk process has the @cap capability in the indicated
- *	credentials.
- *	@cred contains the credentials to use.
- *	@ns contains the user namespace we want the capability in
- *	@cap contains the capability <include/linux/capability.h>.
- *	@audit contains whether to write an audit message or not
- *	Return 0 if the capability is granted for @tsk.
- * @syslog:
- *	Check permission before accessing the kernel message ring or changing
- *	logging to the console.
- *	See the syslog(2) manual page for an explanation of the @type values.
- *	@type contains the type of action.
- *	@from_file indicates the context of action (if it came from /proc).
- *	Return 0 if permission is granted.
- * @settime:
- *	Check permission to change the system time.
- *	struct timespec64 is defined in include/linux/time64.h and timezone
- *	is defined in include/linux/time.h
- *	@ts contains new time
- *	@tz contains new timezone
- *	Return 0 if permission is granted.
- * @vm_enough_memory:
- *	Check permissions for allocating a new virtual mapping.
- *	@mm contains the mm struct it is being added to.
- *	@pages contains the number of pages.
- *	Return 0 if permission is granted.
- *
- * @ismaclabel:
- *	Check if the extended attribute specified by @name
- *	represents a MAC label. Returns 1 if name is a MAC
- *	attribute otherwise returns 0.
- *	@name full extended attribute name to check against
- *	LSM as a MAC label.
- *
- * @secid_to_secctx:
- *	Convert secid to security context.  If secdata is NULL the length of
- *	the result will be returned in seclen, but no secdata will be returned.
- *	This does mean that the length could change between calls to check the
- *	length and the next call which actually allocates and returns the
- *	secdata.
- *	@secid contains the security ID.
- *	@secdata contains the pointer that stores the converted security
- *	context.
- *	@seclen pointer which contains the length of the data
- * @secctx_to_secid:
- *	Convert security context to secid.
- *	@secid contains the pointer to the generated security ID.
- *	@secdata contains the security context.
- *
- * @release_secctx:
- *	Release the security context.
- *	@secdata contains the security context.
- *	@seclen contains the length of the security context.
- *
- * Security hooks for Audit
- *
- * @audit_rule_init:
- *	Allocate and initialize an LSM audit rule structure.
- *	@field contains the required Audit action.
- *	Fields flags are defined in include/linux/audit.h
- *	@op contains the operator the rule uses.
- *	@rulestr contains the context where the rule will be applied to.
- *	@lsmrule contains a pointer to receive the result.
- *	Return 0 if @lsmrule has been successfully set,
- *	-EINVAL in case of an invalid rule.
- *
- * @audit_rule_known:
- *	Specifies whether given @rule contains any fields related to
- *	current LSM.
- *	@rule contains the audit rule of interest.
- *	Return 1 in case of relation found, 0 otherwise.
- *
- * @audit_rule_match:
- *	Determine if given @secid matches a rule previously approved
- *	by @audit_rule_known.
- *	@secid contains the security id in question.
- *	@field contains the field which relates to current LSM.
- *	@op contains the operator that will be used for matching.
- *	@rule points to the audit rule that will be checked against.
- *	@actx points to the audit context associated with the check.
- *	Return 1 if secid matches the rule, 0 if it does not, -ERRNO on failure.
- *
- * @audit_rule_free:
- *	Deallocate the LSM audit rule structure previously allocated by
- *	audit_rule_init.
- *	@rule contains the allocated rule
- *
- * @inode_invalidate_secctx:
- *	Notify the security module that it must revalidate the security context
- *	of an inode.
- *
- * @inode_notifysecctx:
- *	Notify the security module of what the security context of an inode
- *	should be.  Initializes the incore security context managed by the
- *	security module for this inode.  Example usage:  NFS client invokes
- *	this hook to initialize the security context in its incore inode to the
- *	value provided by the server for the file when the server returned the
- *	file's attributes to the client.
- *
- *	Must be called with inode->i_mutex locked.
- *
- *	@inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
- *
- * @inode_setsecctx:
- *	Change the security context of an inode.  Updates the
- *	incore security context managed by the security module and invokes the
- *	fs code as needed (via __vfs_setxattr_noperm) to update any backing
- *	xattrs that represent the context.  Example usage:  NFS server invokes
- *	this hook to change the security context in its incore inode and on the
- *	backing filesystem to a value provided by the client on a SETATTR
- *	operation.
- *
- *	Must be called with inode->i_mutex locked.
- *
- *	@dentry contains the inode we wish to set the security context of.
- *	@ctx contains the string which we wish to set in the inode.
- *	@ctxlen contains the length of @ctx.
- *
- * @inode_getsecctx:
- *	On success, returns 0 and fills out @ctx and @ctxlen with the security
- *	context for the given @inode.
- *
- *	@inode we wish to get the security context of.
- *	@ctx is a pointer in which to place the allocated security context.
- *	@ctxlen points to the place to put the length of @ctx.
- *
- * Security hooks for using the eBPF maps and programs functionalities through
- * eBPF syscalls.
- *
- * @bpf:
- *	Do a initial check for all bpf syscalls after the attribute is copied
- *	into the kernel. The actual security module can implement their own
- *	rules to check the specific cmd they need.
- *
- * @bpf_map:
- *	Do a check when the kernel generate and return a file descriptor for
- *	eBPF maps.
- *
- *	@map: bpf map that we want to access
- *	@mask: the access flags
- *
- * @bpf_prog:
- *	Do a check when the kernel generate and return a file descriptor for
- *	eBPF programs.
- *
- *	@prog: bpf prog that userspace want to use.
- *
- * @bpf_map_alloc_security:
- *	Initialize the security field inside bpf map.
- *
- * @bpf_map_free_security:
- *	Clean up the security information stored inside bpf map.
- *
- * @bpf_prog_alloc_security:
- *	Initialize the security field inside bpf program.
- *
- * @bpf_prog_free_security:
- *	Clean up the security information stored inside bpf prog.
- *
- */
 union security_list_options {
-	int (*binder_set_context_mgr)(struct task_struct *mgr);
-	int (*binder_transaction)(struct task_struct *from,
-					struct task_struct *to);
-	int (*binder_transfer_binder)(struct task_struct *from,
-					struct task_struct *to);
-	int (*binder_transfer_file)(struct task_struct *from,
-					struct task_struct *to,
-					struct file *file);
-
-	int (*ptrace_access_check)(struct task_struct *child,
-					unsigned int mode);
-	int (*ptrace_traceme)(struct task_struct *parent);
-	int (*capget)(struct task_struct *target, kernel_cap_t *effective,
-			kernel_cap_t *inheritable, kernel_cap_t *permitted);
-	int (*capset)(struct cred *new, const struct cred *old,
-			const kernel_cap_t *effective,
-			const kernel_cap_t *inheritable,
-			const kernel_cap_t *permitted);
-	int (*capable)(const struct cred *cred, struct user_namespace *ns,
-			int cap, int audit);
-	int (*quotactl)(int cmds, int type, int id, struct super_block *sb);
-	int (*quota_on)(struct dentry *dentry);
-	int (*syslog)(int type);
-	int (*settime)(const struct timespec64 *ts, const struct timezone *tz);
-	int (*vm_enough_memory)(struct mm_struct *mm, long pages);
-
-	int (*bprm_set_creds)(struct linux_binprm *bprm);
-	int (*bprm_check_security)(struct linux_binprm *bprm);
-	void (*bprm_committing_creds)(struct linux_binprm *bprm);
-	void (*bprm_committed_creds)(struct linux_binprm *bprm);
-
-	int (*sb_alloc_security)(struct super_block *sb);
-	void (*sb_free_security)(struct super_block *sb);
-	int (*sb_copy_data)(char *orig, char *copy);
-	int (*sb_remount)(struct super_block *sb, void *data);
-	int (*sb_kern_mount)(struct super_block *sb, int flags, void *data);
-	int (*sb_show_options)(struct seq_file *m, struct super_block *sb);
-	int (*sb_statfs)(struct dentry *dentry);
-	int (*sb_mount)(const char *dev_name, const struct path *path,
-			const char *type, unsigned long flags, void *data);
-	int (*sb_umount)(struct vfsmount *mnt, int flags);
-	int (*sb_pivotroot)(const struct path *old_path, const struct path *new_path);
-	int (*sb_set_mnt_opts)(struct super_block *sb,
-				struct security_mnt_opts *opts,
-				unsigned long kern_flags,
-				unsigned long *set_kern_flags);
-	int (*sb_clone_mnt_opts)(const struct super_block *oldsb,
-					struct super_block *newsb,
-					unsigned long kern_flags,
-					unsigned long *set_kern_flags);
-	int (*sb_parse_opts_str)(char *options, struct security_mnt_opts *opts);
-	int (*dentry_init_security)(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
-	int (*dentry_create_files_as)(struct dentry *dentry, int mode,
-					struct qstr *name,
-					const struct cred *old,
-					struct cred *new);
-
-
-#ifdef CONFIG_SECURITY_PATH
-	int (*path_unlink)(const struct path *dir, struct dentry *dentry);
-	int (*path_mkdir)(const struct path *dir, struct dentry *dentry,
-				umode_t mode);
-	int (*path_rmdir)(const struct path *dir, struct dentry *dentry);
-	int (*path_mknod)(const struct path *dir, struct dentry *dentry,
-				umode_t mode, unsigned int dev);
-	int (*path_truncate)(const struct path *path);
-	int (*path_symlink)(const struct path *dir, struct dentry *dentry,
-				const char *old_name);
-	int (*path_link)(struct dentry *old_dentry, const struct path *new_dir,
-				struct dentry *new_dentry);
-	int (*path_rename)(const struct path *old_dir, struct dentry *old_dentry,
-				const struct path *new_dir,
-				struct dentry *new_dentry);
-	int (*path_chmod)(const struct path *path, umode_t mode);
-	int (*path_chown)(const struct path *path, kuid_t uid, kgid_t gid);
-	int (*path_chroot)(const struct path *path);
-#endif
-
-	int (*inode_alloc_security)(struct inode *inode);
-	void (*inode_free_security)(struct inode *inode);
-	int (*inode_init_security)(struct inode *inode, struct inode *dir,
-					const struct qstr *qstr,
-					const char **name, void **value,
-					size_t *len);
-	int (*inode_create)(struct inode *dir, struct dentry *dentry,
-				umode_t mode);
-	int (*inode_link)(struct dentry *old_dentry, struct inode *dir,
-				struct dentry *new_dentry);
-	int (*inode_unlink)(struct inode *dir, struct dentry *dentry);
-	int (*inode_symlink)(struct inode *dir, struct dentry *dentry,
-				const char *old_name);
-	int (*inode_mkdir)(struct inode *dir, struct dentry *dentry,
-				umode_t mode);
-	int (*inode_rmdir)(struct inode *dir, struct dentry *dentry);
-	int (*inode_mknod)(struct inode *dir, struct dentry *dentry,
-				umode_t mode, dev_t dev);
-	int (*inode_rename)(struct inode *old_dir, struct dentry *old_dentry,
-				struct inode *new_dir,
-				struct dentry *new_dentry);
-	int (*inode_readlink)(struct dentry *dentry);
-	int (*inode_follow_link)(struct dentry *dentry, struct inode *inode,
-				 bool rcu);
-	int (*inode_permission)(struct inode *inode, int mask);
-	int (*inode_setattr)(struct dentry *dentry, struct iattr *attr);
-	int (*inode_getattr)(const struct path *path);
-	int (*inode_setxattr)(struct dentry *dentry, const char *name,
-				const void *value, size_t size, int flags);
-	void (*inode_post_setxattr)(struct dentry *dentry, const char *name,
-					const void *value, size_t size,
-					int flags);
-	int (*inode_getxattr)(struct dentry *dentry, const char *name);
-	int (*inode_listxattr)(struct dentry *dentry);
-	int (*inode_removexattr)(struct dentry *dentry, const char *name);
-	int (*inode_need_killpriv)(struct dentry *dentry);
-	int (*inode_killpriv)(struct dentry *dentry);
-	int (*inode_getsecurity)(struct inode *inode, const char *name,
-					void **buffer, bool alloc);
-	int (*inode_setsecurity)(struct inode *inode, const char *name,
-					const void *value, size_t size,
-					int flags);
-	int (*inode_listsecurity)(struct inode *inode, char *buffer,
-					size_t buffer_size);
-	void (*inode_getsecid)(struct inode *inode, u32 *secid);
-	int (*inode_copy_up)(struct dentry *src, struct cred **new);
-	int (*inode_copy_up_xattr)(const char *name);
-
-	int (*file_permission)(struct file *file, int mask);
-	int (*file_alloc_security)(struct file *file);
-	void (*file_free_security)(struct file *file);
-	int (*file_ioctl)(struct file *file, unsigned int cmd,
-				unsigned long arg);
-	int (*mmap_addr)(unsigned long addr);
-	int (*mmap_file)(struct file *file, unsigned long reqprot,
-				unsigned long prot, unsigned long flags);
-	int (*file_mprotect)(struct vm_area_struct *vma, unsigned long reqprot,
-				unsigned long prot);
-	int (*file_lock)(struct file *file, unsigned int cmd);
-	int (*file_fcntl)(struct file *file, unsigned int cmd,
-				unsigned long arg);
-	void (*file_set_fowner)(struct file *file);
-	int (*file_send_sigiotask)(struct task_struct *tsk,
-					struct fown_struct *fown, int sig);
-	int (*file_receive)(struct file *file);
-	int (*file_open)(struct file *file, const struct cred *cred);
-
-	int (*task_alloc)(struct task_struct *task, unsigned long clone_flags);
-	void (*task_free)(struct task_struct *task);
-	int (*cred_alloc_blank)(struct cred *cred, gfp_t gfp);
-	void (*cred_free)(struct cred *cred);
-	int (*cred_prepare)(struct cred *new, const struct cred *old,
-				gfp_t gfp);
-	void (*cred_transfer)(struct cred *new, const struct cred *old);
-	int (*kernel_act_as)(struct cred *new, u32 secid);
-	int (*kernel_create_files_as)(struct cred *new, struct inode *inode);
-	int (*kernel_module_request)(char *kmod_name);
-	int (*kernel_read_file)(struct file *file, enum kernel_read_file_id id);
-	int (*kernel_post_read_file)(struct file *file, char *buf, loff_t size,
-				     enum kernel_read_file_id id);
-	int (*task_fix_setuid)(struct cred *new, const struct cred *old,
-				int flags);
-	int (*task_setpgid)(struct task_struct *p, pid_t pgid);
-	int (*task_getpgid)(struct task_struct *p);
-	int (*task_getsid)(struct task_struct *p);
-	void (*task_getsecid)(struct task_struct *p, u32 *secid);
-	int (*task_setnice)(struct task_struct *p, int nice);
-	int (*task_setioprio)(struct task_struct *p, int ioprio);
-	int (*task_getioprio)(struct task_struct *p);
-	int (*task_prlimit)(const struct cred *cred, const struct cred *tcred,
-			    unsigned int flags);
-	int (*task_setrlimit)(struct task_struct *p, unsigned int resource,
-				struct rlimit *new_rlim);
-	int (*task_setscheduler)(struct task_struct *p);
-	int (*task_getscheduler)(struct task_struct *p);
-	int (*task_movememory)(struct task_struct *p);
-	int (*task_kill)(struct task_struct *p, struct siginfo *info,
-				int sig, u32 secid);
-	int (*task_prctl)(int option, unsigned long arg2, unsigned long arg3,
-				unsigned long arg4, unsigned long arg5);
-	void (*task_to_inode)(struct task_struct *p, struct inode *inode);
-
-	int (*ipc_permission)(struct kern_ipc_perm *ipcp, short flag);
-	void (*ipc_getsecid)(struct kern_ipc_perm *ipcp, u32 *secid);
-
-	int (*msg_msg_alloc_security)(struct msg_msg *msg);
-	void (*msg_msg_free_security)(struct msg_msg *msg);
-
-	int (*msg_queue_alloc_security)(struct msg_queue *msq);
-	void (*msg_queue_free_security)(struct msg_queue *msq);
-	int (*msg_queue_associate)(struct msg_queue *msq, int msqflg);
-	int (*msg_queue_msgctl)(struct msg_queue *msq, int cmd);
-	int (*msg_queue_msgsnd)(struct msg_queue *msq, struct msg_msg *msg,
-				int msqflg);
-	int (*msg_queue_msgrcv)(struct msg_queue *msq, struct msg_msg *msg,
-				struct task_struct *target, long type,
-				int mode);
-
-	int (*shm_alloc_security)(struct shmid_kernel *shp);
-	void (*shm_free_security)(struct shmid_kernel *shp);
-	int (*shm_associate)(struct shmid_kernel *shp, int shmflg);
-	int (*shm_shmctl)(struct shmid_kernel *shp, int cmd);
-	int (*shm_shmat)(struct shmid_kernel *shp, char __user *shmaddr,
-				int shmflg);
-
-	int (*sem_alloc_security)(struct sem_array *sma);
-	void (*sem_free_security)(struct sem_array *sma);
-	int (*sem_associate)(struct sem_array *sma, int semflg);
-	int (*sem_semctl)(struct sem_array *sma, int cmd);
-	int (*sem_semop)(struct sem_array *sma, struct sembuf *sops,
-				unsigned nsops, int alter);
-
-	int (*netlink_send)(struct sock *sk, struct sk_buff *skb);
-
-	void (*d_instantiate)(struct dentry *dentry, struct inode *inode);
-
-	int (*getprocattr)(struct task_struct *p, char *name, char **value);
-	int (*setprocattr)(const char *name, void *value, size_t size);
-	int (*ismaclabel)(const char *name);
-	int (*secid_to_secctx)(u32 secid, char **secdata, u32 *seclen);
-	int (*secctx_to_secid)(const char *secdata, u32 seclen, u32 *secid);
-	void (*release_secctx)(char *secdata, u32 seclen);
-
-	void (*inode_invalidate_secctx)(struct inode *inode);
-	int (*inode_notifysecctx)(struct inode *inode, void *ctx, u32 ctxlen);
-	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
-	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
-
-#ifdef CONFIG_SECURITY_NETWORK
-	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
-					struct sock *newsk);
-	int (*unix_may_send)(struct socket *sock, struct socket *other);
-
-	int (*socket_create)(int family, int type, int protocol, int kern);
-	int (*socket_post_create)(struct socket *sock, int family, int type,
-					int protocol, int kern);
-	int (*socket_bind)(struct socket *sock, struct sockaddr *address,
-				int addrlen);
-	int (*socket_connect)(struct socket *sock, struct sockaddr *address,
-				int addrlen);
-	int (*socket_listen)(struct socket *sock, int backlog);
-	int (*socket_accept)(struct socket *sock, struct socket *newsock);
-	int (*socket_sendmsg)(struct socket *sock, struct msghdr *msg,
-				int size);
-	int (*socket_recvmsg)(struct socket *sock, struct msghdr *msg,
-				int size, int flags);
-	int (*socket_getsockname)(struct socket *sock);
-	int (*socket_getpeername)(struct socket *sock);
-	int (*socket_getsockopt)(struct socket *sock, int level, int optname);
-	int (*socket_setsockopt)(struct socket *sock, int level, int optname);
-	int (*socket_shutdown)(struct socket *sock, int how);
-	int (*socket_sock_rcv_skb)(struct sock *sk, struct sk_buff *skb);
-	int (*socket_getpeersec_stream)(struct socket *sock,
-					char __user *optval,
-					int __user *optlen, unsigned len);
-	int (*socket_getpeersec_dgram)(struct socket *sock,
-					struct sk_buff *skb, u32 *secid);
-	int (*sk_alloc_security)(struct sock *sk, int family, gfp_t priority);
-	void (*sk_free_security)(struct sock *sk);
-	void (*sk_clone_security)(const struct sock *sk, struct sock *newsk);
-	void (*sk_getsecid)(struct sock *sk, u32 *secid);
-	void (*sock_graft)(struct sock *sk, struct socket *parent);
-	int (*inet_conn_request)(struct sock *sk, struct sk_buff *skb,
-					struct request_sock *req);
-	void (*inet_csk_clone)(struct sock *newsk,
-				const struct request_sock *req);
-	void (*inet_conn_established)(struct sock *sk, struct sk_buff *skb);
-	int (*secmark_relabel_packet)(u32 secid);
-	void (*secmark_refcount_inc)(void);
-	void (*secmark_refcount_dec)(void);
-	void (*req_classify_flow)(const struct request_sock *req,
-					struct flowi *fl);
-	int (*tun_dev_alloc_security)(void **security);
-	void (*tun_dev_free_security)(void *security);
-	int (*tun_dev_create)(void);
-	int (*tun_dev_attach_queue)(void *security);
-	int (*tun_dev_attach)(struct sock *sk, void *security);
-	int (*tun_dev_open)(void *security);
-#endif	/* CONFIG_SECURITY_NETWORK */
-
-#ifdef CONFIG_SECURITY_INFINIBAND
-	int (*ib_pkey_access)(void *sec, u64 subnet_prefix, u16 pkey);
-	int (*ib_endport_manage_subnet)(void *sec, const char *dev_name,
-					u8 port_num);
-	int (*ib_alloc_security)(void **sec);
-	void (*ib_free_security)(void *sec);
-#endif	/* CONFIG_SECURITY_INFINIBAND */
-
-#ifdef CONFIG_SECURITY_NETWORK_XFRM
-	int (*xfrm_policy_alloc_security)(struct xfrm_sec_ctx **ctxp,
-					  struct xfrm_user_sec_ctx *sec_ctx,
-						gfp_t gfp);
-	int (*xfrm_policy_clone_security)(struct xfrm_sec_ctx *old_ctx,
-						struct xfrm_sec_ctx **new_ctx);
-	void (*xfrm_policy_free_security)(struct xfrm_sec_ctx *ctx);
-	int (*xfrm_policy_delete_security)(struct xfrm_sec_ctx *ctx);
-	int (*xfrm_state_alloc)(struct xfrm_state *x,
-				struct xfrm_user_sec_ctx *sec_ctx);
-	int (*xfrm_state_alloc_acquire)(struct xfrm_state *x,
-					struct xfrm_sec_ctx *polsec,
-					u32 secid);
-	void (*xfrm_state_free_security)(struct xfrm_state *x);
-	int (*xfrm_state_delete_security)(struct xfrm_state *x);
-	int (*xfrm_policy_lookup)(struct xfrm_sec_ctx *ctx, u32 fl_secid,
-					u8 dir);
-	int (*xfrm_state_pol_flow_match)(struct xfrm_state *x,
-						struct xfrm_policy *xp,
-						const struct flowi *fl);
-	int (*xfrm_decode_session)(struct sk_buff *skb, u32 *secid, int ckall);
-#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
-
-	/* key management security hooks */
-#ifdef CONFIG_KEYS
-	int (*key_alloc)(struct key *key, const struct cred *cred,
-				unsigned long flags);
-	void (*key_free)(struct key *key);
-	int (*key_permission)(key_ref_t key_ref, const struct cred *cred,
-				unsigned perm);
-	int (*key_getsecurity)(struct key *key, char **_buffer);
-#endif	/* CONFIG_KEYS */
-
-#ifdef CONFIG_AUDIT
-	int (*audit_rule_init)(u32 field, u32 op, char *rulestr,
-				void **lsmrule);
-	int (*audit_rule_known)(struct audit_krule *krule);
-	int (*audit_rule_match)(u32 secid, u32 field, u32 op, void *lsmrule,
-				struct audit_context *actx);
-	void (*audit_rule_free)(void *lsmrule);
-#endif /* CONFIG_AUDIT */
-
-#ifdef CONFIG_BPF_SYSCALL
-	int (*bpf)(int cmd, union bpf_attr *attr,
-				 unsigned int size);
-	int (*bpf_map)(struct bpf_map *map, fmode_t fmode);
-	int (*bpf_prog)(struct bpf_prog *prog);
-	int (*bpf_map_alloc_security)(struct bpf_map *map);
-	void (*bpf_map_free_security)(struct bpf_map *map);
-	int (*bpf_prog_alloc_security)(struct bpf_prog_aux *aux);
-	void (*bpf_prog_free_security)(struct bpf_prog_aux *aux);
-#endif /* CONFIG_BPF_SYSCALL */
+#define INT_HOOK(_hook_name, ...)	int(*_hook_name)(__VA_ARGS__)
+#define VOID_HOOK(_hook_name, ...)	void(*_hook_name)(__VA_ARGS__)
+#define INT_HOOK_INT(...)			INT_HOOK(__VA_ARGS__)
+#define INT_HOOK_EXT(...)
+#define VOID_HOOK_INT(...)			VOID_HOOK(__VA_ARGS__)
+#define VOID_HOOK_EXT(...)
+#include <linux/lsm_hook_types.h>
+#undef INT_HOOK
+#undef VOID_HOOK
+#undef INT_HOOK_INT
+#undef INT_HOOK_EXT
 };
 
 struct security_hook_heads {
-	struct hlist_head binder_set_context_mgr;
-	struct hlist_head binder_transaction;
-	struct hlist_head binder_transfer_binder;
-	struct hlist_head binder_transfer_file;
-	struct hlist_head ptrace_access_check;
-	struct hlist_head ptrace_traceme;
-	struct hlist_head capget;
-	struct hlist_head capset;
-	struct hlist_head capable;
-	struct hlist_head quotactl;
-	struct hlist_head quota_on;
-	struct hlist_head syslog;
-	struct hlist_head settime;
-	struct hlist_head vm_enough_memory;
-	struct hlist_head bprm_set_creds;
-	struct hlist_head bprm_check_security;
-	struct hlist_head bprm_committing_creds;
-	struct hlist_head bprm_committed_creds;
-	struct hlist_head sb_alloc_security;
-	struct hlist_head sb_free_security;
-	struct hlist_head sb_copy_data;
-	struct hlist_head sb_remount;
-	struct hlist_head sb_kern_mount;
-	struct hlist_head sb_show_options;
-	struct hlist_head sb_statfs;
-	struct hlist_head sb_mount;
-	struct hlist_head sb_umount;
-	struct hlist_head sb_pivotroot;
-	struct hlist_head sb_set_mnt_opts;
-	struct hlist_head sb_clone_mnt_opts;
-	struct hlist_head sb_parse_opts_str;
-	struct hlist_head dentry_init_security;
-	struct hlist_head dentry_create_files_as;
-#ifdef CONFIG_SECURITY_PATH
-	struct hlist_head path_unlink;
-	struct hlist_head path_mkdir;
-	struct hlist_head path_rmdir;
-	struct hlist_head path_mknod;
-	struct hlist_head path_truncate;
-	struct hlist_head path_symlink;
-	struct hlist_head path_link;
-	struct hlist_head path_rename;
-	struct hlist_head path_chmod;
-	struct hlist_head path_chown;
-	struct hlist_head path_chroot;
-#endif
-	struct hlist_head inode_alloc_security;
-	struct hlist_head inode_free_security;
-	struct hlist_head inode_init_security;
-	struct hlist_head inode_create;
-	struct hlist_head inode_link;
-	struct hlist_head inode_unlink;
-	struct hlist_head inode_symlink;
-	struct hlist_head inode_mkdir;
-	struct hlist_head inode_rmdir;
-	struct hlist_head inode_mknod;
-	struct hlist_head inode_rename;
-	struct hlist_head inode_readlink;
-	struct hlist_head inode_follow_link;
-	struct hlist_head inode_permission;
-	struct hlist_head inode_setattr;
-	struct hlist_head inode_getattr;
-	struct hlist_head inode_setxattr;
-	struct hlist_head inode_post_setxattr;
-	struct hlist_head inode_getxattr;
-	struct hlist_head inode_listxattr;
-	struct hlist_head inode_removexattr;
-	struct hlist_head inode_need_killpriv;
-	struct hlist_head inode_killpriv;
-	struct hlist_head inode_getsecurity;
-	struct hlist_head inode_setsecurity;
-	struct hlist_head inode_listsecurity;
-	struct hlist_head inode_getsecid;
-	struct hlist_head inode_copy_up;
-	struct hlist_head inode_copy_up_xattr;
-	struct hlist_head file_permission;
-	struct hlist_head file_alloc_security;
-	struct hlist_head file_free_security;
-	struct hlist_head file_ioctl;
-	struct hlist_head mmap_addr;
-	struct hlist_head mmap_file;
-	struct hlist_head file_mprotect;
-	struct hlist_head file_lock;
-	struct hlist_head file_fcntl;
-	struct hlist_head file_set_fowner;
-	struct hlist_head file_send_sigiotask;
-	struct hlist_head file_receive;
-	struct hlist_head file_open;
-	struct hlist_head task_alloc;
-	struct hlist_head task_free;
-	struct hlist_head cred_alloc_blank;
-	struct hlist_head cred_free;
-	struct hlist_head cred_prepare;
-	struct hlist_head cred_transfer;
-	struct hlist_head kernel_act_as;
-	struct hlist_head kernel_create_files_as;
-	struct hlist_head kernel_read_file;
-	struct hlist_head kernel_post_read_file;
-	struct hlist_head kernel_module_request;
-	struct hlist_head task_fix_setuid;
-	struct hlist_head task_setpgid;
-	struct hlist_head task_getpgid;
-	struct hlist_head task_getsid;
-	struct hlist_head task_getsecid;
-	struct hlist_head task_setnice;
-	struct hlist_head task_setioprio;
-	struct hlist_head task_getioprio;
-	struct hlist_head task_prlimit;
-	struct hlist_head task_setrlimit;
-	struct hlist_head task_setscheduler;
-	struct hlist_head task_getscheduler;
-	struct hlist_head task_movememory;
-	struct hlist_head task_kill;
-	struct hlist_head task_prctl;
-	struct hlist_head task_to_inode;
-	struct hlist_head ipc_permission;
-	struct hlist_head ipc_getsecid;
-	struct hlist_head msg_msg_alloc_security;
-	struct hlist_head msg_msg_free_security;
-	struct hlist_head msg_queue_alloc_security;
-	struct hlist_head msg_queue_free_security;
-	struct hlist_head msg_queue_associate;
-	struct hlist_head msg_queue_msgctl;
-	struct hlist_head msg_queue_msgsnd;
-	struct hlist_head msg_queue_msgrcv;
-	struct hlist_head shm_alloc_security;
-	struct hlist_head shm_free_security;
-	struct hlist_head shm_associate;
-	struct hlist_head shm_shmctl;
-	struct hlist_head shm_shmat;
-	struct hlist_head sem_alloc_security;
-	struct hlist_head sem_free_security;
-	struct hlist_head sem_associate;
-	struct hlist_head sem_semctl;
-	struct hlist_head sem_semop;
-	struct hlist_head netlink_send;
-	struct hlist_head d_instantiate;
-	struct hlist_head getprocattr;
-	struct hlist_head setprocattr;
-	struct hlist_head ismaclabel;
-	struct hlist_head secid_to_secctx;
-	struct hlist_head secctx_to_secid;
-	struct hlist_head release_secctx;
-	struct hlist_head inode_invalidate_secctx;
-	struct hlist_head inode_notifysecctx;
-	struct hlist_head inode_setsecctx;
-	struct hlist_head inode_getsecctx;
-#ifdef CONFIG_SECURITY_NETWORK
-	struct hlist_head unix_stream_connect;
-	struct hlist_head unix_may_send;
-	struct hlist_head socket_create;
-	struct hlist_head socket_post_create;
-	struct hlist_head socket_bind;
-	struct hlist_head socket_connect;
-	struct hlist_head socket_listen;
-	struct hlist_head socket_accept;
-	struct hlist_head socket_sendmsg;
-	struct hlist_head socket_recvmsg;
-	struct hlist_head socket_getsockname;
-	struct hlist_head socket_getpeername;
-	struct hlist_head socket_getsockopt;
-	struct hlist_head socket_setsockopt;
-	struct hlist_head socket_shutdown;
-	struct hlist_head socket_sock_rcv_skb;
-	struct hlist_head socket_getpeersec_stream;
-	struct hlist_head socket_getpeersec_dgram;
-	struct hlist_head sk_alloc_security;
-	struct hlist_head sk_free_security;
-	struct hlist_head sk_clone_security;
-	struct hlist_head sk_getsecid;
-	struct hlist_head sock_graft;
-	struct hlist_head inet_conn_request;
-	struct hlist_head inet_csk_clone;
-	struct hlist_head inet_conn_established;
-	struct hlist_head secmark_relabel_packet;
-	struct hlist_head secmark_refcount_inc;
-	struct hlist_head secmark_refcount_dec;
-	struct hlist_head req_classify_flow;
-	struct hlist_head tun_dev_alloc_security;
-	struct hlist_head tun_dev_free_security;
-	struct hlist_head tun_dev_create;
-	struct hlist_head tun_dev_attach_queue;
-	struct hlist_head tun_dev_attach;
-	struct hlist_head tun_dev_open;
-#endif	/* CONFIG_SECURITY_NETWORK */
-#ifdef CONFIG_SECURITY_INFINIBAND
-	struct hlist_head ib_pkey_access;
-	struct hlist_head ib_endport_manage_subnet;
-	struct hlist_head ib_alloc_security;
-	struct hlist_head ib_free_security;
-#endif	/* CONFIG_SECURITY_INFINIBAND */
-#ifdef CONFIG_SECURITY_NETWORK_XFRM
-	struct hlist_head xfrm_policy_alloc_security;
-	struct hlist_head xfrm_policy_clone_security;
-	struct hlist_head xfrm_policy_free_security;
-	struct hlist_head xfrm_policy_delete_security;
-	struct hlist_head xfrm_state_alloc;
-	struct hlist_head xfrm_state_alloc_acquire;
-	struct hlist_head xfrm_state_free_security;
-	struct hlist_head xfrm_state_delete_security;
-	struct hlist_head xfrm_policy_lookup;
-	struct hlist_head xfrm_state_pol_flow_match;
-	struct hlist_head xfrm_decode_session;
-#endif	/* CONFIG_SECURITY_NETWORK_XFRM */
-#ifdef CONFIG_KEYS
-	struct hlist_head key_alloc;
-	struct hlist_head key_free;
-	struct hlist_head key_permission;
-	struct hlist_head key_getsecurity;
-#endif	/* CONFIG_KEYS */
-#ifdef CONFIG_AUDIT
-	struct hlist_head audit_rule_init;
-	struct hlist_head audit_rule_known;
-	struct hlist_head audit_rule_match;
-	struct hlist_head audit_rule_free;
-#endif /* CONFIG_AUDIT */
-#ifdef CONFIG_BPF_SYSCALL
-	struct hlist_head bpf;
-	struct hlist_head bpf_map;
-	struct hlist_head bpf_prog;
-	struct hlist_head bpf_map_alloc_security;
-	struct hlist_head bpf_map_free_security;
-	struct hlist_head bpf_prog_alloc_security;
-	struct hlist_head bpf_prog_free_security;
-#endif /* CONFIG_BPF_SYSCALL */
+#define INT_HOOK(_hook_name, ...)	struct hlist_head _hook_name
+#define VOID_HOOK(_hook_name, ...)	struct hlist_head _hook_name
+#define INT_HOOK_INT(...)			INT_HOOK(__VA_ARGS__)
+#define INT_HOOK_EXT(...)
+#define VOID_HOOK_INT(...)			VOID_HOOK(__VA_ARGS__)
+#define VOID_HOOK_EXT(...)
+#include <linux/lsm_hook_types.h>
+#undef INT_HOOK
+#undef VOID_HOOK
+#undef INT_HOOK_INT
+#undef INT_HOOK_EXT
+#undef VOID_HOOK_INT
+#undef VOID_HOOK_EXT
 } __randomize_layout;
 
 /*
diff --git a/include/linux/security.h b/include/linux/security.h
index 73f1ef625d40..1a1476d95008 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -115,6 +115,12 @@ struct xfrm_policy;
 struct xfrm_state;
 struct xfrm_user_sec_ctx;
 struct seq_file;
+#ifdef CONFIG_BPF_SYSCALL
+union bpf_attr;
+struct bpf_map;
+struct bpf_prog;
+struct bpf_prog_aux;
+#endif /* CONFIG_BPF_SYSCALL */
 
 #ifdef CONFIG_MMU
 extern unsigned long mmap_min_addr;
@@ -197,196 +203,21 @@ static inline void security_free_mnt_opts(struct security_mnt_opts *opts)
 extern int security_init(void);
 
 /* Security operations */
-int security_binder_set_context_mgr(struct task_struct *mgr);
-int security_binder_transaction(struct task_struct *from,
-				struct task_struct *to);
-int security_binder_transfer_binder(struct task_struct *from,
-				    struct task_struct *to);
-int security_binder_transfer_file(struct task_struct *from,
-				  struct task_struct *to, struct file *file);
-int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
-int security_ptrace_traceme(struct task_struct *parent);
-int security_capget(struct task_struct *target,
-		    kernel_cap_t *effective,
-		    kernel_cap_t *inheritable,
-		    kernel_cap_t *permitted);
-int security_capset(struct cred *new, const struct cred *old,
-		    const kernel_cap_t *effective,
-		    const kernel_cap_t *inheritable,
-		    const kernel_cap_t *permitted);
-int security_capable(const struct cred *cred, struct user_namespace *ns,
-			int cap);
-int security_capable_noaudit(const struct cred *cred, struct user_namespace *ns,
-			     int cap);
-int security_quotactl(int cmds, int type, int id, struct super_block *sb);
-int security_quota_on(struct dentry *dentry);
-int security_syslog(int type);
-int security_settime64(const struct timespec64 *ts, const struct timezone *tz);
-static inline int security_settime(const struct timespec *ts, const struct timezone *tz)
-{
-	struct timespec64 ts64 = timespec_to_timespec64(*ts);
-
-	return security_settime64(&ts64, tz);
-}
-int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
-int security_bprm_set_creds(struct linux_binprm *bprm);
-int security_bprm_check(struct linux_binprm *bprm);
-void security_bprm_committing_creds(struct linux_binprm *bprm);
-void security_bprm_committed_creds(struct linux_binprm *bprm);
-int security_sb_alloc(struct super_block *sb);
-void security_sb_free(struct super_block *sb);
-int security_sb_copy_data(char *orig, char *copy);
-int security_sb_remount(struct super_block *sb, void *data);
-int security_sb_kern_mount(struct super_block *sb, int flags, void *data);
-int security_sb_show_options(struct seq_file *m, struct super_block *sb);
-int security_sb_statfs(struct dentry *dentry);
-int security_sb_mount(const char *dev_name, const struct path *path,
-		      const char *type, unsigned long flags, void *data);
-int security_sb_umount(struct vfsmount *mnt, int flags);
-int security_sb_pivotroot(const struct path *old_path, const struct path *new_path);
-int security_sb_set_mnt_opts(struct super_block *sb,
-				struct security_mnt_opts *opts,
-				unsigned long kern_flags,
-				unsigned long *set_kern_flags);
-int security_sb_clone_mnt_opts(const struct super_block *oldsb,
-				struct super_block *newsb,
-				unsigned long kern_flags,
-				unsigned long *set_kern_flags);
-int security_sb_parse_opts_str(char *options, struct security_mnt_opts *opts);
-int security_dentry_init_security(struct dentry *dentry, int mode,
-					const struct qstr *name, void **ctx,
-					u32 *ctxlen);
-int security_dentry_create_files_as(struct dentry *dentry, int mode,
-					struct qstr *name,
-					const struct cred *old,
-					struct cred *new);
-
-int security_inode_alloc(struct inode *inode);
-void security_inode_free(struct inode *inode);
-int security_inode_init_security(struct inode *inode, struct inode *dir,
-				 const struct qstr *qstr,
-				 initxattrs initxattrs, void *fs_data);
-int security_old_inode_init_security(struct inode *inode, struct inode *dir,
-				     const struct qstr *qstr, const char **name,
-				     void **value, size_t *len);
-int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode);
-int security_inode_link(struct dentry *old_dentry, struct inode *dir,
-			 struct dentry *new_dentry);
-int security_inode_unlink(struct inode *dir, struct dentry *dentry);
-int security_inode_symlink(struct inode *dir, struct dentry *dentry,
-			   const char *old_name);
-int security_inode_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode);
-int security_inode_rmdir(struct inode *dir, struct dentry *dentry);
-int security_inode_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev);
-int security_inode_rename(struct inode *old_dir, struct dentry *old_dentry,
-			  struct inode *new_dir, struct dentry *new_dentry,
-			  unsigned int flags);
-int security_inode_readlink(struct dentry *dentry);
-int security_inode_follow_link(struct dentry *dentry, struct inode *inode,
-			       bool rcu);
-int security_inode_permission(struct inode *inode, int mask);
-int security_inode_setattr(struct dentry *dentry, struct iattr *attr);
-int security_inode_getattr(const struct path *path);
-int security_inode_setxattr(struct dentry *dentry, const char *name,
-			    const void *value, size_t size, int flags);
-void security_inode_post_setxattr(struct dentry *dentry, const char *name,
-				  const void *value, size_t size, int flags);
-int security_inode_getxattr(struct dentry *dentry, const char *name);
-int security_inode_listxattr(struct dentry *dentry);
-int security_inode_removexattr(struct dentry *dentry, const char *name);
-int security_inode_need_killpriv(struct dentry *dentry);
-int security_inode_killpriv(struct dentry *dentry);
-int security_inode_getsecurity(struct inode *inode, const char *name, void **buffer, bool alloc);
-int security_inode_setsecurity(struct inode *inode, const char *name, const void *value, size_t size, int flags);
-int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer_size);
-void security_inode_getsecid(struct inode *inode, u32 *secid);
-int security_inode_copy_up(struct dentry *src, struct cred **new);
-int security_inode_copy_up_xattr(const char *name);
-int security_file_permission(struct file *file, int mask);
-int security_file_alloc(struct file *file);
-void security_file_free(struct file *file);
-int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
-int security_mmap_file(struct file *file, unsigned long prot,
-			unsigned long flags);
-int security_mmap_addr(unsigned long addr);
-int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
-			   unsigned long prot);
-int security_file_lock(struct file *file, unsigned int cmd);
-int security_file_fcntl(struct file *file, unsigned int cmd, unsigned long arg);
-void security_file_set_fowner(struct file *file);
-int security_file_send_sigiotask(struct task_struct *tsk,
-				 struct fown_struct *fown, int sig);
-int security_file_receive(struct file *file);
-int security_file_open(struct file *file, const struct cred *cred);
-int security_task_alloc(struct task_struct *task, unsigned long clone_flags);
-void security_task_free(struct task_struct *task);
-int security_cred_alloc_blank(struct cred *cred, gfp_t gfp);
-void security_cred_free(struct cred *cred);
-int security_prepare_creds(struct cred *new, const struct cred *old, gfp_t gfp);
-void security_transfer_creds(struct cred *new, const struct cred *old);
-int security_kernel_act_as(struct cred *new, u32 secid);
-int security_kernel_create_files_as(struct cred *new, struct inode *inode);
-int security_kernel_module_request(char *kmod_name);
-int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
-int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
-				   enum kernel_read_file_id id);
-int security_task_fix_setuid(struct cred *new, const struct cred *old,
-			     int flags);
-int security_task_setpgid(struct task_struct *p, pid_t pgid);
-int security_task_getpgid(struct task_struct *p);
-int security_task_getsid(struct task_struct *p);
-void security_task_getsecid(struct task_struct *p, u32 *secid);
-int security_task_setnice(struct task_struct *p, int nice);
-int security_task_setioprio(struct task_struct *p, int ioprio);
-int security_task_getioprio(struct task_struct *p);
-int security_task_prlimit(const struct cred *cred, const struct cred *tcred,
-			  unsigned int flags);
-int security_task_setrlimit(struct task_struct *p, unsigned int resource,
-		struct rlimit *new_rlim);
-int security_task_setscheduler(struct task_struct *p);
-int security_task_getscheduler(struct task_struct *p);
-int security_task_movememory(struct task_struct *p);
-int security_task_kill(struct task_struct *p, struct siginfo *info,
-			int sig, u32 secid);
-int security_task_prctl(int option, unsigned long arg2, unsigned long arg3,
-			unsigned long arg4, unsigned long arg5);
-void security_task_to_inode(struct task_struct *p, struct inode *inode);
-int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
-void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
-int security_msg_msg_alloc(struct msg_msg *msg);
-void security_msg_msg_free(struct msg_msg *msg);
-int security_msg_queue_alloc(struct msg_queue *msq);
-void security_msg_queue_free(struct msg_queue *msq);
-int security_msg_queue_associate(struct msg_queue *msq, int msqflg);
-int security_msg_queue_msgctl(struct msg_queue *msq, int cmd);
-int security_msg_queue_msgsnd(struct msg_queue *msq,
-			      struct msg_msg *msg, int msqflg);
-int security_msg_queue_msgrcv(struct msg_queue *msq, struct msg_msg *msg,
-			      struct task_struct *target, long type, int mode);
-int security_shm_alloc(struct shmid_kernel *shp);
-void security_shm_free(struct shmid_kernel *shp);
-int security_shm_associate(struct shmid_kernel *shp, int shmflg);
-int security_shm_shmctl(struct shmid_kernel *shp, int cmd);
-int security_shm_shmat(struct shmid_kernel *shp, char __user *shmaddr, int shmflg);
-int security_sem_alloc(struct sem_array *sma);
-void security_sem_free(struct sem_array *sma);
-int security_sem_associate(struct sem_array *sma, int semflg);
-int security_sem_semctl(struct sem_array *sma, int cmd);
-int security_sem_semop(struct sem_array *sma, struct sembuf *sops,
-			unsigned nsops, int alter);
-void security_d_instantiate(struct dentry *dentry, struct inode *inode);
-int security_getprocattr(struct task_struct *p, char *name, char **value);
-int security_setprocattr(const char *name, void *value, size_t size);
-int security_netlink_send(struct sock *sk, struct sk_buff *skb);
-int security_ismaclabel(const char *name);
-int security_secid_to_secctx(u32 secid, char **secdata, u32 *seclen);
-int security_secctx_to_secid(const char *secdata, u32 seclen, u32 *secid);
-void security_release_secctx(char *secdata, u32 seclen);
-
-void security_inode_invalidate_secctx(struct inode *inode);
-int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
-int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
-int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+#define INT_HOOK(_hook_name, ...) \
+	int security_ ## _hook_name(__VA_ARGS__)
+#define VOID_HOOK(_hook_name, ...) \
+	void security_ ## _hook_name(__VA_ARGS__)
+#define INT_HOOK_INT(...)
+#define INT_HOOK_EXT(...)	INT_HOOK(__VA_ARGS__)
+#define VOID_HOOK_INT(...)
+#define VOID_HOOK_EXT(...)	VOID_HOOK(__VA_ARGS__)
+#include <linux/lsm_hook_types.h>
+#undef INT_HOOK
+#undef VOID_HOOK
+#undef INT_HOOK_INT
+#undef INT_HOOK_EXT
+#undef VOID_HOOK_INT
+#undef VOID_HOOK_EXT
 #else /* CONFIG_SECURITY */
 struct security_mnt_opts {
 };
@@ -503,12 +334,6 @@ static inline int security_syslog(int type)
 	return 0;
 }
 
-static inline int security_settime64(const struct timespec64 *ts,
-				     const struct timezone *tz)
-{
-	return cap_settime(ts, tz);
-}
-
 static inline int security_settime(const struct timespec *ts,
 				   const struct timezone *tz)
 {
@@ -1185,52 +1010,7 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
 }
 #endif	/* CONFIG_SECURITY */
 
-#ifdef CONFIG_SECURITY_NETWORK
-
-int security_unix_stream_connect(struct sock *sock, struct sock *other, struct sock *newsk);
-int security_unix_may_send(struct socket *sock,  struct socket *other);
-int security_socket_create(int family, int type, int protocol, int kern);
-int security_socket_post_create(struct socket *sock, int family,
-				int type, int protocol, int kern);
-int security_socket_bind(struct socket *sock, struct sockaddr *address, int addrlen);
-int security_socket_connect(struct socket *sock, struct sockaddr *address, int addrlen);
-int security_socket_listen(struct socket *sock, int backlog);
-int security_socket_accept(struct socket *sock, struct socket *newsock);
-int security_socket_sendmsg(struct socket *sock, struct msghdr *msg, int size);
-int security_socket_recvmsg(struct socket *sock, struct msghdr *msg,
-			    int size, int flags);
-int security_socket_getsockname(struct socket *sock);
-int security_socket_getpeername(struct socket *sock);
-int security_socket_getsockopt(struct socket *sock, int level, int optname);
-int security_socket_setsockopt(struct socket *sock, int level, int optname);
-int security_socket_shutdown(struct socket *sock, int how);
-int security_sock_rcv_skb(struct sock *sk, struct sk_buff *skb);
-int security_socket_getpeersec_stream(struct socket *sock, char __user *optval,
-				      int __user *optlen, unsigned len);
-int security_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid);
-int security_sk_alloc(struct sock *sk, int family, gfp_t priority);
-void security_sk_free(struct sock *sk);
-void security_sk_clone(const struct sock *sk, struct sock *newsk);
-void security_sk_classify_flow(struct sock *sk, struct flowi *fl);
-void security_req_classify_flow(const struct request_sock *req, struct flowi *fl);
-void security_sock_graft(struct sock*sk, struct socket *parent);
-int security_inet_conn_request(struct sock *sk,
-			struct sk_buff *skb, struct request_sock *req);
-void security_inet_csk_clone(struct sock *newsk,
-			const struct request_sock *req);
-void security_inet_conn_established(struct sock *sk,
-			struct sk_buff *skb);
-int security_secmark_relabel_packet(u32 secid);
-void security_secmark_refcount_inc(void);
-void security_secmark_refcount_dec(void);
-int security_tun_dev_alloc_security(void **security);
-void security_tun_dev_free_security(void *security);
-int security_tun_dev_create(void);
-int security_tun_dev_attach_queue(void *security);
-int security_tun_dev_attach(struct sock *sk, void *security);
-int security_tun_dev_open(void *security);
-
-#else	/* CONFIG_SECURITY_NETWORK */
+#ifndef CONFIG_SECURITY_NETWORK
 static inline int security_unix_stream_connect(struct sock *sock,
 					       struct sock *other,
 					       struct sock *newsk)
@@ -1423,12 +1203,7 @@ static inline int security_tun_dev_open(void *security)
 }
 #endif	/* CONFIG_SECURITY_NETWORK */
 
-#ifdef CONFIG_SECURITY_INFINIBAND
-int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey);
-int security_ib_endport_manage_subnet(void *sec, const char *name, u8 port_num);
-int security_ib_alloc_security(void **sec);
-void security_ib_free_security(void *sec);
-#else	/* CONFIG_SECURITY_INFINIBAND */
+#ifndef CONFIG_SECURITY_INFINIBAND
 static inline int security_ib_pkey_access(void *sec, u64 subnet_prefix, u16 pkey)
 {
 	return 0;
@@ -1449,26 +1224,7 @@ static inline void security_ib_free_security(void *sec)
 }
 #endif	/* CONFIG_SECURITY_INFINIBAND */
 
-#ifdef CONFIG_SECURITY_NETWORK_XFRM
-
-int security_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
-			       struct xfrm_user_sec_ctx *sec_ctx, gfp_t gfp);
-int security_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx, struct xfrm_sec_ctx **new_ctxp);
-void security_xfrm_policy_free(struct xfrm_sec_ctx *ctx);
-int security_xfrm_policy_delete(struct xfrm_sec_ctx *ctx);
-int security_xfrm_state_alloc(struct xfrm_state *x, struct xfrm_user_sec_ctx *sec_ctx);
-int security_xfrm_state_alloc_acquire(struct xfrm_state *x,
-				      struct xfrm_sec_ctx *polsec, u32 secid);
-int security_xfrm_state_delete(struct xfrm_state *x);
-void security_xfrm_state_free(struct xfrm_state *x);
-int security_xfrm_policy_lookup(struct xfrm_sec_ctx *ctx, u32 fl_secid, u8 dir);
-int security_xfrm_state_pol_flow_match(struct xfrm_state *x,
-				       struct xfrm_policy *xp,
-				       const struct flowi *fl);
-int security_xfrm_decode_session(struct sk_buff *skb, u32 *secid);
-void security_skb_classify_flow(struct sk_buff *skb, struct flowi *fl);
-
-#else	/* CONFIG_SECURITY_NETWORK_XFRM */
+#ifndef CONFIG_SECURITY_NETWORK_XFRM
 
 static inline int security_xfrm_policy_alloc(struct xfrm_sec_ctx **ctxp,
 					     struct xfrm_user_sec_ctx *sec_ctx,
@@ -1534,24 +1290,7 @@ static inline void security_skb_classify_flow(struct sk_buff *skb, struct flowi
 
 #endif	/* CONFIG_SECURITY_NETWORK_XFRM */
 
-#ifdef CONFIG_SECURITY_PATH
-int security_path_unlink(const struct path *dir, struct dentry *dentry);
-int security_path_mkdir(const struct path *dir, struct dentry *dentry, umode_t mode);
-int security_path_rmdir(const struct path *dir, struct dentry *dentry);
-int security_path_mknod(const struct path *dir, struct dentry *dentry, umode_t mode,
-			unsigned int dev);
-int security_path_truncate(const struct path *path);
-int security_path_symlink(const struct path *dir, struct dentry *dentry,
-			  const char *old_name);
-int security_path_link(struct dentry *old_dentry, const struct path *new_dir,
-		       struct dentry *new_dentry);
-int security_path_rename(const struct path *old_dir, struct dentry *old_dentry,
-			 const struct path *new_dir, struct dentry *new_dentry,
-			 unsigned int flags);
-int security_path_chmod(const struct path *path, umode_t mode);
-int security_path_chown(const struct path *path, kuid_t uid, kgid_t gid);
-int security_path_chroot(const struct path *path);
-#else	/* CONFIG_SECURITY_PATH */
+#ifndef CONFIG_SECURITY_PATH
 static inline int security_path_unlink(const struct path *dir, struct dentry *dentry)
 {
 	return 0;
@@ -1617,17 +1356,8 @@ static inline int security_path_chroot(const struct path *path)
 }
 #endif	/* CONFIG_SECURITY_PATH */
 
+#ifndef CONFIG_SECURITY
 #ifdef CONFIG_KEYS
-#ifdef CONFIG_SECURITY
-
-int security_key_alloc(struct key *key, const struct cred *cred, unsigned long flags);
-void security_key_free(struct key *key);
-int security_key_permission(key_ref_t key_ref,
-			    const struct cred *cred, unsigned perm);
-int security_key_getsecurity(struct key *key, char **_buffer);
-
-#else
-
 static inline int security_key_alloc(struct key *key,
 				     const struct cred *cred,
 				     unsigned long flags)
@@ -1651,20 +1381,9 @@ static inline int security_key_getsecurity(struct key *key, char **_buffer)
 	*_buffer = NULL;
 	return 0;
 }
-
-#endif
 #endif /* CONFIG_KEYS */
 
 #ifdef CONFIG_AUDIT
-#ifdef CONFIG_SECURITY
-int security_audit_rule_init(u32 field, u32 op, char *rulestr, void **lsmrule);
-int security_audit_rule_known(struct audit_krule *krule);
-int security_audit_rule_match(u32 secid, u32 field, u32 op, void *lsmrule,
-			      struct audit_context *actx);
-void security_audit_rule_free(void *lsmrule);
-
-#else
-
 static inline int security_audit_rule_init(u32 field, u32 op, char *rulestr,
 					   void **lsmrule)
 {
@@ -1684,9 +1403,42 @@ static inline int security_audit_rule_match(u32 secid, u32 field, u32 op,
 
 static inline void security_audit_rule_free(void *lsmrule)
 { }
+#endif /* CONFIG_AUDIT */
+
+#ifdef CONFIG_BPF_SYSCALL
+static inline int security_bpf(int cmd, union bpf_attr *attr,
+					     unsigned int size)
+{
+	return 0;
+}
+
+static inline int security_bpf_map(struct bpf_map *map, fmode_t fmode)
+{
+	return 0;
+}
+
+static inline int security_bpf_prog(struct bpf_prog *prog)
+{
+	return 0;
+}
+
+static inline int security_bpf_map_alloc(struct bpf_map *map)
+{
+	return 0;
+}
+
+static inline void security_bpf_map_free(struct bpf_map *map)
+{ }
 
+static inline int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
+{
+	return 0;
+}
+
+static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
+{ }
+#endif /* CONFIG_BPF_SYSCALL */
 #endif /* CONFIG_SECURITY */
-#endif /* CONFIG_AUDIT */
 
 #ifdef CONFIG_SECURITYFS
 
@@ -1730,54 +1482,6 @@ static inline void securityfs_remove(struct dentry *dentry)
 
 #endif
 
-#ifdef CONFIG_BPF_SYSCALL
-union bpf_attr;
-struct bpf_map;
-struct bpf_prog;
-struct bpf_prog_aux;
-#ifdef CONFIG_SECURITY
-extern int security_bpf(int cmd, union bpf_attr *attr, unsigned int size);
-extern int security_bpf_map(struct bpf_map *map, fmode_t fmode);
-extern int security_bpf_prog(struct bpf_prog *prog);
-extern int security_bpf_map_alloc(struct bpf_map *map);
-extern void security_bpf_map_free(struct bpf_map *map);
-extern int security_bpf_prog_alloc(struct bpf_prog_aux *aux);
-extern void security_bpf_prog_free(struct bpf_prog_aux *aux);
-#else
-static inline int security_bpf(int cmd, union bpf_attr *attr,
-					     unsigned int size)
-{
-	return 0;
-}
-
-static inline int security_bpf_map(struct bpf_map *map, fmode_t fmode)
-{
-	return 0;
-}
-
-static inline int security_bpf_prog(struct bpf_prog *prog)
-{
-	return 0;
-}
-
-static inline int security_bpf_map_alloc(struct bpf_map *map)
-{
-	return 0;
-}
-
-static inline void security_bpf_map_free(struct bpf_map *map)
-{ }
-
-static inline int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
-{
-	return 0;
-}
-
-static inline void security_bpf_prog_free(struct bpf_prog_aux *aux)
-{ }
-#endif /* CONFIG_SECURITY */
-#endif /* CONFIG_BPF_SYSCALL */
-
 #ifdef CONFIG_SECURITY
 
 static inline char *alloc_secdata(void)
diff --git a/kernel/time/time.c b/kernel/time/time.c
index bd4e6c7dd689..e18e6e338639 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -90,7 +90,7 @@ SYSCALL_DEFINE1(stime, time_t __user *, tptr)
 
 	tv.tv_nsec = 0;
 
-	err = security_settime64(&tv, NULL);
+	err = security_settime(&tv, NULL);
 	if (err)
 		return err;
 
@@ -130,7 +130,7 @@ COMPAT_SYSCALL_DEFINE1(stime, compat_time_t __user *, tptr)
 
 	tv.tv_nsec = 0;
 
-	err = security_settime64(&tv, NULL);
+	err = security_settime(&tv, NULL);
 	if (err)
 		return err;
 
@@ -176,7 +176,7 @@ int do_sys_settimeofday64(const struct timespec64 *tv, const struct timezone *tz
 	if (tv && !timespec64_valid(tv))
 		return -EINVAL;
 
-	error = security_settime64(tv, tz);
+	error = security_settime(tv, tz);
 	if (error)
 		return error;
 
diff --git a/security/security.c b/security/security.c
index 3cafff61b049..04b0b8ce6c00 100644
--- a/security/security.c
+++ b/security/security.c
@@ -299,7 +299,7 @@ int security_syslog(int type)
 	return call_int_hook(syslog, 0, type);
 }
 
-int security_settime64(const struct timespec64 *ts, const struct timezone *tz)
+int security_settime(const struct timespec64 *ts, const struct timezone *tz)
 {
 	return call_int_hook(settime, 0, ts, tz);
 }
-- 
2.14.1
