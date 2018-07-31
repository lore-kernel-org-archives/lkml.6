Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4708C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB8D20894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LZKDePO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB8D20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbeHAAPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:15:46 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:52046 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732379AbeHAAPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:15:45 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5F1FA24E0880;
        Tue, 31 Jul 2018 15:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1533076396; bh=U+nwpwJIs77xPBjrDg7U1piHzoVoG+XCufaSHy9Tmhk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=LZKDePO/llSGSRSVgFqKyE0gPnEmYPSLft6nBrQiIT2dx2iSgH20K/+nDNKDMWFr3
         aDNY4x2BPMRCgGn31FI+q4B7+27Dg3Yaxlo09lVi3bp48zwG06UKxfD1YCHqTxDlOj
         9jIr6aJxGfRy/0oJluRtFBsiUaL0epHLxR/HGGEkhwv6dCbQJfBVXDZcPy1Q8k2N5K
         AWc4PIN5eC8cRqC2/HFjyDXSP4P7QE5cyC1RRgPWEz0W/GfhUQj8EZQlWdaG8viOPl
         olErolLHONyw60E5uqyAp9xoCoj2b1R+LZrggpoCHWqRlN0PHr2XeREe6YUVDmbwWC
         0CKlSKmNOjW/w==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4BA2C3A7E;
        Tue, 31 Jul 2018 15:33:16 -0700 (PDT)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 31 Jul 2018 15:33:00 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 1 Aug 2018 04:02:57 +0530
Received: from [10.10.161.98] (10.10.161.98) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Wed, 1 Aug 2018 04:02:56 +0530
Subject: Re: ARC show_regs() triggers preempt debug splat, lockdep
To:     Peter Zijlstra <peterz@infradead.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
CC:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Newsgroups: gmane.linux.kernel,gmane.linux.kernel.arc
References: <5c3cfd4d-46d2-d817-a29a-1890d84c1fbb@synopsys.com>
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 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
 i91ThhqBJlyU6MVUa6vZNv8E
Message-ID: <f05b18a2-b6d3-ae6d-d358-4b2b5ae5250a@synopsys.com>
Date:   Tue, 31 Jul 2018 15:32:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5c3cfd4d-46d2-d817-a29a-1890d84c1fbb@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.98]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 02:26 PM, Vineet Gupta wrote:
> Hi Peter, Al,
> 
> Reaching out about a problem I understand, but not quite sure how to fix it.
> Its the weird feeling of how was this working all along, if at all.
> 
> With print-fatal-signals enabled, there's CONFIG_DEBUG_PREEMPT splat all over,
> even with a simple single threaded segv inducing program (console log below). This
> originally came to light with a glibc test suite tst-tls3-malloc which is a
> multi-threaded monster.
> 
> ARC show_regs() is a bit more fancy as it tries to print the executable path,
> faulting vma name (in case it was a shared lib etc). This involves taking a bunch
> of customary locks which seems to be tripping the debug infra.
> 
> The preemption disabling around show_regs() in core signal handling seem to have
> been introduced back in 2009 by 3a9f84d354ce1 ("signals, debug: fix BUG: using
> smp_processor_id() in preemptible code in print_fatal_signal()") and the fact it
> it there still implies it is needed in general.
> 
> Possible solutions are to
> (1) override this by re-enabling preemption in ARC show_regs()
> (2) rip out all the mm access and hence locks from ARC show_regs()
> ...

I investigated a bit more and it seems the story is more complicated and there are
2 distinct issues.

1. print-fatal-signals ENABLED: induces the show_regs() issue of __might_sleep()
with preemption_disabled(). This happens with simplest of programs

2. print-fatal-signals DISABLED: this causes glibc testsuite tst-tls3-malloc to
barf still, see below. This is a multi-threaded test where one thread is serving a
page fault, gets scheduled out and other thread observes the signal and decides to
exit (this is UP kernel BTW)


------------------->8------------------
# while true; do ./tst-tls3-malloc ; done
Didn't expect signal from child: got `Segmentation fault'
^C
============================================
WARNING: possible recursive locking detected
4.17.0+ #25 Not tainted
--------------------------------------------
tst-tls3-malloc/510 is trying to acquire lock:
606c7728 (&mm->mmap_sem){++++}, at: __might_fault+0x28/0x5c

but task is already holding lock:
606c7728 (&mm->mmap_sem){++++}, at: do_page_fault+0x9c/0x2a0

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&mm->mmap_sem);
  lock(&mm->mmap_sem);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by tst-tls3-malloc/510:
 #0: 606c7728 (&mm->mmap_sem){++++}, at: do_page_fault+0x9c/0x2a0

stack backtrace:
CPU: 0 PID: 510 Comm: tst-tls3-malloc Not tainted 4.17.0+ #25

Stack Trace:
  arc_unwind_core.constprop.1+0xd0/0xf4
  __lock_acquire+0x586/0x142c
  lock_acquire+0x36/0x4c
  __might_fault+0x42/0x5c
  exit_robust_list+0x40/0x19c
  mm_release+0xce/0xf4
  do_exit+0x554/0x780
  do_group_exit+0x22/0x84
  get_signal+0x196/0x79c
  do_signal+0x30/0x224
  resume_user_mode_begin+0x90/0xd8

Timed out: killed the child process
------------------->8------------------

