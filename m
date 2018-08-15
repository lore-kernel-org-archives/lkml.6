Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EF1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EA721530
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35EA721530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbeHPAvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 20:51:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727126AbeHPAvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 20:51:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E393C87A85;
        Wed, 15 Aug 2018 21:57:22 +0000 (UTC)
Received: from horse.redhat.com (ovpn-121-49.rdu2.redhat.com [10.10.121.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE71B2156712;
        Wed, 15 Aug 2018 21:57:18 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5830E22425E; Wed, 15 Aug 2018 17:57:18 -0400 (EDT)
Date:   Wed, 15 Aug 2018 17:57:18 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Yannik Sembritzki <yannik@sembritzki.me>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Justin Forbes <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom platform
 keys to boot
Message-ID: <20180815215718.GB15952@redhat.com>
References: <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
 <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
 <20180815174247.GB29541@redhat.com>
 <20180815185812.GC29541@redhat.com>
 <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
 <20180815194932.GD29541@redhat.com>
 <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
 <1ca6772b-46e0-9d93-0e15-7cf73a0b7b3f@sembritzki.me>
 <1534367597.4049.21.camel@HansenPartnership.com>
 <2872b945-60e7-b5d1-1f20-1ae6ecfd3967@sembritzki.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2872b945-60e7-b5d1-1f20-1ae6ecfd3967@sembritzki.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 15 Aug 2018 21:57:23 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Wed, 15 Aug 2018 21:57:23 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vgoyal@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 11:31:27PM +0200, Yannik Sembritzki wrote:
> On 15.08.2018 23:13, James Bottomley wrote:
> > Consider a UEFI system for which a user has taken ownership, but which
> > has some signed ROMs which are UEFI secure boot verified.  Simply to
> > get their system to boot the user will be forced to add the ODM key to
> > the UEFI db ... and I'm sure in that situation the user wouldn't want
> > to trust the ODM key further than booting.
> I definitely agree with this point.
> 
> Is there any solution, except from building your own kernel, to the
> scenario I described?
> I think there should be.
> (I've personally run into this with VirtualBox, which I IIRC couldn't
> load, even though I provisioned my own PK, and signed both kernel and
> VirtualBox module with my own key. I could've compiled my own kernel
> with my //own key, but that is pretty impractical for most users.)

Aha.., so that's your real problem. You are trying to load VirtualBox
module and that will not load even if you take ownership of platform
by adding your key and sign module with that key.

So this patch still will not fix the problem you are facing. It is still
good to fix the case of kexec/kdump broken on Fedora on secureboot
machines.

Thanks
Vivek
