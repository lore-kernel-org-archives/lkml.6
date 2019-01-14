Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2994C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C52720656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfANKaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:30:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:40890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbfANKaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:30:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 358B0AE4C;
        Mon, 14 Jan 2019 10:30:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E17511E157A; Mon, 14 Jan 2019 11:30:11 +0100 (CET)
Date:   Mon, 14 Jan 2019 11:30:11 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kevin Weidemann <kwe-lnx@postn.eu>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Subject: Re: udf: Prevent write-unsupported filesystem to be remounted
 read-write
Message-ID: <20190114103011.GD13316@quack2.suse.cz>
References: <124cc6ea-ca79-20f2-651e-c2f909729ac0@gmx.de>
 <8cf39b7c-505b-91e6-849d-e66ba980042f@postn.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf39b7c-505b-91e6-849d-e66ba980042f@postn.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon 14-01-19 01:33:30, Kevin Weidemann wrote:
> this is RE the patch 8515b9edf7a0c9dcf1ad218ccc783700db217336 (Upstream
> commit a9ad01bc759df79b0012f43ee52164391e31cd96) in 4.18.20.
> 
> I have an issue with UDF. I used to be able to create a UDF fs in a way
> that is very similar to this:
> 
> `# mkudffs --label=.... -m dvd -b 512 /dev/mapper/cryptdev1`
> 
> I used to proceed mounting it, noticing it got mounted as readonly
> (because the accesstype of the udf fs is readonly (as decided per -m
> dvd)), so I remounted it as rw and then was able to fill it with data.[1]
> 
> Now, this doesn't work anymore since the last time I did that. I figured
> out it must have to do with the commit mentioned above.  All I get now,
> during a remount-as-rw attempt, is:
> `cannot remount /dev/mapper/cryptdev1 read-write, is write-protected`.
> 
> I am not sure if this counts as a regression, because I see the point in
> not only auto-mounting such filesystems as readonly, but also preventing
> remounting as rw, however it breaks my use case.
> 
> However, I noticed the following, too:
> case A) when having a "readonly udf" on a readwrite device, the
> filesystem mounts as readonly (old behavior) and also prevents remounting
> as rw (new behavior)

This works as intended.

> case B) when having a "readwrite udf" on a readonly device, the
> filesystem mounts as readwrite (!), but the writes end up being invisibly
> discarded

That's a bug. I'll fix it. Thanks for reporting this!

> To me, B) sounds just like the kind of issue that the commit, that I
> mentioned above, promised to fix.

Actually A) is what the commit a9ad01bc75 "udf: Prevent write-unsupported
filesystem to be remounted read-write" intended to fix.

> In fact, I believe case B to be more severe, because it automatically
> mounts as rw on a ro device, while the old (pre-patch) behavior of case A
> correctly mounted as ro and required manual remounting intervention to
> mount as rw on (potentially) rw - and even then, it's still less of an
> issue, when the underlying device is writeable.
> 
> I feel like the correct solution would be to:
> - disallow mounting as rw if the UDF is ro
> - disallow mounting as rw if the device is ro
> - disallow remounting as rw if the device is ro

Agreed on these.

> As for the case of remounting as rw if the UDF is ro but the device is
> rw, I am not sure what the best idea is to deal with this.  If this new
> behavior doesn't count as a regression, is there any way to end up with a
> UDF filesystem as specced by the command above (-m dvd -b 512, so with it
> being read-only), but still allow for mounting it as rw if the device
> supports it? Does udftools offer a way to manipulate the UDF partition
> descriptor flag in a pre-existing filesystem after it had already been
> created that I am missing?

So I would really prefer to keep the behavior of disallowing remounting
read-only partition read write. After all ECMA-167 standard is pretty clear
on this saying that for read-only partitions no sectors can be recorded. I
understand it is inconvenient if you try to create e.g. a DVD image. So you
want partition to be read-only in the end but initially you need it to be
writeable so that you can fill-in the contents.

Generally I think a clean solution for this is to provide a way in udftools
to switch partition read-only / read-write. Also this is how similar things
are achieved for other filesystems. Pali, is there a way to switch
accessType of a partition on existing media with udftools? If not, can you
look into implementing that please? It should be rather straightforward,
the biggest question really is which tool should do this...

								Honza

> [1] sanity check: people actually do this:
> - https://unix.stackexchange.com/a/17613
> - https://www.g-loaded.eu/2005/11/10/packet-writing-on-cdrw-and-dvdrw-media/
> - https://www.altlinux.org/WritingLargeFilesOnDVD
> - https://computador.docow.com/como-usair-dvd-rw-udf-tanto-no-windows-quanto-no-linux.html (case 4)
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
