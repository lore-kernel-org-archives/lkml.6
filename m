Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FF9C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCDE20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4pG37de"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCDE20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbeLNM1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:27:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37585 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731456AbeLNM1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:27:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so4821973wrt.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 04:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PtrM3IXtbt8nwfcMS89hHRm88umcDtIpTZMA0MTgIX0=;
        b=S4pG37dez+eLRCD8auY2EVne10+IPDlwPrpWRNoqXt6AXOspZXactIBop+rWTDk5lC
         COQih7jRcUOLWdsD08s210pBj14KGPNuidY21bhyH415YD0SdoQyy1DoUgK6uL++w8BX
         ScBixlHrIzLOXwPTNW66mJu+is/jaj2mJnZ/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PtrM3IXtbt8nwfcMS89hHRm88umcDtIpTZMA0MTgIX0=;
        b=euRpt7oHOHsK8KdjLEm0s1MCvUAbDIgdmSMZ7Mg2m/3yIMEb5n7NIF1N2t/qNJ/MPa
         bdMpdLkRPTPIF4PkM0EZHkDYfmNMpzR2ygyDsjb2i9pvWiH7G9YJl6ZdJMR9bJChdUkb
         YHWv99NgIc41vwKNgGT0/kcZJX1HNGRMFc74V5EfzLdW5gXWZvEtq4NFBB8GSPcbyCJI
         3dcprpglznU+8nwpZAZlpVzcxjMmXYQWvOKuUphmuiX8tbw7qNzMI6wHSYyJTqPQhssQ
         E7nuz5Hlzy3leSQyGcSUz9Dm4KX+yzOZ/XYVOqam1XUoExuHZ7mhykAjNmfmU08lYyJt
         olrg==
X-Gm-Message-State: AA+aEWbKb/XIrYFAqxZz7FftV1LNt2j04qQ+Fjc1/8+ujxRGUeylCxVD
        kodCz7OuW0qbCRFyI7qpIi1J0Q==
X-Google-Smtp-Source: AFSGD/X3Kimwdqw7IAKtmaSZExGZ6EqNrxZat5ZWuHGB/NXcuV8mcGY0fCCpeb3MoCCveV66e/PlAA==
X-Received: by 2002:adf:eb45:: with SMTP id u5mr2330076wrn.102.1544790431370;
        Fri, 14 Dec 2018 04:27:11 -0800 (PST)
Received: from dell (host109-155-202-221.range109-155.btcentralplus.com. [109.155.202.221])
        by smtp.gmail.com with ESMTPSA id c77sm5339554wmh.12.2018.12.14.04.27.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 04:27:10 -0800 (PST)
Date:   Fri, 14 Dec 2018 12:27:09 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] video/backlight: Use of_node_name_eq for node name
 comparisons
Message-ID: <20181214122709.GX4497@dell>
References: <20181205195050.4759-28-robh@kernel.org>
 <20181206140221.rq4zp74olghzipxu@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181206140221.rq4zp74olghzipxu@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Dec 2018, Daniel Thompson wrote:

> On Wed, Dec 05, 2018 at 01:50:44PM -0600, Rob Herring wrote:
> > Convert string compares of DT node names to use of_node_name_eq helper
> > instead. This removes direct access to the node name pointer.
> > 
> > For instances using of_node_cmp, this has the side effect of now using
> > case sensitive comparisons. This should not matter for any FDT based
> > system which this is.
> > 
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Jingoo Han <jingoohan1@gmail.com>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-fbdev@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> 
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> [this is FAO Lee J. rather than recommending you take it via you tree]

Rob knows better than that. ;)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
