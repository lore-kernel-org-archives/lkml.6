Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CC8C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5502064C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 13:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="dau/jQwL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB5502064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbeJXVoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 17:44:16 -0400
Received: from imap.thunk.org ([74.207.234.97]:52676 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbeJXVoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 17:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bBxSB3Vz4tdzpwUC7MA6Ml58QKYOxyWCVP1GvRwfYsc=; b=dau/jQwLkN6wuQgTUvkpNkl8Og
        zH5tTWa8mClAXqMJdAJJeADvHDnFBQw1RRfmGh4tpKOwx4aqp4Eo4w9EbKraOjKGREhFyZtb6D/90
        j025dQxVqvnT5sAB0GqyL4C6QbwTUuk5nP9qrvpDZsxRpNz/YcxDM6WQpusoPdjdtpdg=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1gFJ0e-0007sP-Sx; Wed, 24 Oct 2018 13:15:40 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D180F7A56C1; Wed, 24 Oct 2018 09:15:34 -0400 (EDT)
Date:   Wed, 24 Oct 2018 09:15:34 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     NeilBrown <neilb@suse.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-tip-commits@vger.kernel.org, jsimmons@infradead.org
Subject: Re: in_compat_syscall() returns from kernel thread for X86_32.
Message-ID: <20181024131534.GD11606@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        NeilBrown <neilb@suse.com>, Andy Lutomirski <luto@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-tip-commits@vger.kernel.org, jsimmons@infradead.org
References: <1460987025-30360-1-git-send-email-dsafonov@virtuozzo.com>
 <tip-abfb9498ee1327f534df92a7ecaea81a85913bae@git.kernel.org>
 <87h8hkc9fd.fsf@notabene.neil.brown.name>
 <CALCETrXB8PE4Ue0BeD0wUS9psLLjpv_pt+nj=SEaj+Nb_dZzUA@mail.gmail.com>
 <871s8ndg6a.fsf@notabene.neil.brown.name>
 <CALCETrWH342Y7jKHsYdT=_3fuyDkWhvQLK9z4PTs9jzbfoCVwg@mail.gmail.com>
 <871s8g6roy.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871s8g6roy.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:47:57PM +1100, NeilBrown wrote:
> 
> I doubt it was copied - more likely independent evolution.
> But on reflection, I see that it is probably reasonable that it
> shouldn't be used this way - or at all in this context.
> I'll try to understand what the issues really are and see if I can
> find a solution that doesn't depend on this interface.
> Thanks for your help.

At least for ext4, the primary problem is that we want to use a 64-bit
telldir/seekdir cookie if all 64-bits will make it to user space, and
a 32-bit telldir cookie if only 32 bits will make it userspace.  This
impacts NFS as well because if there are people who are still using
NFSv2, which has 32-bit directory offsets, we need to constrain the
telldir/seekdir cookies we give to NFS to be a 32 has as opposed to a
64-bit hash.

						- Ted
