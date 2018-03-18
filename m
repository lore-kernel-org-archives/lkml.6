Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754086AbeCRPKE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 11:10:04 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42967 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeCRPKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 11:10:02 -0400
X-Google-Smtp-Source: AG47ELvj6cZZlkJ2eWf6f9JgZ193Osnpguj+ofRNToQkrv+oGnR4nkxxoaOSJ3YDx28r7+vq2zYhgA==
Message-ID: <1521385797.6569.90.camel@baylibre.com>
Subject: Re: [PATCH 1/4] dt-bindings: clock: meson: update documentation
 with hhi syscon
From: Jerome Brunet <jbrunet@baylibre.com>
To: Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date: Sun, 18 Mar 2018 16:09:57 +0100
In-Reply-To: <20180318125222.kqtybu4hiwvsx3om@rob-hp-laptop>
References: <20180315115545.1884-1-jbrunet@baylibre.com>
         <20180315115545.1884-2-jbrunet@baylibre.com>
         <20180318125222.kqtybu4hiwvsx3om@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-03-18 at 07:52 -0500, Rob Herring wrote:
> On Thu, Mar 15, 2018 at 12:55:42PM +0100, Jerome Brunet wrote:
> > The HHI register region hosts more than just clocks and needs to
> > accessed drivers other than the clock controller, such as the display
> > driver.
> > 
> > This register region should be managed by syscon. It is already the case
> > on gxbb/gxl and it soon will be on axg. The clock controllers must use
> > this system controller instead of directly mapping the registers.
> 
> Sounds like a kernel problem, not a DT one.

It's a platform problem, so it has much a kernel problem (solution already
merged) as a DT problem

DT wise, we've got two devices mapping the same region

in arch/arm64/boot/dts/amlogic/meson-gx.dtsi:
> system-controller@0 

which is used by the display device.

and in arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi (same for gxl)
> clock-controller@0

It has worked so far because the clock controller claims the region w/o
reserving it but it remains unsafe since both device may access the same region.
The fix is to have the clock controller go through the existing syscon.

> 
> > 
> 
> With a single child, there is really no point to this change. A single 
> node can provide multiple functions. Look at nodes that are both reset 
> and clock providers.

There is more than a single user, as explained above and in the cover letter of
this series.

> 
> What other functions are there?
> 
> Rob
