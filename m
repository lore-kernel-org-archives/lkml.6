Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40126C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4AE20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfANMao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:30:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:60950 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbfANMan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:30:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87804AF09;
        Mon, 14 Jan 2019 12:30:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4993A1E157A; Mon, 14 Jan 2019 13:30:42 +0100 (CET)
Date:   Mon, 14 Jan 2019 13:30:42 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Michael Sabolish <sabolish@me.com>,
        Kevin Weidemann <kwe-lnx@postn.eu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: udf: Prevent write-unsupported filesystem to be remounted
 read-write
Message-ID: <20190114123042.GH13316@quack2.suse.cz>
References: <124cc6ea-ca79-20f2-651e-c2f909729ac0@gmx.de>
 <8cf39b7c-505b-91e6-849d-e66ba980042f@postn.eu>
 <20190114103011.GD13316@quack2.suse.cz>
 <20190114120023.wkftfz6pwatehpfe@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190114120023.wkftfz6pwatehpfe@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-01-19 13:00:23, Pali Rohár wrote:
> On Monday 14 January 2019 11:30:11 Jan Kara wrote:
> > > As for the case of remounting as rw if the UDF is ro but the device is
> > > rw, I am not sure what the best idea is to deal with this.  If this new
> > > behavior doesn't count as a regression, is there any way to end up with a
> > > UDF filesystem as specced by the command above (-m dvd -b 512, so with it
> > > being read-only), but still allow for mounting it as rw if the device
> > > supports it? Does udftools offer a way to manipulate the UDF partition
> > > descriptor flag in a pre-existing filesystem after it had already been
> > > created that I am missing?
> > 
> > So I would really prefer to keep the behavior of disallowing remounting
> > read-only partition read write. After all ECMA-167 standard is pretty clear
> > on this saying that for read-only partitions no sectors can be recorded. I
> > understand it is inconvenient if you try to create e.g. a DVD image. So you
> > want partition to be read-only in the end but initially you need it to be
> > writeable so that you can fill-in the contents.
> > 
> > Generally I think a clean solution for this is to provide a way in udftools
> > to switch partition read-only / read-write. Also this is how similar things
> > are achieved for other filesystems. Pali, is there a way to switch
> > accessType of a partition on existing media with udftools? If not, can you
> > look into implementing that please? It should be rather straightforward,
> > the biggest question really is which tool should do this...
> 
> You are not the first who asked for such functionality in udftools.
> Michael (CCed) already experimented with such thing and "hacked"
> udflabel to switch access type from overwritable to readonly.
> 
> I'm not against adding a new tool into udftools project which can
> manipulate UDF access type. Question is design / API of such tool.
> 
> Currently udftools has udfinfo tool which prints lot of information
> about UDF filesystem (including access type). But the only tool which
> modifies UDF filesystem in udftools is udflabel. And udflabel is not
> really the proper place for changing access type.
> 
> So some new tool for modifying UDF filesystem would be better. Which
> other settings of UDF filesystem could be useful to be modifiable? I'm
> thinking about "udftune" where new features for modification could be
> implemented later too.

Yes, that sounds good to me and is in line with what tools for other
filesystems have.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
