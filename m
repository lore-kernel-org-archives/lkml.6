Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C4CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C6E2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 08:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfBTIH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:07:27 -0500
Received: from lilium.sigma-star.at ([109.75.188.150]:51786 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfBTIH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 03:07:27 -0500
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Feb 2019 03:07:24 EST
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 72AB31802C9AE;
        Wed, 20 Feb 2019 09:01:30 +0100 (CET)
From:   Richard Weinberger <richard@sigma-star.at>
To:     yuyufen <yuyufen@huawei.com>, dwmw2@infradead.org
Cc:     richard.weinberger@gmail.com, linux-mtd@lists.infradead.org,
        Joakim.Tjernlund@infinera.com, houtao1@huawei.com,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] jffs2: safely remove obsolete dirent from the f->dents list
Date:   Wed, 20 Feb 2019 09:01:24 +0100
Message-ID: <8000531.srAqeQn4W0@blindfold>
In-Reply-To: <d2697496-c7db-94a1-4292-03625b47cf63@huawei.com>
References: <20190123072249.103847-1-yuyufen@huawei.com> <d2697496-c7db-94a1-4292-03625b47cf63@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 16. Februar 2019, 09:53:35 CET schrieb yuyufen:
> ping?

Sorry for the delay.

I didn't forget (completely) about this one.
The thing is, I don't really maintain jffs2 but I will collect and test patches
for the upcoming merge window and carry them via my ubifs tree. 

David, I hope I have by end of the week a list with potential patches ready
such that you can have a final look and veto what you don't like. :-)

