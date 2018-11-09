Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F11DC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1672081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 18:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1672081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbeKJEY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 23:24:27 -0500
Received: from mga04.intel.com ([192.55.52.120]:6759 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbeKJEY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 23:24:26 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2018 10:42:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,484,1534834800"; 
   d="scan'208";a="103062574"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.154])
  by fmsmga002.fm.intel.com with ESMTP; 09 Nov 2018 10:42:37 -0800
Date:   Fri, 9 Nov 2018 10:42:37 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Rian Quinn <rianquinn@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: x86_64 INIT/SIPI Bug
Message-ID: <20181109184237.GA4051@linux.intel.com>
References: <CANmpu8XY10CgYsnGn9hVDzGJQyWdwNihpYu3So62KtNwrkwGXw@mail.gmail.com>
 <20181109174918.GA3594@linux.intel.com>
 <CANmpu8Xuuuqhfa8Tspgd9cHXetNCBkRGuGfFFSovB1A1We=n+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANmpu8Xuuuqhfa8Tspgd9cHXetNCBkRGuGfFFSovB1A1We=n+A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 11:04:59AM -0700, Rian Quinn wrote:
> >> I apologize upfront if this is the wrong place to post this, pretty new to this.
> >>
> >> We are working on the Bareflank Hypervisor (www.bareflank.org), and we
> >> are passing through the INIT/SIPI process (similar to how a VMX
> >> rootkit from EFI might boot the OS) and we noticed that on Arch Linux,
> >> the INIT/SIPI process stalls, something we are not seeing on Ubuntu.
> >
> > I'm confused, INIT is blocked post-VMXON, what are you passing through?
> 
> You are correct that INIT will track unconditionally, but all we do is set the
> activity state to wait-for-sipi and return back, allowing Linux to continue
> its boot process.

That's not pass-through, maybe call it reflection?  I realize I'm being
a bit pedantic, but differentiating between the two matters since true
pass-through gives you bare metal performance whereas reflection obviously
requires a round-trip VMX transition.

Most hypervisors don't need a delay because they don't pass-through the
local APIC and instead emulate INIT/SIPI/SIPI.  In other words, forcing
a delay for all hypervisors is unwarranted.

The correct fix is probably to add a new hook to struct x86_hyper_init
to provide a custom init delay, and add Bareflank as a new hypervisor.
