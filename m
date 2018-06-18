Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C80C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EEE20850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 19:14:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EEE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936119AbeFRTOx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 15:14:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935860AbeFRTOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 15:14:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8EF4B401BF87;
        Mon, 18 Jun 2018 19:14:51 +0000 (UTC)
Received: from darcari.bos.csb (dhcp-17-203.bos.redhat.com [10.18.17.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D553F2018063;
        Mon, 18 Jun 2018 19:14:50 +0000 (UTC)
Subject: Re: [PATCH] perf/x86: read the FREEZE_WHILE_SMM bit during boot
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Donald Zickus <dzickus@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>
References: <1528050223-144925-1-git-send-email-darcari@redhat.com>
 <20180604082414.GO12217@hirez.programming.kicks-ass.net>
 <e420bcc1-c75d-e6a1-0ca6-b668b6818f16@redhat.com>
 <20180612165635.GT12198@hirez.programming.kicks-ass.net>
From:   David Arcari <darcari@redhat.com>
Organization: Red Hat
Message-ID: <4fad5d31-0e04-2a1e-68e6-5512f8dd93bf@redhat.com>
Date:   Mon, 18 Jun 2018 15:14:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180612165635.GT12198@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 18 Jun 2018 19:14:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 18 Jun 2018 19:14:51 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'darcari@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 12:56 PM, Peter Zijlstra wrote:

> 
>> Ultimately, my solution was to restore the previous behavior by reading and
>> storing the firmware setting of the bit rather than to always clear it.
> 
> Ah, urgh.. what a mess. So the OS setting the bit to a known and
> consistent value is 'good' IMO. The firmware magically frobbing things
> is 'bad'.

I had actually considered changing the code to enable the FREEZE_WHILE_SMM by
default, but decided against this approach as I was concerned that setting the
bit on a system where it is initially cleared by the firmware could also have
negative side effects.

> 
> Now, explain to me why an IO-check results in an external NMI, and why
> there are long running SMI handlers around? Why can't the IO error not
> be propagated through the regular device interrupt/state? Why are long
> running SMIs required at all, ever? Why doesn't the OS handler whatever
> it is the SMM does?
> 
> Are you not solving the wrong problem here?
> 

I didn't think so.

1) This functionality was working reasonably well before this commit was
   introduced into the OS.

2) As discussed, the problem cannot be addressed in the NMI handler.

3) The work around that I proposed is quite unobtrusive. You are correct in
   this is not an actual "fix" since the problem will be present if the user
   decides to change the setting of FREEZE_WHILE_SMM via sysfs, but at least
   external NMIs are functional by default.

IIUC, you are proposing a complete rewrite of the external NMI infrastructure
along with modification to system firmware.  I also believe this would be
somewhat problematic as an external NMI would not function when interrupts are
disabled.

Is there an alternate solution that could provide relief in the short term?  I
think that what I have proposed accomplishes this, but perhaps there is a better
more palatable alternative.

