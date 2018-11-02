Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46E5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717582081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717582081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeKCFml convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:42:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbeKCFml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:42:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 474A1307D850;
        Fri,  2 Nov 2018 20:34:06 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-8.bos.redhat.com [10.18.17.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A761600CD;
        Fri,  2 Nov 2018 20:34:05 +0000 (UTC)
Subject: Re: [RFC PATCH] x86/mm/fault: Allow stack access below %rsp
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <1541187610-5322-1-git-send-email-longman@redhat.com>
 <a3584dd1-c030-cebe-3f3d-eadc0744580a@intel.com>
 <fb715262-df9e-3e77-6964-80ec4a1c7a24@redhat.com>
 <CALCETrVqe2BhHTMG0joSC3eTk6CibAtn1c5gd7Ou6zLXQrgO3w@mail.gmail.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <32f64637-8c9e-9b8d-9570-095b015757a9@redhat.com>
Date:   Fri, 2 Nov 2018 16:34:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVqe2BhHTMG0joSC3eTk6CibAtn1c5gd7Ou6zLXQrgO3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 02 Nov 2018 20:34:06 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2018 04:11 PM, Andy Lutomirski wrote:
> On Fri, Nov 2, 2018 at 12:50 PM Waiman Long <longman@redhat.com> wrote:
>> On 11/02/2018 03:44 PM, Dave Hansen wrote:
>>> On 11/2/18 12:40 PM, Waiman Long wrote:
>>>> The 64k+ limit check is kind of arbitrary. So the check is now removed
>>>> to just let expand_stack() decide if a segmentation fault should happen.
>>> With the 64k check removed, what's the next limit that we bump into?  Is
>>> it just the stack_guard_gap space above the next-lowest VMA?
>> I think it is both the stack_guard_gap space above the next lowest VMA
>> and the rlimit(RLIMIT_STACK).
>>
> Did the non-working programs ever work?  Because, if not, I say let them fail.

The program was working before on older kernel. After the backport of
the commit 1be7107fbe18 ("mm: larger stack guard gap, between vmas"),
the program stopped working. I believe it is the removal of the
check_stack_guard_page() function which did expand the stack. So the 64k
check was actually not functional because of the stack expansion before
hand, but now it does.

Anyway, I see the current 64k check a very crude check on an userspace
error. I think there are quite a number of more powerful userspace tools
out there that can do this kind of check more effectively. Kernel isn't
the right place to do that.

Cheers,
Longman


