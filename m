Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeDSPf6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:35:58 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40048 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751228AbeDSPf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:35:57 -0400
Subject: Re: [RFC PATCH v2 3/4] acpi: apei: Do not panic() when correctable
 errors are marked as fatal.
To: "Alex G." <mr.nuke.me@gmail.com>
Cc: Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org,
        linux-edac@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
        tony.luck@intel.com, tbaicar@codeaurora.org, will.deacon@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-4-mr.nuke.me@gmail.com> <20180418175415.GJ4795@pd.tnic>
 <bdc1d19b-3cc1-3f90-d276-414aaacdbd3a@gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <e5e107e7-e18e-725a-8f9b-95e6f033ab45@arm.com>
Date: Thu, 19 Apr 2018 16:35:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <bdc1d19b-3cc1-3f90-d276-414aaacdbd3a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

(I haven't read through all this yet, just on this one:)

On 04/19/2018 03:57 PM, Alex G. wrote:
 > Maybe it's better move the AER handling to NMI/IRQ context, since
 > ghes_handle_aer() is only scheduling the real AER andler, and is irq
 > safe. I'm scratching my head about why we're messing with IRQ work from
 > NMI context, instead of just scheduling a regular handler to take care
 > of things.

We can't touch schedule_work_on() from NMI context as it takes spinlocks and
disables interrupts. (see __queue_work()) The NMI may have interrupted 
IRQ-context code
that was already holding the same locks.

IRQ-work behaves differently, it uses an llist for the work and an arch 
code hook
to raise a self-IPI.


Thanks,

James
