Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755663AbeDWQsn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:48:43 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:33747 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755308AbeDWQsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:48:42 -0400
X-Google-Smtp-Source: AB8JxZq/+E7yjAhpJlps6FvO/QVKhya7LxwGcVUSN6osG9OofihZX0IqcgPNAWhMacn+zvIvEg6LsMHhdQDgfbdG7u0=
MIME-Version: 1.0
In-Reply-To: <b5c77c79-11e2-ce71-7037-6d050677241a@arm.com>
References: <20180423103440.26592-1-marc.zyngier@arm.com> <CAKv+Gu9zrnUevJdde_6vSwqFh0ojtDdC7Y_uHxqcGmE=5OZizw@mail.gmail.com>
 <b5c77c79-11e2-ce71-7037-6d050677241a@arm.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 23 Apr 2018 18:48:41 +0200
Message-ID: <CAKv+Gu9rxc4em8gxR41BGF-LTFYt+m=nu8b-7qjRCAr8RmSoxQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Level-triggered MSI support
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 April 2018 at 17:53, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 23/04/18 12:51, Ard Biesheuvel wrote:
>> On 23 April 2018 at 12:34, Marc Zyngier <marc.zyngier@arm.com> wrote:
>>> This series is a first shot at teaching the kernel about the oxymoron
>>> expressed in $SUBJECT. Over the past couple of years, we've seen some
>>> SoCs coming up with ways of signalling level interrupts using a new
>>> flavor of MSIs, where the MSI controller uses two distinct messages:
>>> one that raises a virtual line, and one that lowers it. The target MSI
>>> controller is in charge of maintaining the state of the line.
>>>
>>> This allows for a much simplified HW signal routing (no need to have
>>> hundreds of discrete lines to signal level interrupts if you already
>>> have a memory bus), but results in a departure from the current idea
>>> the kernel has of MSIs.
>>>
>>> This series takes a minimal approach to the problem, which is to allow
>>> MSI controllers to use not only one, but up to two messages at a
>>> time. This is controlled by a flag exposed at MSI irq domain creation,
>>> and is only supported with platform MSI.
>>>
>>> The rest of the series repaints the Marvell ICU/GICP drivers which
>>> already make use of this feature with a side-channel, and adds support
>>> for the same feature in GICv3. A side effect of the last GICv3 patch
>>> is that you can also use SPIs to signal PCI MSIs. This is a last
>>> resort measure for SoCs where the ITS is unusable for unspeakable
>>> reasons.
>>>
>>
>> Hi Marc,
>>
>> I am hitting the splat below when trying this series on SynQuacer,
>> with mbi range <64 32> (which is reserved in the h/w manual but note
>> that I haven't confirmed with Socionext whether these are expected to
>> work or not. However, I don't think that makes any difference
>> regarding the issue below.)
>
> [...]
>
> For the record: After some IRC debugging with Ard, this turns out to be
> due to two issues:
> - GICv3 is now advertising several domains, all using the same device nodes
> - irq_find_host() is picking the first one, which is the wrong one.
>
> A good way to avoid this mess is to:
> - Let GICv3 advertise its core domain with DOMAIN_BUS_WIRED (consistent
> with what the armada-370-xp driver is already doing)
> - Let irq_find_host return DOMAIN_BUS_WIRED before trying DOMAIN_BUS_ANY
> (consistent with the way irq_create_fwspec_mapping works).
>
> I've stashed the whole series at [1] with these two fixes.
>

For the fixed version (1c1eff8a4d6b14aae9a709570e692f5fcd837670)

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org> # SynQuacer
