Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55A6C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9C921473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 10:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LCATvn00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9C921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJCRCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 13:02:06 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46070 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbeJCRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 13:02:06 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A4F4D8EE23D;
        Wed,  3 Oct 2018 03:14:20 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id s4rnvWXcFXsh; Wed,  3 Oct 2018 03:14:11 -0700 (PDT)
Received: from [172.16.135.230] (unknown [217.16.13.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 7460B8EE0E9;
        Wed,  3 Oct 2018 03:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1538561637;
        bh=pCGXyBme1H1lJ7eg8YSUxt6SBr3Nw32p6JI/La9s9Ow=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LCATvn00xn4sfbLbjdyRfPnZUaJveKGsMlEJK65tH6E/+Nz19UdbszxVTc4Ofm1yR
         pkxPUZRAaREmMoB5IYP2KayNPC2fa6IcacAIRMQqkk4STfZi3p+/0lnUx1DCZ77AgV
         km+h+aaUvTawQGKZsfHKGn/1gnwi1ocPLZheuJs8=
Message-ID: <1538561623.7448.5.camel@HansenPartnership.com>
Subject: Re: [RFC v2 v2 0/1] ns: introduce binfmt_misc namespace
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 03 Oct 2018 12:13:43 +0200
In-Reply-To: <a9997ce3-d63d-44b4-6a2a-09fd207a1550@vivier.eu>
References: <20181002102054.13245-1-laurent@vivier.eu>
         <1538496810.14607.5.camel@HansenPartnership.com>
         <a9997ce3-d63d-44b4-6a2a-09fd207a1550@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-02 at 18:47 +0200, Laurent Vivier wrote:
> Le 02/10/2018 à 18:13, James Bottomley a écrit :
> > On Tue, 2018-10-02 at 12:20 +0200, Laurent Vivier wrote:
> > > v2: no new namespace, binfmt_misc data are now part of
> > >     the mount namespace
> > >     I put this in mount namespace instead of user namespace
> > >     because the mount namespace is already needed and
> > >     I don't want to force to have the user namespace for that.
> > >     As this is a filesystem, it seems logic to have it here.
> > > 
> > > This allows to define a new interpreter for each new container.
> > > 
> > > But the main goal is to be able to chroot to a directory
> > > using a binfmt_misc interpreter without being root.
> > 
> > Reading all this, I don't quite understand why this works for me
> > and
> > not for you (I think I get from your explanation that it doesn't
> > work
> > for you, but I might have missed something):
> > 
> > jejb@jarvis:~> uname -m
> > x86_64
> > jejb@jarvis:~> unshare -r -m
> > root@jarvis:~# chroot /home/jejb/containers/aarch64
> > jarvis:/ # uname -m
> > aarch64
> > 
> > Of course to get that to work I have an 'F' entry in
> > /etc/binfmt.d/qemu-aarch64.conf
> > 
> 
> I'd like to configure the interpreter without being root.
> 
> As a simple user can run a VM and a full system inside, I'd like to
> be
> able to start a container/chroot without having to configure
> something
> at the host level.
> 
> For instance, I'd like to provide to "someone" (with no admin rights)
> a tar file with inside an OS environment for a given target and the
> interpreter, and allow him to run the binaries inside just by running
> a simple command (like qemu-system-XXX -hda my.img)

OK, since trying to persuade the distros to add the 'F' flag has been
challenging, I certainly buy this use case.

There is a security risk to allowing an unprivileged user to supply an
arbitrary interpreter (suid and sgid binaries), but as long as
whatever's agreed requires root in the user namespace, I'm happy we
have the security issue confined.

James


> It's also interesting for a test purpose: I can test concurrently
> different interpreters for the same target without modifying the
> target root filesystem (with the 'F' flag but on a per directory
> basis) or the host configuration.
> 
> Another case is we can't configure qemu-mips/qemu-mipsel (old kernel
> API) and qemu-mipsn32/qemu-mipsne32el (new kernel API) interpreters
> on the same system because they share the same ELF signature (to be
> honest qemu should have only one binary for the old and the new
> interface and dynamically change it according to the ELF binary that
> is loaded, as it is done for ARM).
> 
> But if no one thinks it's useful, I don't want to push this more than
> that...
> 
> Thanks,
> Laurent
> _______________________________________________
> Containers mailing list
> Containers@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/containers

