Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4697FC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0234920839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544581277;
	bh=EYbu8MgJLCirsT4hYmTYWW5aQZBsQHrNzVI5gypmykI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0cOEvwDnNJMpDgPVrqwUPBYr8/j6vF9ObCp+d3BGGIZ8ivEsGIw3SCGchN/uinNWB
	 7P2fVi13ufrvvkaIReTH5mYX6Ng63RN+TrTlTjP0L6HdQcMKGw8ddsSAXg5i/9IupJ
	 PQWVq+nDNdbhuhq32T4Y5XVQF0cuHmbkr7yLCddQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0234920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbeLLCVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:21:15 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43852 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeLLCVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:21:15 -0500
Received: by mail-oi1-f195.google.com with SMTP id u18so13795617oie.10;
        Tue, 11 Dec 2018 18:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hzI/A0LY6wZYrVXrit/7ykfGzVkCjWR3jJLQbnY6hpY=;
        b=Vv3DCGfXYW6bb94SLVgn3s0fb5oG2+1Chbtk6jnyke3Cxvtd2/Ic9T0L1I2EH1hoRY
         7T9biPvhgYZ4WCR4usWMjUERHB784/S9TBR2ztgOsyVcpIwTr71kEH6mLzAFpvXJO6bW
         OdSM24N0F2EAIT0wCaav84QPsvUkYrnSSUNgduU/KRpFE7M6yhRVdRaIkI/bfnM1Ff1s
         oZG1ZlcijixKEs6bvlIDcdh8a7qKf4+OCPnvx8Gis3wtCmSUN9Rdb7D9ywAJSJmLInot
         +LlFu0+G2uCdZvzSLvopoHLE8s9QIZokGbuLD8QqPgt5VYGWE08OlreTG36RI9bE9Vue
         OcLA==
X-Gm-Message-State: AA+aEWZm55l/+FLEWav5wNDVMsG+yx5Wczk93SA6QjPeEwVWUw84jyVo
        GzgSywusc3WY4y4nWkys/w==
X-Google-Smtp-Source: AFSGD/VGNw9r88AezUNEN++9+TeS54AK7bit3QfXkyLPYhrqXrOhBwW/H6MvehDnUDy05XJW/xFpQw==
X-Received: by 2002:aca:b388:: with SMTP id c130mr177489oif.123.1544581274202;
        Tue, 11 Dec 2018 18:21:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e81sm7036415oig.8.2018.12.11.18.21.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 18:21:13 -0800 (PST)
Date:   Tue, 11 Dec 2018 20:21:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Juri Lelli <juri.lelli@arm.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [RFT PATCH v1 2/4] dt-binding: cpu-topology: Move cpu-map to a
 common binding.
Message-ID: <20181212022112.GA14213@bogus>
References: <1543534100-3654-1-git-send-email-atish.patra@wdc.com>
 <1543534100-3654-3-git-send-email-atish.patra@wdc.com>
 <20181203165521.GB17883@e107155-lin>
 <f902086b-09e1-ad85-d191-137708f5b105@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f902086b-09e1-ad85-d191-137708f5b105@wdc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 09:23:42AM -0800, Atish Patra wrote:
> On 12/3/18 8:55 AM, Sudeep Holla wrote:
> > On Thu, Nov 29, 2018 at 03:28:18PM -0800, Atish Patra wrote:
> > > cpu-map binding can be used to described cpu topology for both
> > > RISC-V & ARM. It makes more sense to move the binding to document
> > > to a common place.
> > > 
> > > The relevant discussion can be found here.
> > > https://lkml.org/lkml/2018/11/6/19
> > > 
> > 
> > Looks good to me apart from a minor query below in the example.
> > 
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > 
> > > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > > ---
> > >   .../{arm/topology.txt => cpu/cpu-topology.txt}     | 81 ++++++++++++++++++----
> > >   1 file changed, 67 insertions(+), 14 deletions(-)
> > >   rename Documentation/devicetree/bindings/{arm/topology.txt => cpu/cpu-topology.txt} (86%)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/topology.txt b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> > > similarity index 86%
> > > rename from Documentation/devicetree/bindings/arm/topology.txt
> > > rename to Documentation/devicetree/bindings/cpu/cpu-topology.txt
> > > index 66848355..1de6fbce 100644
> > > --- a/Documentation/devicetree/bindings/arm/topology.txt
> > > +++ b/Documentation/devicetree/bindings/cpu/cpu-topology.txt
> > 
> > [...]
> > 
> > > +Example 3: HiFive Unleashed (RISC-V 64 bit, 4 core system)
> > > +
> > > +cpus {
> > > +	#address-cells = <2>;
> > > +	#size-cells = <2>;
> > > +	compatible = "sifive,fu540g", "sifive,fu500";
> > > +	model = "sifive,hifive-unleashed-a00";
> > > +
> > > +	...
> > > +
> > > +	cpu-map {
> > > +		cluster0 {
> > > +			core0 {
> > > +				cpu = <&L12>;
> > > +		 	};
> > > +			core1 {
> > > +				cpu = <&L15>;
> > > +			};
> > > +			core2 {
> > > +				cpu0 = <&L18>;
> > > +			};
> > > +			core3 {
> > > +				cpu0 = <&L21>;
> > > +			};
> > > +		};
> > > + 	};
> > > +
> > > +	L12: cpu@1 {
> > > +		device_type = "cpu";
> > > +		compatible = "sifive,rocket0", "riscv";
> > > +		reg = <0x1>;
> > > +	}
> > > +
> > > +	L15: cpu@2 {
> > > +		device_type = "cpu";
> > > +		compatible = "sifive,rocket0", "riscv";
> > > +		reg = <0x2>;
> > > +	}
> > > +	L18: cpu@3 {
> > > +		device_type = "cpu";
> > > +		compatible = "sifive,rocket0", "riscv";
> > > +		reg = <0x3>;
> > > +	}
> > > +	L21: cpu@4 {
> > > +		device_type = "cpu";
> > > +		compatible = "sifive,rocket0", "riscv";
> > > +		reg = <0x4>;
> > > +	}
> > > +};
> > 
> > The labels for the CPUs drew my attention. Is it intentionally random
> > (or even specific) or just chosen to show anything can be used as labels ?
> 
> SiFive generates the device tree from RTL directly. So I am not sure if they
> assign random numbers or a particular algorithm chooses the label. I tried
> to put the exact ones that is available publicly.
> 
> https://github.com/riscv/riscv-device-tree-doc/blob/master/examples/sifive-hifive_unleashed-microsemi.dts

Oh, that's really terrible. I wouldn't care as this was just source 
level stuff, but labels are part of the ABI with overlays.

Rob
