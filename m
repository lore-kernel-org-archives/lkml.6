Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0C8C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD94820839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544581887;
	bh=QYO5U6h0/FA3b59fEwGr/mAZ3N748YL6Mr2oTvnwTk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KI1cDavJPXAY3VNCw9eIPYm8lkA4ykUpKnT4wDpv1A1C+yqrqOw/IVibSg5G/ZlN7
	 nj/EnEQgd+atAH1+tA62uaqJMTE1w//zzbg+lesLbnWZuYsw8VU+TSq+S+mk22mS/o
	 2ljaZKt94m1gMZanf5FJRBOvW+SIVJAtI/XVBZ9U=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD94820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeLLCb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:31:26 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40960 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLCbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:31:25 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so13813382oii.8;
        Tue, 11 Dec 2018 18:31:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JSdQZJweWPk6BAdWHHcAkj2ssa0zPN7sDYIXlGWtClU=;
        b=LJdINTzosiLAaGvERb/b5KYzM0IFEEDhQ7rb+FznvlIsfVSMV66l03akrelPsnWG38
         yuwPKxy6hixfArsQhbAgtn6ayB47SVU9qr9kqz4D+LzHdjI4zR2KIVN8Eq7/vnXBGBSh
         E2fxmWw7pb5fo8aXPhZJFdrrgNR5M7eiwmSl+oT1ZIl6EmP2tqKXWzistrIEONI96jmu
         32GxvN7xNY3b6HnJiDgFedQSCo3XB2Y8LGdfotijIzzAqQFKZvKSj8eW+5QM+CaXm1+Y
         LhKoSswCd51qR7QHobzi7/Sli0MWD7wgT0h0ou7Bq/Bg4BpU/UR5zse8sMokROPqs/KW
         6SLA==
X-Gm-Message-State: AA+aEWbZ1ofjTRDIbSGd3htM0Xy6c229320AaOdzA0/YTwsEB9OA9nmm
        EPQ4yeWd4SAZs1n82+Bm7A==
X-Google-Smtp-Source: AFSGD/WUL+gr1+ZUmzzI/idm/8r5/q6w5+BAYiwGlY05OjIWeXzXSE+UTITJGjVxF5ZsAaRfqSn3vw==
X-Received: by 2002:aca:e3d3:: with SMTP id a202mr2551031oih.79.1544581883988;
        Tue, 11 Dec 2018 18:31:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f127sm9431995oia.19.2018.12.11.18.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 18:31:23 -0800 (PST)
Date:   Tue, 11 Dec 2018 20:31:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Juri Lelli <juri.lelli@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFT PATCH v1 2/4] dt-binding: cpu-topology: Move cpu-map to a
 common binding.
Message-ID: <20181212023122.GB14213@bogus>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-3-git-send-email-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543534100-3654-3-git-send-email-atish.patra@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 03:28:18PM -0800, Atish Patra wrote:
> cpu-map binding can be used to described cpu topology for both
> RISC-V & ARM. It makes more sense to move the binding to document
> to a common place.
> 
> The relevant discussion can be found here.
> https://lkml.org/lkml/2018/11/6/19
> 
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  .../{arm/topology.txt => cpu/cpu-topology.txt}     | 81 ++++++++++++++++++----
>  1 file changed, 67 insertions(+), 14 deletions(-)
>  rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)
> 
> diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> similarity index 86%
> rename from Documentation/devicetree/bindings/arm/topology.txt
> rename to Documentation/devicetree/bindings/cpu/cpu-topology.txt
> index 66848355..1de6fbce 100644
> --- a/Documentation/devicetree/bindings/arm/topology.txt
> +++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> @@ -1,12 +1,12 @@
>  ===========================================
> -ARM topology binding description
> +CPU topology binding description
>  ===========================================
>  
>  ===========================================
>  1 - Introduction
>  ===========================================
>  
> -In an ARM system, the hierarchy of CPUs is defined through three entities that
> +In a SMP system, the hierarchy of CPUs is defined through three entities that
>  are used to describe the layout of physical CPUs in the system:
>  
>  - socket
> @@ -14,9 +14,6 @@ are used to describe the layout of physical CPUs in the system:
>  - core
>  - thread
>  
> -The cpu nodes (bindings defined in [1]) represent the devices that
> -correspond to physical CPUs and are to be mapped to the hierarchy levels.
> -
>  The bottom hierarchy level sits at core or thread level depending on whether
>  symmetric multi-threading (SMT) is supported or not.
>  
> @@ -25,33 +22,37 @@ threads existing in the system and map to the hierarchy level "thread" above.
>  In systems where SMT is not supported "cpu" nodes represent all cores present
>  in the system and map to the hierarchy level "core" above.
>  
> -ARM topology bindings allow one to associate cpu nodes with hierarchical groups
> +CPU topology bindings allow one to associate cpu nodes with hierarchical groups
>  corresponding to the system hierarchy; syntactically they are defined as device
>  tree nodes.
>  
> -The remainder of this document provides the topology bindings for ARM, based
> -on the Devicetree Specification, available from:
> +Currently, only ARM/RISC-V intend to use this cpu topology binding but it may be
> +used for any other architecture as well.
>  
> -https://www.devicetree.org/specifications/
> +The remainder of this document provides the topology bindings for ARM/RISC-V, based

