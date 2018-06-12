Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8B40BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4257D20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4257D20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754273AbeFLShS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:37:18 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:44514 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754049AbeFLShQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:37:16 -0400
Received: by mail-yw0-f195.google.com with SMTP id p14-v6so7846913ywm.11;
        Tue, 12 Jun 2018 11:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8yjIGb/erDDHAOupNu4dpuKaEuc+jQ9MhFtfJ2zghyA=;
        b=NbQul0IEZtobdYHMd8806FCV1gr1s9Rn1MkQPMCuVQgjOl7ewlZY1P2BJLewGclWJY
         q1QpFucT516G20RbmlglP4wJW1jM5gaB9e3BP5cCUWVvD1rRTpl/jQZ3ddsDQBqGNgWv
         mK9juOb9YhxFH/SEKFENQP8qZEIAkG+pkSUpX0W3svntc8kjEvvbwQd230qPYy30sjE0
         +Rz1YNmBad5bWrqcwxYVNP5G6T0Z5asg6m67HfbNvp83jWwa2sal1FClNRU8Tssv3hpi
         1sx88CtML/jFCPphJrVRHmNwNB8vbdwd/OHmFuKQJ3Rqk1Fv0n9qBYDga9t6KqHJaJ3E
         qmlw==
X-Gm-Message-State: APt69E0lfnRdAoJBdbwLx25Q/pIVZeQyOKUdb5S+HG0YLlOmuZHnbWXO
        zTIH3ALToH5WoR8KvGGjOg==
X-Google-Smtp-Source: ADUXVKLu9l67ULXZeToRwQ4dbI00q5xoumIRNWvYL1dLfSkf7iIzqGtcukn6CKzvdjAYDLA/f4cixA==
X-Received: by 2002:a81:c8b:: with SMTP id 133-v6mr748974ywm.437.1528828635539;
        Tue, 12 Jun 2018 11:37:15 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id t18-v6sm366983ywg.32.2018.06.12.11.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 11:37:14 -0700 (PDT)
Date:   Tue, 12 Jun 2018 12:37:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     boris.brezillon@bootlin.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        mark.rutland@arm.com, thierry.reding@gmail.com, dev@lynxeye.de,
        miquel.raynal@bootlin.com, richard@nod.at, marcel@ziswiler.com,
        krzk@kernel.org, digetx@gmail.com, benjamin.lindqvist@endian.se,
        jonathanh@nvidia.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mirza.krak@gmail.com, gaireg@gaireg.de,
        linux-mtd@lists.infradead.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] mtd: rawnand: add Reed-Solomon error correction
 algorithm
Message-ID: <20180612183712.GA24397@rob-hp-laptop>
References: <20180611205224.23340-1-stefan@agner.ch>
 <20180611205224.23340-2-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611205224.23340-2-stefan@agner.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 10:52:19PM +0200, Stefan Agner wrote:
> Add Reed-Solomon (RS) to the enumeration of ECC algorithms.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mtd/nand.txt | 2 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/mtd/nand/raw/nand_base.c               | 1 +
>  include/linux/mtd/rawnand.h                    | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)
