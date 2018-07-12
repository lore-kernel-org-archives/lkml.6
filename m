Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B39C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31664213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 07:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31664213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbeGLHwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 03:52:46 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9660 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeGLHwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 03:52:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b4706d50000>; Thu, 12 Jul 2018 00:44:21 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 12 Jul 2018 00:44:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 12 Jul 2018 00:44:24 -0700
Received: from dhcp-10-21-25-168 (10.21.25.201) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 12 Jul
 2018 07:44:21 +0000
Date:   Thu, 12 Jul 2018 10:44:16 +0300
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Jon Hunter <jonathanh@nvidia.com>
CC:     Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] clk: tegra: refactor 7.1 div calculation
Message-ID: <20180712104416.7d2a6e14@dhcp-10-21-25-168>
In-Reply-To: <7022b1f4-97ac-aa1b-5c60-d7041da6704b@nvidia.com>
References: <1531154338-3998-1-git-send-email-avienamo@nvidia.com>
        <1531154338-3998-3-git-send-email-avienamo@nvidia.com>
        <5805047f-4099-db34-0759-42e4a9e11629@nvidia.com>
        <20180711080022.GB1636@tbergstrom-lnx.Nvidia.com>
        <ef90eb24-e993-9cc1-ac09-5afedeceba75@nvidia.com>
        <20180711111754.GC1636@tbergstrom-lnx.Nvidia.com>
        <7022b1f4-97ac-aa1b-5c60-d7041da6704b@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.21.25.201]
X-ClientProxiedBy: UKMAIL102.nvidia.com (10.26.138.15) To HQMAIL101.nvidia.com
 (172.20.187.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 16:14:13 +0100
Jon Hunter <jonathanh@nvidia.com> wrote:

> On 11/07/18 12:17, Peter De Schrijver wrote:
> > On Wed, Jul 11, 2018 at 09:42:20AM +0100, Jon Hunter wrote:  
> >>
> >> On 11/07/18 09:00, Peter De Schrijver wrote:  
> >>> On Tue, Jul 10, 2018 at 05:17:05PM +0100, Jon Hunter wrote:  
> >>>>
> >>>> On 09/07/18 17:38, Aapo Vienamo wrote:  
> >>>>> From: Peter De Schrijver <pdeschrijver@nvidia.com>
> >>>>>
> >>>>> Move this to a separate file so it can be used to calculate the sdmmc
> >>>>> clock dividers.  
> >>>>
> >>>> Sorry for not commenting sooner, but what is the motivation for moving
> >>>> this to its own file? I don't see why we need to do this in order to use
> >>>> elsewhere. Furthermore, the original file is quite aptly named 'clk-divider.c'
> >>>> and now we have a div71.c which seems quite specific.  
> >>>
> >>> How else would you do it?  
> >>
> >> Keep it in the same file?
> >>  
> > 
> > That seems odd. clk-divider.c is meant to implement a clock type, not
> > utility functions we happen to need in several types.  
> 
> I see, then why not have a clk-utils.c for stuff like this. I am painting
> the bikeshed here, but div71.c seems very specific and I still don't
> understand the 7.1 bit.

While the code could work with other dividers, it was called 7.1 because
the current usecases were only on 7.1 dividers. I can submit another
version with a different filename if other changes to the series come
about or if it's seen necessary to change div-frac.c from the latest
version of the series to something else.

 -Aapo
