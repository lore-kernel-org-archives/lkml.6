Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeDJQSq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:18:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:36791 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbeDJQSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:18:45 -0400
Date: Tue, 10 Apr 2018 09:05:21 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Eric Biggers <ebiggers3@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ipc/shm: fix use-after-free of shm file via
 remap_file_pages()
Message-ID: <20180410160521.ybi6g2r7b43eb2di@linux-n805>
Mail-Followup-To: Eric Biggers <ebiggers3@gmail.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        syzkaller-bugs@googlegroups.com
References: <94eb2c06f65e5e2467055d036889@google.com>
 <20180409043039.28915-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180409043039.28915-1-ebiggers3@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Apr 2018, Eric Biggers wrote:
>@@ -480,6 +487,7 @@ static int shm_release(struct inode *ino, struct file *file)
> 	struct shm_file_data *sfd = shm_file_data(file);
>
> 	put_ipc_ns(sfd->ns);
>+	fput(sfd->file);
> 	shm_file_data(file) = NULL;
> 	kfree(sfd);
> 	return 0;
>@@ -1432,7 +1440,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
> 	file->f_mapping = shp->shm_file->f_mapping;
> 	sfd->id = shp->shm_perm.id;
> 	sfd->ns = get_ipc_ns(ns);
>-	sfd->file = shp->shm_file;
>+	sfd->file = get_file(shp->shm_file);
> 	sfd->vm_ops = NULL;

This probably merits a comment as it is adhoc to remap_file_pages(),
but otherwise:

Acked-by: Davidlohr Bueso <dbueso@suse.de>
