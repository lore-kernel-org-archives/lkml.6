Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B102C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8F3206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8F3206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730675AbeKQJly convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:41:54 -0500
Received: from mga14.intel.com ([192.55.52.115]:35999 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729592AbeKQJly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:41:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 15:27:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,242,1539673200"; 
   d="scan'208";a="86589363"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 16 Nov 2018 15:27:32 -0800
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 16 Nov 2018 15:27:32 -0800
Received: from crsmsx151.amr.corp.intel.com (172.18.7.86) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 16 Nov 2018 15:27:31 -0800
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.85]) by
 CRSMSX151.amr.corp.intel.com ([169.254.3.57]) with mapi id 14.03.0415.000;
 Fri, 16 Nov 2018 17:27:29 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] x86/fsgsbase/64: Fix the base write helper functions
Thread-Topic: [PATCH v4] x86/fsgsbase/64: Fix the base write helper functions
Thread-Index: AQHUfGOK+9iMNa6Qske+lWK44a7PAKVTc62A
Date:   Fri, 16 Nov 2018 23:27:27 +0000
Message-ID: <7A9F766D-333A-4ED5-8C3C-AE3BEBE39C69@intel.com>
References: <20181114214641.8573-1-chang.seok.bae@intel.com>
In-Reply-To: <20181114214641.8573-1-chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.147.160]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2357DF8BB798E34C81D13B648EA01A57@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Nov 14, 2018, at 13:46, Bae, Chang Seok <chang.seok.bae@intel.com> wrote:
> 
> int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
> @@ -758,11 +720,45 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
> 
> 	switch (option) {
> 	case ARCH_SET_GS: {
> -		ret = x86_gsbase_write_task(task, arg2);
> +		preempt_disable();
> +		if (unlikely(arg2 >= TASK_SIZE_MAX))
> +			return -EPERM;

Sorry, preempt_disabled() should go after this.
Chang
