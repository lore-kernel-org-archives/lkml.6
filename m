Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DD8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC652170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:31:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECC652170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbeI1AvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:51:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54931 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbeI1AvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:51:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 712C53001FCD;
        Thu, 27 Sep 2018 18:31:47 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40DDD752CA;
        Thu, 27 Sep 2018 18:31:42 +0000 (UTC)
Date:   Thu, 27 Sep 2018 14:31:41 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        helen.koike@collabora.com,
        device-mapper development <dm-devel@redhat.com>,
        Alasdair G Kergon <agk@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Will Drewry <wad@chromium.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-lvm@redhat.com, kernel@collabora.com
Subject: Re: [PATCH 0/2] boot to a mapped device
Message-ID: <20180927183141.GA4921@redhat.com>
References: <cover.1537936397.git.helen.koike@collabora.com>
 <CAFLxGvzCDOTR4stPmp1TTLkQ39x3e8MQuL=AR754abKc5skhpA@mail.gmail.com>
 <20180927142328.GA4074@redhat.com>
 <CAGXu5j+Y5e_oTZVCAHa48XgVcvEKGnVW_74oXZOUyLnfYPAjAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+Y5e_oTZVCAHa48XgVcvEKGnVW_74oXZOUyLnfYPAjAg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 27 Sep 2018 18:31:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27 2018 at 12:36pm -0400,
Kees Cook <keescook@chromium.org> wrote:

> On Thu, Sep 27, 2018 at 7:23 AM, Mike Snitzer <snitzer@redhat.com> wrote:
> > On Wed, Sep 26 2018 at  3:16am -0400,
> > Richard Weinberger <richard.weinberger@gmail.com> wrote:
> >
> >> Helen,
> >>
> >> On Wed, Sep 26, 2018 at 7:01 AM Helen Koike <helen.koike@collabora.com> wrote:
> >> >
> >> > This series is reviving an old patchwork.
> >> > Booting from a mapped device requires an initramfs. This series is
> >> > allows for device-mapper targets to be configured at boot time for
> >> > use early in the boot process (as the root device or otherwise).
> >>
> >> What is the reason for this patch series?
> >> Setting up non-trivial root filesystems/storage always requires an
> >> initramfs, there is nothing
> >> wrong about this.
> >
> > Exactly.  If phones or whatever would benefit from this patchset then
> > say as much.
> 
> I think some of the context for the series was lost in commit logs,
> but yes, both Android and Chrome OS do not use initramfs. The only
> thing that was needed to do this was being able to configure dm
> devices on the kernel command line, so the overhead of a full
> initramfs was seen as a boot time liability, a boot image size
> liability (e.g. Chrome OS has a limited amount of storage available
> for the boot image that is covered by the static root of trust
> signature), and a complexity risk: everything that is needed for boot
> could be specified on the kernel command line, so better to avoid the
> whole initramfs dance.
> 
> So, instead, this plumbs the dm commands directly instead of bringing
> up a full userspace and performing ioctls.
> 
> > I will not accept this patchset at this time.
> >
> >> > Example, the following could be added in the boot parameters.
> >> > dm="lroot,,,rw, 0 4096 linear 98:16 0, 4096 4096 linear 98:32 0" root=/dev/dm-0
> >>
> >> Hmmm, the new dm= parameter is anything but easy to get right.
> >
> > No, it isn't.. exposes way too much potential for users hanging
> > themselves.
> 
> IIRC, the changes in syntax were suggested back when I was trying to
> drive this series:
> https://www.redhat.com/archives/dm-devel/2016-February/msg00199.html
> 
> And it matches the "concise" format in dmsetup:
> https://sourceware.org/git/?p=lvm2.git;a=commit;h=827be01758ec5adb7b9d5ea75b658092adc65534
> 
> What do you feel are next steps?

There is quite a lot of init/ code, to handle parsing the concise DM
format, that is being proposed for inclusion.  I question why that
DM-specific code would be located in init/

There also needs to be a careful comparison done between the proposed
init/ code to support consise DM format and the userspace lvm2
equivalent (e.g. lvm2.git commit 827be0175)

That aside, the DM targets that are allowed to be supported by this dm=
commandline boot interface must be constrained (there are serious risks
in allowing activation of certain DM targets without first using
userspace tools to check the validity of associated metadata, as is done
by the DM thin and cache targets).  Also, all targets supported must be
upstream.  "linear", "verity" and "bootcache" DM targets are referenced
in Documentation, "bootcache" must be a Google target.  I'm not aware of
it.

Mike
