Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA31C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 02:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB7320820
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 02:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="vHwk6qCL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB7320820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeKBLTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 07:19:01 -0400
Received: from imap.thunk.org ([74.207.234.97]:56036 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbeKBLTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 07:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=k4z3ONInjNqKX6QJPPuNK1qhfsiyeZs0ZmD1UAsPUYQ=; b=vHwk6qCLc2Pc9hXpew0ieoFgST
        clXnlbTJ/0UJMoua/enAfIZ0Ec/wUQ5y1XmjbEV26pjAxFn8aZfLOJnKEHFA2VBXkeQrca4VQ+hrq
        ll8U93Ghs3dMXjrlhoTpf3oJ4p8/hLovvqt14OnUFHd2pZrQFTWfnjq+TkyRSK6cpjA4=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gIOxb-0008Fd-Kp; Fri, 02 Nov 2018 02:13:19 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 339727A7A7D; Thu,  1 Nov 2018 22:13:18 -0400 (EDT)
Date:   Thu, 1 Nov 2018 22:13:18 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Kurt Roeckx <kurt@roeckx.be>
Cc:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        912087@bugs.debian.org,
        "Package Development List for OpenSSL packages." 
        <pkg-openssl-devel@alioth-lists.debian.net>,
        linux-kernel@vger.kernel.org,
        Bernhard =?iso-8859-1?Q?=DCbelacker?= <bernhardu@mailbox.org>,
        pkg-systemd-maintainers@lists.alioth.debian.org,
        debian-ssh@lists.debian.org, 912087-submitter@bugs.debian.org
Subject: Re: Bug#912087: openssh-server: Slow startup after the upgrade to
 7.9p1
Message-ID: <20181102021318.GA5902@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Kurt Roeckx <kurt@roeckx.be>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        912087@bugs.debian.org,
        "Package Development List for OpenSSL packages." <pkg-openssl-devel@alioth-lists.debian.net>,
        linux-kernel@vger.kernel.org,
        Bernhard =?iso-8859-1?Q?=DCbelacker?= <bernhardu@mailbox.org>,
        pkg-systemd-maintainers@lists.alioth.debian.org,
        debian-ssh@lists.debian.org, 912087-submitter@bugs.debian.org
References: <20181029223334.GH10011@roeckx.be>
 <20181030001807.7wailpm37mlinsli@breakpoint.cc>
 <20181030141544.GE15839@thunk.org>
 <20181030183723.GI10011@roeckx.be>
 <20181030205136.GB6236@thunk.org>
 <6BBD7CF1-696B-4B5E-ABD8-A30C2F15E5C5@breakpoint.cc>
 <20181031224106.GD6236@thunk.org>
 <20181101221813.qfglqvmzk47m53yx@breakpoint.cc>
 <20181101235035.GC25621@thunk.org>
 <20181102002424.GD1547@roeckx.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102002424.GD1547@roeckx.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 01:24:25AM +0100, Kurt Roeckx wrote:
> Anyway, on my laptop I get:
> [   12.675935] random: crng init done
> 
> If the TPM is enabled, I also have an /etc/hwrng, but rng-tools is
> started later after the init is done.
> 
> On my desktop (with a chaos key attached)
> [    3.844484] random: crng init done
> [    5.312406] systemd[1]: systemd 239 running in system mode.

Starting with the 3.17 kernel, the kernel will automatically pull from
hardware random number generators without needing to install a user
space daemon, such as rng-tools.  For most hardware devices, it is not
enabled by default, so you have to enable by adding something like
"rng_core.default_quality=700" to the kernel boot line.

There are *two* devices which are an exception to this rule.  The
first is virtio_rng, since the assumption is if you are using a VM,
you had better trust the host infrastructure or you have much worse
problems.  The second is the driver for the Chaos Key.  That appears
to be because the author of the driver for the Chaos Key wasn't aware
of the general policy that hardware rng's shouldn't be trusted by
default, and the driver was coded violating that policy.

This is why (with a chaos key attached) you see the "crng init done"
message so early, *before* the root file system is mounted.  (The root
file system gets mounted after the "systemd running in system mode"
message is logged.)

This is better than relying on rng-toonls, since we can initialize the
CRNG must earlier in the boot process.  (It should have been the case
that this would only happen if you configured by setting the
rng_core.default_quality parameter, but see above about how the Chaos
Key driver is currently violating policy.)

In the future I should change the kernel so you can explicitly specify
something like tpm.rng_quality=500 and chaos_key.rng_quality=1000 on
the boot command line.  That way the system administrator can be very
explicit about which hwrng they trust; right now what we have is not
ideal since it's not clear which hwrng the system administrator wanted
to configure as trusted, and if you have more than one hwnrg in the
system (say, a closed source, proprietary tpm, and an open hardware
Chaos Key) you can't say which one you want to have trusted.

Cheers,

						- Ted
