Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA0EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1993F20896
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:50:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1993F20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbeIYX7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:59:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:28323 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbeIYX7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:59:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 10:50:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="73625962"
Received: from agluck-desk.sc.intel.com (HELO agluck-desk) ([10.3.52.160])
  by fmsmga008.fm.intel.com with ESMTP; 25 Sep 2018 10:50:23 -0700
Date:   Tue, 25 Sep 2018 10:50:23 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Justin Ernst <justin.ernst@hpe.com>, russ.anderson@hpe.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Raise maximum number of memory controllers
Message-ID: <20180925175023.GA16725@agluck-desk>
References: <20180925143449.284634-1-justin.ernst@hpe.com>
 <20180925152659.GE23986@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925152659.GE23986@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 05:26:59PM +0200, Borislav Petkov wrote:
> On Tue, Sep 25, 2018 at 09:34:49AM -0500, Justin Ernst wrote:
> > We observe an oops in the skx_edac module during boot.
> > Examining /var/log/messages:
> > [ 3401.985757] EDAC MC0: Giving out device to module skx_edac controller Skylake Socket#0 IMC#0
> > [ 3401.985887] EDAC MC1: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1
> > [ 3401.986014] EDAC MC2: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0
> > ...
> > [ 3401.987318] EDAC MC13: Giving out device to module skx_edac controller Skylake Socket#0 IMC#1
> > [ 3401.987435] EDAC MC14: Giving out device to module skx_edac controller Skylake Socket#1 IMC#0
> > [ 3401.987556] EDAC MC15: Giving out device to module skx_edac controller Skylake Socket#1 IMC#1
> > [ 3401.987579] Too many memory controllers: 16
> > [ 3402.042614] EDAC MC: Removed device 0 for skx_edac Skylake Socket#0 IMC#0
> > 
> > We observe there are two memory controllers per socket, with a limit of 16.
> > Raise the maximum number of memory controllers from 16 to 2 * MAX_NUMNODES (1024).
> 
> Tony,
> 
> can we read that out from the hardware instead of having this silly
> static number?
> 
> Leaving in the rest.

There are way too many places where we use the identifier "bus"
in the edac core and drivers. But I'm not sure that we need a
static array mc_bus[EDAC_MAX_MCS].

Why can't we:


-	mci->bus = &mc_bus[mci->mc_idx];
+	mci->bus = kmalloc(sizeof *(mci->bus), GFP_KERNEL);

and then figure out where to kfree(mci->bus) on driver removal?

Do we every do arithmetic on different mci->bus pointers that
assume they are all part of a single array?

-Tony
