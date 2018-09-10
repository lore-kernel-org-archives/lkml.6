Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F94C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D48320855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 21:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D48320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbeIKCcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 22:32:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:54482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726141AbeIKCcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 22:32:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 794EDAE0A;
        Mon, 10 Sep 2018 21:36:03 +0000 (UTC)
Date:   Mon, 10 Sep 2018 23:36:00 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     "Schaufler, Casey" <casey.schaufler@intel.com>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v5 1/2] x86/speculation: apply IBPB more strictly to
 avoid cross-process data leak
In-Reply-To: <99FC4B6EFCEFD44486C35F4C281DC6732144AF87@ORSMSX107.amr.corp.intel.com>
Message-ID: <nycvar.YFH.7.76.1809102332290.15880@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1809101119280.15880@cbobk.fhfr.pm> <nycvar.YFH.7.76.1809101123020.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144ADF9@ORSMSX107.amr.corp.intel.com> <nycvar.YFH.7.76.1809102111410.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144AEC9@ORSMSX107.amr.corp.intel.com> <nycvar.YFH.7.76.1809102132480.15880@cbobk.fhfr.pm> <99FC4B6EFCEFD44486C35F4C281DC6732144AF24@ORSMSX107.amr.corp.intel.com> <nycvar.YFH.7.76.1809102235010.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC6732144AF87@ORSMSX107.amr.corp.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2018, Schaufler, Casey wrote:

> > So please tell me what exactly you'd like to see changed in the IBPB patch
> > and why exactly, I am not seeing it yet.
> 
> Short of a patch to show the changes (which I wish I could do today, but really can't)
> what I want to see is:
> 
> 	- Put ptrace back to using the security module interfaces.
> 	- Identify where this causes locking issues and work with the module
> 	  owners (a reasonable lot, all) to provide lock safe paths for the IBPB case.
> 
> Otherwise, I have to add a new LSM hook right after your ptrace call and duplicate
> a whole lot of what you've just turned off, plus creating lock safe code that duplicates
> what ptrace already does. While I would rather have the side-channel checks be
> separate from the ptrace checks I can't justify doing both.

So why can't this be then done as 2nd step, once you've audited the LSM 
callbacks and worked around the locking in LSM callbacks/audit code?

Once that is taken care of, of course feel free to undo the changes my 
patch is doing so that you don't have to duplicate any ptrace code.

But before all that is fixed / worked around in LSM/audit (and I don't 
have spare cycles for doing that myself), why not take the simple aproach 
for now?

Thanks,

-- 
Jiri Kosina
SUSE Labs

