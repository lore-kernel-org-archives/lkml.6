Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbeCYXvC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 19:51:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:40810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbeCYXvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 19:51:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD9D217A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AG47ELvgegIuDNqI8nVpreaIp23TIspRfUBup9cismuX1/7VrmGR40dmnR/e50+L+tyzYMe9PYrMiKOmaVfK/bEvdVs=
MIME-Version: 1.0
In-Reply-To: <4b1a471a56ac0ebd7510f4759afce9104595d6da.1521753738.git.ivan.gorinov@intel.com>
References: <cover.1521753738.git.ivan.gorinov@intel.com> <4b1a471a56ac0ebd7510f4759afce9104595d6da.1521753738.git.ivan.gorinov@intel.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Sun, 25 Mar 2018 18:50:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL8PZLfKkU01z5u6L+9bogpBmsb2FL_DyaM=RzkGvVwRQ@mail.gmail.com>
Message-ID: <CAL_JsqL8PZLfKkU01z5u6L+9bogpBmsb2FL_DyaM=RzkGvVwRQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] of: Documentation: Specify local APIC ID in "reg"
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

On Thu, Mar 22, 2018 at 4:35 PM, Ivan Gorinov <ivan.gorinov@intel.com> wrote:
> Use the "reg" property to specify the processor's local APIC ID instead of
> setting it to the CPU node index in Device Tree.
>
> Local APIC ID is assigned by hardware and visible in the APIC ID register.
> Some processor models allow APIC ID to be changed by software, but CPUID
> instruction executed with %eax = 0x0b always returns the initial ID in %edx.
>
> Local APIC ID does not match the node index in many systems.
>
> Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
> ---
>  Documentation/devicetree/bindings/x86/ce4100.txt | 37 ++++++++++++++++++------
>  1 file changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/x86/ce4100.txt b/Documentation/devicetree/bindings/x86/ce4100.txt
> index b49ae59..4bbfed1 100644
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

As I mentioned on prior versions, drop the '0x' and leading zeros.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

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
