Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCABC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58C720894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gnyXPwnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58C720894
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbeG0LP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:15:27 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39284 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730475AbeG0LP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:15:26 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6R9qfDc010873;
        Fri, 27 Jul 2018 04:52:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532685161;
        bh=EiFNRucd9iNx1pQMy77dLtPqlzIVRX4TVPU5qTrqitg=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=gnyXPwnVSQZJV0LeRzTg/XlLaOsym/DhzLgoAx+CHkSmIbg6ujLhp4+x/bV3kLHHj
         pX6yb4PfBz+vmp8HdLXF3FOyvQwOJx8QCo2lmMvkF3Zy+wiu6qTu0fIH3cqh7ew4tn
         iVR+MyLyNOSMnVi5gCpXIbsUWWoLHR/+BebxzqJQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6R9qf2D018021;
        Fri, 27 Jul 2018 04:52:41 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 27
 Jul 2018 04:52:41 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 27 Jul 2018 04:52:41 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6R9qX3e000517;
        Fri, 27 Jul 2018 04:52:34 -0500
Subject: Re: [PATCH v4 08/18] net: davinci_emac: potentially get the MAC
 address from MTD
From:   Sekhar Nori <nsekhar@ti.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andrew Lunn <andrew@lunn.ch>
CC:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Lechner <david@lechnology.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ladislav Michl <ladis@linux-mips.org>,
        <netdev@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        <linux-omap@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20180629094039.7543-1-brgl@bgdev.pl>
 <20180629094039.7543-9-brgl@bgdev.pl>
 <03b77e24-9ab9-fa01-2387-9de0408a9942@gmail.com>
 <20180704070919.GA14051@lenoch>
 <CAMRc=McOYG9=naT2=4c4hnhJwxcqBCATEZOGXXv9u9zuvXyDXw@mail.gmail.com>
 <c0ffc590-8064-3b02-9b5c-fcc24628d390@ti.com>
 <CAMRc=McO8H9Aw8a7h318a=hJjKBOgeC+9_hreBnOY3Tc3Fh7sg@mail.gmail.com>
 <d7f03763-982f-5e3e-d0ad-54e024b10f97@ti.com>
 <a70aebb0-408c-c61f-897a-227114888585@linaro.org>
 <efd9388f-c378-4723-602d-1209c8bae7d3@ti.com>
Message-ID: <e98a0d1b-a587-cf6e-9b95-726701241331@ti.com>
Date:   Fri, 27 Jul 2018 15:22:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <efd9388f-c378-4723-602d-1209c8bae7d3@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 July 2018 10:34 AM, Sekhar Nori wrote:

> There is a lot of follow-up traffic on how exactly to develop the needed
> interfaces for reading mac address in mtd and/or network subsystem.
> 
> But, I don't think any of that negates the need for nvmem lookups that
> work for non-device-tree and populating the lookups in mach-davinci
> board code.
> 
> I am going to send patches 1-7 to ARM-SoC soon, so please do say if
> there is any disagreement on this.

I owed a response on this. After thinking over some and discussing with
Bartosz as well, I decided not to merge any patches from  this series.
Its better to merge anything after the actual path we are talking is
fully clear.

Thanks,
Sekhar
