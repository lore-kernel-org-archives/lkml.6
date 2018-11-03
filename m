Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21852C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E247120833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 06:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E247120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeKCPk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 11:40:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59548 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbeKCPk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 11:40:59 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 52A848C58AD9C;
        Sat,  3 Nov 2018 14:30:42 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.408.0; Sat, 3 Nov 2018
 14:30:41 +0800
Subject: Re: [git pull] mount API series
To:     Al Viro <viro@ZenIV.linux.org.uk>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        <swhiteho@redhat.com>, <john.johansen@canonical.com>,
        <alan.christopher.jenkins@gmail.com>, <ebiederm@redhat.com>,
        <linux-fsdevel@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <CAHk-=whysoVxJU8+TBw=D3xN00HOOqg-9Chc=i0Pt+Ozm3Z0Tg@mail.gmail.com>
 <20181031053355.GQ32577@ZenIV.linux.org.uk>
 <CAHk-=whAE6gVi18=u4sSWe1m2RWPh19YCkKQmW4Kx+NQX1mg8w@mail.gmail.com>
 <af28fc2c-d207-875e-8070-f64ead878b5a@redhat.com>
 <CAHk-=wjjVRQVZL+QMnb=CyCOY8yzEZ=S1DBCE7=FiiWsQfV_5Q@mail.gmail.com>
 <28156.1541092687@warthog.procyon.org.uk>
 <3549.1541116763@warthog.procyon.org.uk>
 <20181102040701.GX32577@ZenIV.linux.org.uk>
From:   Gao Xiang <gaoxiang25@huawei.com>
Message-ID: <2bc0d9c2-bd62-5a5b-7d92-011c688b9ab5@huawei.com>
Date:   Sat, 3 Nov 2018 14:30:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20181102040701.GX32577@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On 2018/11/2 12:07, Al Viro wrote:
> On Thu, Nov 01, 2018 at 11:59:23PM +0000, David Howells wrote:
> 
>>  (*) mount-api-core.  These are the internal-only patches that add the
>>      fs_context, the legacy wrapper and the security hooks and make certain
>>      filesystems make use of it.
> 
> FWIW, while rereading that series I'd spotted something very odd in erofs.
> It's orthogonal to everything else, but just to make sure it doesn't get
> lost:
> 	* sbi->dev_name thing in erofs is used only for debugging printks,
> basically.  Just use sb->s_id[] and be done with that.
> 	* dump struct erofs_mount_private - you don't need dev_name in
> your erofs_fill_super().  Just use mount_bdev() in usual fashion.

OK, these two points are the same, the original alternative patch to fixup it is to use bdevname(),
However I saw what is done in drivers/usb/gadget/function/f_fs.c, therefore I fixed in as what I saw in f_fs.c.

Refer:
https://lists.ozlabs.org/pipermail/linux-erofs/2018-September/000548.html
https://lists.ozlabs.org/pipermail/linux-erofs/2018-September/000551.html

I could remove erofs_mount_private entirely if you want. :)

> 	* what the hell are you doing with ->s_root???  Why would you
> possibly want it hashed and what kind of dcache lookup could find it?
> That d_rehash() looks deeply confused; what are you trying to do there?
Thanks for pointing out. After I think into this piece of code, I also think that is redundant.
I will fix it immediately, thanks again for pointing out.

Thanks,
Gao Xiang

> 
