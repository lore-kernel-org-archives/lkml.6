Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeCTQea (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:34:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:56147 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751310AbeCTQdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:33:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,336,1517904000";
   d="scan'208";a="35388159"
From: "Bae, Chang Seok" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>
CC: X86 ML <x86@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when
 FS/GS updated by ptracer
Thread-Topic: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when
 FS/GS updated by ptracer
Thread-Index: AQHTv61cgKpKrSnds0atXlLhYuaZSaPZns+A//+jdIA=
Date: Tue, 20 Mar 2018 16:33:35 +0000
Message-ID: <C78DE381-C618-4370-9B06-F6E25C850661@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-15-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXb5RRuAnKpU2_3Rac4F4tbv1Z+UHU6=QrYk-GCSLv4cw@mail.gmail.com>
In-Reply-To: <CALCETrXb5RRuAnKpU2_3Rac4F4tbv1Z+UHU6=QrYk-GCSLv4cw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
x-originating-ip: [10.254.178.80]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE90764316240C4E8F468758B981D642@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2KGYWgf025689

On 3/20/18, 08:05, "Andy Lutomirski" <luto@kernel.org> wrote:
> I've also suggested something like this myself, but this approach is
> far more complicated than the older approach.  Was there something
> that the old approach would break?  If so, what?
Sorry, I don't know your suggestion. Can you elaborate your suggestion?
  
>> +               /*
>> +                * %fs setting goes to reload its base, when tracee
>> +                * resumes without FSGSBASE (legacy). Here with FSGSBASE
>> +                * FS base is (manually) fetched from GDT/LDT when needed.
>> +                */
>> +               else if (static_cpu_has(X86_FEATURE_FSGSBASE) &&
>> +                        (value != 0) && (task->thread.fsindex != value))
>> +                       task->thread.fsbase = task_seg_base(task, value);

> The comment above should explain why you're checking this particular
> condition.  I find the fsindex != value check to be *very* surprising.
>  On a real CPU, writing some nonzero value to %fs does the same thing
>  regardless of what the old value of %fs was.

With FSGSBASE, when both index and base are not changed, base will
be (always) fetched from GDT/LDT. This is not thought as legacy behavior 
we need to support, AFAIK.

> This is_fully_covered thing is IMO overcomplicated.  Why not just make
> a separate helper set_fsgs_index_and_base() and have putregs() call it
> when both are set at once?

Using helper function here is exactly what I did at first. I thought this
tag is simple enough and straightforward at the end. But I'm open to
factor it out.
 
