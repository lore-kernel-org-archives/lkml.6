Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751107AbeEDKiw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 06:38:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:21479 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbeEDKiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 06:38:50 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,362,1520924400";
   d="scan'208";a="52376694"
Date: Fri, 4 May 2018 13:38:42 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Luwei Kang <luwei.kang@intel.com>, kvm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        rkrcmar@redhat.com, linux-kernel@vger.kernel.org, joro@8bytes.org,
        peterz@infradead.org, chao.p.peng@linux.intel.com
Subject: Re: [PATCH v7 06/13] KVM: x86: Add Intel Processor Trace
 virtualization mode
Message-ID: <20180504103842.rcbpnkjeoavulii6@um.fi.intel.com>
References: <1525349323-9938-1-git-send-email-luwei.kang@intel.com>
 <1525349323-9938-7-git-send-email-luwei.kang@intel.com>
 <20180503113223.x2ykby6wglppgdwf@um.fi.intel.com>
 <47494e95-edcb-e8b5-0a32-004e9470dbdf@redhat.com>
 <20180503120215.dev7ti43zk7yoovn@um.fi.intel.com>
 <221c297b-1270-371b-70a3-4cff4bed7a7e@redhat.com>
 <20180503124847.tcrizs2sxy3j6mu2@um.fi.intel.com>
 <26505f7a-9e6b-efb9-e5f9-8aae3756be49@redhat.com>
 <20180503133823.tqbraql3b7ltuo6a@um.fi.intel.com>
 <e948d77e-b96e-147a-745d-aad05935b61b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e948d77e-b96e-147a-745d-aad05935b61b@redhat.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 03:48:12PM +0200, Paolo Bonzini wrote:
> On 03/05/2018 15:38, Alexander Shishkin wrote:
> > On Thu, May 03, 2018 at 02:50:12PM +0200, Paolo Bonzini wrote:
> >> On 03/05/2018 14:48, Alexander Shishkin wrote:
> >>>> Guest tracing can only be enabled at boot time, because the guest's
> >>>> CPUID changes depending on whether it's enabled.  And likewise if perf
> >>>> record can do system-wide tracing at any time during the guest's
> >>>> execution, we need to know it at boot time in order to set the guest CPUID.
> >>>
> >>> CPUID is immaterial here; the real trick is to disallow the use of PT at
> >>> runtime when the host suddenly decides to trace the guest, in such a way
> >>> that the guest user is informed that their trace is incomplete due to the
> >>> host activity.
> >>
> >> How do you do that?
> > 
> > Off the top of my head:
> >   * you don't;
> >   * you write something to the PT stream;
> >   * you signal an error via RTIT_STATUS;
> >   * guest always prevails: host gets PARTIAL records in case of a conflict.
> > 
> >> And you still need the module parameter to decide
> >> whether the host is _allowed_ to cause incomplete traces in the guest.
> > 
> > Or rather a parameter to decide who wins in case both host and guest want
> > to trace the guest. That's arguably better than having different versions of
> > PT in the guest depending on a module parameter setting.
> 
> It's not different versions; it's having PT vs. not having PT at all.  I
> don't really see it as a big issue.  The nice thing about this series is
> that the interactions between PT code and KVM code are minimal.

Unfortunately, it gets it wrong. Like I just said in another email, if you
switch off host's PT, you need to let them know, which this patchset doesn't
do. And when it does, it would be the same amount of interaction with PT
code as what would be required to get the dynamic guest PT right.

Regards,
--
Alex
