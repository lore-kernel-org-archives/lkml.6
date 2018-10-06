Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16345C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 05:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5241205C9
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 05:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlXZvIpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5241205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJFMta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 08:49:30 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43738 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbeJFMta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 08:49:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id p24-v6so5996959pff.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 22:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5gCcXUAurwGrJDoh/Gd2lyAJu5TWDppL/aLxQ9aIXmU=;
        b=BlXZvIpcaDt/nwaD+2Mb8vHbLIHylzQY1TU+07YEHzjEfRni3eoiV4of3A91UP7vw9
         EiT4G487OTSfPS6FMSUSfmOBIqVsUrUgfI1mzrSqi+9wH0uiXfbfruqCRtULrvx6Tzdo
         8S15qjBDS6yBcKdf1ggYorOa5x50p6VVLulFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5gCcXUAurwGrJDoh/Gd2lyAJu5TWDppL/aLxQ9aIXmU=;
        b=rLBZXGVQ2wLkIdmgPjq5+ZN1qttxTkwUflbI5FesuSggMCB3meRbvT4S2yZT8+d9/m
         9HyBj6wR2dR6Gngi3THwxnNsOikj2sE/6GVDyU65ZyT+gAejSUEY5IP4ZCak2jwxoven
         F1TfdPqeNTjdRn7VTkLuwDKViZBoBfKexjDq44vP/na0Kx2DYB41jV8XIDIUTtFhDw2p
         sJxfsmEkN1wmr7m7xnBGG4URwIko1uL8Y8FvMgNbhLTqvKgkPqwsN4U71nONlL0pAl29
         fhR3NSkGSuUvfTcvkURzb/NFWfpOV1cMTConSsUPLhecHYy85ud1cdVHxrgzr8Vxu+ru
         NJ+g==
X-Gm-Message-State: ABuFfojM1gipPFyua7B33Ac12bRT/2Yx/7f/LZ73LUe2TPVOhfQNKiTr
        EQPtDHW3JR4sycmyXzV6fQE88A==
X-Google-Smtp-Source: ACcGV61mc1ZioWrq5Aoe+5DyjDmgUfoJf1SL+3aJeTab/zWvGHFLPs/RSxUZjnNP4Nint0pyMcdJBA==
X-Received: by 2002:a63:f744:: with SMTP id f4-v6mr12978482pgk.410.1538804851480;
        Fri, 05 Oct 2018 22:47:31 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v83-v6sm19610108pfa.103.2018.10.05.22.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 22:47:30 -0700 (PDT)
Date:   Fri, 5 Oct 2018 22:50:16 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Wendy Liang <wendy.liang@xilinx.com>
Cc:     ohad@wizery.com, michal.simek@xilinx.com, robh+dt@kernel.org,
        mark.rutland@arm.com, rajan.vaja@xilinx.com, jollys@xilinx.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wendy Liang <jliang@xilinx.com>
Subject: Re: [PATCH 7/7] Documentation: devicetree: Add Xilinx R5 rproc
 binding
Message-ID: <20181006055016.GB9450@builder>
References: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
 <1534403190-28523-8-git-send-email-jliang@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534403190-28523-8-git-send-email-jliang@xilinx.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16 Aug 00:06 PDT 2018, Wendy Liang wrote:

> Add device tree binding for Xilinx Cortex-r5 remoteproc.
> 
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> ---
>  .../remoteproc/xlnx,zynqmp-r5-remoteproc.txt       | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
> new file mode 100644
> index 0000000..3940019
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
> @@ -0,0 +1,81 @@
> +Xilinx ARM Cortex A53-R5 remoteproc driver
> +==========================================
> +
> +ZynqMP family of devices use two Cortex R5 processors to help with various
> +low power / real time tasks.
> +
> +This driver requires specific ZynqMP hardware design.
> +
> +ZynqMP R5 RemoteProc Device Node:
> +=================================
> +A zynqmp_r5_remoteproc device node is used to represent a R5 IP instance
> +within ZynqMP SoC.
> +
> +Required properties:
> +--------------------
> + - compatible : Should be "xlnx,zynqmp-r5-remoteproc-1.0"

What is 1.0?

> + - reg : Address and length of the register set for the device. It
> +        contains in the same order as described reg-names
> + - reg-names: Contain the register set names.
> +              "tcm_a" and "tcm_b" for TCM memories.
> +              If the user uses the remoteproc driver with the RPMsg kernel
> +              driver,"ipi" for the IPI register used to communicate with RPU
> +              is also required.
> +              Otherwise, if user only uses the remoteproc driver to boot RPU
> +              firmware, "ipi" is not required.
> + - tcm-pnode-id: TCM resources power nodes IDs which are used to request TCM
> +                 resources for the remoteproc driver to access.
> + - rpu-pnode-id : RPU power node id which is used by the remoteproc driver
> +                  to start RPU or shut it down.
> +
> +Optional properties:
> +--------------------
> + - core_conf : R5 core configuration (valid string - split0 or split1 or
> +               lock-step), default is lock-step.
> + - memory-region: memories regions for RPU executable and DMA memory.
> + - interrupts : Interrupt mapping for remoteproc IPI. It is required if the
> +                user uses the remoteproc driver with the RPMsg kernel driver.
> + - interrupt-parent : Phandle for the interrupt controller. It is required if
> +                      the user uses the remoteproc driver with the RPMsg kernel
> +                      kernel driver.
> +
> +Example:
> +--------
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		rproc_0_fw_reserved: rproc@3ed000000 {
> +			compatible = "rproc-prog-memory";
> +			no-map;
> +			reg = <0x0 0x3ed00000 0x0 0x40000>;
> +		};
> +		rproc_0_dma_reserved: rproc@3ed400000 {
> +			compatible = "shared-dma-pool";
> +			no-map;
> +			reg = <0x0 0x3ed40000 0x0 0x80000>;
> +		};
> +	};
> +
> +	firmware {
> +		zynqmp_firmware: zynqmp-firmware {
> +			compatible = "xlnx,zynqmp-firmware";
> +			method = "smc";
> +		};
> +	};
> +
> +	zynqmp-r5-remoteproc@0 {

remoteproc@ffe00000 {

> +		compatible = "xlnx,zynqmp-r5-remoteproc-1.0";
> +		reg = <0x0 0xFFE00000 0x0 0x10000>,
> +			<0x0 0xFFE20000 0x0 0x10000>,
> +			<0x0 0xff340000 0x0 0x100>;

Make all addresses lowercase, rather than mixing case.

> +		reg-names = "tcm_a", "tcm_b", "ipi";
> +		dma-ranges;
> +		core_conf = "split0";
> +		memory-region = <&rproc_0_fw_reserved>,
> +				<&rproc_0_dma_reserved>;
> +		tcm-pnode-id = <0xf>, <0x10>;
> +		rpu-pnode-id = <0x7>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 29 4>;

interrutps = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;

> +	} ;
> -- 
> 2.7.4
> 

Regards,
Bjorn
