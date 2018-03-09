Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbeCIFDM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 00:03:12 -0500
Received: from mail-qt0-f171.google.com ([209.85.216.171]:32925 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeCIFDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 00:03:10 -0500
X-Google-Smtp-Source: AG47ELtLTw681kjhEX2JCbO2+PuMsD2omFKKIjeaL188DL3emt0Gb81zqOfYJKb0yNhbFrDViqa6M0AcbiE+ds2r5ec=
MIME-Version: 1.0
In-Reply-To: <CAARXrtktSUMBuHUUjqTgrWNZaHVkOC9DUQEr4WKeGNz2z6WVdA@mail.gmail.com>
References: <1520542640-9185-1-git-send-email-eajames@linux.vnet.ibm.com>
 <1520542640-9185-3-git-send-email-eajames@linux.vnet.ibm.com> <CAARXrtktSUMBuHUUjqTgrWNZaHVkOC9DUQEr4WKeGNz2z6WVdA@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 9 Mar 2018 15:32:48 +1030
X-Google-Sender-Auth: DfkwjGZeDMW6KvVh9XZo1-BfqZ8
Message-ID: <CACPK8XdFC1KZVj0RM1tjBXqNuz18Su=S2_-o_9Lsgma7ixPogw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] clk: aspeed: Prevent reset if clock is enabled
To: Lei YU <mine260309@gmail.com>
Cc: Eddie James <eajames@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
        sboyd@kernel.org, Ryan Chen <ryan_chen@aspeedtech.com>,
        Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lei,

On Fri, Mar 9, 2018 at 1:49 PM, Lei YU <mine260309@gmail.com> wrote:
>
>
>
>>  static int aspeed_clk_enable(struct clk_hw *hw)
>>  {
>>         struct aspeed_clk_gate *gate = to_aspeed_clk_gate(hw);
>> @@ -215,6 +227,11 @@ static int aspeed_clk_enable(struct clk_hw *hw)
>>
>>         spin_lock_irqsave(gate->lock, flags);
>>
>> +       if (aspeed_clk_is_enabled(hw)) {
>> +               spin_unlock_irqrestore(gate->lock, flags);
>> +               return 0;
>> +       }
>> +
>
> I think this piece of code can be run before spin_lock_irqsave(), so it is
> able to just return without spin_unlock_irqrestore()?

As far as I understand, we are not running under any kind of lock when
calling into the clock framework.

Consider two clock consumer (any old driver) attempting an operation
to change the state of a clock. The first consumer calls
aspeed_clk_enable, and run the aspeed_clk_is_enabled function. This
consumer is then preempted, and the second consume calls
aspeed_clk_disable, taking the lock, they then disable the clock. They
return out of aspeed_clk_disable and the first consumer can run again.

The first consumer has already checked that the clock was disabled, so
they execute the 'return 0', without enabling it. However, their
information is out of date, so they are now in a state where the clock
hardware is disabled, but the clock framework and the consumer think
it is enabled.

By doing the check under a lock, the second consumer won't be able to
perform it's operation until after the first has finished (and as we
disable IRQs, the first bit of code will run to completion without
being preempted).

I might have missed something, so if you're confident we don't need to
check the value under a lock then please let me know :)

Cheers,

Joel
