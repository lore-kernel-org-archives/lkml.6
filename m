Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66DEC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE81206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 18:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIo1ep0r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE81206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbeK2FSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 00:18:03 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43849 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725266AbeK2FSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 00:18:03 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so17356363qkr.10;
        Wed, 28 Nov 2018 10:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=0YsASNn8KNZVVRlRICNLoCyTLlKveFqQ7IBqojFvt68=;
        b=rIo1ep0rfrv/cW1k9G9RKGA0ZsVKeeTr/nigCm1U/xLIYCggHvJrT84Fe6pk9UB0R3
         tIFEHgU2gcK3irG+/SGxU4CPgIoNlpLQEjbLLLQ62BiQ8F1x+XdocpzFKZuWJCzBGuol
         JfGHV26sXr9qtzDtoi2ZH85XzIldoQA0uKaAP+EH7gWq/r2lJ4mtuw35kRdR/Cdxd4qR
         0VSMcAtXwclMbVvP3hSqzvBpdfM0S4makbzcSyimyM7uDBfsUg3bKAvHiWc8veKo6RBp
         It8Bd6w2i7iFhHG8NhjpuMwutdyG71QAg56WAvnou6qJe+Pr6480MsszlfcbTgfDaSxv
         DDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0YsASNn8KNZVVRlRICNLoCyTLlKveFqQ7IBqojFvt68=;
        b=a382JhjIlzQ7e820U5c5dhwb0ssR2RDYaJlDtTYsYgKV9nF9kGOmN8bvDnLelYVtVS
         lX39QMXyFy7vH1xqTiZgKIY2kpcEEYRKSMdpxRVE+VzwsOSHz2tFpg8x4PSmWgiPZ3Pv
         dyVXyWJsMJWlP8HJgCT9t+m3VCsFJP7goNzDobaE9SNh3LJnw5PvEhWMlZdrqsQLs1oE
         MqOHUk9li0eIdiux++gtDDQKz4LOfu52zbT+4+KNsC2J957wmD24/vLrBpZDuLSmUCfx
         qFa4BRhltpiV4iZgKEmnwRyUwqfi6IpNE8tJ0IR8ECY7oAYpKATgCoN9onrRoW5bBQgM
         f6OQ==
X-Gm-Message-State: AA+aEWbn2Rlv7zXbPzks0BZZlKyAx66qy8/I/SlGn/Inwelw7/LNdkN0
        Vv+9DZyTt1W2ZjHn5mqWVKw=
X-Google-Smtp-Source: AFSGD/VrknUGMRW9KkNT6y134hAOvCtLsBgSijuO16BGX8nmGARuvDStpkOW5OEB9KLq6QbMhS/9/w==
X-Received: by 2002:a37:17df:: with SMTP id 92mr35710998qkx.191.1543428931732;
        Wed, 28 Nov 2018 10:15:31 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 46sm2558324qtv.22.2018.11.28.10.15.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 10:15:31 -0800 (PST)
From:   Giuliano Belinassi <giuliano.belinassi@gmail.com>
X-Google-Original-From: Giuliano Belinassi <giuliano.belinassi@usp.br>
Date:   Wed, 28 Nov 2018 16:15:25 -0200
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        renatogeh@gmail.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 0/2] staging: iio: ad7780: move out of staging
Message-ID: <cover.1543428366.git.giuliano.belinassi@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches add user input to ad7780 'gain' & 'filter' gpio
pins. Also, it moves the ad7780 out of staging to the main tree.

Giuliano Belinassi (2):
  staging: iio: ad7780: Add gain & filter gpio support
  staging: iio: ad7780: Moving ad7780 out of staging

 drivers/iio/adc/Kconfig                |  13 +
 drivers/iio/adc/Makefile               |   1 +
 drivers/iio/adc/ad7780.c               | 347 +++++++++++++++++++++++++
 drivers/staging/iio/adc/Kconfig        |  13 -
 drivers/staging/iio/adc/Makefile       |   1 -
 drivers/staging/iio/adc/ad7780.c       | 277 --------------------
 include/linux/iio/adc/ad_sigma_delta.h |   5 +
 7 files changed, 366 insertions(+), 291 deletions(-)
 create mode 100644 drivers/iio/adc/ad7780.c
 delete mode 100644 drivers/staging/iio/adc/ad7780.c

-- 
2.19.1

