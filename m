Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB32C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E2021530
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E2021530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeHPAqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 20:46:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727501AbeHPAqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 20:46:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B2EB26351;
        Wed, 15 Aug 2018 21:52:43 +0000 (UTC)
Received: from horse.redhat.com (ovpn-121-49.rdu2.redhat.com [10.10.121.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6F4D2026D7E;
        Wed, 15 Aug 2018 21:52:40 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7A66E22425E; Wed, 15 Aug 2018 17:52:40 -0400 (EDT)
Date:   Wed, 15 Aug 2018 17:52:40 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Yannik Sembritzki <yannik@sembritzki.me>,
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
Message-ID: <20180815215240.GA15952@redhat.com>
References: <20180815100053.13609-1-yannik@sembritzki.me>
 <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
 <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
 <20180815174247.GB29541@redhat.com>
 <20180815185812.GC29541@redhat.com>
 <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
 <20180815194932.GD29541@redhat.com>
 <CA+55aFzRHVXP4Ag4aygao1dTGaaMJZSOisHT2ks3_WP97kLLhQ@mail.gmail.com>
 <1ca6772b-46e0-9d93-0e15-7cf73a0b7b3f@sembritzki.me>
 <1534367597.4049.21.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534367597.4049.21.camel@HansenPartnership.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 15 Aug 2018 21:52:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 15 Aug 2018 21:52:43 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vgoyal@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 02:13:17PM -0700, James Bottomley wrote:
> On Wed, 2018-08-15 at 23:08 +0200, Yannik Sembritzki wrote:
> > On 15.08.2018 22:47, Linus Torvalds wrote:
> > > It basically says: we don't allow modules that weren't built with
> > > the kernel. Adding a new key later and signing a module with it
> > > violates that premise.
> > 
> > Considering the following scenario:
> > A user is running a distro kernel, which is built by the distro, and
> > has the distro signing key builtin (i.e. fedora). Now, the user has
> > taken ownership of their system and provisioned their own platform
> > key. Accordingly, the user signs the distro kernel with their own
> > key.
> > 
> > If I understand you correctly, modules signed by the users own key,
> > but not signed with the distro key, will stop working in this case?
> 
> They never actually would have worked, but yes.
> 
> > IMO, this is not okay. The layer of trust should extend from the
> > bottom (user-provisioned platform key) up. Only trusting the kernel
> > builtin key later on (wrt. kernel modules) contradicts this
> > principal.
> 
> The kernel can't tell whether the UEFI user has taken ownership or not
> so it has no basis on which to make a decision to trust the UEFI keys
> or not, so we should *always* not trust them.
> 
> Consider a UEFI system for which a user has taken ownership, but which
> has some signed ROMs which are UEFI secure boot verified.  Simply to
> get their system to boot the user will be forced to add the ODM key to
> the UEFI db ... and I'm sure in that situation the user wouldn't want
> to trust the ODM key further than booting.

IIUC, it is fine to trust these ODM keys, User keys and "foo" keys for loading
kernel but not for modules? If yes, then atleast we can enable trusting
keys in .secondary_trusted_keys keyring for kernel signature verificaton
and that will solve the kexec/kdump issue on distribution kernels.

Thanks
Vivek
