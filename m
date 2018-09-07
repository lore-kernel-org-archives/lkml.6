Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAD2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB902083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB902083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeIGXcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:32:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40487 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbeIGXcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:32:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id l63-v6so7405149pga.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 11:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=vIIkIbgiuSUJjpz0K1r5H4tLrFnyyZwMmUr4AOpBfZ0=;
        b=oz+EJwVnFHzoUl3boqy2vM+62qjUvu5dnFFhwBLIYZNc/f3TEEySiWzXNLQec72wSa
         Rl2Eawb2892OWoOx832VkqvgvNHBVNN6ON37UXDZ6jESE75kvOyyl8N5PL17A4+z3LcV
         rmftzQfq6rNBNJqiDTXmYerjP8Jq5vLCa1hKW90ugu/m0s26P44PdmFq+d22lAsHK6Ua
         1VJu/GYGFn16o5Ra+jagQW+U9PK2q9SU+YFfKF/xOQHT8/zG8Cota03S2wEgmVzU0ITP
         oVEJHF8gu1xs51E8O5UkQZIgD/muw8VYalrSipkg54eljfHoYxHsVIcjqVTWYd4zxSIn
         7a+w==
X-Gm-Message-State: APzg51CNU1N/N7LPOtkSurZIe4mKPwJx87uSdSxdtd2D7avjJgUh0QBF
        HOVKtNYJ09akDsIrXxI3LPVi7A==
X-Google-Smtp-Source: ANB0VdaayRBE+sC4vX9s9k8pwyl3Tl4r94Tp0z0OKb1HzvxDByeJzqmfySGMWfaRYXF0WeqT9XL9oQ==
X-Received: by 2002:a62:2646:: with SMTP id m67-v6mr10168793pfm.254.1536346186233;
        Fri, 07 Sep 2018 11:49:46 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:1004:378:275a:f56d:4749:7a3b])
        by smtp.gmail.com with ESMTPSA id l85-v6sm15587466pfk.34.2018.09.07.11.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 11:49:44 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc:     "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V4 3/3] x86/efi: Introduce EFI_PAGE_FAULT_HANDLER
References: <1536276468-28499-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536276468-28499-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <20180907112207.GS24106@hirez.programming.kicks-ass.net>
 <FFF73D592F13FD46B8700F0A279B802F485BA5C1@ORSMSX114.amr.corp.intel.com>
Message-ID: <e10acaa8-f5d8-85f3-219c-86fafd793a87@redhat.com>
Date:   Sat, 8 Sep 2018 00:19:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F485BA5C1@ORSMSX114.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 11:53 PM, Prakhya, Sai Praneeth wrote:
> >> There may exist some buggy UEFI firmware implementations that might
> >> access efi regions other than EFI_RUNTIME_SERVICES_<CODE/DATA> even
> >> after the kernel has assumed control of the platform. This violates
> >> UEFI specification.
> >>
> >> If selected, this debug option will print a warning message if the
> >> UEFI firmware tries to access any memory region which it shouldn't.
> >> Along with the warning, the efi page fault handler will also try to
> >> recover from the page fault triggered by the firmware so that the
> >> machine doesn't hang.
> >
> > Why make this optional?
>
> I made it as a config option in RFC because the page fault handler was
> complicated and touching many parts (it had lots of code change and I didn't want
> to break any existing functionality). Now that it's simple, I don't think we need
> the config option.
>
> Without efi page fault handler, any page fault caused by firmware should panic
> kernel but with this patch I think we are just improving existing condition (ideally).
>
> So, if Thomas, Ingo, Andy, Ard and Boris are ok.. I will make it as default (i.e. without
> config).
>
> Regards,
> Sai
>
Also, some distributions already have specific ways to handle buggy firmwares which can be at times dependent on the underlying hardware and the firmware versions.

I would suggest that we enable this under a CONFIG for the first round and once it is tested with wider variety of x86 machines which have buggy or orphaned firmware and linux (and reboot) works fine with them, we can drop the CONFIG option in future and enable this by default.

Regards,
Bhupesh
