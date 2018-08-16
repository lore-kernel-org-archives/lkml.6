Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8EAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19740208AD
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19740208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391393AbeHPPLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 11:11:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731460AbeHPPLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 11:11:47 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EA9794012970;
        Thu, 16 Aug 2018 12:13:34 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-130.rdu2.redhat.com [10.10.120.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CB6923141;
        Thu, 16 Aug 2018 12:13:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20180815185812.GC29541@redhat.com>
References: <20180815185812.GC29541@redhat.com> <20180815100053.13609-1-yannik@sembritzki.me> <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com> <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me> <20180815174247.GB29541@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     dhowells@redhat.com, Yannik Sembritzki <yannik@sembritzki.me>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Justin M. Forbes" <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@google.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom platform keys to boot
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4910.1534421610.1@warthog.procyon.org.uk>
Date:   Thu, 16 Aug 2018 13:13:30 +0100
Message-ID: <4911.1534421610@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 16 Aug 2018 12:13:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 16 Aug 2018 12:13:35 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> wrote:

> Now this patch changed it to trusting builtin_trusted_keys by default,
> and all the other keys go to secondary_trusted_keys kerying. And that
> probably explains why it broke.
> 
> So checking for keys in both the keyrings makes sense to me. 
> 
> I am wondering why did we have to split this keyring to begin with. 
> So there are use cases where we want to trust builtin keys but
> not the ones which came from other places (UEFI secure boot db, or
> user loaded one)?

IMA and the IMA authors.  They want everything separated into separate
keyrings out by source and usage as far as I can tell - though this just makes
it harder to use things.

One advantage of splitting things, though, is that you don't lose the built-in
keys if you load a conflicting one from another source.

One thing that's on my to-do list is to mark keys with the provenance, perhaps
something like:

	enum key_source {
	     key_added_by_user,
	     key_built_in_for_modsign,
	     key_added_to_image,
	     key_from_uefi_db,
	     key_from_uefi_dbx,
	     key_from_tpm,
	};

	struct key {
		...
		enum key_source	source;
	};

Then:

 (1) pass this information to LSMs to make use of

 (2) Make the verification code take a bitmask of what keys are permitted for
     the task at hand.

David
