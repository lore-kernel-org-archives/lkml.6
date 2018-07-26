Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1034CC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8ABE20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 03:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8ABE20846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sympatico.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbeGZFCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 01:02:15 -0400
Received: from belmont79srvr.owm.bell.net ([184.150.200.79]:38390 "EHLO
        mtlfep01.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726326AbeGZFCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 01:02:15 -0400
Received: from bell.net mtlfep01 184.150.200.30 by mtlfep01.bell.net
          with ESMTP
          id <20180726034728.DDOP10498.mtlfep01.bell.net@mtlspm02.bell.net>
          for <linux-kernel@vger.kernel.org>;
          Wed, 25 Jul 2018 23:47:28 -0400
Received: from arcusix ([67.71.42.39]) by mtlspm02.bell.net with ESMTP
          id <20180726034728.TUSK6415.mtlspm02.bell.net@arcusix>;
          Wed, 25 Jul 2018 23:47:28 -0400
Message-ID: <0432580c68060ed979433a04416cc19307fc5511.camel@sympatico.ca>
Subject: Re: [PATCH 0/3] PTI for x86-32 Fixes and Updates
From:   "David H. Gutteridge" <dhgutteridge@sympatico.ca>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 25 Jul 2018 23:47:21 -0400
In-Reply-To: <20180723072951.qesrz5pdnngtk455@suse.de>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org>
         <14206a19d597881b2490eb3fea47ee97be17ca93.camel@sympatico.ca>
         <20180723072951.qesrz5pdnngtk455@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cloudmark-Analysis: v=2.2 cv=IaFoYSia c=1 sm=0 tr=0 a=/4BQ6POolEllGJf7n1YyrQ==:17 a=IkcTkHD0fZMA:10 a=R9QF1RCXAYgA:10 a=HtA15Fq3rhd34ZHif-8A:9 a=QEXdDO2ut3YA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-23 at 09:29 +0200, Joerg Roedel wrote:
> Hey David,
> 
> On Sun, Jul 22, 2018 at 11:49:00PM -0400, David H. Gutteridge wrote:
> > Unfortunately, I can trigger a bug in KVM+QEMU with the Bochs VGA
> > driver. (This is the same VM definition I shared with you in a PM
> > back on Feb. 20th, except note that 4.18 kernels won't successfully
> > boot with QEMU's IDE device, so I'm using SATA instead. That's a
> > regression totally unrelated to your change sets, or to the general
> > booting issue with 4.18 RC5, since it occurs in vanilla RC4 as
> > well.)
> 
> Yes, this needs the fixes in the tip/x86/mm branch as well. Can you
> that branch in and test again, please?

Sorry, I didn't realize I needed those changes, too. I've re-tested
with those applied and haven't encountered any issues. I'm now
re-testing again with your newer patch set from the 25th. No issues
so far with those, either; I'll confirm in that email thread after
the laptop has seen some more use.

Dave


