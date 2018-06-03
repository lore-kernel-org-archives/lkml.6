Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751182AbeFCQGd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 12:06:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46206 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750789AbeFCQGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 12:06:31 -0400
Date: Sun, 3 Jun 2018 12:06:27 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
        Laurence Oberman <loberman@redhat.com>, Ewan Milne <emilne@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Martin George <marting@netapp.com>,
        John Meneghini <John.Meneghini@netapp.com>, axboe@kernel.dk
Subject: Re: [PATCH 0/3] Provide more fine grained control over multipathing
Message-ID: <20180603160626.GA4361@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de>
 <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <20180530220206.GA7037@redhat.com>
 <20180531163311.GA30954@lst.de>
 <20180531181757.GB11848@redhat.com>
 <yq17enjut3q.fsf@oracle.com>
 <20180601042441.GB14244@redhat.com>
 <0a0d4ff8-fe06-5869-cd18-a8c99b5e86f6@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0d4ff8-fe06-5869-cd18-a8c99b5e86f6@grimberg.me>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03 2018 at  7:00P -0400,
Sagi Grimberg <sagi@grimberg.me> wrote:

> 
> >I'm aware that most everything in multipath.conf is SCSI/FC specific.
> >That isn't the point.  dm-multipath and multipathd are an existing
> >framework for managing multipath storage.
> >
> >It could be made to work with NVMe.  But yes it would not be easy.
> >Especially not with the native NVMe multipath crew being so damn
> >hostile.
> 
> The resistance is not a hostile act. Please try and keep the
> discussion technical.

This projecting onto me that I've not been keeping the conversation
technical is in itself hostile.  Sure I get frustrated and lash out (as
I'm _sure_ you'll feel in this reply) but I've been beating my head
against the wall on the need for native NVMe multipath and dm-multipath
to coexist in a fine-grained manner for literally 2 years!

But for the time-being I was done dwelling on the need for a switch like
mpath_personality.  Yet you persist.  If you read the latest messages in
this thread [1] and still elected to send this message, then _that_ is a
hostile act.  Because I have been nothing but informative.  The fact you
choose not to care, appreciate or have concern for users' experience
isn't my fault.

And please don't pretend like the entire evolution of native NVMe
multipath was anything but one elaborate hostile act against
dm-multipath.  To deny that would simply discredit your entire
viewpoint on this topic.

Even smaller decisions that were communicated in person and then later
unilaterally reversed were hostile.  Examples:
1) ANA would serve as a scsi device handler like (multipath agnostic)
   feature to enhance namespaces -- now you can see in the v2
   implemation that certainly isn't the case
2) The dm-multipath path-selectors were going to be elevated for use by
   both native NVMe multipath and dm-multipath -- now people are
   implementing yet another round-robin path selector directly in NVMe.

I get it, Christoph (and others by association) are operating from a
"winning" position that was hostiley taken and now the winning position
is being leveraged to further ensure dm-multipath has no hope of being a
viable alternative to native NVMe multipath -- at least not without a
lot of work to refactor code to be unnecessarily homed in the
CONFIG_NVME_MULTIPATH=y sandbox.

> >>But I don't think the burden of allowing multipathd/DM to inject
> >>themselves into the path transition state machine has any benefit
> >>whatsoever to the user. It's only complicating things and therefore we'd
> >>be doing people a disservice rather than a favor.
> >
> >This notion that only native NVMe multipath can be successful is utter
> >bullshit.  And the mere fact that I've gotten such a reaction from a
> >select few speaks to some serious control issues.
> >
> >Imagine if XFS developers just one day imposed that it is the _only_
> >filesystem that can be used on persistent memory.
> >
> >Just please dial it back.. seriously tiresome.
> 
> Mike, you make a fair point on multipath tools being more mature
> compared to NVMe multipathing. But this is not the discussion at all (at
> least not from my perspective). There was not a single use-case that
> gave a clear-cut justification for a per-subsystem personality switch
> (other than some far fetched imaginary scenarios). This is not unusual
> for the kernel community not to accept things with little to no use,
> especially when it involves exposing a userspace ABI.

The interfaces dm-multipath and multipath-tools provide are exactly the
issue.  SO which is it, do I have a valid usecase, like you indicated
before [2] or am I just talking non-sense (with hypotehticals because I
was baited to do so)?  NOTE: even in your [2] reply you also go on to
say that "no one is forbidden to use [dm-]multipath." when the reality
is users will be as-is.

If you and others genuinely think that disallowing dm-multipath from
being able to manage NVMe devices if CONFIG_NVME_MULTIPATH is enabled
(and not shutoff via nvme_core.multipath=N) is a reasonable action then
you're actively complicit in limiting users from continuing to use the
long-established dm-multipath based infrastructure that Linux has had
for over 10 years.

There is literally no reason why they need to be mutually exclussive
(other than to grant otherwise would errode the "winning" position hch
et al have been operating from).
The implemetation of the switch to allow fine-grained control does need
proper care and review and buy-in.  But I'm sad to see there literally
is zero willingness to even acknowledge that it is "the right thing to
do".

> As for now, all I see is a disclaimer saying that it'd need to be
> nurtured over time as the NVMe spec evolves.
> 
> Can you (or others) please try and articulate why a "fine grained"
> multipathing is an absolute must? At the moment, I just don't
> understand.

Already made the point multiple times in this thread [3][4][5][1].
Hint: it is about the users who have long-standing expertise and
automation built around dm-multipath and multipath-tools.  BUT those
same users may need/want to simultaneously use native NVMe multipath on
the same host.  Dismissing this point or acting like I haven't
articulated it just illustrates to me continuing this conversation is
not going to be fruitful.

Mike

[1] https://lkml.org/lkml/2018/6/1/562
[2] https://lkml.org/lkml/2018/5/31/175
[3] https://lkml.org/lkml/2018/5/29/230
[4] https://lkml.org/lkml/2018/5/29/1260
[5] https://lkml.org/lkml/2018/5/31/707
