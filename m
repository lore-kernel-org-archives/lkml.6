Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C06C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2BBE20863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BBE20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbeK3BAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:00:24 -0500
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:35650 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbeK3BAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:00:23 -0500
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1gSMmG-00043N-DS; Thu, 29 Nov 2018 14:54:48 +0100
Date:   Thu, 29 Nov 2018 14:54:48 +0100
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Olaf van der Spek <olafvdspek@gmail.com>,
        Alok Kataria <akataria@vmware.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     912087@bugs.debian.org, Michael Biebl <biebl@debian.org>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: Bug#912087: reassign to systemd #912087 | openssh-server: Slow
 startup after the upgrade to 7.9p1
Message-ID: <20181129135446.jsrckfmy2urcsb5g@breakpoint.cc>
References: <20181126230521.twugjqastskgmolx@breakpoint.cc>
 <154070458824.7875.5742628083142648872.reportbug@mitsos>
 <68d6a356-bb0c-d879-4de3-db7a632bc162@debian.org>
 <20181127130935.4vh3pipxupzr2n6m@breakpoint.cc>
 <CAA7U3HN8aV-BrYGS4XNgXsfAL8eFcxdjReM-5VZOSnJntVanJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAA7U3HN8aV-BrYGS4XNgXsfAL8eFcxdjReM-5VZOSnJntVanJw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-28 13:43:07 [+0100], Olaf van der Spek wrote:
> > > They might just as well install haveged or configure virtio-rng in such
> > > a case.
> >
> > Right. Do you think, that it would necessary to add something to the
> > release notes?
> 
> I do. ;)
> What's the workaround for VMware?
> 
> Does it just take longer to start or do some services not start at all?

It will take longer to start, it will start. Let me pass that workaround
question to someone from vmware/virtualbox and #912087:

On a recent kernel you see something like that:
[   68.823013] random: crng init done

which means it took almost 69 seconds for the system to initialize its
rng. OpenSSH 7.9 can be compilied against OpenSSL 1.1.1 which in turn
switched to getrandom() (for its randomness).
This syscall will block until kernel's rng is ready which took in this
example almost 69 seconds.
Those "high" numbers are not a problem on decent/recent HW but occur
oftern on in virtualized environments.
For KVM we have CONFIG_HW_RANDOM_VIRTIO. Are there any plans to get
something similar for VMware/Vbox?

[0] http://bugs.debian.org/912087

Sebastian
