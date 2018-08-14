Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CE2C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0217F2172F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0217F2172F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387407AbeHNT5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:57:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:46340 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732943AbeHNT5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:57:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B98A18A;
        Tue, 14 Aug 2018 10:09:12 -0700 (PDT)
Received: from dupont (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C1233F5BD;
        Tue, 14 Aug 2018 10:09:11 -0700 (PDT)
Date:   Tue, 14 Aug 2018 12:09:10 -0500
From:   Kim Phillips <kim.phillips@arm.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ast@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, suzuki.poulosi@arm.com,
        linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/7] perf: Add ioctl for PMU driver configuration
Message-Id: <20180814120910.ed225bbc462c58b09e5d68de@arm.com>
In-Reply-To: <CANLsYkx=tjCG-eb4qRoGz0SvG4qCMDz1ajR9Mo9VK5XTAn_WdQ@mail.gmail.com>
References: <1531950487-24554-1-git-send-email-mathieu.poirier@linaro.org>
        <20180813124642.3d49c082a95fc294d926016e@arm.com>
        <CANLsYkx=tjCG-eb4qRoGz0SvG4qCMDz1ajR9Mo9VK5XTAn_WdQ@mail.gmail.com>
Organization: Arm
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2018 10:15:56 -0600
Mathieu Poirier <mathieu.poirier@linaro.org> wrote:

> On Mon, 13 Aug 2018 at 11:46, Kim Phillips <kim.phillips@arm.com> wrote:
> > It yields success for the --per-thread case..:
> >
> > $ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ --per-thread uname -a
> > Linux juno 4.18.0-rc8-00011-gb82af52c4b35-dirty #147 SMP PREEMPT Thu Aug 9 11:20:37 CDT 2018 aarch64 GNU/Linux
> > [ perf record: Woken up 0 times to write data ]
> > Warning:
> > AUX data lost 1 times out of 2!
> >
> > [ perf record: Captured and wrote 0.067 MB perf.data ]
> > $
> >
> > ..but not for CPU-wide?:
> >
> > $ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ uname -a
> > failed to mmap with 12 (Cannot allocate memory)
> > $ sudo taskset -c 0 ./perf record -e cs_etm/@20010000.etf/ -C 0 uname -a
> > failed to mmap with 12 (Cannot allocate memory)
> > $
> 
> This patchset is getting very old and a fair amount of things have
> changed since then.  I'm hoping to be coming out with a new one
> shortly.  Nonetheless the above is returning an error in CPU-wide
> scenarios while the feature is being implemented.  Isn't what you
> requested or have I misunderstood your comment?

No, sigh, I just automatically assumed the patchset would include
CPU-wide support again.  If it were being done that way, we'd all know
that the feature(s) this patchset adds would be doing the right thing
for that purpose, guaranteed.

The other thing that's going on here is that I'm becoming numb to the
loathsome "failed to mmap with 12 (Cannot allocate memory)" being
returned no matter what the error is/was.  E.g., an error that would
indicate a sense of non-implementation would be much better
appreciated than presumably what the above is doing, i.e., returning
-ENOMEM.  That, backed up with specific details in the form of human
readable text in dmesg would be *most* welcome.

Thanks,

Kim
