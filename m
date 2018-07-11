Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B9EC3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179D820BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 179D820BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbeGKCNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:13:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45260 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732287AbeGKCNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:13:35 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fd4bR-00033m-19; Wed, 11 Jul 2018 02:11:37 +0000
Date:   Wed, 11 Jul 2018 03:11:37 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: linux-next: manual merge of the vfs tree with the overlayfs tree
Message-ID: <20180711021136.GN30522@ZenIV.linux.org.uk>
References: <20180710101736.32d6cc6c@canb.auug.org.au>
 <20180710150455.GK30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710150455.GK30522@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 04:04:55PM +0100, Al Viro wrote:
> First of all, I'm still not at all convinced that this "noaccount" thing is
> sane, especially since path_open() is exported.  But that aside, __get_empty_filp()
> needs to be shot, just for the name and calling conventions alone.
> 
> It gets a bullshit argument (bool account) *AND* does not get the argument it
> does need.  Note that the first thing get_empty_filp() (now __get...) does
> is
>         const struct cred *cred = current_cred();
> followed by
>         f->f_cred = get_cred(cred);
> 
> Now look at path_open().  What happens to the cred argument it gets?  It goes
> to do_dentry_open(), where it gets passed to security_file_open() and not
> used by anything else.  In security_file_open() we have it passed to
> 	ret = call_int_hook(file_open, 0, file, cred);
> and there are three instances of ->file_open() - apparmor, selinux and tomoyo.
> The last one ignores cred entirely; the other two do checks based on it,
> but *all* of them leave file->f_cred as it was.
> 
> This is not a new crap.  It had been inherited from dentry_open(), which got it
> from "CRED: Pass credentials through dentry_open()" back in 2008.  Note that
> 	* among the callers of dentry_open() (20) and vfs_open() (2 more)
> only these
> fs/cachefiles/rdwr.c:913:       file = dentry_open(&path, O_RDWR | O_LARGEFILE, cache->cache_cred);
> security/apparmor/file.c:695:   devnull = dentry_open(&aa_null, O_RDWR, cred);
> security/selinux/hooks.c:2628:  devnull = dentry_open(&selinux_null, O_RDWR, cred);
> get cred != current_cred().  Which helps masking the issue, but makes the
> decision to add that argument (instead of a separate helper) rather dubious.
> 	* overlayfs itself appears to *have* run into the problem, judging
> by
>         old_cred = ovl_override_creds(inode->i_sb);
>         realfile = path_open(&file->f_path, file->f_flags | O_NOATIME,
>                              realinode, current_cred(), false);
>         revert_creds(old_cred);
> in there.
> 
> Folks, if you have to go to that kind of contortions, why not do it right?
> 	* add static __alloc_file(cred), which would get cred pointer (and not
> use current_cred() internally), allocated a file (without bothering with
> nr_files) and returned it
> 	* have alloc_empty_file(cred) that would do the song and dance
> with nr_files (and used __alloc_file() internally).
> 	* use that as a replacement for get_empty_filp() - path_openat() would
> *probably* use current_cred() for argument, alloc_file() definitely would and
> dentry_open() would pass its cred argument.
> 	* in internal.h, static inline alloc_empty_file_noaccount(cred) would
> use __alloc_file() and set FMODE_NOACCOUNT in case of success.
> 	* do_dentry_open() loses the fucking cred argument - it should be in
> file->f_cred.
> 	* vfs_open() goes away - in your branch it's absolutely pointless.
> 	* path_open() loses its 'account' argument - it's always false.
> Uses alloc_empty_file_noaccount() to allocate the sucker.  And for fsck
> sake, pass it the creds you want to use rather than playing that kind of
> games with override/revert.

FWIW, see vfs.git#work.open2 for part of that program.  I have not pulled
the overlayfs stuff in, but doing the rest based at circa e9cf4c40af4c
("fold put_filp() into fput()") is trivial.  Remains to be done out of the
above:
 	* add static __alloc_file(cred), which would be basically
alloc_empty_file() sans nr_files-related parts.  Make alloc_empty_file()
call it for actual allocation.
 	* in internal.h, static inline alloc_empty_file_noaccount(cred) would
use __alloc_file() and set FMODE_NOACCOUNT in case of success.
	* path_open() loses its 'account' argument - it's always false.
Uses alloc_empty_file_noaccount() to allocate the sucker.  And for fsck
sake, pass it the creds you want to use rather than playing that kind of
games with override/revert.
	* (after the overlayfs changes to vfs_open()) vfs_open() goes away,
expanded into callers.

Stuff currently in work.open2:

Preparatory fixes (this cycle fodder):
      drm_mode_create_lease_ioctl(): fix open-coded filp_clone_open()
      cxl_getfile(): fix double-iput() on alloc_file() failures
      ocxlflash_getfile(): fix double-iput() on alloc_file() failures
More preparatory massage:
      make get_empty_filp() to call file_free_rcu() directly
      fold security_file_free() into file_free()
      turn filp_clone_open() into inline wrapper for dentry_open()
      create_pipe_files(): use fput() if allocation of the second file fails
      make sure do_dentry_open() won't return positive as an error
