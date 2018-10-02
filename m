Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B30AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E752F204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 02:28:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E752F204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbeJBJJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 05:09:09 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43132 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBJJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 05:09:08 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7AQ2-00016Q-7U; Tue, 02 Oct 2018 02:28:14 +0000
Date:   Tue, 2 Oct 2018 03:28:14 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     dushistov@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: ufs: Convert ufs_set_de_type to use lookup table
Message-ID: <20181002022814.GN32577@ZenIV.linux.org.uk>
References: <20181001153310.GA13006@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001153310.GA13006@pathfinder>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 04:33:10PM +0100, Phillip Potter wrote:
> Modify ufs_set_de_type function in fs/ufs/util.h to use a lookup
> table rather than a switch statement, as per the TODO comment.

Brittle, that...   Something like fs/ext2/dir.c approach (that is,
#define S_SHIFT 12
static unsigned char ext2_type_by_mode[S_IFMT >> S_SHIFT] = {
        [S_IFREG >> S_SHIFT]    = EXT2_FT_REG_FILE,
        [S_IFDIR >> S_SHIFT]    = EXT2_FT_DIR,
        [S_IFCHR >> S_SHIFT]    = EXT2_FT_CHRDEV,
        [S_IFBLK >> S_SHIFT]    = EXT2_FT_BLKDEV,
        [S_IFIFO >> S_SHIFT]    = EXT2_FT_FIFO,
        [S_IFSOCK >> S_SHIFT]   = EXT2_FT_SOCK,
        [S_IFLNK >> S_SHIFT]    = EXT2_FT_SYMLINK,
};
in there) would be saner, IMO.  Note that DT_UNKNOWN is zero, so the
array elements lacking an explicit initializer will end up with that.

What's more, the values are ->i_mode >> 12 or 0, depending upon the
value being valid.  And since the upper layers do validate the type,
I'd consider simply using (inode->i_mode & S_IFMT) >> 12 there.
Unlike ext2, ufs stores straight bits 12..15 there (ext2 uses an
enum with sequential values instead; e.g. regular files are encoded
as 1 there, not 8 as on ufs)...
