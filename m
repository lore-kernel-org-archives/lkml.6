Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752549AbeCUPLr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:11:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:51958 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752299AbeCUPLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:11:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,340,1517904000";
   d="scan'208";a="213371755"
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
Thread-Index: AQHTv61cgKpKrSnds0atXlLhYuaZSaPZns+A//+jdICAAP9OgIAAfB0A
Date: Wed, 21 Mar 2018 15:11:35 +0000
Message-ID: <E9221EFA-636C-4D36-AEBA-3A1EEBBF2F50@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
 <1521481767-22113-15-git-send-email-chang.seok.bae@intel.com>
 <CALCETrXb5RRuAnKpU2_3Rac4F4tbv1Z+UHU6=QrYk-GCSLv4cw@mail.gmail.com>
 <C78DE381-C618-4370-9B06-F6E25C850661@intel.com>
 <CALCETrX03_AG-OuJdmfmsbvEt0UTdUpaUVDRQgbDZWGY7WD-Xw@mail.gmail.com>
In-Reply-To: <CALCETrX03_AG-OuJdmfmsbvEt0UTdUpaUVDRQgbDZWGY7WD-Xw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.b.0.180311
x-originating-ip: [10.254.180.102]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0455AF43AD50F84A866F3782AA86928B@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2LFBqaV015770

On 3/20/18, 17:47, "Andy Lutomirski" <luto@kernel.org> wrote:
>    If I've understood all your emails right, when you looked at existing
>    ptrace users, you found that all of them that write to gs and/or
>    gs_base do it as part of a putregs call that writes them at the same
>    time.  If so, then your patch does exactly the same thing that my old
>    patches did, but your patch is much more complicated.  So why did you
>    add all that complexity?

What is tried to be provided is backward compatibility by emulating 
“mov gs (fs) …” when index is only changed and preserve a (given) base value 
in other cases. If ptracer changes GS index between PTRACE_GETREGS 
and PTRACE_SETREG, the tracee does not have GS base from GDT/LDT 
when it resumes, with the patch [1]. Task’s GS base is preserved at schedule-in, 
when FSGSBASE enabled.

Code-wise, no clean implementation was found from the existing putreg(). 
putreg() goes in an independently isolated way, while the backward 
compatibility needs something to put one from the other value. 
I would like to know a better way without introducing putregs() (and 
reversely setting them).

[1] https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fsgsbase&id=cfaf9911b88930ca6e4d0173fe8a58d2ea4ee6fb
