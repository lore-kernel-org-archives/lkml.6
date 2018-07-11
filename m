Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307ABC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E215920C03
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E215920C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389430AbeGKPv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:51:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:40653 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389424AbeGKPv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:51:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2018 08:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,338,1526367600"; 
   d="scan'208";a="71462702"
Received: from 2b52.sc.intel.com ([143.183.136.52])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2018 08:45:26 -0700
Message-ID: <1531323709.13297.25.camel@intel.com>
Subject: Re: [RFC PATCH v2 18/27] x86/cet/shstk: Introduce WRUSS instruction
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Balbir Singh <bsingharora@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromiun.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>
Date:   Wed, 11 Jul 2018 08:41:49 -0700
In-Reply-To: <20180711152754.GJ2476@hirez.programming.kicks-ass.net>
References: <20180710222639.8241-1-yu-cheng.yu@intel.com>
         <20180710222639.8241-19-yu-cheng.yu@intel.com>
         <20180711094549.GA2476@hirez.programming.kicks-ass.net>
         <1531321089.13297.4.camel@intel.com>
         <20180711152754.GJ2476@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-11 at 17:27 +0200, Peter Zijlstra wrote:
> On Wed, Jul 11, 2018 at 07:58:09AM -0700, Yu-cheng Yu wrote:
> > 
> > On Wed, 2018-07-11 at 11:45 +0200, Peter Zijlstra wrote:
> > > 
> > > On Tue, Jul 10, 2018 at 03:26:30PM -0700, Yu-cheng Yu wrote:
> > > > 
> > > > 
> > > > diff --git a/arch/x86/lib/x86-opcode-map.txt
> > > > b/arch/x86/lib/x86-
> > > > opcode-map.txt
> > > > index e0b85930dd77..72bb7c48a7df 100644
> > > > --- a/arch/x86/lib/x86-opcode-map.txt
> > > > +++ b/arch/x86/lib/x86-opcode-map.txt
> > > > @@ -789,7 +789,7 @@ f0: MOVBE Gy,My | MOVBE Gw,Mw (66) | CRC32
> > > > Gd,Eb (F2) | CRC32 Gd,Eb (66&F2)
> > > >  f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32
> > > > Gd,Ew (66&F2)
> > > >  f2: ANDN Gy,By,Ey (v)
> > > >  f3: Grp17 (1A)
> > > > -f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey
> > > > (F2),(v)
> > > > +f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey
> > > > (F2),(v) | WRUSS Pq,Qq (66),REX.W
> > > >  f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey
> > > > (F2),(v)
> > > >  f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX
> > > > Gy,Ey,By
> > > > (F3),(v) | SHRX Gy,Ey,By (F2),(v)
> > > >  EndTable
> > > Where are all the other instructions? ISTR that documentation
> > > patch
> > > listing a whole bunch of new instructions, not just wuss.
> > Currently we only use WRUSS in the kernel code.  Do we want to add
> > all
> > instructions here?
> Yes, since we also use the in-kernel decoder to decode random
> userspace
> code.

I will add other instructions.

Yu-cheng

