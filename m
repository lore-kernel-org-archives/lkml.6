Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDCBC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F033520851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544567784;
	bh=kEE3XpjJjgVHB0i7RsmyKd0lbrjRjHNAQJ8Zz3sJuB4=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=TGuvRMTafDO24VG7pk5CbcLnH9u0TZtlzqOXBqNEA82ZzfC5xOMbCUBtmuGtjEWxq
	 FdIYVlmFvK3ZYmMe4FI5p4O7hGj2ouqv2fv9/p3nVq1NM/VvKVajlvufDo1ACwJan5
	 neARND9mGv49uKiWpAiSf90TNDIqaIFUVj148SUQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F033520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbeLKWgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:36:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbeLKWgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:36:22 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2E9D20672;
        Tue, 11 Dec 2018 22:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544567782;
        bh=kEE3XpjJjgVHB0i7RsmyKd0lbrjRjHNAQJ8Zz3sJuB4=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=ri3cPjHH7Xhts58AVUXfc3BUrzhl4e+CS4rhaMZmvfOpNC6Xa7utxgW92cvopvHWv
         7fe9Hf80YMxb0gfY4v6c5jF0J16tAyzmKSm3OL54iGiGjWjf6X1+a91TLG6VinyPo4
         hWtIhzaHj3icbhBmYxz2FucH4/5He9DMUoDA7uwI=
Date:   Tue, 11 Dec 2018 14:36:20 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org
Subject: Re: [BUG BISECT next] Files cannot be opened after "fsverity: Move
 verity status check to fsverity_file_open"
Message-ID: <20181211223619.GF221175@gmail.com>
References: <CAJKOXPdNS+Qs6t1GwrgYhWT5EbtORJwYMzSrDPf8oAxv7ndNBg@mail.gmail.com>
 <20181211222721.GC4464@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211222721.GC4464@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 05:27:21PM -0500, Theodore Y. Ts'o wrote:
> On Tue, Dec 11, 2018 at 03:15:53PM +0100, Krzysztof Kozlowski wrote:
> > Hi,
> > 
> > Bisect from today's next pointed me to:
> > commit 4de97efb578a094e8fbf279522d41eb9ece1e3e0
> > Author: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> > Date:   Sat Dec 8 12:21:43 2018 +0530
> >     fsverity: Move verity status check to fsverity_file_open
> > 
> > as a reason of "Operation not supported" when reading any file from
> > mounted ext4fs (from SD card). Rootfs from nfsroot works but reading
> > from /home with ext4fs fails.
> 
> Can you send me an compressed e2image of your sdcard?
> 
> 	e2image -Q /dev/mmcblk0p2 sdcard.qcow2
> 	bzip2 -z sdcard.qcow2
> 
> Thanks!
> 
> 					- Ted

I don't think that's necessary.  Due to the bug, ext4_file_open() and
ext4_setattr() always return -EOPNOTSUPP when !CONFIG_FS_VERITY.

I'm working on a fixed version of the two patches to replace the ones currently
in the fscrypt tree.  Will send out soon.

- Eric
