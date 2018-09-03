Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A9BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20332077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20332077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbeICVjq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:39:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:48301 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730161AbeICVjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:39:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2018 10:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,325,1531810800"; 
   d="scan'208";a="86816379"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga001.fm.intel.com with ESMTP; 03 Sep 2018 10:16:02 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 3 Sep 2018 10:16:02 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.8]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.139]) with mapi id 14.03.0319.002;
 Mon, 3 Sep 2018 10:16:02 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Lee Chun-Yi <jlee@suse.com>, Al Stone <astone@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: RE: [PATCH V2 4/6] x86/efi: Add efi page fault handler to
 fixup/recover from page faults caused by firmware
Thread-Topic: [PATCH V2 4/6] x86/efi: Add efi page fault handler to
 fixup/recover from page faults caused by firmware
Thread-Index: AQHUQqID5ZqTpFABTEWuUoO8aT1pw6TeuKqAgAATPZA=
Date:   Mon, 3 Sep 2018 17:16:01 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F485B9218@ORSMSX114.amr.corp.intel.com>
References: <1535881594-25469-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1535881594-25469-5-git-send-email-sai.praneeth.prakhya@intel.com>
 <alpine.DEB.2.21.1809031053340.1349@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809031053340.1349@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjBkNjEyYWEtYzFhZS00MWI1LThjYTUtYTlhMGI0YzViODUwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYWoxVm5QYkhXY0FpVk41cGxtSkNjU3VVOENVc2ZycHdxaVk4Yk96cms4RUl4dnZCM0daRXZBclM1WnZuYlIyUSJ9
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

> > The efi specific page fault handler offers us two advantages:
> > 1. Avoid panics/hangs caused by buggy firmware.
> > 2. Shout loud that the firmware is buggy and hence is not a kernel bug.
> >
> > Finally, this new mapping will not impact a reboot from kexec, as
> > kexec is only concerned about runtime memory regions.
> 
> No. This is just a horrible hack to make completely bogus firmware work and
> never fixed.
> 

Yes, that's true.

> The proper thing to do is to have a minimal page fault handler which does:
> 
>  1) Yell loudly if that ever happens
> 
>  2) Handles the reboot request gracefully
> 
>  3) Freeze and disable the EFI mess for all other cases
> 
> That does not require any hackery to make these mappings work from atomic
> context and keeps the mess confined to the EFI code where it belongs.
> 
> Ideally we just blacklist the offending system and be done with it.

This makes sense to me. I will implement the above suggested and as said should 
avoid the need for making mappings work from atomic context.

Regards,
Sai
