Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00804C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 23:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AADB32150C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 23:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AADB32150C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeJUHTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 03:19:50 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57224 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbeJUHTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 03:19:50 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gE0LH-0006RY-0O; Sat, 20 Oct 2018 23:07:35 +0000
Date:   Sun, 21 Oct 2018 00:07:34 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Phillip Potter <phil@philpotter.co.uk>, dushistov@mail.ru,
        David.Laight@aculab.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type
 function
Message-ID: <20181020230734.GO32577@ZenIV.linux.org.uk>
References: <20181020220957.GA7267@pathfinder>
 <20181020222637.GA3477@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020222637.GA3477@bombadil.infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 03:26:37PM -0700, Matthew Wilcox wrote:
> On Sat, Oct 20, 2018 at 11:09:57PM +0100, Phillip Potter wrote:
> > Remove switch statement from ufs_set_de_type function in fs/ufs/util.h
> > header and replace with simple assignment. For each case, S_IFx >> 12
> > is equal to DT_x, so in valid cases (mode & S_IFMT) >> 12 should give
> > us the correct file type. It is expected that for *nix compatibility
> > reasons, the relation between S_IFx and DT_x will not change. For
> > cases where the mode is invalid, upper layer validation catches this
> > anyway, so this improves readability and arguably performance by
> > assigning (mode & S_IFMT) >> 12 directly without any jump table
> > or conditional logic.
> 
> Shouldn't we also do this for other filesystems?  A quick scan suggests
> someone should at least look at xfs, ubifs, squashfs, romfs, ocfs2,
> nilfs2, hfsplus, f2fs, ext4, ext2, exofs, coda, cifs & btrfs.

Do what for other filesystems?  E.g. ext* has the type cached in directory
entry - as a straight enum, so encoding is needed.  Which we do.  ocfs2
is pretty certain to have it in ext*-compatible layout.  ubifs stores
them in another enum of its own (also handled).  XFS - another enum (present
on some layout variants), etc.

And... CIFS?  Seriously?  This stuff is about encoding used to cache the
file type in directory entry; how the bleeding hell would CIFS _client_
get anywhere near that?
