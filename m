Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6F78CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D23120693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwbN/Q6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D23120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754501AbeFMGQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:16:42 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33808 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754398AbeFMGQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:16:40 -0400
Received: by mail-wr0-f196.google.com with SMTP id a12-v6so1380793wro.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 23:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iDK+1EUPLUB7R8V3Kbss7QTSO3E9BRgNyrHpzR7Abmg=;
        b=bwbN/Q6VMOqXDC7et1lDb5dy7cemHjUVgmfnxNMgvC6/Zs3JX7iwOdJzMRrlhv7CLM
         WQDgiEJ5WfTNE7F/xs4XvKDJxG39hp74NdZeRgZ1KOHdj2y4OyjmDqQC9Bh7wOZcBLWb
         gtyafu5zLi6htCxxIZsO7qO0wEm0lY5BJyr9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iDK+1EUPLUB7R8V3Kbss7QTSO3E9BRgNyrHpzR7Abmg=;
        b=Ql4a+nVziTrkb87Wa+811YFk9HMbB9XwjxJNSLeh2JAdUWMhhPOxMd3e6kUHEytGBe
         nmEcRigumsn65ZLV6x/byQt7b5cxfDjHUy21nOt4ykKvxGL78IfmI8+m8H2TyJxDsgmj
         cZFzabGwYNAmwWaA1KTH+Hlmgqj5LOAPyEg3eo28VhcNxOsK2n8Xej1gPhTd4V9oVVXO
         Pl4YDuxQnhHcI40AA2ytf90JYXWbuWCY0H6aHIM2k7t+N0i4B4N4UYwPZV80q9aIWigf
         iQzq+nErgm1pcBZMroetEUGGO61ztJd1bpEaZKJ3zIe2tBMkv3+LIQSrzlGk/FmN8QeK
         fkrw==
X-Gm-Message-State: APt69E3pW84MS4dsNtUd1PDbw0ChnAM8qfAqBJ/CnEaiPJA0LjZ2b8OW
        zg10ZjCSHvGyOcc+lYnVPrWQAw==
X-Google-Smtp-Source: ADUXVKLc291Rg6xhYwyGlWiyy6CO6lhl0dgoef4uwp5BkvOkjAN/eHQ2n0BmKTeb0J2V3kaxSchvDA==
X-Received: by 2002:adf:98cf:: with SMTP id w73-v6mr3090176wrb.209.1528870599820;
        Tue, 12 Jun 2018 23:16:39 -0700 (PDT)
Received: from dell ([95.149.160.78])
        by smtp.gmail.com with ESMTPSA id l10-v6sm2154321wrm.29.2018.06.12.23.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 23:16:38 -0700 (PDT)
Date:   Wed, 13 Jun 2018 07:16:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Andrew Jeffery <andrew@aj.id.au>,
        James Feist <james.feist@linux.intel.com>,
        Jason M Biils <jason.m.bills@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>,
        Vernon Mauery <vernon.mauery@linux.intel.com>
Subject: Re: [PATCH linux-next v5 07/13] dt-bindings: mfd: Add a document for
 PECI client mfd
Message-ID: <20180613061637.GI5278@dell>
References: <20180601182216.23894-1-jae.hyun.yoo@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180601182216.23894-1-jae.hyun.yoo@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All s/mfd/MFD/

> This commit adds a dt-bindings document for PECI client multi-function
> device.

Multi-Function Device

> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: James Feist <james.feist@linux.intel.com>
> Cc: Jason M Biils <jason.m.bills@linux.intel.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Vernon Mauery <vernon.mauery@linux.intel.com>
> ---
>  .../devicetree/bindings/mfd/peci-client.txt   | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/peci-client.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/peci-client.txt b/Documentation/devicetree/bindings/mfd/peci-client.txt
> new file mode 100644
> index 000000000000..4eb8f6bb6ca4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/peci-client.txt
> @@ -0,0 +1,23 @@
> +* Intel PECI client bindings

Now it the time to expand on what a "PECI client" is.

> +Required properties:
> +- compatible : Should be "intel,peci-client", "simple-mfd".
> +- reg        : Should contain address of a client CPU. Address range of CPU
> +	       clients is starting from 0x30 based on PECI specification.

s/is starting/start/

> +Example:
> +	peci-bus@0 {

0?

> +		#address-cells = <1>;
> +		#size-cells = <0>;

No 'reg' property?

> +		< more properties >

Remove this.

> +		peci-client@30 {
> +			compatible = "intel,peci-client", "simple-mfd";
> +			reg = <0x30>;
> +		};
> +
> +		peci-client@31 {
> +			compatible = "intel,peci-client", "simple-mfd";
> +			reg = <0x31>;
> +		};
> +	};

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
