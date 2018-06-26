Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E80C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9549F26686
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9549F26686
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752917AbeFZIM2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:12:28 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:44239 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752409AbeFZIMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:12:23 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 0C18334FF4F;
        Tue, 26 Jun 2018 10:12:22 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     jdow <jdow@earthlink.net>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: moving affs + RDB partition support to staging?
Date:   Tue, 26 Jun 2018 10:12:21 +0200
Message-ID: <1954225.EY2fU3p6yy@merkaba>
In-Reply-To: <45e05e92-e2b1-d46c-11fb-4bd75e793712@earthlink.net>
References: <20180425154602.GA8546@bombadil.infradead.org> <CAOmrzk+CuuraUnWWKDKen9FV6=UcgKgc6+qJ3g-Fx+tkt5HHQw@mail.gmail.com> <45e05e92-e2b1-d46c-11fb-4bd75e793712@earthlink.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joanne.

jdow - 26.06.18, 07:17:
> As long as it preserves compatibility it should be OK, I suppose.
> Personally I'd make any partitioning tool front end gently force the
> block size towards 8k as the disk size gets larger. The file systems
> may also run into 2TB issues that are not obvious. An unused blocks
> list will have to go beyond a uint32_t size, for example. But a block
> list (OFS for sure, don't remember for the newer AFS) uses a tad
> under 1% of the disk all by itself. A block bitmap is not quite so
> bad. {^_-}
> 
> Just be sure you are aware of all the ramifications when you make a
> change. I remember thinking about this for awhile and then
> determining I REALLY did not want to think about it as my brain was
> getting tied into a gordian knot.

Heh… :)

Well, all I can say it that it just worked on AmigaOS 4. I did not see 
any data corruption in any of the filesystems. Well as far as I have 
been able to check. There has been no repair tool for JXFS I think. But 
as I migrated the data on it to SFS, I was able to copy everything.

Famous last words.

Well especially the disk size was detected properly and there was no 
overflow like on Linux. So I´d say rather have on error less than one 
error more.

Of course, it could also be an option to outright *refuse* to detect 
such disks with a big fat warning in kernel log that it may unsafe. But 
overflowing and thus on writes overwriting existing data is not safe.

I do think it is safe enough, but what I do know about the internals 
about RDB (more than the average user certainly, but not as much as you 
or some other AmigaOS developer who digged  deeper into that).

So in case you´d rather see Linux to refuse to handle disks like that, 
that would also be fine with me. Just do not handle them in the broken 
way that they are handled in Linux now. I.e. do not deliberately corrupt 
things as in "Its dangerous, so let´s overwrite data straight away, so 
the user gets it." :)

Anyway, in my opinion RDB still just so much more advanced than MBR and 
in some parts even on par with the much later GPT. With some limitations 
it is a quite brilliant partition format, if you ask me.

> {^_^}
> 
> On 20180625 19:23, Michael Schmitz wrote:
> > Joanne,
> > 
> > Martin's boot log (including your patch) says:
> > 
> > Jun 19 21:19:09 merkaba kernel: [ 7891.843284]  sdb: RDSK (512) sdb1
> > (LNX^@)(res 2 spb 1) sdb2 (JXF^D)(res 2 spb 1) sdb3 (DOS^C)(res 2
> > spb
> > 4)
> > Jun 19 21:19:09 merkaba kernel: [ 7891.844055] sd 7:0:0:0: [sdb]
> > Attached SCSI disk
> > 
> > so it's indeed a case of self inflicted damage (RDSK (512) means 512
> > byte blocks) and can be worked around by using a different block
> > size.
> > 
> > Your memory serves right indeed - blocksize is in 512 bytes units.
> > I'll still submit a patch to Jens anyway as this may bite others
> > yet.
> > 
> > Cheers,
> > 
> >    Michael
> > 
> > On Sun, Jun 24, 2018 at 11:40 PM, jdow <jdow@earthlink.net> wrote:
> >> BTW - anybody who uses 512 byte blocks with an Amiga file system is
> >> a famn dool.
> >> 
> >> If memory serves the RDBs think in blocks rather than bytes so it
> >> should work up to 2 gigablocks whatever your block size is. 512
> >> blocks is 2199023255552 bytes. But that wastes just a WHOLE LOT of
> >> disk in block maps. Go up to 4096 or 8192. The latter is 35 TB.
> >> 
> >> {^_^}
> >> 
> >> On 20180624 02:06, Martin Steigerwald wrote:
> >>> Hi.
> >>> 
> >>> Michael Schmitz - 27.04.18, 04:11:
> >>>> test results at https://bugzilla.kernel.org/show_bug.cgi?id=43511
> >>>> indicate the RDB parser bug is fixed by the patch given there, so
> >>>> if
> >>>> Martin now submits the patch, all should be well?
> >>> 
> >>> Ok, better be honest than having anyone waiting for it:
> >>> 
> >>> I do not care enough about this, in order to motivate myself
> >>> preparing the a patch from Joanne Dow´s fix.
> >>> 
> >>> I am not even using my Amiga boxes anymore, not even the Sam440ep
> >>> which I still have in my apartment.
> >>> 
> >>> So RDB support in Linux it remains broken for disks larger 2 TB,
> >>> unless someone else does.
> >>> 
> >>> Thanks.
[…]
-- 
Martin


