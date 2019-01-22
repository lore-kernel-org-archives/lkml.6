Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD80C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7219217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfAVNWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:22:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:40202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbfAVNWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:22:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29C18AFF7;
        Tue, 22 Jan 2019 13:22:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C8F101E3E20; Tue, 22 Jan 2019 14:22:28 +0100 (CET)
Date:   Tue, 22 Jan 2019 14:22:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Kevin Weidemann <kwe-lnx@postn.eu>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Subject: Re: udf: Prevent write-unsupported filesystem to be remounted
 read-write
Message-ID: <20190122132228.GF13149@quack2.suse.cz>
References: <124cc6ea-ca79-20f2-651e-c2f909729ac0@gmx.de>
 <8cf39b7c-505b-91e6-849d-e66ba980042f@postn.eu>
 <20190114103011.GD13316@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114103011.GD13316@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon 14-01-19 11:30:11, Jan Kara wrote:
> On Mon 14-01-19 01:33:30, Kevin Weidemann wrote:
> > this is RE the patch 8515b9edf7a0c9dcf1ad218ccc783700db217336 (Upstream
> > commit a9ad01bc759df79b0012f43ee52164391e31cd96) in 4.18.20.
> > 
> > I have an issue with UDF. I used to be able to create a UDF fs in a way
> > that is very similar to this:
> > 
> > `# mkudffs --label=.... -m dvd -b 512 /dev/mapper/cryptdev1`
> > 
> > I used to proceed mounting it, noticing it got mounted as readonly
> > (because the accesstype of the udf fs is readonly (as decided per -m
> > dvd)), so I remounted it as rw and then was able to fill it with data.[1]
> > 
> > Now, this doesn't work anymore since the last time I did that. I figured
> > out it must have to do with the commit mentioned above.  All I get now,
> > during a remount-as-rw attempt, is:
> > `cannot remount /dev/mapper/cryptdev1 read-write, is write-protected`.
> > 
> > I am not sure if this counts as a regression, because I see the point in
> > not only auto-mounting such filesystems as readonly, but also preventing
> > remounting as rw, however it breaks my use case.
> > 
> > However, I noticed the following, too:
> > case A) when having a "readonly udf" on a readwrite device, the
> > filesystem mounts as readonly (old behavior) and also prevents remounting
> > as rw (new behavior)
> 
> This works as intended.
> 
> > case B) when having a "readwrite udf" on a readonly device, the
> > filesystem mounts as readwrite (!), but the writes end up being invisibly
> > discarded
> 
> That's a bug. I'll fix it. Thanks for reporting this!

I have checked this and it works for me as designed:
(none):~# mount -t udf /dev/ubdb /mnt
mount: block device /dev/ubdb is write-protected, mounting read-only
UDF-fs: warning (device ubdb): udf_load_vrs: No anchor found
UDF-fs: Scanning with blocksize 512 failed
UDF-fs: warning (device ubdb): udf_load_vrs: No anchor found
UDF-fs: Scanning with blocksize 1024 failed
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2017/01/20 10:17 (1000)

So if the block device is read-only, you will get only read only mount.
Also remount read-write gets prevented:

(none):~# mount -o remount,rw /mnt/
mount: block device /dev/ubdb is write-protected, mounting read-only

Or with more recent util-linux (2.31.1):
(none):/ # mount -t udf /dev/ubdb /mnt
UDF-fs: warning (device ubdb): udf_load_vrs: No anchor found
UDF-fs: Scanning with blocksize 512 failed
UDF-fs: warning (device ubdb): udf_load_vrs: No anchor found
UDF-fs: Scanning with blocksize 1024 failed
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2017/01/20 10:17 (1000)
mount: /mnt: WARNING: device write-protected, mounted read-only.

and remount:
(none):/ # mount -o remount,rw /mnt
mount: /mnt: cannot remount /dev/ubdb read-write, is write-protected.

The kernel is 5.0-rc3. What kernel were you testing with?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
