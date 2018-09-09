Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A8CC4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 11:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A0F20857
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 11:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A0F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeIIQBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 12:01:46 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50144 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbeIIQBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 12:01:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gerddie)
        with ESMTPSA id 9B47A264D43
Message-ID: <1536491489.4810.22.camel@collabora.com>
Subject: Re: [PATCH v7] Add udmabuf misc device
From:   Gert Wollny <gert.wollny@collabora.com>
To:     linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Sun, 09 Sep 2018 13:11:29 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am by no means a kernel expert, but Tomeu asked whether I could
review this. Generally the patch looks okay, it applied (on top of
4.18.5-gentoo), and compiled without problems. 

However, running the experimental qemu branch I get a kernel bug:

BUG: unable to handle kernel NULL pointer dereference at
0000000000000038
[12100.605908] PGD 0 P4D 0 
[12100.605918] Oops: 0002 [#1] SMP NOPTI
[12100.605926] CPU: 5 PID: 7247 Comm: qemu-system-x86 Not tainted
4.18.5-gentoo #1
[12100.605930] Hardware name: To be filled by O.E.M. To be filled by
O.E.M./M5A97 R2.0, BIOS 1302 11/14/2012
[12100.605942] RIP: 0010:fput+0x5/0x80
[12100.605945] Code: e4 ff 48 8b 3d b4 23 10 01 48 8b 34 24 48 83 c4 08
e9 6f 6c fd ff 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
00 <f0> 48 ff 4f 38 75 51 53 48 89 fb 65 8b 05 e9 fe 9c 5f 65 48 8b 3c 
[12100.606003] RSP: 0018:ffffbf00c94ffd90 EFLAGS: 00010246
[12100.606007] RAX: 0000000000000000 RBX: fffffffffffffff8 RCX:
ffff98336e000b00
[12100.606011] RDX: 0000000000000000 RSI: 0000000000004000 RDI:
0000000000000000
[12100.606014] RBP: 0000000000000000 R08: ffff983366504bc0 R09:
00000000ffffffff
[12100.606018] R10: 0000000000000000 R11: 0000000000000000 R12:
ffffffffffffffea
[12100.606021] R13: 0000000000000000 R14: ffff983100c5ca20 R15:
0000000000000000
[12100.606026] FS:  00007fe49ea8fbc0(0000) GS:ffff98338ed40000(0000)
knlGS:0000000000000000
[12100.606029] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[12100.606032] CR2: 0000000000000038 CR3: 00000003df65e000 CR4:
00000000000406e0
[12100.606036] Call Trace:
[12100.606046]  udmabuf_create+0x220/0x310
[12100.606057]  udmabuf_ioctl+0xf3/0x120
[12100.606064]  do_vfs_ioctl+0xb0/0x630
[12100.606071]  ? handle_mm_fault+0x108/0x200
[12100.606077]  ksys_ioctl+0x92/0xa0
[12100.606082]  __x64_sys_ioctl+0x16/0x20
[12100.606089]  do_syscall_64+0x4f/0xe0
[12100.606096]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[12100.606103] RIP: 0033:0x7fe4974b43b7

The offending code is in the error exit (0x220 = 544): 

   0xffffffff816085db <+539>:	callq  0xffffffff81240350 <fput>
   0xffffffff816085e0 <+544>:	mov    0x8(%r14),%rdi
   0xffffffff816085e4 <+548>:	callq  0xffffffff81217ad0 <kfree>
   0xffffffff816085e9 <+553>:	mov    %r14,%rdi
   0xffffffff816085ec <+556>:	callq  0xffffffff81217ad0 <kfree>
   0xffffffff816085f1 <+561>:	mov    0x50(%rsp),%rbx
   0xffffffff816085f6 <+566>:	xor    %gs:0x28,%rbx
   0xffffffff816085ff <+575>:	mov    %r12,%rax
   0xffffffff81608602 <+578>:	jne    0xffffffff816086c8
<udmabuf_create+776>

err_free_ubuf:
	fput(memfd);
	kfree(ubuf->pages);
	kfree(ubuf);
	return ret;

further commenst see below. 

+
> +static long udmabuf_create(struct udmabuf_create_list *head,
> +			   struct udmabuf_create_item *list)
> +{
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +	struct file *memfd = NULL;
> +	struct udmabuf *ubuf;
> +	struct dma_buf *buf;
> +	pgoff_t pgoff, pgcnt, pgidx, pgbuf;
> +	struct page *page;
> +	int seals, ret = -EINVAL;
> +	u32 i, flags;
> +
> +	ubuf = kzalloc(sizeof(struct udmabuf), GFP_KERNEL);
> +	if (!ubuf)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < head->count; i++) {
> +		if (!IS_ALIGNED(list[i].offset, PAGE_SIZE))
> +			goto err_free_ubuf;
> +		if (!IS_ALIGNED(list[i].size, PAGE_SIZE))
> +			goto err_free_ubuf;
> +		ubuf->pagecount += list[i].size >> PAGE_SHIFT;
> +	}
> +	ubuf->pages = kmalloc_array(ubuf->pagecount, sizeof(struct
> page *),
> +				    GFP_KERNEL);
> +	if (!ubuf->pages) {
> +		ret = -ENOMEM;
> +		goto err_free_ubuf;
> +	}
> +
> +	pgbuf = 0;
> +	for (i = 0; i < head->count; i++) {
> +		memfd = fget(list[i].memfd);
> +		if (!memfd)
> +			goto err_put_pages;
> +		if (!shmem_mapping(file_inode(memfd)->i_mapping))
> +			goto err_put_pages;
> +		seals = memfd_fcntl(memfd, F_GET_SEALS, 0);
> +		if (seals == -EINVAL ||
> +		    (seals & SEALS_WANTED) != SEALS_WANTED ||
> +		    (seals & SEALS_DENIED) != 0)
> +			goto err_put_pages;
> +		pgoff = list[i].offset >> PAGE_SHIFT;
> +		pgcnt = list[i].size   >> PAGE_SHIFT;
> +		for (pgidx = 0; pgidx < pgcnt; pgidx++) {
> +			page = shmem_read_mapping_page(
> +				file_inode(memfd)->i_mapping, pgoff
> + pgidx);
> +			if (IS_ERR(page)) {
> +				ret = PTR_ERR(page);
> +				goto err_put_pages;
> +			}
> +			ubuf->pages[pgbuf++] = page;
> +		}
> +		fput(memfd);
> +	}
> +	memfd = NULL;
Now memfd is NULL 

> +
> +	exp_info.ops  = &udmabuf_ops;
> +	exp_info.size = ubuf->pagecount << PAGE_SHIFT;
> +	exp_info.priv = ubuf;
> +
> +	buf = dma_buf_export(&exp_info);
> +	if (IS_ERR(buf)) {
> +		ret = PTR_ERR(buf);
> +		goto err_put_pages;
Assume an error occured 

> +	}
> +
> +	flags = 0;
> +	if (head->flags & UDMABUF_FLAGS_CLOEXEC)
> +		flags |= O_CLOEXEC;
> +	return dma_buf_fd(buf, flags);
> +
> +err_put_pages:
> +	while (pgbuf > 0)
> +		put_page(ubuf->pages[--pgbuf]);
> +err_free_ubuf:
> +	fput(memfd);
Now fput it called with NULL, and in fput this is used in 

0xffffffff81240350 <+0>:	callq  0xffffffff81a015c0 <__fentry__>
0xffffffff81240355 <+5>:	lock decq 0x38(%rdi)

where the bug is signalled, so I guess fput doesn't accept a null
pointer. 

I'm not sure why you set memfd to NULL at all, because on the following
non-error path it is not used.

The other question is of course, why did dma_buf_export fail for me ...

Best, 
Gert  

PS: Please CC me since I'm not on lkml, 

> +	kfree(ubuf->pages);
> +	kfree(ubuf);
> +	return ret;
> +}
> +
> +static long udmabuf_ioctl_create(struct file *filp, unsigned long
> arg)
> +{
> +	struct udmabuf_create create;
> +	struct udmabuf_create_list head;
> +	struct udmabuf_create_item list;
> +
> +	if (copy_from_user(&create, (void __user *)arg,
> +			   sizeof(struct udmabuf_create)))
> +		return -EFAULT;
> +
> +	head.flags  = create.flags;
> +	head.count  = 1;
> +	list.memfd  = create.memfd;
> +	list.offset = create.offset;
> +	list.size   = create.size;
> +
> +	return udmabuf_create(&head, &list);
> +}
> +
> +static long udmabuf_ioctl_create_list(struct file *filp, unsigned
> long arg)
> +{
> +	struct udmabuf_create_list head;
> +	struct udmabuf_create_item *list;
> +	int ret = -EINVAL;
> +	u32 lsize;
> +
> +	if (copy_from_user(&head, (void __user *)arg, sizeof(head)))
> +		return -EFAULT;
> +	if (head.count > 1024)
> +		return -EINVAL;
> +	lsize = sizeof(struct udmabuf_create_item) * head.count;
> +	list = memdup_user((void __user *)(arg + sizeof(head)),
> lsize);
> +	if (IS_ERR(list))
> +		return PTR_ERR(list);
> +
> +	ret = udmabuf_create(&head, list);
> +	kfree(list);
> +	return ret;
> +}
> +
> +static long udmabuf_ioctl(struct file *filp, unsigned int ioctl,
> +			  unsigned long arg)
> +{
> +	long ret;
> +
> +	switch (ioctl) {
> +	case UDMABUF_CREATE:
> +		ret = udmabuf_ioctl_create(filp, arg);
> +		break;
> +	case UDMABUF_CREATE_LIST:
> +		ret = udmabuf_ioctl_create_list(filp, arg);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static const struct file_operations udmabuf_fops = {
> +	.owner		= THIS_MODULE,
> +	.unlocked_ioctl = udmabuf_ioctl,
> +};
> +
> +static struct miscdevice udmabuf_misc = {
> +	.minor          = MISC_DYNAMIC_MINOR,
> +	.name           = "udmabuf",
> +	.fops           = &udmabuf_fops,
> +};
> +
> +static int __init udmabuf_dev_init(void)
> +{
> +	return misc_register(&udmabuf_misc);
> +}
> +
> +static void __exit udmabuf_dev_exit(void)
> +{
> +	misc_deregister(&udmabuf_misc);
> +}
> +
> +module_init(udmabuf_dev_init)
> +module_exit(udmabuf_dev_exit)
> +
> +MODULE_AUTHOR("Gerd Hoffmann <kraxel@redhat.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> new file mode 100644
> index 0000000000..376b1d6730
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <malloc.h>
> +
> +#include <sys/ioctl.h>
> +#include <sys/syscall.h>
> +#include <linux/memfd.h>
> +#include <linux/udmabuf.h>
> +
> +#define TEST_PREFIX	"drivers/dma-buf/udmabuf"
> +#define NUM_PAGES       4
> +
> +static int memfd_create(const char *name, unsigned int flags)
> +{
> +	return syscall(__NR_memfd_create, name, flags);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct udmabuf_create create;
> +	int devfd, memfd, buf, ret;
> +	off_t size;
> +	void *mem;
> +
> +	devfd = open("/dev/udmabuf", O_RDWR);
> +	if (devfd < 0) {
> +		printf("%s: [skip,no-udmabuf]\n", TEST_PREFIX);
> +		exit(77);
> +	}
> +
> +	memfd = memfd_create("udmabuf-test", MFD_CLOEXEC);
> +	if (memfd < 0) {
> +		printf("%s: [skip,no-memfd]\n", TEST_PREFIX);
> +		exit(77);
> +	}
> +
> +	size = getpagesize() * NUM_PAGES;
> +	ret = ftruncate(memfd, size);
> +	if (ret == -1) {
> +		printf("%s: [FAIL,memfd-truncate]\n", TEST_PREFIX);
> +		exit(1);
> +	}
> +
> +	memset(&create, 0, sizeof(create));
> +
> +	/* should fail (offset not page aligned) */
> +	create.memfd  = memfd;
> +	create.offset = getpagesize()/2;
> +	create.size   = getpagesize();
> +	buf = ioctl(devfd, UDMABUF_CREATE, &create);
> +	if (buf >= 0) {
> +		printf("%s: [FAIL,test-1]\n", TEST_PREFIX);
> +		exit(1);
> +	}
> +
> +	/* should fail (size not multiple of page) */
> +	create.memfd  = memfd;
> +	create.offset = 0;
> +	create.size   = getpagesize()/2;
> +	buf = ioctl(devfd, UDMABUF_CREATE, &create);
> +	if (buf >= 0) {
> +		printf("%s: [FAIL,test-2]\n", TEST_PREFIX);
> +		exit(1);
> +	}
> +
> +	/* should fail (not memfd) */
> +	create.memfd  = 0; /* stdin */
> +	create.offset = 0;
> +	create.size   = size;
> +	buf = ioctl(devfd, UDMABUF_CREATE, &create);
> +	if (buf >= 0) {
> +		printf("%s: [FAIL,test-3]\n", TEST_PREFIX);
> +		exit(1);
> +	}
> +
> +	/* should work */
> +	create.memfd  = memfd;
> +	create.offset = 0;
> +	create.size   = size;
> +	buf = ioctl(devfd, UDMABUF_CREATE, &create);
> +	if (buf < 0) {
> +		printf("%s: [FAIL,test-4]\n", TEST_PREFIX);
> +		exit(1);
> +	}
> +
> +	fprintf(stderr, "%s: ok\n", TEST_PREFIX);
> +	close(buf);
> +	close(memfd);
> +	close(devfd);
> +	return 0;
> +}
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a5b256b259..11a9b04277 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14934,6 +14934,14 @@ S:	Maintained
>  F:	Documentation/filesystems/udf.txt
>  F:	fs/udf/
>  
> +UDMABUF DRIVER
> +M:	Gerd Hoffmann <kraxel@redhat.com>
> +L:	dri-devel@lists.freedesktop.org
> +S:	Maintained
> +F:	drivers/dma-buf/udmabuf.c
> +F:	include/uapi/linux/udmabuf.h
> +F:	tools/testing/selftests/drivers/dma-buf/udmabuf.c
> +
>  UDRAW TABLET
>  M:	Bastien Nocera <hadess@hadess.net>
>  L:	linux-input@vger.kernel.org
> @@ -15343,6 +15351,14 @@ F:	arch/x86/um/
>  F:	fs/hostfs/
>  F:	fs/hppfs/
>  
> +USERSPACE DMA BUFFER DRIVER
> +M:	Gerd Hoffmann <kraxel@redhat.com>
> +S:	Maintained
> +L:	dri-devel@lists.freedesktop.org
> +F:	drivers/dma-buf/udmabuf.c
> +F:	include/uapi/linux/udmabuf.h
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +
>  USERSPACE I/O (UIO)
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  S:	Maintained
> diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
> index ed3b785bae..338129eb12 100644
> --- a/drivers/dma-buf/Kconfig
> +++ b/drivers/dma-buf/Kconfig
> @@ -30,4 +30,12 @@ config SW_SYNC
>  	  WARNING: improper use of this can result in deadlocking
> kernel
>  	  drivers from userspace. Intended for test and debug only.
>  
> +config UDMABUF
> +	bool "userspace dmabuf misc driver"
> +	default n
> +	depends on DMA_SHARED_BUFFER
> +	help
> +	  A driver to let userspace turn memfd regions into dma-
> bufs.
> +	  Qemu can use this to create host dmabufs for guest
> framebuffers.
> +
>  endmenu
> diff --git a/drivers/dma-buf/Makefile b/drivers/dma-buf/Makefile
> index c33bf88631..0913a6ccab 100644
> --- a/drivers/dma-buf/Makefile
> +++ b/drivers/dma-buf/Makefile
> @@ -1,3 +1,4 @@
>  obj-y := dma-buf.o dma-fence.o dma-fence-array.o reservation.o
> seqno-fence.o
>  obj-$(CONFIG_SYNC_FILE)		+= sync_file.o
>  obj-$(CONFIG_SW_SYNC)		+= sw_sync.o sync_debug.o
> +obj-$(CONFIG_UDMABUF)		+= udmabuf.o
> diff --git a/tools/testing/selftests/drivers/dma-buf/Makefile
> b/tools/testing/selftests/drivers/dma-buf/Makefile
> new file mode 100644
> index 0000000000..4154c3d7aa
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/dma-buf/Makefile
> @@ -0,0 +1,5 @@
> +CFLAGS += -I../../../../../usr/include/
> +
> +TEST_GEN_PROGS := udmabuf
> +
> +include ../../lib.mk
> -- 
> 2.9.3
