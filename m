Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123C2C65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2C420881
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vcdqm4RB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD2C420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeLHSSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:18:25 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43908 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeLHSSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:18:25 -0500
Received: by mail-qk1-f195.google.com with SMTP id r71so4353578qkr.10;
        Sat, 08 Dec 2018 10:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=rt5h1t7zqFvLUJ9jATybrdq6U3TEt2hEHacZUTDXfPk=;
        b=Vcdqm4RBsgRu2n5tATS12D6pNeshWOEfepKrJDupOlafBT+Fbz+Ymb90G9/Y5EM5Ma
         x9GNm47TKQ9WvSs0NztEvv8+rDzsYhyWkSm8HD8GCOklnLz7dD8dU3o4Zko4ZtiuOABh
         S6IcpKgWhjHmjJqHLfszVWVJegj0KaTwTAUaQ18KVkIStVIV3jzlmcThTN12Fo+6/uSx
         EpYC+osuVAg3+/ZdI87ojSuRF48QQHvTJeLW7YqxYOUgtX8yDSIifbgEKLQhAkgpif/k
         SWA+3tQ/P4XnZe53SXnhBGU0EdkHMOGzR+NjfKajOJHG3pqavxezI3TtshJkaP5PrC8Z
         gDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=rt5h1t7zqFvLUJ9jATybrdq6U3TEt2hEHacZUTDXfPk=;
        b=K73k+Rg5UHhoxlqqybviokXQYP3QdIkqncOZaq/MWY0ewLp7b+hNveATXCUDk34YoT
         Qc/NhF9EKQ5hb2C3mtsOcjibneS9cFPLWdcdb/qy05cUnZY1rU/9CEbp2XOpat0fTK2D
         1wStjoq4wk6CzJZdYcYmjA+zLBeekDM21ZGsoEN+rES7lvhjx/naUcRkBytMAwsxHgHg
         H1EOppeRCZGiDb/5zbWNDGjzCbPS9nmDj0XNqC9ewx3Pibcmp7+VB0/8lroqlOgQf3QE
         D3u9N9lX0lwAgggyIaSuCl1WCtR7Hwz1JGAXUXa1OTQme20H6teET6stQ2N/TpGav3rj
         hkew==
X-Gm-Message-State: AA+aEWZeUDW11q8y3pK5xBNqeWml8vx/pe1e2zkQfURZZmPcmhI4Wz6l
        AnP4Jn2ydsnogl7svIvxXAI=
X-Google-Smtp-Source: AFSGD/U1s97S1vD9Sw5+QE5G+CXlSkU8Q2+1zcPMiN5om+MjxGt3FHFG7SWMndiZlPzi9dkw8kIZ+w==
X-Received: by 2002:a37:ccc2:: with SMTP id n63mr5849499qkl.82.1544293104339;
        Sat, 08 Dec 2018 10:18:24 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id n8sm4653630qtk.91.2018.12.08.10.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 10:18:23 -0800 (PST)
Date:   Sat, 8 Dec 2018 16:18:18 -0200
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 0/3] Add devicetree support for ad5933
Message-ID: <cover.1544292845.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches change voltage regulator error handling for the
ad5933.
It also add an option to specify external clock reference using a clock
framework and remove the old platform data structure.
Finally it adds binding documentation for devicetree.

Marcelo Schmitt (3):
  staging: iio: ad5933: change regulator binging for vref
  staging: iio: ad5933: use clock framework for clock reference
  staging: iio: ad5933: add binding doc for ad5933

 .../iio/impedance-analyzer/ad5933.txt         | 26 +++++++++
 .../staging/iio/impedance-analyzer/ad5933.c   | 57 +++++++++----------
 2 files changed, 54 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt

-- 
2.17.1