Thanks,
//richard
> 
> On 2019/1/23 15:22, Yufen Yu wrote:
> > We may delete a bunch of directory entries, operating such as:
> > getdents(), unlink(), getdents()..., until the end of the directory.
> > jffs2 handles f_pos on the directory merely as the position on the
> > f->dents list. So, the next getdents() may skip some entries
> > before f_pos, if we remove some entries from the list between two
> > getdents(), resulting in some entries of the directory cannot be deleted.
> >
> > Commit 15953580e79b is introduced to resolve this bug by not
> > removing delete entries from the list immediately.
> >
> > However, when CONFIG_JFFS2_SUMMARY is not set, it can cause the
> > following issues:
> >
> > * 'deletion' dirents is always in the f->dents list, wasting memory
> >      resource. For example:
> >          There is a file named 'file1'. Then we rename it:
> >          mv file1 file2;
> >          mv file2 file3;
> >          ...
> >          mv file99999 file1000000
> >
> >      All of file1~file1000000 dirents always in the f->dents list.
> >
> > * Though, the list we're traversing is already ordered by CRC,
> > it could waste much CPU time when the list is very long.
> >
> > To fix, we define two variables in struct jffs2_inode_info: nr_dir_opening,
> > obsolete_count, and two new functions: jffs2_dir_open(), jffs2_dir_release().
> >
> > When open a directory, jffs2_dir_open() will increase nr_dir_opening,
> > which will be decreased by jffs2_dir_release(). if the value is 0,
> > it means nobody open the dir and nobody in getdents()/seek() semantics.
> > Thus, we can remove all obsolete dirent from the list.
> >
> > When delete a file, jffs2_do_unlink() can remove the dirent directly if
> > nobody open the directory(i.e. nr_dir_opending == 0). Otherwise, it just
> > increase obsolete_count, denoting obsolete dirent count of the list.
> >
> > Fixes: 15953580e79b ("[JFFS2] Improve getdents vs. f_pos handling on NOR flash.")
> > Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> > ---
> >   fs/jffs2/dir.c             | 49 ++++++++++++++++++++++++++++++++++++++++++++++
> >   fs/jffs2/jffs2_fs_i.h      |  7 +++++++
> >   fs/jffs2/super.c           |  4 ++++
> >   fs/jffs2/write.c           | 30 +++++++++++++++++++---------
> >   include/uapi/linux/jffs2.h |  4 ++++
> >   5 files changed, 85 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
> > index f20cff1194bb..aed872dcd0ca 100644
> > --- a/fs/jffs2/dir.c
> > +++ b/fs/jffs2/dir.c
> > @@ -37,6 +37,8 @@ static int jffs2_mknod (struct inode *,struct dentry *,umode_t,dev_t);
> >   static int jffs2_rename (struct inode *, struct dentry *,
> >   			 struct inode *, struct dentry *,
> >   			 unsigned int);
> > +static int jffs2_dir_release (struct inode *, struct file *);
> > +static int jffs2_dir_open (struct inode *, struct file *);
> >   
> >   const struct file_operations jffs2_dir_operations =
> >   {
> > @@ -45,6 +47,8 @@ const struct file_operations jffs2_dir_operations =
> >   	.unlocked_ioctl=jffs2_ioctl,
> >   	.fsync =	jffs2_fsync,
> >   	.llseek =	generic_file_llseek,
> > +	.open =		jffs2_dir_open,
> > +	.release =	jffs2_dir_release,
> >   };
> >   
> >   
> > @@ -865,3 +869,48 @@ static int jffs2_rename (struct inode *old_dir_i, struct dentry *old_dentry,
> >   	return 0;
> >   }
> >   
> > +static int jffs2_dir_open(struct inode *dir_i, struct file *filp)
> > +{
> > +#ifndef CONFIG_JFFS2_SUMMARY
> > +	struct jffs2_inode_info *dir_f = JFFS2_INODE_INFO(dir_i);
> > +	atomic_inc(&dir_f->nr_dir_opening);
> > +#endif
> > +
> > +	return 0;
> > +}
> > +
> > +static int jffs2_dir_release(struct inode *dir_i, struct file *filp)
> > +{
> > +#ifndef CONFIG_JFFS2_SUMMARY
> > +	struct jffs2_inode_info *dir_f = JFFS2_INODE_INFO(dir_i);
> > +
> > +	BUG_ON(atomic_read(&dir_f->nr_dir_opening) <= 0);
> > +
> > +	mutex_lock(&dir_f->sem);
> > +	/* jffs2_dir_open may increase nr_dir_opening after
> > +	 * atomic_dec_and_test() returning true.
> > +	 * However, it cannot traverse the list until hold
> > +	 * mutex dir_f->sem lock, so that we can go on
> > +	 * removing.*/
> > +	if (atomic_dec_and_test(&dir_f->nr_dir_opening) &&
> > +			dir_f->obsolete_count > JFFS2_OBS_DIRENT_LIMIT) {
> > +		struct jffs2_full_dirent **prev = &dir_f->dents;
> > +
> > +		/* remove all obsolete dirent from the list, which
> > +		 * can save memory space and reduce CPU time for
> > +		 * traverse the list */
> > +		while(*prev) {
> > +			if ((*prev)->raw == NULL && (*prev)->ino == 0) {
> > +				struct jffs2_full_dirent *this = *prev;
> > +				*prev = this->next;
> > +				jffs2_free_full_dirent(this);
> > +			} else
> > +				prev = &((*prev)->next);
> > +		}
> > +		dir_f->obsolete_count = 0;
> > +	}
> > +	mutex_unlock(&dir_f->sem);
> > +#endif
> > +
> > +	return 0;
> > +}
> > diff --git a/fs/jffs2/jffs2_fs_i.h b/fs/jffs2/jffs2_fs_i.h
> > index 2e4a86763c07..a4da25d16cb4 100644
> > --- a/fs/jffs2/jffs2_fs_i.h
> > +++ b/fs/jffs2/jffs2_fs_i.h
> > @@ -50,6 +50,13 @@ struct jffs2_inode_info {
> >   
> >   	uint16_t flags;
> >   	uint8_t usercompr;
> > +
> > +	/* obsolete dirent count in the list of 'dents' */
> > +	uint8_t  obsolete_count;
> > +
> > +	/* Directory open refcount */
> > +	atomic_t nr_dir_opening;
> > +
> >   	struct inode vfs_inode;
> >   };
> >   
> > diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
> > index 87bdf0f4cba1..bf181b0ade9c 100644
> > --- a/fs/jffs2/super.c
> > +++ b/fs/jffs2/super.c
> > @@ -41,6 +41,10 @@ static struct inode *jffs2_alloc_inode(struct super_block *sb)
> >   	f = kmem_cache_alloc(jffs2_inode_cachep, GFP_KERNEL);
> >   	if (!f)
> >   		return NULL;
> > +
> > +	atomic_set(&f->nr_dir_opening, 0);
> > +	f->obsolete_count = 0;
> > +
> >   	return &f->vfs_inode;
> >   }
> >   
> > diff --git a/fs/jffs2/write.c b/fs/jffs2/write.c
> > index cda9a361368e..780b4fd9af51 100644
> > --- a/fs/jffs2/write.c
> > +++ b/fs/jffs2/write.c
> > @@ -600,29 +600,41 @@ int jffs2_do_unlink(struct jffs2_sb_info *c, struct jffs2_inode_info *dir_f,
> >   	} else {
> >   		uint32_t nhash = full_name_hash(NULL, name, namelen);
> >   
> > -		fd = dir_f->dents;
> > +		struct jffs2_full_dirent **prev = &dir_f->dents;
> > +
> >   		/* We don't actually want to reserve any space, but we do
> >   		   want to be holding the alloc_sem when we write to flash */
> >   		mutex_lock(&c->alloc_sem);
> >   		mutex_lock(&dir_f->sem);
> >   
> > -		for (fd = dir_f->dents; fd; fd = fd->next) {
> > -			if (fd->nhash == nhash &&
> > -			    !memcmp(fd->name, name, namelen) &&
> > -			    !fd->name[namelen]) {
> > +		while((*prev) && (*prev)->nhash <= nhash) {
> > +			if ((*prev)->nhash == nhash &&
> > +			    !memcmp((*prev)->name, name, namelen) &&
> > +			    !(*prev)->name[namelen]) {
> >   
> > +				fd = *prev;
> >   				jffs2_dbg(1, "Marking old dirent node (ino #%u) @%08x obsolete\n",
> >   					  fd->ino, ref_offset(fd->raw));
> >   				jffs2_mark_node_obsolete(c, fd->raw);
> > -				/* We don't want to remove it from the list immediately,
> > -				   because that screws up getdents()/seek() semantics even
> > -				   more than they're screwed already. Turn it into a
> > -				   node-less deletion dirent instead -- a placeholder */
> >   				fd->raw = NULL;
> >   				fd->ino = 0;
> > +
> > +				/* if nr_dir_openning is 0, we think nobody open the dir, and
> > +				 * nobody being in getdents()/seek() semantics. Thus, we can
> > +				 * safely remove this obsolete dirent from the list. Otherwise,
> > +				 * we just increase obsolete_count, and finally delete it in
> > +				 * jffs2_dir_release() */
> > +				if (atomic_read(&dir_f->nr_dir_opening) == 0) {
> > +					*prev = fd->next;
> > +					jffs2_free_full_dirent(fd);
> > +				} else
> > +					dir_f->obsolete_count++;
> > +
> >   				break;
> >   			}
> > +			prev = &((*prev)->next);
> >   		}
> > +
> >   		mutex_unlock(&dir_f->sem);
> >   	}
> >   
> > diff --git a/include/uapi/linux/jffs2.h b/include/uapi/linux/jffs2.h
> > index a18b719f49d4..dff3ac2d6b0c 100644
> > --- a/include/uapi/linux/jffs2.h
> > +++ b/include/uapi/linux/jffs2.h
> > @@ -35,6 +35,10 @@
> >   */
> >   #define JFFS2_MAX_NAME_LEN 254
> >   
> > +/* The obsolete dirent of dents list limit. When the number over
> > + * this limit, we can remove the obsoleted dents. */
> > +#define JFFS2_OBS_DIRENT_LIMIT 64
> > +
> >   /* How small can we sensibly write nodes? */
> >   #define JFFS2_MIN_DATA_LEN 128
> >   
> 
> 
> 


-- 
sigma star gmbh - Eduard-Bodem-Gasse 6 - 6020 Innsbruck - Austria
ATU66964118 - FN 374287y


