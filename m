Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26085C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC502174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 01:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC502174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeH0EsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 00:48:20 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:41846 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeH0EsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 00:48:20 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fu5wl-000050-0V; Mon, 27 Aug 2018 01:03:59 +0000
Date:   Mon, 27 Aug 2018 02:03:58 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Ian Kent <raven@themaw.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] autofs - fix autofs_sbi() does not check super block type
Message-ID: <20180827010358.GZ6515@ZenIV.linux.org.uk>
References: <153475422934.17131.7563724552005298277.stgit@pluto.themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153475422934.17131.7563724552005298277.stgit@pluto.themaw.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 04:37:09PM +0800, Ian Kent wrote:
> The autofs_sbi() inline function does not check the super block
> magic number to verify it has been given an autofs super block.

IMO it's the wrong way to fix it.  The one and only caller where that
check might trigger is

                if (!fp) {
                        if (cmd == AUTOFS_DEV_IOCTL_ISMOUNTPOINT_CMD)
                                goto cont;
                        err = -EBADF;
                        goto out;
                }

                sbi = autofs_dev_ioctl_sbi(fp);
                if (!sbi || sbi->magic != AUTOFS_SBI_MAGIC) {
                        err = -EINVAL;
                        fput(fp);
                        goto out;
                }
with
static struct autofs_sb_info *autofs_dev_ioctl_sbi(struct file *f)
{
        struct autofs_sb_info *sbi = NULL;
        struct inode *inode;

        if (f) { 
                inode = file_inode(f);
                sbi = autofs_sbi(inode->i_sb);
        }
        return sbi;
}

First of all, what is that `if (f)' doing in there?  We have just checked
that in the only caller.

Next, dereferencing the result of autofs_sbi() does need to be preceded
by making sure that superblock is autofs one, all right... and what are
we doing in that first dereferencing, again?

IOW, turn that into

	if (!fp) {
		....
		goto out;
	}
	sb = file_inode(fp)->i_sb;
	if (sb->s_type != &autofs_fs_type)
		bugger off
	sbi = autofs_sbi(sb);
	....

and be done with that.  Other callers of autofs_sbi() really shouldn't
happen to other filesystem's superblocks...
