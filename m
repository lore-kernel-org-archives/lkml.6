Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59225C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2008220837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QqWh8jvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2008220837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeLGQ30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:29:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44570 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeLGQ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:29:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id k8so2045343pls.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=X2pu8p3WZy3f+AE9epItTKGjPmNG8+ItYYTRAcx7W+g=;
        b=QqWh8jvDePAOhofuVQh0swZUyA8wlLQxcP6G07/2c8ZcESSxdI9GUqiDoXsymf8GQl
         rMN5a73555bUpsR0RbLU2GK7F2K9gGwnOwB4Kt3ZjdV3vb2t9Y8FBrmjFQlsCh1r9Cec
         vokBs5WxtgwVmFlt1gzu23Anf6ODsjc08PotZzDOn588ukXJYHrd7MocKk7z+m5kxeh7
         tmg1ZdxjC6EhHhP1TxKTjK+/ROTYEoGJta3Z9XdlGuQjtiknQWKbGpi1Fgk3FVfzh7zX
         +U0oHPhdmIpRjbhUAxLKZP+UHBrVnTcMxLffnOtc/5GdETNFyp3YMr+P9XJBrcMLytud
         YnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=X2pu8p3WZy3f+AE9epItTKGjPmNG8+ItYYTRAcx7W+g=;
        b=p7Ns+rYQ4sUXanoU3+7QCRFKRsKyNkatVQ1pZ/7KdAJNc5L9WonPYrpfOEspKtIg/O
         w4nHjRVDpHy9cXcC/IXIN4hhafPLmon6oE5aMQ8MGKN6TyLQwFwT5cLsAvZNA72LeRd+
         O0yo5GUQ+K2EbP9foo6+tsObWb0/GNVlTVyl3js3rKzxMZ2T1v21cJQhfIBZiH05N1nj
         9EVYWhuKuWRl/pn4hSz09JM7Snqzissg2PhORTYSvf4N7m9UmowPHTuWPnMsAVstRAvw
         VKEcJJ+RpJE+ukAaE5WHmxyZ39m43FX8z1ouffd8+eegVypvnyKqPCfiCnhQ3vb3A9WP
         LBZQ==
X-Gm-Message-State: AA+aEWbqqaMC+2oHLuoYC5EX8IBR94XyHqmazmdYoPkZWqhwe/QoYvor
        TirulygkiUbAs1BXFUNJspydzWYS120=
X-Google-Smtp-Source: AFSGD/VPQK3YjMW5KcYamItmXPt3ZkU3p4hQQuC7lNu6PLyR5sqQ/VdrhMHUbVoUIHb/ETybuLhMrw==
X-Received: by 2002:a17:902:a6:: with SMTP id a35mr2734632pla.201.1544200164102;
        Fri, 07 Dec 2018 08:29:24 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id g2sm4750135pfi.95.2018.12.07.08.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 08:29:23 -0800 (PST)
Date:   Fri, 07 Dec 2018 08:29:23 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 08:23:54 PST (-0800)
Subject:     Re: [PATCH 1/4] dt-bindings: Correct RISC-V's timebase-frequency
In-Reply-To: <1543870651-16669-2-git-send-email-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        aou@eecs.berkeley.edu, atish.patra@wdc.com,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        dmitriy@oss-tech.org, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, robh+dt@kernel.org, tglx@linutronix.de,
        anup@brainfault.org, Damien.LeMoal@wdc.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     atish.patra@wdc.com
Message-ID: <mhng-a15b587e-3bfe-4568-8262-dc421585bc36@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Dec 2018 12:57:28 PST (-0800), atish.patra@wdc.com wrote:
> From: Palmer Dabbelt <palmer@sifive.com>
>
> Someone must have read the device tree specification incorrectly,
> because we were putting timebase-frequency in the wrong place.  This
> corrects the issue, moving it from
>
> / {
>         cpus {
>                 timebase-frequency = X;
>         }
> }
>
> to
>
> / {
>         cpus {
>                 cpu@0 {
>                         timebase-frequency = X;
>                 }
>         }
> }
>
> This is great, because the timer's frequency should really be a per-cpu
> quantity on RISC-V systems since there's a timer per CPU.  This should
> lead to some cleanups in our timer driver.

I think I was actually wrong here: the top version is preferred if 
timebase-frequency is the same between all CPUs, while the bottom is if it's 
different.

Updating the documentation is still good, because it matches the hardware, but 
the commit message should be a bit less assertive... :)

> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/riscv/cpus.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/riscv/cpus.txt b/Documentation/devicetree/bindings/riscv/cpus.txt
> index adf7b7af..b0b038d6 100644
> --- a/Documentation/devicetree/bindings/riscv/cpus.txt
> +++ b/Documentation/devicetree/bindings/riscv/cpus.txt
> @@ -93,9 +93,9 @@ Linux is allowed to run on.
>          cpus {
>                  #address-cells = <1>;
>                  #size-cells = <0>;
> -                timebase-frequency = <1000000>;
>                  cpu@0 {
>                          clock-frequency = <1600000000>;
> +                        timebase-frequency = <1000000>;
>                          compatible = "sifive,rocket0", "riscv";
>                          device_type = "cpu";
>                          i-cache-block-size = <64>;
> @@ -113,6 +113,7 @@ Linux is allowed to run on.
>                  };
>                  cpu@1 {
>                          clock-frequency = <1600000000>;
> +                        timebase-frequency = <1000000>;
>                          compatible = "sifive,rocket0", "riscv";
>                          d-cache-block-size = <64>;
>                          d-cache-sets = <64>;
> @@ -145,6 +146,7 @@ Example: Spike ISA Simulator with 1 Hart
>  This device tree matches the Spike ISA golden model as run with `spike -p1`.
>
>          cpus {
> +                timebase-frequency = <1000000>;
>                  cpu@0 {
>                          device_type = "cpu";
>                          reg = <0x00000000>;
