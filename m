Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756850AbeDZQnJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 12:43:09 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33149 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756828AbeDZQnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 12:43:03 -0400
X-Google-Smtp-Source: AB8JxZqTqHTsIn2z0LKRhqo7/cvoiZTRn521abq5ibGowD53RtY9JciO9SRpbqbX4W+4O67BzJCPE23M0s0KOtZRKLg=
MIME-Version: 1.0
In-Reply-To: <36dd1547-38a3-0658-b25f-fbb41d6fe265@metafoo.de>
References: <20180426161239.15234-1-mdf@kernel.org> <36dd1547-38a3-0658-b25f-fbb41d6fe265@metafoo.de>
From: Moritz Fischer <moritz.fischer.private@gmail.com>
Date: Thu, 26 Apr 2018 09:43:01 -0700
Message-ID: <CAJYdmePT+EYK5MgF4tjS47reF2FPOOd+G3jZaQ4GitgQMMQsEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dmaengine: axi-dmac: Use devm_request_irq()
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, vinod.koul@intel.com,
        dan.j.williams@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

On Thu, Apr 26, 2018 at 9:26 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 04/26/2018 06:12 PM, Moritz Fischer wrote:
>> Use devm_request_irq() instead of request_irq() to request the IRQ.
>>
>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> ---
>>
>> Hi Lars,
>>
>> was there a specific reason not to use devm_request_irq() ?
>
> Yes, it is wrong :)
>
> This reorders the sequence in the remove() function. We really need to free
> the IRQ at the point in the sequence where it is at the moment. We need to
> call tasklet_kill() after the free_irq() function has been called, otherwise
> the tasklet can be re-scheduled and we might end up with a use after free.
>
> But also if we disable the clock to the core before the IRQ is freed we
> might end up trying to access the register map while the clock is off and
> then never get a response and block the AXI bus.
>
> This is all very very unlikely to ever happen, but still I'd like to have
> correct code.

Thanks for the explanation. I'll drop this and resubmit [2/2] without
this change.

- Moritz
