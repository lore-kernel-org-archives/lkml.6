Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37611C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2992184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbfBLIjE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:39:04 -0500
Received: from mga18.intel.com ([134.134.136.126]:45680 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbfBLIjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:39:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 00:39:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,361,1544515200"; 
   d="scan'208";a="133607227"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
  by orsmga002.jf.intel.com with ESMTP; 12 Feb 2019 00:39:00 -0800
Received: from irsmsx102.ger.corp.intel.com ([169.254.2.219]) by
 IRSMSX104.ger.corp.intel.com ([169.254.5.56]) with mapi id 14.03.0415.000;
 Tue, 12 Feb 2019 08:38:59 +0000
From:   "Reshetova, Elena" <elena.reshetova@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>
CC:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] uprobes: convert uprobe.ref to refcount_t
Thread-Topic: [PATCH] uprobes: convert uprobe.ref to refcount_t
Thread-Index: AQHUrY2Yq0EjPRAwRUCLAKsVmClMRaXLSiAAgAQGjiCAC+L4AIAAAaSAgAAAXACAABaQgIAABeWAgACvbfA=
Date:   Tue, 12 Feb 2019 08:38:59 +0000
Message-ID: <2236FBA76BA1254E88B949DDB74E612BA4BBE3AE@IRSMSX102.ger.corp.intel.com>
References: <1547637627-29526-1-git-send-email-elena.reshetova@intel.com>
        <20190201172150.GA1853@linux.vnet.ibm.com>
        <2236FBA76BA1254E88B949DDB74E612BA4BA0C70@IRSMSX102.ger.corp.intel.com>
        <CAGXu5jJdeQ5DOZj_nPkWWBn8y0fRg2UEUGhd_seHL=KmKJey2g@mail.gmail.com>
        <20190211152725.65d0ed18@gandalf.local.home>
        <20190211152842.6a2a7794@gandalf.local.home>
        <CAGXu5jKgqHyji+W5coyeMmO7wQpJ_mxHK9Rga4UD=65kFavMEQ@mail.gmail.com>
 <20190211171033.4691d581@gandalf.local.home>
In-Reply-To: <20190211171033.4691d581@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzUxODdkYjEtYzU0OS00ZTI1LTg5ZWMtMjYxNWEwMWMyZDQwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUVl0V3hrNzVtMDhWZ0tGaXg3RTNaM2RVc2hoXC9mYlNyNTkwem53dmJsWGJUWHZQbWdOR0orNlQ0V2FYK1d4MUwifQ==
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, 11 Feb 2019 13:49:27 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > On Mon, Feb 11, 2019 at 12:28 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > On Mon, 11 Feb 2019 15:27:25 -0500
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > > On Mon, 11 Feb 2019 12:21:32 -0800
> > > > Kees Cook <keescook@chromium.org> wrote:
> > > >
> > > > > > > Looks good to me.
> > > > > > >
> > > > > > > Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> > > > > >
> > > > > > Thank you very much Srikar!
> > > > > > Would you be able to take this patch to integration?
> > > > >
> > > > > Steve can you pick this up with Srikar's Reviewed-by?
> > > >
> > > > Yep. And I'll also add Oleg's acked-by. (Currently doing my "urgent"
> > > > patches now).
> > > >
> > >
> > > Or is this something that can wait till the next merge window?
> >
> > I wouldn't classify the change as _urgent_, no. For "next merge
> > window" you mean v5.1, I assume? I think that'd be fine unless Elena
> > sees something I don't.
> 
> OK, then I'll just place this in the "for-next" branch of mine. Still
> need to test what I current have ;-)


Sure, thank you very much! It is not any urgent stuff!

Best Regards,
Elena.
