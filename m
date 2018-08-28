Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C419CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706EC2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCDIhBNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706EC2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbeH1OGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:06:14 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38947 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeH1OGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:06:12 -0400
Received: by mail-wm0-f45.google.com with SMTP id q8-v6so1394824wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 03:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eFEDCsp7W9hfDmCytTf7/IYHRAO9pUMzrBfL2aDncfU=;
        b=JCDIhBNd79zTXl5L8alaXs6S+o12ZDrNjtJLGv6s8hnojMd1buaNYHGm053B07CGk0
         gBUOBEnLmYfRLUhaVlfkj72nAXgm3LlUXFMdMpB9wy4eCOVg7UxeSZI/TDUh6u8tFe9Z
         QlficPRWFDHvOrenk5EYFAixVDS5LxyEx4JgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eFEDCsp7W9hfDmCytTf7/IYHRAO9pUMzrBfL2aDncfU=;
        b=GDIFDbVHqUkQdjjHVz2Qm27ME7WYBV4a6MT1VTbjabMXvMQmTVCRBzGSaeOcolT4zF
         Tb31KBPIQHXP42HZytz65sB7yCJHquHdrv2RaG4UsPE85Dt3cjUAyyKhxg26fU2d68S7
         lu9ZsBBIe0MdcepqIkcX6wD46qexKY+ubTZoHxlhhn3KdURkbHM0ytxv7AbO1Z+ni2me
         1MRhkoie84s7wyfKlX9pqmmf6qjdDazbUsD3ZoyRohOnrLzKCHNVpQMyuIVu+Q2AFz0v
         MGHm6ZFY9LAlDB4kaCSzQHbAdCAR+EMkh3LOt2Nm1I0iGG4Nh9hADtskq7TgcdhMUrn4
         kvuw==
X-Gm-Message-State: APzg51BHQVDqiBeQoAWsR4Jqhxmf2OYuyYyiIksF+IKF5++TGi3NDMLn
        fPaFKnCDyCPGaumCGFsax7YkTg==
X-Google-Smtp-Source: ANB0VdbhZdSwmLNZTR4NuF3OdtieZ3D28Qy40kE5o7AiOdlwqrqVuo7ZKy9SDTzLkA5mEg62+PTrcw==
X-Received: by 2002:a1c:9f41:: with SMTP id i62-v6mr832033wme.87.1535451315287;
        Tue, 28 Aug 2018 03:15:15 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id u127-v6sm622722wmf.48.2018.08.28.03.15.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 03:15:14 -0700 (PDT)
Subject: Re: [PATCH v2 01/29] nvmem: add support for cell lookups
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        linux-doc <linux-doc@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Marek Vasut <marek.vasut@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        David Lechner <david@lechnology.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sven Van Asbroeck <svendev@arcx.com>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, Naren <naren.kernel@gmail.com>,
        netdev <netdev@vger.kernel.org>, Alban Bedel <albeu@free.fr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-2-brgl@bgdev.pl> <20180824170848.29594318@bbrezillon>
 <20180824152740.GD27483@lunn.ch> <20180825082722.567e8c9a@bbrezillon>
 <CAMRc=Men-MPk5DGshWcVEc0v=gH2WSpx1j-CawOeydwp59tejw@mail.gmail.com>
 <20180827110055.122988d0@bbrezillon>
 <CAMRc=MfpZJUEAhM4OoLbmJcnX3rTJk8fvdiL6=9BjNkVcsf=SA@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8cb75723-dc87-f127-2aab-54dd0b08eee8@linaro.org>
Date:   Tue, 28 Aug 2018 11:15:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=MfpZJUEAhM4OoLbmJcnX3rTJk8fvdiL6=9BjNkVcsf=SA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27/08/18 14:37, Bartosz Golaszewski wrote:
> I didn't notice it before but there's a global list of nvmem cells

Bit of history here.

The global list of nvmem_cell is to assist non device tree based cell 
lookups. These cell entries come as part of the non-dt providers 
nvmem_config.

All the device tree based cell lookup happen dynamically on 
request/demand, and all the cell definition comes from DT.

As of today NVMEM supports both DT and non DT usecase, this is much simpler.

Non dt cases have various consumer usecases.

1> Consumer is aware of provider name and cell details.
	This is probably simple usecase where it can just use device based apis.

2> Consumer is not aware of provider name, its just aware of cell name.
	This is the case where global list of cells are used.

> with each cell referencing its owner nvmem device. I'm wondering if
> this isn't some kind of inversion of ownership. Shouldn't each nvmem
> device have a separate list of nvmem cells owned by it? What happens
This is mainly done for use case where consumer does not have idea of 
provider name or any details.

First thing non dt user should do is use "NVMEM device based consumer APIs"

ex: First get handle to nvmem device using its nvmem provider name by 
calling nvmem_device_get(); and use nvmem_device_cell_read/write() apis.

Also am not 100% sure how would maintaining cells list per nvmem 
provider would help for the intended purpose of global list?

> if we have two nvmem providers with the same names for cells? I'm
Yes, it would return the first instance.. which is a known issue.
Am not really sure this is a big problem as of today! but am open for 
any better suggestions!


> asking because dev_id based lookup doesn't make sense if internally
> nvmem_cell_get_from_list() doesn't care about any device names (takes
> only the cell_id as argument).

As I said this is for non DT usecase where consumers are not aware of 
provider details.

> 
> This doesn't cause any trouble now since there are no users defining
> cells in nvmem_config - there are only DT users - but this must be
> clarified before I can advance with correctly implementing nvmem
> lookups.
DT users should not be defining this to start with! It's redundant and 
does not make sense!

> 
> BTW: of_nvmem_cell_get() seems to always allocate an nvmem_cell
> instance even if the cell for this node was already added to the nvmem
> device.
I hope you got the reason why of_nvmem_cell_get() always allocates new 
instance for every get!!

thanks,
srini
