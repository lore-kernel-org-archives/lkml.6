Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7DFC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB6620671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Jw5sLDis"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB6620671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeKTUEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:04:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37810 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbeKTUEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:04:09 -0500
Received: from zn.tnic (p200300EC2BCDE000F95221CD056129B8.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:e000:f952:21cd:561:29b8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF6CC1EC06A7;
        Tue, 20 Nov 2018 10:35:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1542706554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Adm5WkkzbprFM32ahqbf15Fgd0jdzi9E4o2wSIXw1lY=;
        b=Jw5sLDisGmFk4LbEBuvplRyORWMzCzMJUR/f/wPzcErv0BqUNkZSUNv2hsFoeadvaNSith
        +M4wwAgX5QQ1sO9uctvCDTVYb265tAF/yyfE6lgJMKoHMW4pRvjP+YGwh4v5yQCHoAkjO+
        MudXYzZyNn/IQ7GUcC8Yp6Z1LYtzm+0=
Date:   Tue, 20 Nov 2018 10:35:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Moger, Babu" <Babu.Moger@amd.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "qianyue.zj@alibaba-inc.com" <qianyue.zj@alibaba-inc.com>,
        "xiaochen.shen@intel.com" <xiaochen.shen@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>,
        "Hurwitz, Sherry" <sherry.hurwitz@amd.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "jannh@google.com" <jannh@google.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "rian@alum.mit.edu" <rian@alum.mit.edu>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v8 04/13] arch/resctrl: Bring all the macros to resctrl.h
Message-ID: <20181120093553.GB2527@zn.tnic>
References: <20181116205407.10457-1-babu.moger@amd.com>
 <20181116205407.10457-5-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181116205407.10457-5-babu.moger@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 08:54:28PM +0000, Moger, Babu wrote:
> diff --git a/arch/x86/kernel/cpu/resctrl_monitor.c b/arch/x86/kernel/cpu/resctrl_monitor.c
> index 6d654f7b0eba..9fd62263dabd 100644
> --- a/arch/x86/kernel/cpu/resctrl_monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl_monitor.c
> @@ -28,9 +28,6 @@
>  #include <asm/cpu_device_id.h>
>  #include "resctrl.h"
>  
> -#define MSR_IA32_QM_CTR		0x0c8e
> -#define MSR_IA32_QM_EVTSEL		0x0c8d
> -
>  struct rmid_entry {
>  	u32				rmid;
>  	int				busy;
> @@ -97,8 +94,8 @@ static u64 __rmid_read(u32 rmid, u32 eventid)
>  	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
>  	 * are error bits.
>  	 */
> -	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> -	rdmsrl(MSR_IA32_QM_CTR, val);
> +	wrmsr(IA32_QM_EVTSEL, eventid, rmid);
> +	rdmsrl(IA32_QM_CTR, val);

Well, if you have a look at arch/x86/include/asm/msr-index.h, you'll see
that all MSR defines are prefixed with "MSR_" so dropping that prefix
here loses information and staring at the define doesn't tell me what it
is.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
