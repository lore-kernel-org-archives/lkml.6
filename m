Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbeBIMm4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:42:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750945AbeBIMmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:42:54 -0500
Subject: Re: [PATCH] KVM: X86: Fix SMRAM accessing even if VM is shutdown
To: Xiao Guangrong <guangrong.xiao@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <1517984706-47244-1-git-send-email-wanpengli@tencent.com>
 <233cfca3-971e-c3c2-f0fe-b50dd69d2546@redhat.com>
 <d21822e2-2982-7182-1d9a-be3e5b7e1553@gmail.com>
 <5664ca7f-f391-0301-3a0d-666b73f17b15@redhat.com>
 <9034fe13-26c4-ee72-5b94-19aa8fc11efc@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0aedd0e5-f5eb-54d8-6f77-e7a12c65fed5@redhat.com>
Date: Fri, 9 Feb 2018 13:42:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <9034fe13-26c4-ee72-5b94-19aa8fc11efc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2018 04:22, Xiao Guangrong wrote:
>>
> 
> That is a good question... :)
> 
> This case (with KVM_MEMSLOT_INVALID is set) can be easily constructed,
> userspace should avoid this case by itself (avoiding vCPU accessing the
> memslot which is being updated). If it happens, it's a operation issue
> rather than INTERNAL ERROR.
> 
> Maybe treat it as MMIO accessing and return to userspace with MMIO_EXIT
> is a better solution...

Yeah, that's what emulation would do (except if it's an instruction
fetch, which will cause emulation to fail).  I think it's a bug in the
non-EPT #PF case that we return with -EFAULT.

Paolo
