Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9111EC4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52112217CB
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:18:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52112217CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeHDUUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 16:20:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728054AbeHDUUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 16:20:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0249D401B1F4;
        Sat,  4 Aug 2018 18:18:48 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A29EF2026D66;
        Sat,  4 Aug 2018 18:18:47 +0000 (UTC)
Date:   Sat, 4 Aug 2018 14:18:47 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Zdenek Kabelac <zkabelac@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru
Subject: Re: LVM snapshot broke between 4.14 and 4.16
Message-ID: <20180804181845.GA10499@redhat.com>
References: <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <b2bbd8ec-ac5b-fa8a-d3f7-8615d87f73c3@redhat.com>
 <CA+55aFwWZX=CXmWDTkDGb36kf12XmTehmQjbiMPCqCRG2hi9kw@mail.gmail.com>
 <20180803185431.GB3258@redhat.com>
 <CA+55aFwDEY7B6OMh5xL2wc8BRj1KkzBHggNowAjbsWfma6H5Zg@mail.gmail.com>
 <20180803193037.GA4581@redhat.com>
 <20180804052033.GA4461@thunk.org>
 <102c2d75-f768-a649-52c3-bac6f0ca738d@redhat.com>
 <20180804162205.GB4461@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804162205.GB4461@thunk.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sat, 04 Aug 2018 18:18:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Sat, 04 Aug 2018 18:18:48 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'msnitzer@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04 2018 at 12:22pm -0400,
Theodore Y. Ts'o <tytso@mit.edu> wrote:

> On Sat, Aug 04, 2018 at 10:36:50AM +0200, Zdenek Kabelac wrote:
> > dm-snapshost has really outdated design - it's been useful in the old age
> > where megabyte was hell lot of space.
> > 
> > Nowadays, when users do need to handle snapshots in multi gigabyte sizes and
> > moreover have number of snapshots from the same volume taken over the time,
> > want to take snapshot of snapshot of snapshot, the old snapshot simple kills
> > all the performance, uses tons of resources and becomes serious bottleneck
> > of your system and has lots of usability limitation.
> 
> Fair enough.  I don't think I would consider that makes dm-snapshot a
> "steaming pile".  For me, protection against data loss is Job One.

What's your point Ted?  Do you have _any_ intention of actually using
anything DM or is this just a way for you to continue to snipe at it?
 
> > That's where  thin provisioning will shine....
> 
> The dm-thin development might want to take a look at what's currently
> in Documentation/device-mapper/thin-privisioning.txt:
> 
>    Status
>    ======
> 
>    These targets are very much still in the EXPERIMENTAL state.  Please
>    do not yet rely on them in production.  But do experiment and offer us
>    feedback.  Different use cases will have different performance
>    characteristics, for example due to fragmentation of the data volume.
> 
>    If you find this software is not performing as expected please mail
>    dm-devel@redhat.com with details and we'll try our best to improve
>    things for you.
> 
>    Userspace tools for checking and repairing the metadata are under
>    development.
> 
> Saying that dm-snapshot is a steaming pile and dm-thin is what
> everyone should use doesn't seem to be consistent with the above.

Maybe read your email from earlier today before repeating yourself:
https://lkml.org/lkml/2018/8/4/366
