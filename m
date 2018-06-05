Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751735AbeFEHAD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:00:03 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55585 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeFEHAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:00:01 -0400
X-Google-Smtp-Source: ADUXVKInIv4Q82aCcOImMkd6jN0tg7SidPomSXCHys2jY1lYQsMYbIdZc/kzopWXLsdWgyEgVsowYA==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] ksys_mount: check for permissions before resource
 allocation
From: Ilya Matveychikov <matvejchikov@gmail.com>
In-Reply-To: <D2317950-0DB0-4311-ADB1-FF677B676E04@gmail.com>
Date: Tue, 5 Jun 2018 10:59:51 +0400
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Message-Id: <BD48252B-65D7-4238-BDA2-71BAC1CEA855@gmail.com>
References: <D2317950-0DB0-4311-ADB1-FF677B676E04@gmail.com>
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w55709FV020751

Just CC’ed to some of maintainers.

$ perl scripts/get_maintainer.pl fs/0001-ksys_mount-check-for-permissions-before-resource-all.patch
Alexander Viro <viro@zeniv.linux.org.uk> (maintainer:FILESYSTEMS (VFS and infrastructure))
linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and infrastructure))
linux-kernel@vger.kernel.org (open list)

> On Jun 5, 2018, at 6:00 AM, Ilya Matveychikov <matvejchikov@gmail.com> wrote:
> 
> Early check for mount permissions prevents possible allocation of 3
> pages from kmalloc() pool by unpriveledged user which can be used for
> spraying the kernel heap.
> 
> Signed-off-by: Ilya V. Matveychikov <matvejchikov@gmail.com>
> ---
> fs/namespace.c | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 5f75969adff1..1ef8feb2de2a 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -3046,6 +3046,9 @@ int ksys_mount(char __user *dev_name, char __user *dir_name, char __user *type,
> 	char *kernel_dev;
> 	void *options;
> 
> +	if (!may_mount())
> +		return -EPERM;
> +
> 	kernel_type = copy_mount_string(type);
> 	ret = PTR_ERR(kernel_type);
> 	if (IS_ERR(kernel_type))
> --
> 2.17.0
> 
