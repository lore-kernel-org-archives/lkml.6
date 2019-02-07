Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F212FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B783F218FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wN//uXQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfBGDiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 22:38:19 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34515 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfBGDiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 22:38:19 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so4154318pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 19:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=qPVKwWkdOw0HxFt1OwWeIr19YD5fAZm5d0n8VM5F+Dk=;
        b=wN//uXQIeaEsHN34Xq9mNNp/7Ul0iKABTqR8T4i4TmbMmatGEcUFCXLFySjNdx0KOl
         DT+7EnBQUKKJGApyFzUHyW2VGC2k2vSabJVuWu/Gxh6RQgURFrdHpDMUjk+5HFJwQKUs
         DsjV21C3gvwimHLGo960FTBCivJSg2KY/1mNB5oGV61cQYtHc4DvFxLn0+CBIyxpK1qR
         L55BEc05HJzciJsRtvmpNpDu6dvuVhCOgJznnYyxk728G4Ve/f8YKJKbXIs27oKPwvzf
         bzWE9QZZGou1h1z4ZeyJdbrFxsFUpNUPo3UUDlvGRnYJSc7OBkq3MKL4zUjnszd398ns
         smJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qPVKwWkdOw0HxFt1OwWeIr19YD5fAZm5d0n8VM5F+Dk=;
        b=aFEJWCupWrAQM4GNyiPPpYByW1DEWzYq75XM398F6qelDanZQK4ew/0YcY//pwOCXU
         jQ8RAaCXSnxLC+DDyCkSuz4+u2sydIysiI9SxlopQoXFbHiLA1zZugmdICe9rulcQGvX
         ScIVO3sY2Md3jFexN3hJ04/XHD3MzLTe5QRslyzHFUIDGHErYWnuQIzJP791TvqDhl+K
         Kq+HfWzDeWDmxm+1luQcOIMtnCDZsPOZuWKdh75Zhywgj3QyDpW+QVGJ2psZZ8VVYKWO
         JaRKWPaRufjYJwXxLeZVafggvkM7rZT5NepgWkAoJZbFmLRZiGNAxlVPi+K9pRHVqU9g
         prVQ==
X-Gm-Message-State: AHQUAuZDjvBq8RIwYder7zziNbyXDYFeTl2g8Rc27Ade6/22Yo4iz14i
        uIIIysApjPMQjUWxw7A+h+1S8w==
X-Google-Smtp-Source: AHgI3IacPVyoRuCAlG/RwTPE7m8lC1cz6Z0gXM2lt1Rjbk2NueGs9h6T7DtKd9LLZ4mhjn9S4lBtnw==
X-Received: by 2002:a63:b24a:: with SMTP id t10mr12440029pgo.223.1549510698447;
        Wed, 06 Feb 2019 19:38:18 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
        by smtp.googlemail.com with ESMTPSA id h185sm19574767pfg.143.2019.02.06.19.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 19:38:17 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        patchwork-bot+notify@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] soc: amlogic: clk-measure: add axg and g12a support
In-Reply-To: <bc1aa147-e08a-5bb2-9a3b-cf3dad3c0235@baylibre.com>
References: <20190118103423.15075-1-jbrunet@baylibre.com> <bc1aa147-e08a-5bb2-9a3b-cf3dad3c0235@baylibre.com>
Date:   Wed, 06 Feb 2019 19:38:16 -0800
Message-ID: <7hwomcgtef.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> On 18/01/2019 11:34, Jerome Brunet wrote:
>> This patchset adds support for the axg and g12a SoC family in amlogic's
>> clock measure driver and enable it on the related devices
>> 
>> Changes since v1 [0]:
>> * re-order node in the g12a.dtsi
>> * change node name
>> 
>> [0]: https://lkml.kernel.org/r/20190117164838.8008-1-jbrunet@baylibre.com
>> 
>> Jerome Brunet (4):
>>   dt-bindings: amlogic: add new compatible devices to clk_measure
>>   soc: amlogic: clk-measure: add axg and g12a support
>>   arm64: dts: meson: axg: add clk measure support
>>   arm64: dts: meson: g12a: add clk measure support
>> 
>>  .../bindings/soc/amlogic/clk-measure.txt      |   2 +
>>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   5 +
>>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |   5 +
>>  drivers/soc/amlogic/meson-clk-measure.c       | 194 ++++++++++++++++++
>>  4 files changed, 206 insertions(+)
>> 
>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>

Queued for v5.1 (branch v5.1/dt64)

Kevin
