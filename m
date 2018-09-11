Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E7DC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB46206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB46206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=opteya.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbeILBsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:48:38 -0400
Received: from ou.quest-ce.net ([195.154.187.82]:43351 "EHLO ou.quest-ce.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726862AbeILBsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:48:37 -0400
Received: from [2a01:e35:2e9f:6cb0:857c:11e6:3194:d53d] (helo=test.quest-ce.net)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1fzpZ8-000FMY-9v; Tue, 11 Sep 2018 22:47:21 +0200
Message-ID: <e739a3e6de0e9d9c86ae98c6b5cc3710a1fcb40d.camel@opteya.com>
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Airlie <airlied@linux.ie>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-api@vger.kernel.org
Date:   Tue, 11 Sep 2018 22:47:17 +0200
In-Reply-To: <20180827093444.23623-1-kraxel@redhat.com>
References: <20180827093444.23623-1-kraxel@redhat.com>
Organization: OPTEYA
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a01:e35:2e9f:6cb0:857c:11e6:3194:d53d
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: Re: [v7] Add udmabuf misc device
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lundi 27 août 2018 à 11:34 +0200, Gerd Hoffmann a écrit :
> A driver to let userspace turn memfd regions into dma-bufs.
> 
> Use case:  Allows qemu create dmabufs for the vga framebuffer or
> virtio-gpu ressources.  Then they can be passed around to display
> those guest things on the host.  To spice client for classic full
> framebuffer display, and hopefully some day to wayland server for
> seamless guest window display.
> 
> qemu test branch:
>   https://git.kraxel.org/cgit/qemu/log/?h=sirius/udmabuf
> 
> Cc: David Airlie <airlied@linux.ie>
> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  Documentation/ioctl/ioctl-number.txt              |   1 +
>  include/uapi/linux/udmabuf.h                      |  33 +++
>  drivers/dma-buf/udmabuf.c                         | 287
> ++++++++++++++++++++++
>  tools/testing/selftests/drivers/dma-buf/udmabuf.c |  96 ++++++++
>  MAINTAINERS                                       |  16 ++
>  drivers/dma-buf/Kconfig                           |   8 +
>  drivers/dma-buf/Makefile                          |   1 +
>  tools/testing/selftests/drivers/dma-buf/Makefile  |   5 +
>  8 files changed, 447 insertions(+)
>  create mode 100644 include/uapi/linux/udmabuf.h
>  create mode 100644 drivers/dma-buf/udmabuf.c
>  create mode 100644 tools/testing/selftests/drivers/dma-buf/udmabuf.c
>  create mode 100644 tools/testing/selftests/drivers/dma-buf/Makefile
> 
> diff --git a/include/uapi/linux/udmabuf.h
> b/include/uapi/linux/udmabuf.h
> new file mode 100644
> index 0000000000..46b6532ed8
> --- /dev/null
> +++ b/include/uapi/linux/udmabuf.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_UDMABUF_H
> +#define _UAPI_LINUX_UDMABUF_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define UDMABUF_FLAGS_CLOEXEC	0x01
> +
> +struct udmabuf_create {
> +	__u32 memfd;
> +	__u32 flags;
> +	__u64 offset;
> +	__u64 size;
> +};
> +
> +struct udmabuf_create_item {
> +	__u32 memfd;
> +	__u32 __pad;
> +	__u64 offset;
> +	__u64 size;
> +};
> +
> +struct udmabuf_create_list {
> +	__u32 flags;
> +	__u32 count;
> +	struct udmabuf_create_item list[];
> +};
> +
> +#define UDMABUF_CREATE       _IOW('u', 0x42, struct udmabuf_create)
> +#define UDMABUF_CREATE_LIST  _IOW('u', 0x43, struct
> udmabuf_create_list)
> +
> +#endif /* _UAPI_LINUX_UDMABUF_H */
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> new file mode 100644
> index 0000000000..8e24204526
> --- /dev/null
> +++ b/drivers/dma-buf/udmabuf.c
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

You need to check .__pad for unsupported value:

                if (list[i].__pad) {
                        ret = -EINVAL;
                        goto err_free_ubuf;
                }

> +		if (!IS_ALIGNED(list[i].offset, PAGE_SIZE))
> +			goto err_free_ubuf;
> +		if (!IS_ALIGNED(list[i].size, PAGE_SIZE))
> +			goto err_free_ubuf;
> +		ubuf->pagecount += list[i].size >> PAGE_SHIFT;
> +	}
> +	ubuf->pages = kmalloc_array(ubuf->pagecount, sizeof(struct page
> *),
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
> +				file_inode(memfd)->i_mapping, pgoff +
> pgidx);
> +			if (IS_ERR(page)) {
> +				ret = PTR_ERR(page);
> +				goto err_put_pages;
> +			}
> +			ubuf->pages[pgbuf++] = page;
> +		}
> +		fput(memfd);
> +	}
> +	memfd = NULL;
> +
> +	exp_info.ops  = &udmabuf_ops;
> +	exp_info.size = ubuf->pagecount << PAGE_SHIFT;
> +	exp_info.priv = ubuf;
> +
> +	buf = dma_buf_export(&exp_info);
> +	if (IS_ERR(buf)) {
> +		ret = PTR_ERR(buf);
> +		goto err_put_pages;
> +	}
> +
> +	flags = 0;

You need to check .flags for unsupported value:

        if (head->flags & ~UDMABUF_FLAGS_CLOEXEC)
                 return -EINVAL;

(at the beginning of the function, of course).

> +	if (head->flags & UDMABUF_FLAGS_CLOEXEC)
> +		flags |= O_CLOEXEC;
> +	return dma_buf_fd(buf, flags);
> +
> +err_put_pages:
> +	while (pgbuf > 0)
> +		put_page(ubuf->pages[--pgbuf]);
> +err_free_ubuf:
> +	fput(memfd);
> +	kfree(ubuf->pages);
> +	kfree(ubuf);
> +	return ret;
> +}
> +

Regards

-- 
Yann Droneaud
OPTEYA


