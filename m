Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934862AbeBMJ6K (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 04:58:10 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934683AbeBMJ6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 04:58:06 -0500
Subject: Re: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future
 CPUs
To: David Woodhouse <dwmw2@infradead.org>, tglx@linutronix.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com
References: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk>
 <1518449255-2182-2-git-send-email-dwmw@amazon.co.uk>
 <7e2e5ad1-49b6-1fdb-4a62-8ad6aefc30a0@redhat.com>
 <1518509708.12890.33.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <27c85759-e662-d281-f8a0-0a80ca8ee18f@redhat.com>
Date: Tue, 13 Feb 2018 10:58:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1518509708.12890.33.camel@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2018 09:15, David Woodhouse wrote:
>>>  
>>> -		if (!data)
>>> +		if (!data && !spectre_v2_ibrs_all())
>>>  			break;
>> This should check the value of IBRS_ALL in the VM, not in the host.
> No, it's host we want. If IBRS_ALL is set in the host, we set the
> actual hardware MSR once at boot time and never touch it again. The
> SPEC_CTRL MSR we expose to guests is purely a no-op fiction.
> 
> If spectre_v2_ibrs_all() is true then KVM should *never* actually pass
> through or touch the real MSR.

That would be nice but unfortunately it's not possible. :(

The VM might actually not have IBRS_ALL, as usual the reason is
migration compatibility.  In that case, that no-op fiction would be very
slow because the VM will actually do a lot of SPEC_CTRL writes.

So the right logic is:

- if the VM has IBRS_ALL, pass through the MSR when it is zero and
intercept writes when it is one (no writes should happen)

- if the VM doesn't have IBRS_ALL, do as we are doing now, independent
of what the host spectre_v2_ibrs_all() setting is.

Paolo
