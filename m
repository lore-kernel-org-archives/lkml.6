Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F980C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD69A2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD69A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeKBHXM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:23:12 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:51922 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbeKBHXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:23:11 -0400
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1gILI6-0005J2-60; Thu, 01 Nov 2018 23:18:14 +0100
Date:   Thu, 1 Nov 2018 23:18:14 +0100
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Kurt Roeckx <kurt@roeckx.be>,
        912087@bugs.debian.org,
        "Package Development List for OpenSSL packages." 
        <pkg-openssl-devel@alioth-lists.debian.net>,
        linux-kernel@vger.kernel.org,
        Bernhard =?utf-8?Q?=C3=9Cbelacker?= <bernhardu@mailbox.org>,
        pkg-systemd-maintainers@lists.alioth.debian.org,
        debian-ssh@lists.debian.org, 912087-submitter@bugs.debian.org
Subject: Re: Bug#912087: openssh-server: Slow startup after the upgrade to
 7.9p1
Message-ID: <20181101221813.qfglqvmzk47m53yx@breakpoint.cc>
References: <20181029223334.GH10011@roeckx.be>
 <20181030001807.7wailpm37mlinsli@breakpoint.cc>
 <20181030141544.GE15839@thunk.org>
 <20181030183723.GI10011@roeckx.be>
 <20181030205136.GB6236@thunk.org>
 <6BBD7CF1-696B-4B5E-ABD8-A30C2F15E5C5@breakpoint.cc>
 <20181031224106.GD6236@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181031224106.GD6236@thunk.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-31 18:41:06 [-0400], Theodore Y. Ts'o wrote:
> On Wed, Oct 31, 2018 at 11:21:59AM +0000, Sebastian Andrzej Siewior wrote:
> > On October 30, 2018 8:51:36 PM UTC, "Theodore Y. Ts'o" <tytso@mit.edu> wrote:
> > >
> > >So it's complicated.  It's not a binary trusted/untrusted sort of
> > >thing.  
> > 
> > What about RNDRESEEDCRNG? Would it be reasonable to issue it after writing the seed as part of the boot process?
> 
> No, that's for debugging purposes only.

Okay. I'm asking because it has been added to the kernel, marked stable
and the man page has not been updated. So it did not look like a
debugging interface :)

> When there is sufficient entropy added (either through a hw_random
> subsystem, or because RDRAND is trusted, or the RNDADDENTORPY ioctl),
> the crng is automatically reseeded by credit_entropy_bits().  So it's
> not needed to use RNDRESEEDCRNG.

Okay. So you wrote what can be done for a system with HW-RNG/kvm. On
bare metal with nothing fancy I have:
[    3.544985] systemd[1]: systemd 239 running in system mode. (+PAM…
[   10.363377] r8169 0000:05:00.0 eth0: link up
[   41.966375] random: crng init done

which means I have to wait about half a minute until I can ssh into. And
there is no way to speed it up?
You did not oppose RNDADDTOENTCNT/RNDADDENTROPY but you wanted to make
it configureable and not default, correct?

> 
> 					- Ted

Sebastian