You already said who are current users, why restrict it to ARM and 
RISC-V here?

> +on the Devicetree Specification, available at [4].
> +
> +The cpu nodes (bindings defined in [1] for ARM or [2] for RISC-V) represent the devices that
> +correspond to physical CPUs and are to be mapped to the hierarchy levels.

The cpu topology isn't dependent on anything beyond what the DT spec 
says for cpu nodes so I think this can be simplified to just refer to 
the spec.

Plus, shouldn't [2] (numa) be [3] here.

>  If not stated otherwise, whenever a reference to a cpu node phandle is made its
>  value must point to a cpu node compliant with the cpu node bindings as
> -documented in [1].
> +documented in [1] or [3] for respective ISA.
>  A topology description containing phandles to cpu nodes that are not compliant
> -with bindings standardized in [1] is therefore considered invalid.
> +with bindings standardized in [1] or [3] is therefore considered invalid.
>  
>  ===========================================
>  2 - cpu-map node
>  ===========================================
>  
> -The ARM CPU topology is defined within the cpu-map node, which is a direct
> +The ARM/RISC-V CPU topology is defined within the cpu-map node, which is a direct
>  child of the cpus node and provides a container where the actual topology
>  nodes are listed.
>  
>  - cpu-map node
>  
> -	Usage: Optional - On ARM SMP systems provide CPUs topology to the OS.
> -			  ARM uniprocessor systems do not require a topology
> +	Usage: Optional - On SMP systems provide CPUs topology to the OS.
> +			  Uniprocessor systems do not require a topology
>  			  description and therefore should not define a
>  			  cpu-map node.
>  
> @@ -494,8 +495,60 @@ cpus {
>  	};
>  };
>  
> +Example 3: HiFive Unleashed (RISC-V 64 bit, 4 core system)
> +
> +cpus {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	compatible = "sifive,fu540g", "sifive,fu500";
> +	model = "sifive,hifive-unleashed-a00";

This is wrong. Looks like the root node, but called 'cpus'.

> +
> +	...
> +
> +	cpu-map {
> +		cluster0 {
> +			core0 {
> +				cpu = <&L12>;
> +		 	};

Mixed space and tabs.

> +			core1 {
> +				cpu = <&L15>;
> +			};
> +			core2 {
> +				cpu0 = <&L18>;
> +			};
> +			core3 {
> +				cpu0 = <&L21>;
> +			};
> +		};
> + 	};

Mixed space and tab.

> +
> +	L12: cpu@1 {
> +		device_type = "cpu";
> +		compatible = "sifive,rocket0", "riscv";
> +		reg = <0x1>;
> +	}
> +
> +	L15: cpu@2 {
> +		device_type = "cpu";
> +		compatible = "sifive,rocket0", "riscv";
> +		reg = <0x2>;
> +	}
> +	L18: cpu@3 {
> +		device_type = "cpu";
> +		compatible = "sifive,rocket0", "riscv";
> +		reg = <0x3>;
> +	}
> +	L21: cpu@4 {
> +		device_type = "cpu";
> +		compatible = "sifive,rocket0", "riscv";
> +		reg = <0x4>;
> +	}
> +};
>  ===============================================================================
>  [1] ARM Linux kernel documentation
>      Documentation/devicetree/bindings/arm/cpus.txt
>  [2] Devicetree NUMA binding description
>      Documentation/devicetree/bindings/numa.txt
> +[3] RISC-V Linux kernel documentation
> +    Documentation/devicetree/bindings/riscv/cpus.txt
> +[4] https://www.devicetree.org/specifications/
> -- 
> 2.7.4
> 
