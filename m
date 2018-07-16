Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2354ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97780208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 07:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97780208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389642AbeGPIOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 04:14:37 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51126 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbeGPIOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 04:14:37 -0400
Received: from p4fea5a5a.dip0.t-ipconnect.de ([79.234.90.90] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1feyFA-0006yX-Ca; Mon, 16 Jul 2018 09:48:28 +0200
Date:   Mon, 16 Jul 2018 09:48:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Yang, Bin" <bin.yang@intel.com>
cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gross, Mark" <mark.gross@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/mm: fix cpu stuck issue in
 __change_page_attr_set_clr
In-Reply-To: <6957364e872792c9cc310cf4928ae90771f2b69a.camel@intel.com>
Message-ID: <alpine.DEB.2.21.1807160946210.2644@nanos.tec.linutronix.de>
References: <1530180340-18593-1-git-send-email-bin.yang@intel.com>    <alpine.DEB.2.21.1807031442030.1601@nanos.tec.linutronix.de>    <0131cecd5d0456c2a109f4b8bdbfe558389671dd.camel@intel.com>    <alpine.DEB.2.21.1807040849520.1816@nanos.tec.linutronix.de>
   <3224aae1d09788aba687fd7bd9e088f233016fc8.camel@intel.com>   <alpine.DEB.2.21.1807041119260.1816@nanos.tec.linutronix.de>  <34a76fad5c43c11ce8ceb491537b453d8053bdb2.camel@intel.com>  <alpine.DEB.2.21.1807041221110.1816@nanos.tec.linutronix.de>
 <6957364e872792c9cc310cf4928ae90771f2b69a.camel@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018, Yang, Bin wrote:
> > +	 * FIXME:
> > +	 * 1) Make this yell loudly if something tries to set a full
> > +	 *    large page to something which is not allowed.
> 
> I am trying to work out a patch based on your sample code and
> comments. 
> I do not understand here why it needs to yell loudly if set a full
> large page to something which is not allowed. It can split the large
> page to 4K-pages finally. And static_protection() will also be called
> for 4K-page change. Why not just add warning if 4K-page change is not
> allowed?

Think about it. If there is a large page which contains an area which
requires a different mapping that the one which the large page provides,
then something went wrong _before_ this code is called.

Thanks,

	tglx
