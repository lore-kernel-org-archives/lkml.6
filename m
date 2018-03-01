Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966009AbeCAFWq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 00:22:46 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:56184 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932243AbeCAFWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 00:22:44 -0500
X-Google-Smtp-Source: AG47ELvRzhg/eCifWtbirA4yNICNmJKGljlwoxQW7qaUua3MrJydeEIERaiV2Xi5HDaVY0vu31j9zP+KFf+fJEHKFKQ=
MIME-Version: 1.0
In-Reply-To: <e52b48cb-ce06-f4c4-ce20-9b893139e54d@sholland.org>
References: <20180228022714.30068-1-samuel@sholland.org> <20180228022714.30068-4-samuel@sholland.org>
 <CABb+yY2uueAK9kzXzU9DT2a4NtV3kK2dc_wtyFWTBn8=Z6Vi7Q@mail.gmail.com>
 <d9e14058-6ffb-e54a-1565-f228342ee1f0@sholland.org> <CABb+yY3nfVxoA9wy1ym4mtCTKCZtJjepUTr7OP1uUPmzOEzniA@mail.gmail.com>
 <e52b48cb-ce06-f4c4-ce20-9b893139e54d@sholland.org>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Thu, 1 Mar 2018 10:52:42 +0530
Message-ID: <CABb+yY0PZCFtud0qYFNV4LO5A38f=JE=ZwoN2N89c0LiX9zV-Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] mailbox: sunxi-msgbox: Add a new mailbox driver
To: Samuel Holland <samuel@sholland.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <", linux-arm-kernel"@lists.infradead.org>,
        srv_heupstream <linux-mediatek@lists.infradead.org>,
        srv_heupstream <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 12:26 AM, Samuel Holland <samuel@sholland.org> wrote:
> On 02/28/18 12:14, Jassi Brar wrote:
>> On Wed, Feb 28, 2018 at 11:21 PM, Samuel Holland <samuel@sholland.org> wrote:
>>> Hi,
>>>
>>> On 02/28/18 03:16, Jassi Brar wrote:
>>>> On Wed, Feb 28, 2018 at 7:57 AM, Samuel Holland <samuel@sholland.org> wrote:
>>>> ....
>>>>
>>>>> +/*
>>>>> + * The message box hardware provides 8 unidirectional channels. As the mailbox
>>>>> + * framework expects them to be bidirectional
>>>>>
>>>> That is incorrect. Mailbox framework does not require a channel to be
>>>> TX and RX capable.
>>>
>>> Sorry, it would be more accurate to say that the intended mailbox _client_
>>> expects the channels to be bidirectional.
>>>
>> Mailbox clients are very mailbox provider specific. Your client driver
>> is unlikely to be reuseable over another controller+remote combo.
>> Your client has to know already what a physical channel can do (RX, TX
>> or RXTX). There is no api to provide that info.
>
> There's a public specification for SCPI available[1]. I'm writing the remote
> endpoint to follow that protocol specification. (There's even an explicitly
> platform-agnostic update to the protocol called SCMI[2]). Ideally, I should be
> able to reuse the existing Linux client drivers for that protocol.
>
Thanks, I have already read those specs. Please note there are two
parts of the spec - Chapter-4-Protocol and Chapter-5-Transport.

You should definitely be able to reuse the Protocol implementation.

However, transport can vary with platform - that is why it is
separated out from Protocol. And mailbox is but one instance of
transport.
  Consider a platform with "power manager" chip connected via, say,
I2C - one could still make use of SCMI protocol. Or consider another
platform that does have mailbox link to the "power manager" but there
is no shared memory between them - you could then pass packets via the
mailbox FIFOs.
  So no, we can't have common transport implementation for every platform.

> Are you
> suggesting that I need to write a copy of the arm_scpi driver, completely
> identical except that it requests two mailbox channels per client (sending on
> one and receiving on the other) instead of one? In the >1000 line file, this is
> all that I would need to change:
>
I did unsuccessfully try to convince Sudeep to break the
implementation into platform-agnostic protocol and platform-specific
transport drivers. That way there would be no duplication of code.

Also please realise that you should not be writing controller driver,
keeping just one client driver (SCMI/SCPI) in mind. What if another
platform with same mailbox controller needs 8 TX "broadcast" links?
The h/w supports the usecase, but your driver wouldn't.

Thanks
