Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E24C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E40F20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E40F20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeK0GQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:16:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbeK0GQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:16:53 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D4BC130027D0;
        Mon, 26 Nov 2018 19:21:47 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3470A60469;
        Mon, 26 Nov 2018 19:21:40 +0000 (UTC)
Date:   Mon, 26 Nov 2018 14:21:38 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] audit: remove arch_f pointer from struct
 audit_krule
Message-ID: <20181126192138.n6r7buxy4dpra4pt@madcap2.tricolour.ca>
References: <cover.1518435853.git.rgb@redhat.com>
 <7289e57d94a0a13965e3dbd279cc8cd12dfb29a6.1518435853.git.rgb@redhat.com>
 <CAHC9VhRv_F=Gqs7EyTR2ZmLtJobyH9B8Cg-iiHE5hacTC-d=Pw@mail.gmail.com>
 <20181125171115.su4kuu44lazqw56n@madcap2.tricolour.ca>
 <CAHC9VhRpYpkVN5fan91g96YuR9GjT=6TbV7vngtS1Crm72+Knw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRpYpkVN5fan91g96YuR9GjT=6TbV7vngtS1Crm72+Knw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 26 Nov 2018 19:21:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-26 11:37, Paul Moore wrote:
> On Sun, Nov 25, 2018 at 12:11 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2018-02-15 15:42, Paul Moore wrote:
> > > On Mon, Feb 12, 2018 at 7:29 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > The arch_f pointer was added to the struct audit_krule in commit:
> > > > e54dc2431d740a79a6bd013babade99d71b1714f ("audit signal recipients")
> > > >
> > > > This is only used on addition and deletion of rules which isn't time
> > > > critical and the arch field is likely to be one of the first fields,
> > > > easily found iterating over the field type.  This isn't worth the
> > > > additional complexity and storage.  Delete the field.
> > > >
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > ---
> > > >  include/linux/audit.h |  1 -
> > > >  kernel/auditfilter.c  | 12 ++++++++----
> > > >  2 files changed, 8 insertions(+), 5 deletions(-)
> > >
> > > I haven't decided if I like the removal of arch_f or not, but I think
> > > I might know where your oops/panic is coming from, thoughts below ...
> >
> > Have you decided yet if you like the removal of the arch_f pointer or
> > not?  An updated v2 was provided the following day:
> >         https://www.redhat.com/archives/linux-audit/2018-February/msg00059.html
> 
> I still think I'd like to keep it as-is for now.

Can you explain why you'd prefer to keep it as-is for now?  Is there a
factor I'm not aware of that might make it acceptable later?  arch_f
appears to make the code noisier than needed and use extra memory that
is a convenience at best only when adding or deleting rules.

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
