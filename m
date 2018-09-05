Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E583C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0EA20658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0EA20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=BitWizard.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeIEQho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:37:44 -0400
Received: from cust-95-128-94-82.breedbanddelft.nl ([95.128.94.82]:50784 "EHLO
        cust-95-128-94-82.breedbanddelft.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbeIEQhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:37:43 -0400
Received: by abra2.bitwizard.nl (Postfix, from userid 1000)
        id 15BF013F6ED; Wed,  5 Sep 2018 14:07:46 +0200 (CEST)
Date:   Wed, 5 Sep 2018 14:07:46 +0200
From:   Rogier Wolff <R.E.Wolff@BitWizard.nl>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     =?utf-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>,
        bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: POSIX violation by writeback error
Message-ID: <20180905120745.GP17123@BitWizard.nl>
References: <CAJDTihzqn3whQ47uUOxGYk4Je4S10ehNEQCtfb=j--iCsdDqgQ@mail.gmail.com>
 <82ffc434137c2ca47a8edefbe7007f5cbecd1cca.camel@redhat.com>
 <CAJDTihw7T8WLme09W8VHCRfiALq4fxg1ZsywcSjn6hXsAw5wRw@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
 <20180904161203.GD17478@fieldses.org>
 <20180904162348.GN17123@BitWizard.nl>
 <20180904185411.GA22166@fieldses.org>
 <a9d586a8c520e52bad2396b93f8d5cb8a9fd2071.camel@redhat.com>
 <CAJDTihxE07BuXMBmShXuj=TbJCK1mq3ZMFMxP1-T=xjhPF5ySw@mail.gmail.com>
 <09ba078797a1327713e5c2d3111641246451c06e.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09ba078797a1327713e5c2d3111641246451c06e.camel@redhat.com>
Organization: BitWizard B.V.
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 06:55:15AM -0400, Jeff Layton wrote:
> There is no requirement for a filesystem to flush data on close().

And you can't start doing things like that. In some weird cases, you
might have an application open-write-close files at a much higher rate
than what a harddisk can handle. And this has worked for years because
the kernel caches stuff from inodes and data-blocks. If you suddenly
write stuff to harddisk at 10ms for each seek between inode area and
data-area... You end up limited to about 50 of these open-write-close
cycles per second.

My home system is now able make/write/close about 100000 files per
second.

assurancetourix:~/testfiles> time ../a.out 100000 000
0.103u 0.999s 0:01.10 99.0%     0+0k 0+800000io 0pf+0w

(The test program was accessing arguments beyond the end-of-arguments,
An extra argument for this one time program was easier than
open/fix/recompile).

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
**    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    **
*-- BitWizard writes Linux device drivers for any device you may have! --*
The plan was simple, like my brother-in-law Phil. But unlike
Phil, this plan just might work.
