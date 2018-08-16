Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EFBC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 186452147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="C4j62Kkw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 186452147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391808AbeHPRVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:21:24 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:42942 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbeHPRVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:21:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 172AB8EE171;
        Thu, 16 Aug 2018 07:22:28 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id r0dpHb5YEl3a; Thu, 16 Aug 2018 07:22:27 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4A9558EE092;
        Thu, 16 Aug 2018 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1534429347;
        bh=bizF8A69qAOKCl+60U/GAk7jQnP45PSxmWYka8JySLA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C4j62KkwsGLMEgW5GwJNcacwJxDaoF+UlwZtLJjlS7QhPhpwDD02byxEbOhjsfZIU
         IsiL65GVL+MVWy7uSPv4QldlH02w6GICkYy7AzDXJ9KBTeW2tjNXnALedfQmmtHDeQ
         di13hp5R8B+W4WmPLqe4GSzn6Tgm+8v7RQWSQSKg=
Message-ID: <1534429345.3166.1.camel@HansenPartnership.com>
Subject: Re: [PATCH] Fix kexec forbidding kernels signed with custom
 platform keys to boot
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     David Howells <dhowells@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     Yannik Sembritzki <yannik@sembritzki.me>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        "Justin M. Forbes" <jforbes@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>
Date:   Thu, 16 Aug 2018 07:22:25 -0700
In-Reply-To: <4911.1534421610@warthog.procyon.org.uk>
References: <20180815185812.GC29541@redhat.com>
         <20180815100053.13609-1-yannik@sembritzki.me>
         <CA+55aFx2goMXj7rQg-qx-puiiWYJmkDMU1xniWEu6ikDBNgfdQ@mail.gmail.com>
         <654fbafb-69da-cd9a-b176-7b03401e71c5@sembritzki.me>
         <20180815174247.GB29541@redhat.com>
         <4911.1534421610@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-08-16 at 13:13 +0100, David Howells wrote:
> Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > Now this patch changed it to trusting builtin_trusted_keys by
> > default, and all the other keys go to secondary_trusted_keys
> > kerying. And that probably explains why it broke.
> > 
> > So checking for keys in both the keyrings makes sense to me. 
> > 
> > I am wondering why did we have to split this keyring to begin
> > with. So there are use cases where we want to trust builtin keys
> > but not the ones which came from other places (UEFI secure boot db,
> > or user loaded one)?
> 
> IMA and the IMA authors.  They want everything separated into
> separate keyrings out by source and usage as far as I can tell -
> though this just makes it harder to use things.

Hey, it's not just IMA people.  I've told you several times you can't
use the secure boot keys for any form of trust beyond boot, so if you
want to add them to the kernel they have to be in a lesser trusted
keyring.  Anyone who values their security wants to be very careful
what the UEFI keys are trusted for ... it's not just IMA signatures as
the module signing discussion shows.

Personally, I don't see any use for the UEFI keys in the kernel beyond
kexec (where you can actually get the key directly from the UEFI
variable), so I'd prefer not to load them and not to have a secondary
keyring.

> One advantage of splitting things, though, is that you don't lose the
> built-in keys if you load a conflicting one from another source.
> 
> One thing that's on my to-do list is to mark keys with the
> provenance, perhaps
> something like:
> 
> 	enum key_source {
> 	     key_added_by_user,
> 	     key_built_in_for_modsign,
> 	     key_added_to_image,
> 	     key_from_uefi_db,
> 	     key_from_uefi_dbx,
> 	     key_from_tpm,
> 	};
> 
> 	struct key {
> 		...
> 		enum key_source	source;
> 	};
> 
> Then:
> 
>  (1) pass this information to LSMs to make use of
> 
>  (2) Make the verification code take a bitmask of what keys are
> permitted for
>      the task at hand.

Sounds reasonable,

James

