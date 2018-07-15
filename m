Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FD8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 15:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB1DA208E9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 15:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1DA208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeGOPtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 11:49:31 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:59116 "EHLO
        mail.parknet.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeGOPta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 11:49:30 -0400
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id B35F59A180;
        Mon, 16 Jul 2018 00:26:04 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w6FFQ3bV008324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jul 2018 00:26:04 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.15.2/8.15.2/Debian-11) with ESMTPS id w6FFQ3T8006602
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jul 2018 00:26:03 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.15.2/8.15.2/Submit) id w6FFQ3p5006601;
        Mon, 16 Jul 2018 00:26:03 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: FAT: Operating on broken FAT FS causes the write syscall to return negative number not equal to -1
References: <CAE5jQCe4nX8m1f5jPL57GeU32CftNv+NvgNmZxufH85nun1o7w@mail.gmail.com>
        <878t6c7f8p.fsf@mail.parknet.co.jp>
        <20180715143043.GM30522@ZenIV.linux.org.uk>
        <CAE5jQCcs2x4myTHUhNmHPZvhMuPsrkzLmiqqeF5wzZ-Hf5druQ@mail.gmail.com>
Date:   Mon, 16 Jul 2018 00:26:03 +0900
In-Reply-To: <CAE5jQCcs2x4myTHUhNmHPZvhMuPsrkzLmiqqeF5wzZ-Hf5druQ@mail.gmail.com>
        (Anatoly Trosinenko's message of "Sun, 15 Jul 2018 18:08:23 +0300")
Message-ID: <87h8l0y0z8.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anatoly Trosinenko <anatoly.trosinenko@gmail.com> writes:

>> This patch returns better error (-EIO) for me.
>
> This works for me likewise.

Thanks for testing.

>> (But note, the corrupted FS image doesn't guarantee POSIX behavior.)
>
> Oops, I was just doing some testing and thought that correct behavior
> for crafted FS is to return arbitrary valid error code (like -EIO) or
> some arbitrary data, say, not larger than FS (not disclosing the
> kernel memory, of course). Please excuse me if I was wrong. If fixing
> this would slow down some hot code path, then I am not insisting on
> returning valid errno. :)
>
> Meanwhile, how should be considered such discrepancies with man pages
> for invalid FS images: should it be considered low priority bug,
> not-a-bug or feature request (diagnostics)?

To handle the corrupted image _perfectly_, finally we will have to have
online fsck or similar.

For example, if the data block was shared between the regular file and
directory, user can mmap the directory data via (corrupted) regular
file.

Then locking of directory handler doesn't work, and handler has to have
directory data as volatile data (and validate data for each memory
load). And to verify this invalid shared data blocks, we will have to
read all inodes (i.e. almost fsck).

So, I may change the code if data verification is easy and lightweight
like in this case. But like said above, it will not be guaranteed.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
