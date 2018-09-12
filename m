Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F99EC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAAD206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAAD206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeILPkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:40:14 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:57162 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbeILPkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:40:14 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 3548A15AF4A;
        Wed, 12 Sep 2018 19:36:17 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w8CAaFMI030465
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Sep 2018 19:36:16 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w8CAaFQE010409
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Sep 2018 19:36:15 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id w8CAaFkg010408;
        Wed, 12 Sep 2018 19:36:15 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fat: Relax checks for sector size and media type
References: <20180902131932.11558-1-pali.rohar@gmail.com>
        <87bm9ft5h5.fsf@mail.parknet.co.jp>
        <20180903074005.7e3guj24ksq2l44c@pali>
        <874lf7t3gg.fsf@mail.parknet.co.jp>
        <20180903080422.ta3clnhr5bobv6il@pali>
        <87zhwzro1o.fsf@mail.parknet.co.jp>
        <20180912101750.6slpi3puoww72xsj@pali>
Date:   Wed, 12 Sep 2018 19:36:15 +0900
In-Reply-To: <20180912101750.6slpi3puoww72xsj@pali> ("Pali
 =?iso-8859-1?Q?Roh=E1r=22's?= message of
        "Wed, 12 Sep 2018 12:17:50 +0200")
Message-ID: <878t47roio.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Rohár <pali.rohar@gmail.com> writes:

>> If there is real user to use that, I'm ok though (of course, need
>> serious tests). However, FAT would be for exchange data with other
>> devices, and there is "cluster per sector", and spec recommends sector
>> size == device sector size. So I suspect this format is not useful.
>
> I looked into OpenBSD, FreeBSD and NetBSD source code and there is no
> explicit upper limit for sector size. Just that sector size must be
> power of two.
>
> I have not did tests yet, but you are right that some testing should be
> done.
>
> As FAT operates with clusters and cluster size is defined by sector
> size, then sectors per cluster and sector size defines cluster size. And
> cluster size itself implies maximal size of FAT filesystem.
>
> So increasing sector size could be useful to create larger FAT32
> filesystems as current limit hit by sector size = 512 bytes.
>
> What do you think, which operating systems should be tested?

Again, I suspect those custom extension (can't read by some uefi or
windows) is not useful though.

Testing on kernel that has PAGE_SIZE >= 8192, and setting FAT
sector_size >= 8192.  After that, it would be safe to remove 4096
limitation.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
