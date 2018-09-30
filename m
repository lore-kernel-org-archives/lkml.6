Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F473C43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 01:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F1320685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 01:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F1320685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeI3IMc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 04:12:32 -0400
Received: from mga09.intel.com ([134.134.136.24]:1359 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbeI3IMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 04:12:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Sep 2018 18:41:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,322,1534834800"; 
   d="scan'208";a="94671504"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga001.fm.intel.com with ESMTP; 29 Sep 2018 18:41:24 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Sat, 29 Sep 2018 18:41:22 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.140]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.220]) with mapi id 14.03.0319.002;
 Sun, 30 Sep 2018 09:41:20 +0800
From:   "Li, Philip" <philip.li@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Julia Cartwright" <julia@ni.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "Tim Sander" <tim@krieglstein.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>, lkp <lkp@intel.com>
Subject: RE: [kbuild-all] [PATCH RT 2/2] watchdog, rt: prevent deferral of
 watchdogd wakeup
Thread-Topic: [kbuild-all] [PATCH RT 2/2] watchdog, rt: prevent deferral of
 watchdogd wakeup
Thread-Index: AQHUV79Lqw10207ks0OrCgC/xNQ5iqUHTZEAgADAJ6A=
Date:   Sun, 30 Sep 2018 01:41:18 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E662494CD1CCC3@shsmsx102.ccr.corp.intel.com>
References: <0e02d8327aeca344096c246713033887bc490dd7.1538089180.git.julia@ni.com>
 <201809290614.fxFuwGkP%fengguang.wu@intel.com>
 <alpine.DEB.2.21.1809290835240.1432@nanos.tec.linutronix.de>
 <20180929221301.z7dytm4whpcbip6a@linutronix.de>
In-Reply-To: <20180929221301.z7dytm4whpcbip6a@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjBjNjdhZGItMGJlZi00NTVjLWE4ZWMtNWU1NjJjN2IwZTQwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMDVYU1hKT0ZPb0dNNzNJR1RCek1QY1p4ajcyNjAxUzRudlVhSmFqOHdkOE9MZ0pzaUZ3SE1JTDRFa09Qemx6UiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [kbuild-all] [PATCH RT 2/2] watchdog, rt: prevent deferral of
> watchdogd wakeup
> 
> On 2018-09-29 08:38:55 [+0200], Thomas Gleixner wrote:
> > On Sat, 29 Sep 2018, kbuild test robot wrote:
> > > [also build test ERROR on v4.19-rc5 next-20180928]
> > > [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system]
> > >
> >
> > It's against the RT tree, so it won't work against next or upstream. I
> > think it would be good to have a machine parseable tag to describe which
> > tree/branch/commit patches are applicable to. If that tag is missing, the
> > bot can assume it's against upstream/next.
> 
> I asked the testing team to ignore patches or test against the RT tree
> if the patch is tagged [PATCH RT]. I think it worked since I haven't
> seen those mails.
thanks Sebastian for the input, we will consider this to add to our TODO.

> 
> > Thanks,
> >
> > 	tglx
> 
> Sebastian
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all
