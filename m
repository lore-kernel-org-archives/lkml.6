Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F9CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C33A2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C33A2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeIGNBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:01:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:35670 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeIGNBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:01:48 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fyC1d-0001Ww-Ax; Fri, 07 Sep 2018 10:21:57 +0200
Date:   Fri, 7 Sep 2018 10:21:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Yang, Bin" <bin.yang@intel.com>
cc:     "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Gross, Mark" <mark.gross@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v3 4/5] x86/mm: optimize static_protection() by using
 overlap()
In-Reply-To: <cd73f43a15f06c720bb4907d2c424dfb3f0c8683.camel@intel.com>
Message-ID: <alpine.DEB.2.21.1809071019020.1402@nanos.tec.linutronix.de>
References: <1534814186-37067-1-git-send-email-bin.yang@intel.com>  <1534814186-37067-5-git-send-email-bin.yang@intel.com>  <alpine.DEB.2.21.1809041413070.3395@nanos.tec.linutronix.de>  <82fc8d80749f920c4a5107469924205d92037785.camel@intel.com> 
 <alpine.DEB.2.21.1809070943490.1402@nanos.tec.linutronix.de> <cd73f43a15f06c720bb4907d2c424dfb3f0c8683.camel@intel.com>
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

On Fri, 7 Sep 2018, Yang, Bin wrote:
> On Fri, 2018-09-07 at 09:49 +0200, Thomas Gleixner wrote:
> > On Fri, 7 Sep 2018, Yang, Bin wrote:
> > > On Tue, 2018-09-04 at 14:22 +0200, Thomas Gleixner wrote:
> > > 
> > > I just write a test.c to compare the result between overlap() and
> > > original within().
> > 
> > You are right. Your version of doing the overlap exclusive works. I misread
> > the conditions. I still prefer doing inclusive checks because they are way
> > more obvious.
> 
> I am sorry for my poor english. What is "inclusive checks"?

Exlusive:    val >= start && val < end

Inclusive:   val >= start && val <= end

So the difference is that you feed exclusive with:

   end = start + size

and inclusive with

  end = start + size - 1

Thanks,

	tglx


