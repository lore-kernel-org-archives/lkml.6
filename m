Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF86C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3D020659
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 19:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3D020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeHOWnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 18:43:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728031AbeHOWnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 18:43:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36E86406E886;
        Wed, 15 Aug 2018 19:49:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3602510EE822;
        Wed, 15 Aug 2018 19:49:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id EF73722425E; Wed, 15 Aug 2018 15:49:32 -0400 (EDT)
Date:   Wed, 15 Aug 2018 15:49:32 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Yannik Sembritzki <yannik@sembritzki.me>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Justin M. Forbes" <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom platform
 keys to boot
Message-ID: <20180815194932.GD29541@redhat.com>
References: <20180815100053.13609-1-yannik@sembritzki.me>
 <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
 <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
 <20180815174247.GB29541@redhat.com>
 <20180815185812.GC29541@redhat.com>
 <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2649b70-37b6-3929-a9d0-3d82033b2686@sembritzki.me>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 15 Aug 2018 19:49:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 15 Aug 2018 19:49:35 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vgoyal@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 09:06:13PM +0200, Yannik Sembritzki wrote:
> 
> > I am wondering why did we have to split this keyring to begin with. 
> > So there are use cases where we want to trust builtin keys but
> > not the ones which came from other places (UEFI secure boot db, or
> > user loaded one)?
> >
> "User loaded ones" should not be trusted in general to prevent rootkits
> and similar from modifying the kernel (even if they have root).
> 
> According to the patch which introduced the secondary keyring (the one
> you mentioned), the requirements for adding keys to the secondary
> keyring are as follows:
> "Add a secondary system keyring that can be added to by root whilst the
> system is running - provided the key being added is vouched for by a key
> built into the kernel or already added to the secondary keyring."
> 

Right.

So it will become a question of should we trust a key which is
possibly dynamically loaded into the kernel, and which has been
trusted by an existing key. So this sounds like extending chain of
trust to a key which is dynamically loaded later. I feels reasonable
to me to extend chain of trust for kexec kernel. (Until and unless
somebody has a use case in mind where this is not a good idea).

I see that module signing code trusts only builtin keys and
not the keys in secondary_trusted_keys keyring.

Dave, what's the reason behind having two keyrings. Is it because
module signing code does not want to trust keys other than built-in
ones?

Thanks
Vivek



> I personally don't see a reason for this split, as the requirements for
> the secondary keyring are as strict as it can get. However, I'm new to
> this, so feel free to correct me.
> 
> Yannik
> 
