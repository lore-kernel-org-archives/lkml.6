Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935307AbeCTAkQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 20:40:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933689AbeCTAkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 20:40:14 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30ACC217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELvMth/KGg94Xt27n6ph+CqQlVo5KE8OpWASxWfGotawUHmR7ndXLH3IVyOYsu/gsw4kDJ1OQMf32bn8jkzxq8U=
MIME-Version: 1.0
In-Reply-To: <c5eb2fd010855d187007859e7a332c866fbd41ec.1520974793.git.ivan.gorinov@intel.com>
References: <cover.1520974793.git.ivan.gorinov@intel.com> <c5eb2fd010855d187007859e7a332c866fbd41ec.1520974793.git.ivan.gorinov@intel.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 19 Mar 2018 19:39:52 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLvV6-MY_4ui8T3nYnqG0q=QN6nnCVxbxD0aarhLqjNKA@mail.gmail.com>
Message-ID: <CAL_JsqLvV6-MY_4ui8T3nYnqG0q=QN6nnCVxbxD0aarhLqjNKA@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] of: Documentation: Specify local APIC ID in "reg"
To: Ivan Gorinov <ivan.gorinov@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 5:05 PM, Ivan Gorinov <ivan.gorinov@intel.com> wrote:
> Use the "reg" property to specify the processor's local APIC ID.
> Local APIC ID is assigned by hardware and may differ from CPU number.

Is "CPU number" a s/w visible h/w number or has it just been an index
for DT? In the latter case, I'm okay with this change. In the former
case, you should stick to the existing numbering. For example on ARM,
the number here corresponds to a core ID number in a register called
MPIDR.

>
> Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
> ---
>  Documentation/devicetree/bindings/x86/ce4100.txt | 37 ++++++++++++++++++------
>  1 file changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/x86/ce4100.txt b/Documentation/devicetree/bindings/x86/ce4100.txt
> index b49ae59..1c41cbd 100644
> --- a/Documentation/devicetree/bindings/x86/ce4100.txt
> +++ b/Documentation/devicetree/bindings/x86/ce4100.txt
> @@ -7,17 +7,36 @@ Many of the "generic" devices like HPET or IO APIC have the ce4100
>  name in their compatible property because they first appeared in this
>  SoC.
>
> -The CPU node
> -------------
> -       cpu@0 {
> -               device_type = "cpu";
> -               compatible = "intel,ce4100";
> -               reg = <0>;
> -               lapic = <&lapic0>;
> +The CPU nodes
> +-------------
> +
> +       cpus {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               cpu@0x00 {

Drop the '0x' and leading 0s.

> +                       device_type = "cpu";
> +                       compatible = "intel,ce4100";
> +                       reg = <0x00>;
> +               };
> +
> +               cpu@0x02 {
> +                       device_type = "cpu";
> +                       compatible = "intel,ce4100";
> +                       reg = <0x02>;
> +               };
>         };
>
> -The reg property describes the CPU number. The lapic property points to
> -the local APIC timer.
> +A "cpu" node describes one logical processor (hardware thread).
> +
> +Required properties:
> +
> +- device_type
> +       Device type, must be "cpu".
> +
> +- reg
> +       Local APIC ID, the unique number assigned to each processor by
> +       system hardware.
>
>  The SoC node
>  ------------
> --
> 2.7.4
>
