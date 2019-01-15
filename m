Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A06EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293822085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 09:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfAOJp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 04:45:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:33926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbfAOJp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 04:45:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D320BAEEF;
        Tue, 15 Jan 2019 09:45:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 609D41E0DB1; Tue, 15 Jan 2019 10:45:55 +0100 (CET)
Date:   Tue, 15 Jan 2019 10:45:55 +0100
From:   Jan Kara <jack@suse.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Michael Sabolish <sabolish@me.com>,
        Kevin Weidemann <kwe-lnx@postn.eu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: udf: Prevent write-unsupported filesystem to be remounted
 read-write
Message-ID: <20190115094555.GG29524@quack2.suse.cz>
References: <124cc6ea-ca79-20f2-651e-c2f909729ac0@gmx.de>
 <8cf39b7c-505b-91e6-849d-e66ba980042f@postn.eu>
 <20190114103011.GD13316@quack2.suse.cz>
 <20190114120023.wkftfz6pwatehpfe@pali>
 <20190114123042.GH13316@quack2.suse.cz>
 <E11914DA-D254-4198-A152-F9D6E61514BE@me.com>
 <20190115083111.qq2mt2p2kn4opwx7@pali>
 <20190115084119.GE29524@quack2.suse.cz>
 <20190115084832.fypbuhyvgfizh3am@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190115084832.fypbuhyvgfizh3am@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-01-19 09:48:32, Pali Rohár wrote:
> On Tuesday 15 January 2019 09:41:19 Jan Kara wrote:
> > On Tue 15-01-19 09:31:11, Pali Rohár wrote:
> > > On Monday 14 January 2019 19:07:35 Michael Sabolish wrote:
> > > > I can try and make a pull-request for udftune, and I can just copy the API for tune2fs.  It would work something like:
> > > > 
> > > > udftune -O read-only device            (to set read-only access type)
> > > > 
> > > > or:
> > > > 
> > > > udftune -O ^read-only device          (to clear read-only access type (aka set rw))
> > > 
> > > This API is ambiguous. What does it mean for ^read-only? In UDF you have
> > > following access types: overwritable, rewritable, writeonce, readonly,
> > > pseudo-overwritable, unknown.
> > > 
> > > So you would need to know to which R/W access type to switch
> > > (overwritable, rewritable, writeonce or pseudo-overwritable).
> > > 
> > > With information of media type, you could be able to guess correct
> > > access type. But for UDF images stored in VFS there is no media
> > > information. Also you can have uncommon setup, e.g. usage of CD-R
> > > writeonce setup on CD-R/W disc. So "autodetection" of media type would
> > > not work always correctly.
> > > 
> > > So I think that it would be better to have following API:
> > > 
> > >   udftune --access-type=<new_access_type>
> > > 
> > > or
> > > 
> > >   udftune --change-access-type=<new_access_type>
> > > 
> > > I understand that you would like to have similar API as tune2fs, but UDF
> > > settings are too different from ext*.
> > 
> > If you wanted to follow tune2fs interface, you can have e.g.:
> 
> Question is if it is a good idea to follow this interface.

Agreed. I'll leave that decision up to you as a maintainer :)

> > udftune -E access-type=<foo>
> > 
> > Another question about the feature is - the access type is actually per
> > partition and there can be multiple partitions on UDF media. So I think we
> > need to specify the partition number in the command and <foo> has to
> > actually be something like <partition number>,<access_type>.
> 
> Access type is stored in partition descriptor and in UDF (as opposite of
> ECMA-167) you can have only one partition descriptor. IIRC there is some
> exception when you have two partition descriptors, but then one have to be
> readonly and second virtual.

Ah, right, I forgot that UDF standard limits how partitions can be set up.
However I don't see anything that would limit number of "type 1" maps? I've
only found in 2.2.4.7 that "Partition Maps shall be limited to Partition
Map type 1, except type 2 maps ...". In which I'm not sure whether this is
meant to imply there is only one 'type 1' partition map or whether there
can be more of them.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
