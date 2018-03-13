Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932796AbeCMLCD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:02:03 -0400
Received: from foss.arm.com ([217.140.101.70]:35684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932577AbeCMLCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:02:01 -0400
Date: Tue, 13 Mar 2018 11:01:54 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ivan Gorinov <ivan.gorinov@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 1/2] of: Documentation: Specify local APIC ID in "reg"
Message-ID: <20180313110153.vdtgljcvsbwiixwx@lakrids.cambridge.arm.com>
References: <cover.1520891263.git.ivan.gorinov@intel.com>
 <a0a0aff3befabf74a65361d0b7b7e5bc9d00176d.1520891263.git.ivan.gorinov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0a0aff3befabf74a65361d0b7b7e5bc9d00176d.1520891263.git.ivan.gorinov@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 03:21:48PM -0700, Ivan Gorinov wrote:
> Set the "reg" property to the processor's local APIC ID.
> Local APIC ID is assigned by hardware and may differ from CPU number.
> 
> Signed-off-by: Ivan Gorinov <ivan.gorinov@intel.com>
> ---
>  Documentation/devicetree/bindings/x86/ce4100.txt | 38 ++++++++++++++++++------
>  1 file changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/x86/ce4100.txt b/Documentation/devicetree/bindings/x86/ce4100.txt
> index b49ae59..5a4bd83 100644
> --- a/Documentation/devicetree/bindings/x86/ce4100.txt
> +++ b/Documentation/devicetree/bindings/x86/ce4100.txt
> @@ -7,17 +7,37 @@ Many of the "generic" devices like HPET or IO APIC have the ce4100
>  name in their compatible property because they first appeared in this
>  SoC.
>  
> -The CPU node
> -------------
> -	cpu@0 {
> -		device_type = "cpu";
> -		compatible = "intel,ce4100";
> -		reg = <0>;
> -		lapic = <&lapic0>;
> +The CPU nodes
> +-------------
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "intel,ce4100";
> +			reg = <0x00>;
> +		};
> +
> +		cpu@1 {
> +			device_type = "cpu";
> +			compatible = "intel,ce4100";
> +			reg = <0x02>;
> +		};

The unit-address (the bit after the '@' in the node name) should match
the reg, so this node should be named cpu@2.

If there's another ID associated with each CPU, then this should be
described in another property.

>  	};
>  
> -The reg property describes the CPU number. The lapic property points to
> -the local APIC timer.

Why was the lapic phandle removed?

Thanks,
Mark.

> +A "cpu" node describes one logical processor (hardware thread).
> +
> +Required properties:
> +
> +- device_type
> +	Device type, must be "cpu".
> +
> +- reg
> +	Local APIC ID, a unique number assigned to each processor by
> +	hardware. This ID is used to specify the destination of interrupt
> +	messages with "physical" destination mode, including startup IPI.
>  
>  The SoC node
>  ------------
> -- 
> 2.7.4
> 
