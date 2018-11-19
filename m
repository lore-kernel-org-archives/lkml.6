Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDA9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187E42080C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187E42080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731828AbeKTJZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:25:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731164AbeKTJZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:25:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3C4234CC;
        Mon, 19 Nov 2018 22:59:07 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BB8E4D9E0;
        Mon, 19 Nov 2018 22:58:59 +0000 (UTC)
Date:   Mon, 19 Nov 2018 17:58:56 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>, sgrubb@redhat.com
Subject: Re: [RFC PATCH ghak100 V1 1/2] audit: avoid fcaps on MNT_FORCE
Message-ID: <20181119225856.dt3l7qzg2ftggon4@madcap2.tricolour.ca>
References: <cover.1542149969.git.rgb@redhat.com>
 <218e806e61cd5ae2fd38f9d546f953f86c763b58.1542149969.git.rgb@redhat.com>
 <CAJfpegtA74ULckL+PXoM9_pynV78EKOpQ603iZrp=hfR0z0z7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtA74ULckL+PXoM9_pynV78EKOpQ603iZrp=hfR0z0z7w@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 19 Nov 2018 22:59:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-19 13:47, Miklos Szeredi wrote:
> On Fri, Nov 16, 2018 at 6:34 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > Don't fetch fcaps when umount2 is called with MNT_FORCE to avoid a
> > process hang while it waits for the missing resource to (possibly never)
> > re-appear.
> 
> The patch would be pretty good if the dependence on MNT_FORCE wasn't
> added.   As it is, it's buggy in more ways than one:
> 
>  - It does the opposite of the above (i.e. skips fcaps *unless*
> MNT_FORCE is set)

I agree it looks wrong now that I look at it.  It turns out my test case
didn't trigger it properly since "umount -l" doesn't set MNT_FORCE while
it needs "-f" to do so.  This is unacceptable since "-l" needs to work
in this situation too.

>  - sets LOOKUP_NO_REVAL from caller of path lookup, which is invalid
> (LOOKUP_NO_REVAL is used only internally by path lookup)

Fair enough.  949a852e46dd viro 2016-03-14 ("namei: teach lookup_slow()
to skip revalidate") needs a comment update.

Maybe my patch was interacting with this one and changing the behaviour I
expected.

>  - the fact that *_path_mountpoint_at() shouldn't touch the mount root
> is independent of MNT_FORCE

We don't entirely agree here since I'm still aiming for a best effort to
collect this information for the PATH record, but that may be misleading
at best.

> I still don't quite understand what audit is trying to do here, but
> apparently it's okay to skip getxattr in the MNT_FORCE case.  So why
> is it not okay to skip it in the non-MNT_FORCE case?

The simple answer is that the audit PATH record format expects the four
cap_f* fields to be there and a best effort is being attempted to fill
in that information in an expected way with meaningful values.  Perhaps
better to accept that it is unreasonable to expect any fcaps on any
umount operation and simply ignore those fields in the PATH record for
umount syscall events.

This is really a problem the audit folks have backed ourselves into.
This was introduced by 851f7ff56d9c ("This patch will print
cap_permitted and cap_inheritable data in the PATH...")
The fcaps are only really needed for the case of an event that changes
fcaps.  In that case, the fcaps should have been added as a seperate
audit record to accompany this event as necessary, rather than included
in the PATH record that is shared by multiple event types, most of which
do not change the fcaps.  There has been significant and ongoing effort
to normalize all audit record types so that they contain predictable
fields in a predictable order without any fields that swing in and out
since this makes userspace audit record parsers faster and more
reliable.

My preferred solution would be to in fact remove these four cap_f*
fields from the PATH record and put them in a new record that was only
included when the event is relevant and the values are non-zero.
This isn't an option with current upstream kernel audit devel policy.

Thanks Miklos for taking the time to provide feedback on this patch.

> Thanks,
> Miklos

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
