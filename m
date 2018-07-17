Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6BAECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097F12084E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097F12084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sympatico.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbeGQCqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:46:12 -0400
Received: from simcoe209srvr.owm.bell.net ([184.150.200.209]:36504 "EHLO
        torfep06.bell.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbeGQCqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:46:12 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Jul 2018 22:46:11 EDT
Received: from bell.net torfep02 184.150.200.158 by torfep02.bell.net
          with ESMTP
          id <20180717020750.ZUCU32387.torfep02.bell.net@torspm01.bell.net>
          for <linux-kernel@vger.kernel.org>;
          Mon, 16 Jul 2018 22:07:50 -0400
Received: from arcusix ([67.71.42.39]) by torspm01.bell.net with ESMTP
          id <20180717020750.QKNW26298.torspm01.bell.net@arcusix>;
          Mon, 16 Jul 2018 22:07:50 -0400
Message-ID: <18439b1a3755a6bfd8f96b1866c328ada1db0aa8.camel@sympatico.ca>
Subject: Re: [PATCH 00/39 v7] PTI support for x86-32
From:   "David H. Gutteridge" <dhgutteridge@sympatico.ca>
To:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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
        jroedel@suse.de
Date:   Mon, 16 Jul 2018 22:07:44 -0400
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cloudmark-Analysis: v=2.2 cv=DZT4krlW c=1 sm=0 tr=0 a=/4BQ6POolEllGJf7n1YyrQ==:17 a=IkcTkHD0fZMA:10 a=R9QF1RCXAYgA:10 a=D19gQVrFAAAA:8 a=xGJFdQoOOyYT9RtmLrQA:9 a=QEXdDO2ut3YA:10 a=W4TVW4IDbPiebHqcZpNg:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 13:29 +0200, Joerg Roedel wrote:
> Hi,
> 
> here is version 7 of my patches to enable PTI on x86-32.
> Changes to the previous version are:
> 
> 	* Rebased to v4.18-rc4
> 
> 	* Introduced pti_finalize() which is called after
> 	  mark_readonly() and used to update the kernel
> 	  mappings in the user page-table after RO/NX
> 	  protections are in place.
> 
> The patches need the vmalloc/ioremap fixes in tip/x86/mm to
> work correctly, because this enablement makes the issues
> fixed there more likely to happen.

Hi Joerg & *,

I redid my testing on bare metal and in a VM (as with my previous
testing
efforts: https://lkml.org/lkml/2018/2/19/844, same setups
and coverage,
plus CONFIG_X86_DEBUG_ENTRY_CR3 enabled too) with the
pti-x32-v7 branch,
and I didn't encounter any issues. The two DRM
drivers that were
triggering bugs in some of the prior iterations
are both behaving
properly for me.

Regards,

Dave

