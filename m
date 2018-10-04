Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAB5C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74762064E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:27:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74762064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeJDRU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:20:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:35920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbeJDRU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:20:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C97A0AD7A;
        Thu,  4 Oct 2018 10:27:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D884A1E3614; Thu,  4 Oct 2018 12:27:46 +0200 (CEST)
Date:   Thu, 4 Oct 2018 12:27:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+7f4a27091759e2fe7453@syzkaller.appspotmail.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: KASAN: use-after-free Write in jbd2_log_do_checkpoint
Message-ID: <20181004102746.GF11529@quack2.suse.cz>
References: <0000000000002be16c05760f576d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002be16c05760f576d@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-09-18 04:19:02, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    2e2a0c961a87 Merge branch 'progarray_mapinmap_dump'
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17622811400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f59875069d721b6
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f4a27091759e2fe7453
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7f4a27091759e2fe7453@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in atomic_inc
> include/asm-generic/atomic-instrumented.h:109 [inline]
> BUG: KASAN: use-after-free in get_bh include/linux/buffer_head.h:283
> [inline]
> BUG: KASAN: use-after-free in jbd2_log_do_checkpoint+0x113d/0x13e0
> fs/jbd2/checkpoint.c:337
> Write of size 4 at addr ffff8801b6d96300 by task syz-executor1/904

This is at:

                if (buffer_locked(bh)) {
                        spin_unlock(&journal->j_list_lock);
                        get_bh(bh);
                        wait_on_buffer(bh);
                        /* the journal_head may have gone by now */
                        BUFFER_TRACE(bh, "brelse");
                        __brelse(bh);
                        spin_lock(&journal->j_list_lock);
                        goto restart2;
                }

And indeed that get_bh() should be called before we unlock j_list_lock as
otherwise we can race with jbd2_journal_try_to_free_buffers(). I'll send a
fix.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
