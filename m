Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE90BC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF34120823
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfA2NjW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:39:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:32997 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbfA2NjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:39:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jan 2019 05:39:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,537,1539673200"; 
   d="scan'208";a="122249300"
Received: from irsmsx108.ger.corp.intel.com ([163.33.3.3])
  by orsmga003.jf.intel.com with ESMTP; 29 Jan 2019 05:39:19 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.65]) by
 IRSMSX108.ger.corp.intel.com ([169.254.11.205]) with mapi id 14.03.0415.000;
 Tue, 29 Jan 2019 13:39:18 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: RE: [PATCH] refcount_t: add ACQUIRE ordering on success for
 dec(sub)_and_test variants
Thread-Topic: [PATCH] refcount_t: add ACQUIRE ordering on success for
 dec(sub)_and_test variants
Thread-Index: AQHUtwJjl6FToBsL5EumdKDVAgvWOaXEvaUAgAFE0QCAAD1W8A==
Date:   Tue, 29 Jan 2019 13:39:17 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4B98D02@IRSMSX102.ger.corp.intel.com>
References: <1548677377-22177-1-git-send-email-elena.reshetova@intel.com>
 <20190128142910.GA7232@andrea>
 <20190129095144.GH28467@hirez.programming.kicks-ass.net>
In-Reply-To: <20190129095144.GH28467@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDNiODYyZTItODllMS00OGU5LWFlMGMtOWVhNTgwOWM4ZTU5IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRlVTbUdXUm83bE10N3VWTDNsd1JGXC9HaldURm5VblNMSTFKSkpsZ3lSVVBPRzZTY1VTT09hbEpKZHBncTFPTWkifQ==
x-originating-ip: [163.33.239.182]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 
> On Mon, Jan 28, 2019 at 03:29:10PM +0100, Andrea Parri wrote:
> 
> > > diff --git a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> > > index dbaed55..ab8f584 100644
> > > --- a/arch/x86/include/asm/refcount.h
> > > +++ b/arch/x86/include/asm/refcount.h
> > > @@ -67,16 +67,29 @@ static __always_inline void refcount_dec(refcount_t *r)
> > >  static __always_inline __must_check
> > >  bool refcount_sub_and_test(unsigned int i, refcount_t *r)
> > >  {
> > > -	return GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
> > > +	bool ret = GEN_BINARY_SUFFIXED_RMWcc(LOCK_PREFIX "subl",
> > >
> REFCOUNT_CHECK_LT_ZERO,
> > >  					 r-
> >refs.counter, e, "er", i, "cx");
> > > +
> > > +    if (ret) {
> > > +               smp_acquire__after_ctrl_dep();
> > > +               return true;
> > > +    }
> > > +
> > > +    return false;
> >
> > There appears to be some white-space damage (here and in other places);
> > checkpatch.pl should point these and other style problems out.
> 
> It's worse...
> 
> patch: **** malformed patch at line 81: diff --git
> a/arch/x86/include/asm/refcount.h b/arch/x86/include/asm/refcount.h
> 
> And yes, there's a lot of whitespace damage all around. Lots of trailing
> spaces too.


I am very sorry about this, smth is really wrong with my system, in addition to all
above, I haven't even received Andrea reply to my inbox, neither this patch itself. 

I will fix all the whitespacing/trailing stuff and address this comment from Andrea:

"Mmh, this property (A-cumulativity) isn't really associated to ACQUIREs
in the LKMM; I'd suggest to simply remove the last sentence."

Anything else that needs fixing, content-wise? 

Best Regards,
Elena.

