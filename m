Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752919AbeCFA5d (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 19:57:33 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46540 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeCFA5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 19:57:31 -0500
X-Google-Smtp-Source: AG47ELuhuIezfn1VCkWC+E35qSmTcfd5YAtPhTI2dezdmSDpUj/FKgqoF5c6KjakSlHuJeLvjmXy5A==
Date: Mon, 5 Mar 2018 18:57:29 -0600
From: Rob Herring <robh@kernel.org>
To: Fabien Dessenne <fabien.dessenne@st.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Ludovic Barre <ludovic.barre@st.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: add STMicroelectronics STM32
 IPCC binding
Message-ID: <20180306005729.odhf4g5br7tfrq35@rob-hp-laptop>
References: <1519824270-7134-1-git-send-email-fabien.dessenne@st.com>
 <1519824270-7134-2-git-send-email-fabien.dessenne@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519824270-7134-2-git-send-email-fabien.dessenne@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 02:24:29PM +0100, Fabien Dessenne wrote:
> Add a binding for the STMicroelectronics STM32 IPCC block exposing a
> mailbox mechanism between two processors.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../devicetree/bindings/mailbox/stm32-ipcc.txt     | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt b/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
> new file mode 100644
> index 0000000..2321689
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/stm32-ipcc.txt
> @@ -0,0 +1,48 @@
> +* STMicroelectronics STM32 IPCC (Inter-Processor Communication Controller)
> +
> +The IPCC block provides a non blocking signaling mechanism to post and
> +retrieve messages in an atomic way between two processors.
> +It provides the signaling for N bidirectionnal channels. The number of channels
> +(N) can be read from a dedicated register.
> +
> +Required properties:
> +- compatible:   Must be "st,stm32-ipcc"

Kind of generic. There's only 1 version of h/w across all stm32 parts?

> +- reg:          Register address range (base address and length)
> +- st,proc_id:   Processor id using the mailbox (0 or 1)

s/_/-/


> +- clocks:       Input clock
> +- interrupt-names: List of names for the interrupts described by the interrupt
> +                   property. Must contain the following entries:
> +                   - "rx"
> +                   - "tx"
> +- interrupts:   Interrupt specifiers for "rx channel occupied" and "tx channel
> +                free"
> +- #mbox-cells:  Number of cells required for the mailbox specifier. Must be 1.
> +                The data contained in the mbox specifier of the "mboxes"
> +                property in the client node is the mailbox channel index.
> +
> +Optional properties:
> +- wakeup-source: Flag to indicate whether this device can wake up the system

> +- interrupts:    Wakeup interrupt used to wake up the system.
> +- interrupt-names: "wakeup" for the wakeup interrupt.

Make these required. "wakeup-source" alone determines if you use it.

> +
> +
> +
> +Example:
> +	ipcc: mailbox@4c001000 {
> +		compatible = "st,stm32-ipcc";
> +		#mbox-cells = <1>;
> +		reg = <0x4c001000 0x400>;
> +		st,proc_id = <0>;
> +		interrupts-extended = <&intc GIC_SPI 100 IRQ_TYPE_NONE>,
> +				      <&intc GIC_SPI 101 IRQ_TYPE_NONE>,
> +				      <&aiec 62 1>;
> +		interrupt-names = "rx", "tx", "wakeup";
> +		clocks = <&rcc_clk IPCC>;
> +		wakeup-source;
> +	}
> +
> +Client:
> +	mbox_test {
> +		...
> +		mboxes = <&ipcc 0>, <&ipcc 1>;
> +	};
> -- 
> 2.7.4
> 
