Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934685AbeB1Rx3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:53:29 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38899 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934285AbeB1RwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:52:02 -0500
X-ME-Sender: <xms:QeyWWsUuAS3XDuyKATk-0ZuCGSMdeWthBR36898uRNDa8Ze6HnUltA>
Subject: Re: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ", linux-arm-kernel"@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        srv_heupstream <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-4-samuel@sholland.org>
 <CABb+yY2uueAK9kzXzU9DT2a4NtV3kK2dc_wtyFWTBn8=Z6Vi7Q@mail.gmail.com>
From: Samuel Holland <samuel@sholland.org>
Message-ID: <d9e14058-6ffb-e54a-1565-f228342ee1f0@sholland.org>
Date: Wed, 28 Feb 2018 11:51:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CABb+yY2uueAK9kzXzU9DT2a4NtV3kK2dc_wtyFWTBn8=Z6Vi7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 02/28/18 03:16, Jassi Brar wrote:
> On Wed, Feb 28, 2018 at 7:57 AM, Samuel Holland <samuel@sholland.org> wrote:
> ....
> 
>> +/*
>> + * The message box hardware provides 8 unidirectional channels. As the mailbox
>> + * framework expects them to be bidirectional
>>
> That is incorrect. Mailbox framework does not require a channel to be
> TX and RX capable.

Sorry, it would be more accurate to say that the intended mailbox _client_
expects the channels to be bidirectional.

> You should expose each channel as per its physical capability, let the
> client configure it for direction (if its bidirectional) and acquire
> separate channels for RX and TX if it needs to.

Is there any way for the mailbox framework to inform the client that a channel
is uni/bidirectional? Or if the channel supports RX/TX specifically? I couldn't
find any.

It looks like all of the clients assume one case or the other, based on the
hardware they were initially designed to support. For example arm_scpi expects
one channel per client, while ti_sci and st_remoteproc expect two separate RX
and TX channels per client.

Since there's no API for the client to know the hardware properties, modifying
arm_scpi to support unidirectional mailbox channels would break support for all
existing bidirectional mailboxes.

To expose the physical channels individually, there would need to be an API to:
a) Determine if a mailbox channel supports unidirectional or bidirectional
   operation.
b) If a channel is unidirectional, determine which direction(s) it supports.
c) If a unidirectional channel supports both directions, configure which
   direction it should run in.

Since that API doesn't currently exist, I wrote the driver to match what the
intended client expected (as all other mailbox controller drivers currently do).

> Cheers!

Regards,
Samuel
