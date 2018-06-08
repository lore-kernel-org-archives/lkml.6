Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hQgkIz9lGlvIJgAAmS7hNA
	; Fri, 08 Jun 2018 11:15:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7FA18607E4; Fri,  8 Jun 2018 11:15:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 115EC605A5;
	Fri,  8 Jun 2018 11:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 115EC605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeFHLPI (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 07:15:08 -0400
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:58502 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751108AbeFHLPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 07:15:07 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id E2975B870E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jun 2018 12:15:05 +0100 (IST)
Received: (qmail 1725 invoked from network); 8 Jun 2018 11:15:05 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[37.228.237.171])
  by 81.17.254.9 with ESMTPSA (DHE-RSA-AES256-SHA encrypted, authenticated); 8 Jun 2018 11:15:05 -0000
Date: Fri, 8 Jun 2018 12:15:05 +0100
From: Mel Gorman <mgorman@techsingularity.net>
To: Jirka Hladky <jhladky@redhat.com>
Cc: Jakub Racek <jracek@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [4.17 regression] Performance drop on kernel-4.17 visible on
 Stream, Linpack and NAS parallel benchmarks
Message-ID: <20180608111505.qlru36ycih6eltqc@techsingularity.net>
References: <20180606122731.GB27707@jra-laptop.brq.redhat.com>
 <20180607123915.avrqbpp4adgj7ck4@techsingularity.net>
 <CAE4VaGBAZ0HCy-M2rC3ce9ePOBhE6H-LDVBuJDJMNFf40j70Aw@mail.gmail.com>
 <20180608074057.jtxczsw3jwx6boti@techsingularity.net>
 <CAE4VaGAgC7vDwaa-9AzJYst9hdQ5KbnrBUnk_mfp=NeTEe5dAQ@mail.gmail.com>
 <20180608092451.mwzr6pvxh2cprzju@techsingularity.net>
 <CAE4VaGATk3_Hr_2Wh44BZvXDc06A=rxUZXRFj+D=Xwh2x1YOyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAE4VaGATk3_Hr_2Wh44BZvXDc06A=rxUZXRFj+D=Xwh2x1YOyg@mail.gmail.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 01:02:54PM +0200, Jirka Hladky wrote:
> >
> > Unknown and unknowable. It depends entirely on the reference pattern of
> > the different threads. If they are fully parallelised with private buffers
> > that are page-aligned then I expect it to be quick (to pass the 2-reference
> > filter).
> 
> 
> I'm running 20 parallel processes. There is no connection between them. If
> I read it correctly the migration should happen fast in this case, right?
> 
> I have checked the source code and variables are global and static (and
> thus allocated in the data segment). They are NOT 4k aligned:
> 
> variable a is at address: 0x9e999e0
> variable b is at address: 0x524e5e0
> variable c is at address: 0x6031e0
> 
> static double a[N],
> b[N],
> c[N];
> 

If these are 20 completely indepent processes (and not sharing data via
MPI if you're using that version of STREAM) then the migration should be
relatively quick. Migrations should start within 3 seconds of the process
starting. How long it takes depends on the size of the STREAM processes
as it's only scanned in chunks and migrations won't start until there
are two full passes of the address space. You can partially monitor the
progress using /proc/pid/numa_maps. More detailed monitoring needs ftrace
for some activity and the use of probes on specific functions to get
detailed information.

It may also be worth examining /proc/pid/sched and seeing if a task
sets numa_preferred_nid to node 0 and keeps it there even after
migrating to node 1 but that's doubtful.

-- 
Mel Gorman
SUSE Labs
