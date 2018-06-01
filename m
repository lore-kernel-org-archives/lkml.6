Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750968AbeFAVEs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 17:04:48 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39428 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750740AbeFAVEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 17:04:43 -0400
X-Google-Smtp-Source: ADUXVKLuCPopI8GWMKGUhvcfXWdqSERsJa/toAgzALdg9E/nyWNAQ7zt6ZRgGKMCA6MB6DdXG3Enew==
Date: Fri, 1 Jun 2018 15:04:39 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com,
        robh@kernel.org, mark.rutland@arm.com, frowand.list@gmail.com,
        matt.sealey@arm.com, charles.garcia-tobin@arm.com, john.horley@arm.com,
        mike.leach@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] coresight: Update device tree bindings
Message-ID: <20180601210439.GF9838@xps15>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:15:59PM +0100, Suzuki K Poulose wrote:
> Coresight uses DT graph bindings to describe the connections of the
> components. However we have some undocumented usage of the bindings
> to describe some of the properties of the connections.
> 
> The coresight driver needs to know the hardware ports invovled
> in the connection and the direction of data flow to effectively
> manage the trace sessions. So far we have relied on the "port"
> address (as described by the generic graph bindings) to represent
> the hardware port of the component for a connection.
> 
> The hardware uses separate numbering scheme for input and output
> ports, which implies, we could have two different (input and output)
> ports with the same port number. This could create problems in the
> graph bindings where the label of the port wouldn't match the address.
> 
> e.g, with the existing bindings we get :
> 
> 	port@0{				// Output port 0
> 		reg = <0>;
> 		...
> 	};
> 
> 	port@1{
> 		reg = <0>;		// Input port 0
> 		endpoint {
> 			slave-mode;
> 			...
> 		};
> 	};
> 
> With the new enforcement in the DT rules, mismatches in label and address
> are not allowed (as see in the case for port@1). So, we need a new mechanism
> to describe the hardware port number reliably.
> 
> Also, we relied on an undocumented "slave-mode" property (see the above
> example) to indicate if the port is an input port. Let us formalise and
> switch to a new property to describe the direction of data flow.
> 
> There were three options considered for the hardware port number scheme:
> 
>  1) Use natural ordering in the DT to infer the hardware port number.
>   i.e, Mandate that the all ports are listed in the DT and in the ascending
>   order for each class (input and output respectively).
>    Pros :
>       - We don't need new properties and if the existing DTS list them in
>         order (which most of them do), they work out of the box.
>    Cons :
>       - We must list all the ports even if the system cannot/shouldn't use
>         it.
>       - It is prone to human errors (if the order is not kept).
> 
>  2) Use an explicit property to list both the direction and the hw port
>     number and direction. Define "coresight,hwid" as 2 member array of u32,
>     where the members are port number and the direction respectively.
> 	e.g
> 
> 	port@0{
> 		reg = <0>;
> 		endpoint {
> 			coresight,hwid = <0 1>;	// Port # 0, Output
> 		}
> 	};
> 
> 	port@1{
> 		reg = <1>;
> 		endpoint {
> 			coresight,hwid = <0 0>;	// Port # 0, Input
> 		};
> 	};
> 
> 	Pros:
> 	  - The bindings are formal but not so reader friendly and could potentially
> 	    lead to human errors.
> 	Cons:
> 	  - Backward compatiblity is lost.
>  3) Use explicit properties (implemented in the series) for the hardware
>     port id and direction. We define a new property "coresight,hwid" for
>     each endpoint in coresight devices to specify the hardware port number
>     explicitly. Also use a separate property "direction" to specify the
>     direction of the data flow.
> 
> 	e.g,
> 
> 	port@0{
> 		reg = <0>;
> 		endpoint {
> 			direction = <1>;	// Output
> 			coresight,hwid = <0>;	// Port # 0
> 		}
> 	};
> 
> 	port@1{
> 		reg = <1>;
> 		endpoint {
> 			direction = <0>;	// Input
> 			coresight,hwid = <0>;	// Port # 0
> 		};
> 	};
> 
>     Pros:
>        - The bindings are formal and reader friendly, and less prone to errors.
>     Cons:
>        - Backward compatibility is lost.
> 
> 
> This series achieves implements Option (3) listed above while still retaining
> the backward compatibility. The driver now issues a warning (once) when it
> encounters the old bindings.
> It also cleans up the platform parsing code to reduce the memory usage by
> reusing the platform description. The series also includes the
> changes for Juno platform as an example. If there are no objections
> to the approach, I could post the series, converting all the
> in-kernel DTS to the new binding.
> 
> Suzuki K Poulose (8):
>   dts: binding: coresight: Document graph bindings
>   coresight: Fix remote endpoint parsing
>   coresight: Cleanup platform description data
>   coresight: platform: Cleanup coresight connection handling
>   coresight: Handle errors in finding input/output ports
>   dts: coresight: Clean up the device tree graph bindings
>   dts: coresight: Define new bindings for direction of data flow
>   dts: juno: Update coresight bindings for hw port
> 
>  .../devicetree/bindings/arm/coresight.txt          |  52 ++++++++--
>  arch/arm64/boot/dts/arm/juno-base.dtsi             |  82 +++++++++++----
>  arch/arm64/boot/dts/arm/juno.dts                   |   5 +-
>  drivers/hwtracing/coresight/coresight.c            |  28 ++----
>  drivers/hwtracing/coresight/of_coresight.c         | 111 ++++++++++++---------
>  include/linux/coresight.h                          |  11 +-
>  6 files changed, 181 insertions(+), 108 deletions(-)

Aside from the comments I've already posted I'm pretty much good with this set.
Please rebase the next revision on my "next" branch and run checkpatch.pl on the
set.  Patch 6/8 and 7/8 are generating warnings.

Thanks,
Mathieu

> 
> -- 
> 2.7.4
> 
