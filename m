Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E2CECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51C520838
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="U1nLwGYd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51C520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeJTA6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:58:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38758 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeJTA6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:58:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id f29-v6so16742674pff.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 09:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=GVBU39LMN0G5blxzn+JVWLJqFsYI8KTtP2mkWhEjBzM=;
        b=U1nLwGYdAvV0rwH8h2ArpUg4Zar8WWuniQUvRVkEyuobx0Lvj2b3UfRK2cR0NryKSg
         tXg0U4Z39BswpgWFeFkLOWIZk+EfbDVczIJacL7BsEoO72Q2NthF0fGyIOZO1r/DQOLA
         vF5Nw6aZNIdCzUSYen5YJoOLykYo2udIQjnS9vsCGTNC968BywhADqdiI0EtEoDloBE3
         6RfvVEoQl2Wud0t+hEW37D8CygbnBOlL5FdxTDwebNpJSKyQk4pFTKLmu1Y2SVjRfUsy
         yEIG1ELyH9qDEKhMpH+ZvNbZSQMdwZq43r0MaLr2x50KitPo3SwROP7N8Ek0//+Mya4s
         1Z5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=GVBU39LMN0G5blxzn+JVWLJqFsYI8KTtP2mkWhEjBzM=;
        b=oqDo/W+3qtULM7kQNIxzcv/jvIhERs4t5/Tjapqz3YQburYpnjqlomZYM1YW69oRtS
         gCYvNex7OO/1HAt78O0cMGiHR0BchGrRAciqmXwVBpjWjWEHEmO1XPfA5a8qZHi/a6sq
         +pqKDsm0HTYgNzQ0GVzFhE5V2kB+5MP7ABf9b1woHpEIjXmXrXmT1INrZXguscHzhGMb
         yqtxcteybWdNw9GNSTBU+JOg3WDcoTuQBRRkuFLnacoKtC6CE0XphivI309SpSGjSQvE
         /DxQr+DyKbUx1v05QtLVxwoFl6vGIXuztNgB8ShIaZ37JvLEeso53fYt54HKR7OV0lnk
         yuog==
X-Gm-Message-State: ABuFfoimCOvngKvC9HGGiwrFSw233WSw5aavkr/l0xfzRtye7dKDaw+P
        8pMHp3VYacJCUabHRzTFHHY2zA==
X-Google-Smtp-Source: ACcGV63LsToWO/Ffzcekp9W0ci95dOVGvoqYpUyGMoULlXJa7sOn+WtuG52kmtVNOgM2todt1+QlPg==
X-Received: by 2002:a63:844:: with SMTP id 65-v6mr32480005pgi.144.1539967920774;
        Fri, 19 Oct 2018 09:52:00 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id t22-v6sm33978608pfk.141.2018.10.19.09.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 09:51:59 -0700 (PDT)
Date:   Fri, 19 Oct 2018 09:51:59 -0700 (PDT)
X-Google-Original-Date: Fri, 19 Oct 2018 08:30:45 PDT (-0700)
Subject:     Re: [PATCH 1/2] dt-bindings: serial: add documentation for the SiFive UART driver
In-Reply-To: <20181018234352.26788-2-paul.walmsley@sifive.com>
CC:     linux-serial@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        robh+dt@kernel.org, mark.rutland@arm.com, paul@pwsan.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-607b838d-f2e0-4c14-8274-9d696cbc7e78@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 16:43:53 PDT (-0700), Paul Walmsley wrote:
> Add DT binding documentation for the Linux driver for the SiFive
> asynchronous serial IP block.  Nothing too exotic.
>
> Cc: linux-serial@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  .../bindings/serial/sifive-serial.txt         | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/sifive-serial.txt
>
> diff --git a/Documentation/devicetree/bindings/serial/sifive-serial.txt b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> new file mode 100644
> index 000000000000..8982338512f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/sifive-serial.txt
> @@ -0,0 +1,21 @@
> +SiFive asynchronous serial interface (UART)
> +
> +Required properties:
> +
> +- compatible: should be "sifive,fu540-c000-uart0" or "sifive,uart0"
> +- reg: address and length of the register space
> +- interrupt-parent: should contain a phandle pointing to the SoC interrupt
> +    controller device node that the UART interrupts are connected to
> +- interrupts: Should contain the UART interrupt identifier
> +- clocks: Should contain a clock identifier for the UART's parent clock
> +
> +
> +Example:
> +
> +uart0: serial@10010000 {
> +	compatible = "sifive,uart0";
> +	interrupt-parent = <&plic0>;
> +	interrupts = <80>;
> +	reg = <0x0 0x10010000 0x0 0x1000>;
> +	clocks = <&prci PRCI_CLK_TLCLK>;
> +};

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