Providing the right ->f_cred:
      pass creds to get_empty_filp(), make sure dentry_open() passes the right creds
      get rid of cred argument of vfs_open() and do_dentry_open()
      security_file_open(): lose cred argument
      ->file_open(): lose cred argument
Mirror the "do we need fput() or do we need put_filp()" in ->f_mode:
      introduce FMODE_OPENED
      fold put_filp() into fput()
At that point we can start simplifying open-related paths, now that
cleanups are a lot more uniform:
      lift fput() on late failures into path_openat()
      now we can fold open_check_o_direct() into do_dentry_open()
      switch all remaining checks for FILE_OPENED to FMODE_OPENED
Half of the reasons for ->atomic_open() 'opened' argument is gone, let's deal with
the rest:
      introduce FMODE_CREATED and switch to it
      IMA: don't propagate opened through the entire thing
      getting rid of 'opened' argument of ->atomic_open() - step 1
      getting rid of 'opened' argument of ->atomic_open() - part 2
      get rid of 'opened' argument of ->atomic_open() - part 3
      get rid of 'opened' in path_openat() and the helpers downstream
      ->atomic_open(): return 0 in all success cases
      document ->atomic_open() changes
      switch atomic_open() and lookup_open() to returning 0 in all success cases
      kill FILE_{CREATED,OPENED}
At that point we've got _much_ simpler ->atomic_open() calling conventions as well
as the code using it.  Next part - alloc_file() calling conventions:
      new wrapper: alloc_file_pseudo()
      __shmem_file_setup(): reorder allocations
      ... and switch shmem_file_setup() to alloc_file_pseudo()
      cxl_getfile(): switch to alloc_file_pseudo()
      ocxlflash_getfile(): switch to alloc_file_pseudo()
      hugetlb_file_setup(): switch to alloc_file_pseudo()
      anon_inode_getfile(): switch to alloc_file_pseudo()
      create_pipe_files(): switch the first allocation to alloc_file_pseudo()
      new helper: alloc_file_clone()
      do_shmat(): grab shp->shm_file earlier, switch to alloc_file_clone()
      make alloc_file() static
      document alloc_file() changes
And cleanups in pathname-resolving loops from better calling conventions
for path_init()/link_path_walk():
      make path_init() unconditionally paired with terminate_walk()
      allow link_path_walk() to take ERR_PTR()
      few more cleanups of link_path_walk() callers

IMO the diffstat is not too bad -

 Documentation/filesystems/Locking     |   2 +-
 Documentation/filesystems/porting     |  20 +++
 Documentation/filesystems/vfs.txt     |  18 +--
 drivers/gpu/drm/drm_lease.c           |  16 +--
 drivers/misc/cxl/api.c                |  21 +---
 drivers/scsi/cxlflash/ocxl_hw.c       |  24 +---
 fs/9p/vfs_inode.c                     |   7 +-
 fs/9p/vfs_inode_dotl.c                |   7 +-
 fs/aio.c                              |  26 +---
 fs/anon_inodes.c                      |  29 +----
 fs/bad_inode.c                        |   2 +-
 fs/binfmt_misc.c                      |   2 +-
 fs/ceph/file.c                        |   7 +-
 fs/ceph/super.h                       |   3 +-
 fs/cifs/cifsfs.h                      |   3 +-
 fs/cifs/dir.c                         |   7 +-
 fs/file_table.c                       |  71 +++++++----
 fs/fuse/dir.c                         |  10 +-
 fs/gfs2/inode.c                       |  32 +++--
 fs/hugetlbfs/inode.c                  |  55 +++------
 fs/internal.h                         |   6 +-
 fs/namei.c                            | 223 +++++++++++++---------------------
 fs/nfs/dir.c                          |  14 ++-
 fs/nfs/nfs4_fs.h                      |   2 +-
 fs/nfs/nfs4proc.c                     |   2 +-
 fs/nfsd/vfs.c                         |   2 +-
 fs/open.c                             |  86 ++++---------
 fs/pipe.c                             |  38 ++----
 include/linux/file.h                  |   8 +-
 include/linux/fs.h                    |  16 +--
 include/linux/ima.h                   |   4 +-
 include/linux/lsm_hooks.h             |   2 +-
 include/linux/security.h              |   5 +-
 ipc/shm.c                             |  39 +++---
 mm/shmem.c                            |  50 ++------
 net/socket.c                          |  27 +---
 security/apparmor/lsm.c               |   4 +-
 security/integrity/ima/ima.h          |   4 +-
 security/integrity/ima/ima_appraise.c |   4 +-
 security/integrity/ima/ima_main.c     |  16 +--
 security/security.c                   |   4 +-
 security/selinux/hooks.c              |   4 +-
 security/smack/smack_lsm.c            |   6 +-
 security/tomoyo/tomoyo.c              |   2 +-
 44 files changed, 360 insertions(+), 570 deletions(-)
