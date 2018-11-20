Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28DAC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C8E20685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C8E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbeKUEBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 23:01:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46614 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbeKUEBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 23:01:53 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 134BD30820E4;
        Tue, 20 Nov 2018 17:31:37 +0000 (UTC)
Received: from x2.localnet (ovpn-120-172.rdu2.redhat.com [10.10.120.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 645BD7B8C1;
        Tue, 20 Nov 2018 17:31:30 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [RFC PATCH ghak100 V1 1/2] audit: avoid fcaps on MNT_FORCE
Date:   Tue, 20 Nov 2018 12:31:30 -0500
Message-ID: <17943076.6Ld0qRUFEn@x2>
Organization: Red Hat
In-Reply-To: <20181120154820.4s6jflcnyu4ha5qn@madcap2.tricolour.ca>
References: <cover.1542149969.git.rgb@redhat.com> <CAJfpegt8H-8-PJyJbGe9zQB1DxBQLoMA0QRhc-gAH=mw6YKhVw@mail.gmail.com> <20181120154820.4s6jflcnyu4ha5qn@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 20 Nov 2018 17:31:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 20, 2018 10:48:20 AM EST Richard Guy Briggs wrote:
> On 2018-11-20 09:17, Miklos Szeredi wrote:
> > On Mon, Nov 19, 2018 at 11:59 PM Richard Guy Briggs <rgb@redhat.com> 
wrote:
> > > The simple answer is that the audit PATH record format expects the four
> > > cap_f* fields to be there and a best effort is being attempted to fill
> > > in that information in an expected way with meaningful values.  Perhaps
> > > better to accept that it is unreasonable to expect any fcaps on any
> > > umount operation and simply ignore those fields in the PATH record for
> > > umount syscall events.
> > 
> > When there's a mount there are in fact two objects belonging to the
> > exact same path, each having completely independent metadata:  the
> > mount point and the root of the mount.  For example:
> > 
> > stat /mnt
> > umount /mnt
> > stat /mnt
> > 
> > The first stat will show the root of the mount, the second one will
> > show the mount point.
> > Which one is the relevant for audit?
> 
> It would be the root of the mount, the one that is visible to processes
> in that mount namespace.
> 
> Obviously, once that mount has been unmounted, it would be the mount
> point (no longer in use as such at that point) that is of interest.
> 
> On mounting, I'm guessing both would be of interest if the fcaps changed
> for that process-visible path in that mount namespace, so this provides
> an additional operation that would need recording aside from the case
> of a simple attribute change.

fcaps are on files. Mountpoints are directories. Would fcaps changes be 
possible?

-Steve


> > Not saying audit should be doing getxattr on any of them, just trying
> > to see more clearly.
> > 
> > Thanks,
> > Miklos
> 
> - RGB
> 
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635




