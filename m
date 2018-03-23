Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751908AbeCWDEh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 23:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751758AbeCWDEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 23:04:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B2C2183E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELu7CRAlta8KZRKiNX/8V0LN7V9ex71WFUFIxxewONre3Sxs3bhqUfQYgGnxZ/ljMKLfOi8hVVuNkk97s3jAwCE=
MIME-Version: 1.0
In-Reply-To: <1521385797.6569.90.camel@baylibre.com>
References: <20180315115545.1884-1-jbrunet@baylibre.com> <20180315115545.1884-2-jbrunet@baylibre.com>
 <20180318125222.kqtybu4hiwvsx3om@rob-hp-laptop> <1521385797.6569.90.camel@baylibre.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 22 Mar 2018 22:04:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKPFbA4duG8tUKwdJTtxXOG+3kMTwu2qAVxb9zgPckL3g@mail.gmail.com>
Message-ID: <CAL_JsqKPFbA4duG8tUKwdJTtxXOG+3kMTwu2qAVxb9zgPckL3g@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: clock: meson: update documentation with
 hhi syscon
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 10:09 AM, Jerome Brunet <jbrunet@baylibre.com> wrote:
> On Sun, 2018-03-18 at 07:52 -0500, Rob Herring wrote:
>> On Thu, Mar 15, 2018 at 12:55:42PM +0100, Jerome Brunet wrote:
>> > The HHI register region hosts more than just clocks and needs to
>> > accessed drivers other than the clock controller, such as the display
>> > driver.
>> >
>> > This register region should be managed by syscon. It is already the case
>> > on gxbb/gxl and it soon will be on axg. The clock controllers must use
>> > this system controller instead of directly mapping the registers.
>>
>> Sounds like a kernel problem, not a DT one.
>
> It's a platform problem, so it has much a kernel problem (solution already
> merged) as a DT problem
>
> DT wise, we've got two devices mapping the same region
>
> in arch/arm64/boot/dts/amlogic/meson-gx.dtsi:
>> system-controller@0
>
> which is used by the display device.
>
> and in arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi (same for gxl)
>> clock-controller@0
>
> It has worked so far because the clock controller claims the region w/o
> reserving it but it remains unsafe since both device may access the same region.
> The fix is to have the clock controller go through the existing syscon.

We certainly want to avoid multiple nodes using the same mmio region.


>> With a single child, there is really no point to this change. A single
>> node can provide multiple functions. Look at nodes that are both reset
>> and clock providers.
>
> There is more than a single user, as explained above and in the cover letter of
> this series.

Right, but a single node can support more than a single user (or
provider). You don't have to have multiple nodes to have multiple
users/providers.

Rob
