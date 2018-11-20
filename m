Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C91C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C7720851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26C7720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbeKUCSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:18:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56861 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbeKUCSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:18:16 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C63473086254;
        Tue, 20 Nov 2018 15:48:29 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A81060BF6;
        Tue, 20 Nov 2018 15:48:23 +0000 (UTC)
Date:   Tue, 20 Nov 2018 10:48:20 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Steve Grubb <sgrubb@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [RFC PATCH ghak100 V1 1/2] audit: avoid fcaps on MNT_FORCE
Message-ID: <20181120154820.4s6jflcnyu4ha5qn@madcap2.tricolour.ca>
References: <cover.1542149969.git.rgb@redhat.com>
 <218e806e61cd5ae2fd38f9d546f953f86c763b58.1542149969.git.rgb@redhat.com>
 <CAJfpegtA74ULckL+PXoM9_pynV78EKOpQ603iZrp=hfR0z0z7w@mail.gmail.com>
 <20181119225856.dt3l7qzg2ftggon4@madcap2.tricolour.ca>
 <CAJfpegt8H-8-PJyJbGe9zQB1DxBQLoMA0QRhc-gAH=mw6YKhVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt8H-8-PJyJbGe9zQB1DxBQLoMA0QRhc-gAH=mw6YKhVw@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 20 Nov 2018 15:48:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-20 09:17, Miklos Szeredi wrote:
> On Mon, Nov 19, 2018 at 11:59 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> 
> > The simple answer is that the audit PATH record format expects the four
> > cap_f* fields to be there and a best effort is being attempted to fill
> > in that information in an expected way with meaningful values.  Perhaps
> > better to accept that it is unreasonable to expect any fcaps on any
> > umount operation and simply ignore those fields in the PATH record for
> > umount syscall events.
> 
> When there's a mount there are in fact two objects belonging to the
> exact same path, each having completely independent metadata:  the
> mount point and the root of the mount.  For example:
> 
> stat /mnt
> umount /mnt
> stat /mnt
> 
> The first stat will show the root of the mount, the second one will
> show the mount point.
> Which one is the relevant for audit?

It would be the root of the mount, the one that is visible to processes
in that mount namespace.

Obviously, once that mount has been unmounted, it would be the mount
point (no longer in use as such at that point) that is of interest.

On mounting, I'm guessing both would be of interest if the fcaps changed
for that process-visible path in that mount namespace, so this provides
an additional operation that would need recording aside from the case
of a simple attribute change.

> Not saying audit should be doing getxattr on any of them, just trying
> to see more clearly.
> 
> Thanks,
> Miklos

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
