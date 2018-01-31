Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932227AbeAaPlk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 10:41:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33546 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932066AbeAaPlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 10:41:37 -0500
Date: Wed, 31 Jan 2018 16:41:28 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>, Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3 0/5] bugs fix for large PEBS mmap read and rdpmc read
Message-ID: <20180131154128.GA2812@krava>
References: <20180130150454.GE29098@krava>
 <35090c62-466a-aec8-b1a3-69def959c1c6@linux.intel.com>
 <CABPqkBRWtSsKEM7ycPs0HYSKLsYDmZhr4ztUmMMqsytYamPGsw@mail.gmail.com>
 <24210bcb-0e4b-58fe-bcda-da30019f6e7e@linux.intel.com>
 <20180130185212.GA16806@krava>
 <CABPqkBRp9bDmGECStbAHA5Ja0SjJmDQ2SOceat=qXno707MuAA@mail.gmail.com>
 <20180131035941.GW26209@tassilo.jf.intel.com>
 <20180131091539.GA3313@krava>
 <20180131131505.GB31614@krava>
 <b16cfe20-53e0-088b-f833-131e0e9e2210@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16cfe20-53e0-088b-f833-131e0e9e2210@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 10:15:33AM -0500, Liang, Kan wrote:
> 
> 
> On 1/31/2018 8:15 AM, Jiri Olsa wrote:
> > On Wed, Jan 31, 2018 at 10:15:39AM +0100, Jiri Olsa wrote:
> > > On Tue, Jan 30, 2018 at 07:59:41PM -0800, Andi Kleen wrote:
> > > > > Still, the part I am missing here, is why asking for
> > > > > PERF_SAMPLE_PERIOD voids large PEBS.
> > > > 
> > > > I think it was disabled together with frequency mode
> > > > (which we could support too, but it's a bit more work)
> > > > 
> > > > But yes PERIOD could probably be allowed.
> > > 
> > > looks like it's just a matter of adding PERF_SAMPLE_PERIOD
> > > into PEBS_FREERUNNING_FLAGS, we already populate period
> > > in setup_pebs_sample_data
> > > 
> > > jirka
> > > 
> > > 
> > > ---
> > > diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> > > index 8e4ea143ed96..78f91ec1056e 100644
> > > --- a/arch/x86/events/perf_event.h
> > > +++ b/arch/x86/events/perf_event.h
> > > @@ -93,7 +93,8 @@ struct amd_nb {
> > >   	PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_STREAM_ID | \
> > >   	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
> > >   	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
> > > -	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)
> > > +	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
> > > +	PERF_SAMPLE_PERIOD)
> > 
> > seems to work, getting large PEBS event for following command line:
> > 
> >    perf record -e cycles:P -c 100 --no-timestamp -C 0 --period
> > 
> > 
> 
> Yes, I tried the patch. The large PEBS can be enabled with the PERIOD flag.
> Everything looks good.
> 
> Jirka, could you please post the patch as well?

yes, will post that one as well

jirka
