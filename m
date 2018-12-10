Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5484BC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F5B20821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544483643;
	bh=2sRYBZlKceqrmYcBlm0j9j6+oUlkecwrQkbMPHKeoWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=apUt4EuNO8ZMyS3kHdMctaUi7z3U2Y+RpkouHD0Dsl4he9szNuPxqlx02REUk+hK0
	 Wy327zXXDRGob9UQUkGBPLgeUNkbY4VrJoj6Tzh+70pqetujAMdy0U0XiGVhooj5SM
	 884s+VJoOL8CB+79889AQwv4J3F3TEdCgAUhiock=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15F5B20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeLJXOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:14:02 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:47087 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbeLJXOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:14:01 -0500
Received: by mail-oi1-f194.google.com with SMTP id x202so10455814oif.13;
        Mon, 10 Dec 2018 15:14:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OQ2NGOdowaEu9JZPmiczBUyABSOTJVXCfejhysEMLL0=;
        b=A9OS+Z87q4j3xPoCgsMmmFV39upDc50wlaaO5Uq1+qJultCmaWqY4TxhchgvNR5zAx
         U21uya8C9iDE7c5JlfhfN7PL1YgI4rFxpzKkF9licqctb3CGoHqN/XEMGt5DO1qCpmzY
         dmPhPje5tcF/31HUxWAOMbkIbca4vrVz0tZwcHkFM9iLsy/sDF7jvCBR3EO+blPOn6Mw
         uImfhBRinN8UdPkb4pWWsH2L4eCK6hsvVgKtgXgy/8nGSig51TiX+SbusbtV0vA+CHqW
         yuPaudcYF5PUn32LhDTS24tHtmwBYDOpCoPywUCMmjNg6AH2Fy6bJgu4UNdACG6ysCD0
         XvHw==
X-Gm-Message-State: AA+aEWbF8N/nQC2iy7iceh8DxZ28RaONgsIGFMs0U6TP67RqgMhgDTGi
        ROxIWx9dmwVHlmT1nm/AMA==
X-Google-Smtp-Source: AFSGD/UChiZfXl+MVC5iJjlgm4QG5S1nM+C0ZbgplcYWvyMBtJaXN7fuymvLlQr/XRGU4qnwSkSxyg==
X-Received: by 2002:aca:3d4:: with SMTP id 203mr5206oid.315.1544483640611;
        Mon, 10 Dec 2018 15:14:00 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x127sm6048833oia.20.2018.12.10.15.13.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 15:13:59 -0800 (PST)
Date:   Mon, 10 Dec 2018 17:13:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 5/8] dt-bindings: phy: mvebu-comphy: extend the file
 to describe a3700 bindings
Message-ID: <20181210231359.GA26329@bogus>
References: <20181204191730.11516-1-miquel.raynal@bootlin.com>
 <20181204191730.11516-6-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204191730.11516-6-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  4 Dec 2018 20:17:27 +0100, Miquel Raynal wrote:
> Current file describe COMPHY bindings for the IP available on the
> CP110 of Armada 7k/8k. Bindings are very close (and serve the same
> purpose) as the new Armada 3700 COMPHY driver so update this file to
> describe both. Also add an example of how to use this second
> compatible (same as for the ESPRESSObin).
> 
> While doing so, enhance a bit the file by adding upper case where
> needed.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/phy/phy-mvebu-comphy.txt         | 65 +++++++++++++++----
>  1 file changed, 53 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
