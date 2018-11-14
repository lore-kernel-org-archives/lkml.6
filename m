Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08BCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B561214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 09:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B561214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732365AbeKNTjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 14:39:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:37070 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727558AbeKNTjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 14:39:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 44C4FAE30;
        Wed, 14 Nov 2018 09:37:21 +0000 (UTC)
Date:   Wed, 14 Nov 2018 10:37:20 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        aarcange@redhat.com
Subject: Re: Memory hotplug softlock issue
Message-ID: <20181114093720.GI23419@dhcp22.suse.cz>
References: <20181114070909.GB2653@MiWiFi-R3L-srv>
 <5a6c6d6b-ebcd-8bfa-d6e0-4312bfe86586@redhat.com>
 <20181114090134.GG23419@dhcp22.suse.cz>
 <4449a0a2-be72-02bb-9f02-ed2484b160f8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4449a0a2-be72-02bb-9f02-ed2484b160f8@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 14-11-18 10:22:31, David Hildenbrand wrote:
> >>
> >> The real question is, however, why offlining of the last block doesn't
> >> succeed. In __offline_pages() we basically have an endless loop (while
> >> holding the mem_hotplug_lock in write). Now I consider this piece of
> >> code very problematic (we should automatically fail after X
> >> attempts/after X seconds, we should not ignore -ENOMEM), and we've had
> >> other BUGs whereby we would run into an endless loop here (e.g. related
> >> to hugepages I guess).
> > 
> > We used to have number of retries previous and it was too fragile. If
> > you need a timeout then you can easily do that from userspace. Just do
> > timeout $TIME echo 0 > $MEM_PATH/online
> 
> I agree that number of retries is not a good measure.
> 
> But as far as I can see this happens from the kernel via an ACPI event.
> E.g. failing to offline a block after X seconds would still make sense.
> (if something takes 120seconds to offline 128MB/2G there is something
> very bad going on, we could set the default limit to e.g. 30seconds),
> however ...

I disagree. THis is pulling policy into the kernel and that just
generates problems. What might look like a reasonable timeout to some
workloads might be wrong for others.

> > I have seen an issue when the migration cannot make a forward progress
> > because of a glibc page with a reference count bumping up and down. Most
> > probable explanation is the faultaround code. I am working on this and
> > will post a patch soon. In any case the migration should converge and if
> > it doesn't do then there is a bug lurking somewhere.
> 
> ... I also agree that this should converge. And if we detect a serious
> issue that we can't handle/where we can't converge (e.g. -ENOMEM) we
> should abort.

As I've said ENOMEM can be considered a hard failure. We do not trigger
OOM killer when allocating migration target so we only rely on somebody
esle making a forward progress for us and that is suboptimal. Yet I
haven't seen this happening in hotplug scenarios so far. Making
hotremove while the memory is really under pressure is a bad idea in the
first place most of the time. It is quite likely that somebody else just
triggers the oom killer and the offlining part will eventually make a
forward progress.
> 
> > 
> > Failing on ENOMEM is a questionable thing. I haven't seen that happening
> > wildly but if it is a case then I wouldn't be opposed.
> > 
> >> You mentioned memory pressure, if our host is under memory pressure we
> >> can easily trigger running into an endless loop there, because we
> >> basically ignore -ENOMEM e.g. when we cannot get a page to migrate some
> >> memory to be offlined. I assume this is the case here.
> >> do_migrate_range() could be the bad boy if it keeps failing forever and
> >> we keep retrying.
> 
> I've seen quite some issues while playing with virtio-mem, but didn't
> have the time to look into the details. Still on my long list of things
> to look into.

Memory hotplug is really far away from being optimal and robust. This
has always been the case. Issues used to be workaround by retry limits
etc. If we ever want to make it more robust we have to bite a bullet and
actually chase all the issues that might be basically anywhere and fix
them. This is just a nature of a pony that memory hotplug is.
-- 
Michal Hocko
SUSE Labs
