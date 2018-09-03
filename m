Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E43FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA8D20843
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA8D20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbeICV2F convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:28:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:43963 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbeICV2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:28:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 10:07:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,325,1531810800"; 
   d="scan'208";a="254179318"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga005.jf.intel.com with ESMTP; 03 Sep 2018 10:07:04 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.148]) with mapi id 14.03.0319.002;
 Mon, 3 Sep 2018 10:07:03 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Lee Chun-Yi <jlee@suse.com>, Al Stone <astone@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH V2 5/6] x86/mm: If in_atomic(), allocate pages without
 sleeping
Thread-Topic: [PATCH V2 5/6] x86/mm: If in_atomic(), allocate pages without
 sleeping
Thread-Index: AQHUQqIDKLGU941Wr0OybRKnptAV1aTeshSAgAAFKACAABQXoA==
Date:   Mon, 3 Sep 2018 17:07:03 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485B91FE@ORSMSX114.amr.corp.intel.com>
References: <1535881594-25469-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1535881594-25469-6-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180903083459.GT24124@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1809031048430.1349@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809031048430.1349@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTNlNmRjOTctY2Y2ZS00YTM3LTgzOGItNGJmNWQ5YzZkNzQ1IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibG5IblhUMmwyK1JxeXpvSFY5ZFVZbERSeHBuRTNjY1hhQnZsM2tua09tc29SRG1lU01MT284bExKMTUxT2RXUSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for CC'ing me. I wonder why the world and some more is on CC, but
> x86@kernel.org is NOT.
>

Sorry! about that. I will CC you and x86 from V3.

> > On Sun, Sep 02, 2018 at 02:46:33AM -0700, Sai Praneeth Prakhya wrote:
> 
> > > @@ -926,7 +926,13 @@ static void unmap_pud_range(p4d_t *p4d,
> > > unsigned long start, unsigned long end)
> > >
> > >  static int alloc_pte_page(pmd_t *pmd)  {
> > > -	pte_t *pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
> > > +	pte_t *pte;
> > > +
> > > +	if (in_atomic())
> > > +		pte = (pte_t *)get_zeroed_page(GFP_ATOMIC);
> > > +	else
> > > +		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
> > > +
> > >  	if (!pte)
> > >  		return -1;
> > >
> >
> > This looks like tinkering to me..
> 
> Yes it is and it's not going to happen.

Haha.. ok.. I will take your suggestion in the 4th patch and that should avoid this.

Regards,
Sai
