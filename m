Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754162AbeEaIh3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:37:29 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:55211 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754023AbeEaIhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:37:24 -0400
X-Google-Smtp-Source: ADUXVKL6r773OjpTTYqP3fyjmTuMbW7Hth6gSwiH4y7HzDk17a7HvH+YSfYNxs9zySXSalfyxxRcVw==
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <20180530220206.GA7037@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f084e3bc-77af-4268-c882-7b0737e45f3b@grimberg.me>
Date: Thu, 31 May 2018 11:37:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180530220206.GA7037@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Wouldn't expect you guys to nurture this 'mpath_personality' knob.  SO
> when features like "dispersed namespaces" land a negative check would
> need to be added in the code to prevent switching from "native".
> 
> And once something like "dispersed namespaces" lands we'd then have to
> see about a more sophisticated switch that operates at a different
> granularity.  Could also be that switching one subsystem that is part of
> "dispersed namespaces" would then cascade to all other associated
> subsystems?  Not that dissimilar from the 3rd patch in this series that
> allows a 'device' switch to be done in terms of the subsystem.

Which I think is broken by allowing to change this personality on the
fly.

> 
> Anyway, I don't know the end from the beginning on something you just
> told me about ;)  But we're all in this together.  And can take it as it
> comes.

I agree but this will be exposed to user-space and we will need to live
with it for a long long time...

> I'm merely trying to bridge the gap from old dm-multipath while
> native NVMe multipath gets its legs.
> 
> In time I really do have aspirations to contribute more to NVMe
> multipathing.  I think Christoph's NVMe multipath implementation of
> bio-based device ontop on NVMe core's blk-mq device(s) is very clever
> and effective (blk_steal_bios() hack and all).

That's great.

>> Don't get me wrong, I do support your cause, and I think nvme should try
>> to help, I just think that subsystem granularity is not the correct
>> approach going forward.
> 
> I understand there will be limits to this 'mpath_personality' knob's
> utility and it'll need to evolve over time.  But the burden of making
> more advanced NVMe multipath features accessible outside of native NVMe
> isn't intended to be on any of the NVMe maintainers (other than maybe
> remembering to disallow the switch where it makes sense in the future).

I would expect that any "advanced multipath features" would be properly
brought up with the NVMe TWG as a ratified standard and find its way
to nvme. So I don't think this particularly is a valid argument.

>> As I said, I've been off the grid, can you remind me why global knob is
>> not sufficient?
> 
> Because once nvme_core.multipath=N is set: native NVMe multipath is then
> not accessible from the same host.  The goal of this patchset is to give
> users choice.  But not limit them to _only_ using dm-multipath if they
> just have some legacy needs.
> 
> Tough to be convincing with hypotheticals but I could imagine a very
> obvious usecase for native NVMe multipathing be PCI-based embedded NVMe
> "fabrics" (especially if/when the numa-based path selector lands).  But
> the same host with PCI NVMe could be connected to a FC network that has
> historically always been managed via dm-multipath.. but say that
> FC-based infrastructure gets updated to use NVMe (to leverage a wider
> NVMe investment, whatever?) -- but maybe admins would still prefer to
> use dm-multipath for the NVMe over FC.

You are referring to an array exposing media via nvmf and scsi
simultaneously? I'm not sure that there is a clean definition of
how that is supposed to work (ANA/ALUA, reservations, etc..)

>> This might sound stupid to you, but can't users that desperately must
>> keep using dm-multipath (for its mature toolset or what-not) just
>> stack it on multipath nvme device? (I might be completely off on
>> this so feel free to correct my ignorance).
> 
> We could certainly pursue adding multipath-tools support for native NVMe
> multipathing.  Not opposed to it (even if just reporting topology and
> state).  But given the extensive lengths NVMe multipath goes to hide
> devices we'd need some way to piercing through the opaque nvme device
> that native NVMe multipath exposes.  But that really is a tangent
> relative to this patchset.  Since that kind of visibility would also
> benefit the nvme cli... otherwise how are users to even be able to trust
> but verify native NVMe multipathing did what it expected it to?

Can you explain what is missing for multipath-tools to resolve topology?

nvme list-subsys is doing just that, doesn't it? It lists subsys-ctrl
topology but that is sort of the important information as controllers
are the real paths.
