Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9F3ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8367214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8367214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbeIQPA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:00:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51774 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726826AbeIQPAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:00:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AF60520DEEEB7;
        Mon, 17 Sep 2018 17:34:12 +0800 (CST)
Received: from localhost (10.202.226.46) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 17:34:09 +0800
Date:   Mon, 17 Sep 2018 10:33:48 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <qat-linux@intel.com>, <linux-crypto@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>, <amd-gfx@lists.freedesktop.org>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-nvme@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-btrfs@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 05/17] compat_ioctl: move more drivers to
 generic_compat_ioctl_ptrarg
Message-ID: <20180917103348.00003f31@huawei.com>
In-Reply-To: <20180912151134.436719-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
        <20180912151134.436719-1-arnd@arndb.de>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2018 17:08:52 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> The .ioctl and .compat_ioctl file operations have the same prototype so
> they can both point to the same function, which works great almost all
> the time when all the commands are compatible.
> 
> One exception is the s390 architecture, where a compat pointer is only
> 31 bit wide, and converting it into a 64-bit pointer requires calling
> compat_ptr(). Most drivers here will ever run in s390, but since we now
> have a generic helper for it, it's easy enough to use it consistently.
> 
> I double-checked all these drivers to ensure that all ioctl arguments
> are used as pointers or are ignored, but are not interpreted as integer
> values.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

For IIO part.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index a062cfddc5af..22844b94b0e9 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1630,7 +1630,7 @@ static const struct file_operations iio_buffer_fileops = {
>  	.owner = THIS_MODULE,
>  	.llseek = noop_llseek,
>  	.unlocked_ioctl = iio_ioctl,
> -	.compat_ioctl = iio_ioctl,
> +	.compat_ioctl = generic_compat_ioctl_ptrarg,
>  };
>  

