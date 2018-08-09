Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACB0C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39AA21A88
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 07:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39AA21A88
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeHIKDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 06:03:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39134 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727237AbeHIKDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 06:03:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7B2D5F2B41;
        Thu,  9 Aug 2018 07:39:48 +0000 (UTC)
Received: from krava (unknown [10.40.205.2])
        by smtp.corp.redhat.com (Postfix) with SMTP id AE4502026D68;
        Thu,  9 Aug 2018 07:39:46 +0000 (UTC)
Date:   Thu, 9 Aug 2018 09:39:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu
Subject: Re: [PATCH] perf ordered_events: fix crash in free_dup_event()
Message-ID: <20180809073945.GA19243@krava>
References: <1533605015-19514-1-git-send-email-eranian@google.com>
 <20180807072029.GA7716@krava>
 <CABPqkBSyf0WMKmZAFGSyBvX=jn1zifbMPztt_053hvvDh6UsHw@mail.gmail.com>
 <20180807085010.GC7716@krava>
 <CABPqkBTvXSgJNPW=4MxFqDR_oeYHteuDoeavdFHKuXe+8Y=2DQ@mail.gmail.com>
 <20180808082347.GB20320@krava>
 <CABPqkBRwG_MzfJp1d7+4JKNemoD9cOWqJnXaBWQNR7buESKm2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBRwG_MzfJp1d7+4JKNemoD9cOWqJnXaBWQNR7buESKm2w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 09 Aug 2018 07:39:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Thu, 09 Aug 2018 07:39:48 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2018 at 02:47:42PM -0700, Stephane Eranian wrote:
> Hi,
> 
> Ok, I found the problem. It still exists upstream , just very tricky to trigger.
> Took me lots of time with gdb + watchpoints to track this down, where
> in fact it was just in front of me.
> 
> From the crashdump:
>   Program received signal SIGSEGV, Segmentation fault.
>   free_dup_event (oe=0x26a39a0, event=0xffffffff00000000)
> 
> I was puzzled by the 0xffffffff00000000. I tracked down where this
> value was coming from using watchpoints.
> In my case the memory was used before by elfutils to back the struct
> Elf. The -1 in the upper bits came from:
> 
> file_read_elf () at third_party/elfutils/libelf/elf_begin.c:451
> elf->state.elf64.scns.data[cnt].shndx_index = -1;
> 
> And yet the next access to that memory location was in the crash. That
> meant the memory was released by
> elfutils and reused by ordered_events, yet without any initialization.
> But looking at alloc_event(), it was
> not obvious to figure out how a new_event->event could be uninitialized.
> 
> Well, it turns out there is this little hack where the code
> commandeers the first element in the oe->buffer to
> use as a list_head for the oe->to_free freelist. The problem is that
> this entry also gets freed, but its
> event->event field is NEVER initialized. So depending on how the
> memory was previously used, you
> could get a on NULL value and crash in free_dup_event(). This is what
> happened to me. I am glad
> I pursued this further because the bug is still in the upstream
> version. The patch is a one-liner fixing
> the initialization of the event->event = NULL. For the other elements
> in the list, the initialization is
> already done at the end of alloc_event().
> 
> I will send the patch separately.

nice ;-) thanks

jirka
