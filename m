Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbeE3Ptu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:49:50 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33666 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeE3Ptm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:49:42 -0400
X-Google-Smtp-Source: ADUXVKKpTO71YlXZMQDs0Pkp54VZZaKzJjeKgpJYeQ94LPSo7O51KTqeau/DwpXJpfgrU6c1zKj/qQ==
Date: Wed, 30 May 2018 23:49:29 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Mike Leach <mike.leach@linaro.org>
Cc: Robert Walker <robert.walker@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Kim Phillips <kim.phillips@arm.co>,
        Tor Jeremiassen <tor@ti.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org
Subject: Re: [RFT v3 1/4] perf cs-etm: Generate branch sample for missed
 packets
Message-ID: <20180530154929.GB10925@leoy-ThinkPad-X240s>
References: <1527497103-3593-1-git-send-email-leo.yan@linaro.org>
 <1527497103-3593-2-git-send-email-leo.yan@linaro.org>
 <20180528221347.GA4109@xps15>
 <5efe804f-364b-6ae1-3fca-ec7f6d8a383d@arm.com>
 <CAJ9a7VhC7EHJ1DtTEH1uERGiBpCJgseboaH0cqgpsU3ZMcgjgQ@mail.gmail.com>
 <20180530153900.GA10925@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530153900.GA10925@leoy-ThinkPad-X240s>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 11:39:00PM +0800, Leo Yan wrote:
> Hi Mike,
> 
> On Wed, May 30, 2018 at 04:04:34PM +0100, Mike Leach wrote:
> 
> [...]
> 
> > >>> +               /* Generate sample for exception packet */
> > >>> +               if (etmq->prev_packet->exc == true)
> > >>> +                       generate_sample = true;
> > >>
> > >>
> > >> Please don't do that.  Exception packets have a type of their own and can
> > >> be
> > >> added to the decoder packet queue the same way INST_RANGE and TRACE_ON
> > >> packets
> > >> are.  Moreover exception packet containt an address that, if I'm reading
> > >> the
> > >> documenation properly, can be used to keep track of instructions that were
> > >> executed between the last address of the previous range packet and the
> > >> address
> > >> executed just before the exception occurred.  Mike and Rob will have to
> > >> confirm
> > >> this as the decoder may be doing all that hard work for us.
> > >>
> > 
> > clarification on the exception packets....
> > 
> > The Opencsd output exception packet gives you the exception number,
> > and optionally the preferred return address. If this address is
> > present does depend a lot on the underlying protocol - will normally
> > be there with ETMv4.
> > Exceptions are marked differently in the underlying protocol - the
> > OCSD packets abstract away these differences.
> > 
> > consider the code:
> > 
> > 0x1000: <some instructions>
> > 0x1100: BR 0x2000
> > ....
> > 0x2000: <some instructions>
> > 0x2020  BZ r4
> > 
> > Without an exception this would result in the packets
> > 
> > OCSD_RANGE(0x1000,0x1104, Last instr type=Br, taken)   // recall that
> > range packets have start addr inclusive, end addr exclusive.
> > OCSD_RANGE(0x2000,0x2024, Last instr type=Br, <taken / not taken -
> > depends on condition>
> > 
> > Now consider an exception occurring before the BR 0x2000
> > 
> > this will result in:-
> > OCSD_RANGE(0x1000, 0x1100, Last instr type=Other)
> > OCSD_EXECEPTION(IRQ, ret-addr 0x1100)
> > OCSD_RANGE(IRQ_START, IRQ_END+4, Last instr type = BR, taken)    //
> > this is more likely to have multiple ranges / branches before any
> > return, but simplified here.
> > OCSD_EXCEPTION_RETURN()  // present if exception returns are
> > explicitly marked in underlying trace - may not always be depending on
> > circumstances.
> > OCSD_RANGE(0x1100,0x1104, Last=BR, taken) // continue on with short
> > range - just the branch
> > OCSD_RANGE(0x2000,0x2024, Last instr type=Br, <taken / not taken -
> > depends on condition>
> > 
> > Now consider the exception occurring after the BR, but before any
> > other instructions are executed.
> > 
> > OCSD_RANGE(0x1000,0x1104, Last instr type=Br, taken)   // recall that
> > range packets have start addr inclusive, end addr exclusive.
> > OCSD_EXECEPTION(IRQ, ret-addr 0x2000)     // here the preferred return
> > address is actually the target of the branch.
> > OCSD_RANGE(IRQ_START, IRQ_END+4, Last instr type = BR, taken)    //
> > this is more likely to have multiple ranges / branches before any
> > return, but simplified here.
> > OCSD_RANGE(0x2000,0x2024, Last instr type=Br, <taken / not taken -
> > depends on condition>
> > 
> > So in general it is possible to arrive in the IRQ_START range with the
> > previous packet having been either a taken branch, a not taken branch,
> > or not a branch.
> > Care must be taken - whether AutoFDO or normal trace disassembly not
> > to assume that having the last range packet as a taken branch means
> > that the next range packet is the target, if there is an intervening
> > exception packet.
> 
> Thanks a lot for detailed explaination.
> 
> IIUC, AutoFDO will not have such issue due every range packet will be
> handled for it.  On the other hand, as you remind, the branch samples
> (and its consumer trace disassembler) is very dependent on the flag
> 'last_instr_taken_branch'.
> 
> According to your explaination, I think we consider the branch is
> taken for below situations:
> 
> - The new coming packet is exception packet (both for exception entry
>   and exit packets);
> - The previous packet is expcetion packet;
> - The previous packet is normal range packet with
>   'last_instr_taken_branch' = true;
> 
> So I'd like to use below function to demonstrate my understanding for
> exception packets handling.  I also will send out one new patch for
> support exception packet for reviewing.
> 
> If you have concern or I miss anything, please let me know.
> 
> static bool cs_etm__is_taken_branch(struct cs_etm_packet *prev_packet,
>                                     struct cs_etm_packet *packet,)
> {
>         /* The branch is taken for normal range packet with taken branch flag */
>         if (prev_packet->sample_type == CS_ETM_RANGE &&
>             prev_packet->last_instr_taken_branch)
>                 return true;
> 
>         /* The branch is taken if previous packet is exception packet */
>         if (prev_packet->sample_type == CS_ETM_EXCEPTION ||
>             prev_packet->sample_type == CS_ETM_EXCEPTION_RET)
>                 return true;
> 
>         /* The branch is taken for an intervening exception packet */
>         if (packet->sample_type == CS_ETM_EXCEPTION ||
>             packet->sample_type == CS_ETM_EXCEPTION_RET)
>                 return true;
> 
>         return false;
> }

Just clarify, I missed to mention I introduce two extra sample types:
CS_ETM_EXCEPTION and CS_ETM_EXCEPTION_RET, one is for exception
entry packet and another is for exception exit packet.   If this is
hard for understanding, you could hold on for reveiwing new patch.

Thanks,
Leo Yan
