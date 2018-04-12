Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeDLGKq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 02:10:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6737 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750743AbeDLGKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 02:10:45 -0400
Subject: Re: [PATCH v11 0/4] set VSESR_EL2 by user space and support
 NOTIFY_SEI notification
To: James Morse <james.morse@arm.com>
CC: <rkrcmar@redhat.com>, <corbet@lwn.net>, <christoffer.dall@linaro.org>,
        <marc.zyngier@arm.com>, <linux@armlinux.org.uk>,
        <catalin.marinas@arm.com>, <rjw@rjwysocki.net>, <bp@alien8.de>,
        <lenb@kernel.org>, <kvm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <linux-acpi@vger.kernel.org>,
        <devel@acpica.org>, <huangshaoyu@huawei.com>, <zhengxiang9@huawei.com>
References: <1523309796-36423-1-git-send-email-gengdongjiu@huawei.com>
 <d94439b6-9b9a-9bd0-ddec-3bb63ede9461@arm.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <5161fb31-e5bb-872c-3e12-d7d38326aaca@huawei.com>
Date: Thu, 12 Apr 2018 14:09:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d94439b6-9b9a-9bd0-ddec-3bb63ede9461@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.142.68.147]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James，
   thanks for this mail.

On 2018/4/10 22:15, James Morse wrote:
> Hi Dongjiu Geng,
> 
> On 09/04/18 22:36, Dongjiu Geng wrote:
>> 1. Detect whether KVM can set set guest SError syndrome
>> 2. Support to Set VSESR_EL2 and inject SError by user space.
>> 3. Support live migration to keep SError pending state and VSESR_EL2 value.
>> 4. ACPI 6.1 adds support for NOTIFY_SEI as a GHES notification mechanism, so support this
>>    notification in software, KVM or kernel ARCH code call handle_guest_sei() to let ACP driver
>>    to handle this notification.
> 
> Please don't post code during the merge-window, will this apply to v4.17-rc1? We
> can't know until its tagged.
I do not know when it is merge-window. About the apply version, it does not have limited.

> 
> 
> This series is doing two separate things, please split it into two series.
OK, thanks!

> 
> But on the ACPI front: I don't see how any OS can support your NOTIFY_SEI when
> firmware is ignoring the normal world's PSTATE.A.
> 
> The latest lobe of that discussion was on the list here:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1611496.html
I have replied the mail.
I still have some questions that need to clarify with you.
After clarification, we will follow that.
The question is in the reply of this mail "https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1611496.html"

> 
> 
> As it is, we would need to spot SError being delivered while SError is masked,
> spray nasty messages about firmware being horrifically buggy, then panic(). For
> a corrected error, this looks bad, but its preferable to letting firmware
> silently overwrite the exception registers, causing linux to spin through the
> vectors 'eret' with all exceptions masked.
> I still think its best to wait for firmware that does the right thing.
Let us  discuss that in another mail.
In a summary, I think firmware follow below rule can be OK, right?
1. The exception came from the EL that SError should be routed to(according to hcr_EL2.{AMO, TGE}),but PSTATE.A was set, EL3 firmware can't deliver SError;
2. The exception came from the EL that SError should not be routed to(according to hcr_EL2.{AMO, TGE}),even though the PSTATE.A was set,EL3 firmware still deliver SError

> 
> 
> Thanks,
> 
> James
> 
> .
> 
