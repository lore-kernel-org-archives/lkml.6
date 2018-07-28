Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC15C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C70E320842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 07:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70E320842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeG1IvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 04:51:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37544 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeG1IvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 04:51:21 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 018C83EE;
        Sat, 28 Jul 2018 07:25:50 +0000 (UTC)
Date:   Sat, 28 Jul 2018 09:25:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     devel@driverdev.osuosl.org, hsiangkao@aol.com,
        linux-erofs@lists.ozlabs.org, yuchao0@huawei.com,
        linux-kernel@vger.kernel.org, weidu.du@huawei.com,
        linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, chao@kernel.org
Subject: Re: [PATCH 00/25] staging: erofs: introduce erofs file system
Message-ID: <20180728072548.GA1500@kroah.com>
References: <1527764767-22190-1-git-send-email-gaoxiang25@huawei.com>
 <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532607728-103372-1-git-send-email-gaoxiang25@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 08:21:43PM +0800, Gao Xiang wrote:
> Hi,
> 
> This is actually the 2nd patchset of erofs file system,
> the original patchset can be found at
> 
> Link: https://marc.info/?l=linux-fsdevel&m=152776480425624
> 
> In order to keep up with the mainline linux-kernel changes and
> improve it in a more active and timely manner, we put forword
> this upstream proposal for linux-staging.
> 
> EROFS file system is a read-only file system with compression
> support designed for certain devices (especially embeded
> devices) with very limited physical memory and lots of memory
> consumers, such as Android devices. It aimes to provide
> a complete compression solution for such devices focuing
> on high performance and little extra memory overhead.
> 
> It is perferred to select larger compressed cluster sizes
> (generally >= 128k) for traditional compression file systems.
> It reads and decompresses a large compressed cluster at once,
> which has a good-looking random read number when memory
> is sufficient because all historial decompressed data
> is expected to be cached in memory. However, it also
> induces destructive effects when such devices have no enough
> spare memory for caching and decompression.
> 
> EROFS file system acts in some different way. It uses
> fixed-sized compressed size rather than fixed-sized input
> size, namely VLE (variable-length extent) compression,
> which has at least three adventages:
> 
>  1) all data read from block device at once can be
>     utilized, and read amplification can be easier to
>     estimate and control;
>  2) generally, it has a better compression ratio than
>     fixed-sized input compression approaches configured
>     with the same size;
>  3) aggressively optimized paths such as partial page
>     read can be implemented to gain better performance
>     for page-unaligned read (unimplemented yet, in TODO list).
> 
> As can be seen, VLE compression does a great job in small
> compressed cluster sizes, which is of course suitable for
> devices with limited memory. In this patchset, an in-place
> decompresion is also introduced to minimize extra memory usage.
> 
> 
> Apart from compression, EROFS also has the following features
> available and some limits:
>  o page-sized block support (currently, and no buffer-head);
>  o 32-bit block address (16TB for 4KB block);
>  o selectable v1 (32 bytes) / v2 (64 bytes) inode;
>  o 32-bit / 64-bit file size;
>  o 64-bit node number for addressing inodes;
>  o 64-bit s and 32-bit ns timestamps;
>  o inline data support;
>  o inline and shared xattr support;
>  o metadata and data can be mixed (optional);
>  o special inode support;
>  o posix acl support.
> 
> 
> The file system is still actively WIP, see _TODO_ for more details.
> 
> Any comments are welcome. :)

Thanks for submitting this, the filesystem looks very interesting.  I've
queued it all up now in the staging-next tree.

greg k-h
