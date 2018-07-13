Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE827ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B72208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Var1Hvgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B72208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbeGMKT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:19:26 -0400
Received: from 8bytes.org ([81.169.241.247]:37494 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbeGMKTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:19:25 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 73B8C377; Fri, 13 Jul 2018 12:05:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531476326; bh=DOlvZFeh1F+vhRlWVLM8hY8/3suxRydPy3yJRKzFccE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Var1HvgheYnUAMThyWCOhmRNKcDVxgulKY7QmbTabaDKc5HOxRB1Jp7spJlHe+gg5
         PUXydAGVg87eaDEVDMluDl/aSKo2KOWmZmxLUjK6geGgRJ7+st7T7y6O1rIH56p9gT
         jQt9Qa5w+dLoWE5dJj57sNH/Wy16u9HqVFKQxpP3IUDjqOZb8ILGnr8lkufK4zr1Zw
         tBUXm1RyUJRGXldiElSes6OKhr6kTnatb9MW2eRZH10HfTf9MNHjeqbkyro38R2ZJY
         Gg/QnyUGY+vcop6x+Mpzs63iEbwgaNV7bS1C78Jg0aIDW99li6hlyJwn8803KBWMnJ
         9/6NeNrHnanJA==
Date:   Fri, 13 Jul 2018 12:05:19 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>, jroedel@suse.de
Subject: Re: [PATCH 05/39] x86/entry/32: Unshare NMI return path
Message-ID: <20180713100519.pn7ium7a4ga24dys@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
 <1531308586-29340-6-git-send-email-joro@8bytes.org>
 <BEEA447A-26A1-49C9-925A-63F96E9115B0@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BEEA447A-26A1-49C9-925A-63F96E9115B0@amacapital.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 01:53:19PM -0700, Andy Lutomirski wrote:
> > On Jul 11, 2018, at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
> > NMI will no longer use most of the shared return path,
> > because NMI needs special handling when the CR3 switches for
> > PTI are added.
> 
> Why?  What would go wrong?
> 
> How many return-to-usermode paths will we have?  64-bit has only one.

In the non-NMI return path we make a decission on whether we return to
user-space or kernel-space and do different things based on that. For
example, when returning to user-space we call
prepare_exit_to_usermode(). With the CR3 switches added later we also
unconditionally switch to user-cr3 when we are in the return-to-user
path.

The NMI return path does not need any of that, as it doesn't call
prepare_exit_to_usermode() even when it returns to user-space. It
doesn't even care where it returns to. It just remembers stack and cr3
on entry in callee-safed registers and restores that on exit. This works
in the NMI path because it is pretty simple and doesn't do any fancy
work on exit.

While working on a previous version I also tried to store stack and cr3
in a callee-safed register and restore that on exit again, but it didn't
work, most likley because something in-between overwrote one of the
registers. I also found it a bit fragile to make make two registers
untouchable in the whole entry-code. It doesn't make future changes
simpler or more robust.

So long story short, the NMI path can be simpler wrt. stack and cr3
handling as the other entry/exit points, and therefore it is handled
differently.

Regards,

	Joerg

