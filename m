Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F066ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2286520850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 17:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2286520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbeGRR6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 13:58:15 -0400
Received: from www381.your-server.de ([78.46.137.84]:57781 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731344AbeGRR6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 13:58:15 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <lars@metafoo.de>)
        id 1ffq6i-00033H-FA; Wed, 18 Jul 2018 19:19:20 +0200
Received: from [188.174.125.96] (helo=[192.168.178.33])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1ffq6i-000SF2-8x; Wed, 18 Jul 2018 19:19:20 +0200
Subject: Re: [DISCUSSION] spi multi chipselect support
To:     Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@collabora.com
References: <20180718163530.zsa5md3huz3dnotb@earth.universe>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <c497b0e2-c663-fa29-dabc-6dd5ca26e0a4@metafoo.de>
Date:   Wed, 18 Jul 2018 19:19:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718163530.zsa5md3huz3dnotb@earth.universe>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.0/24760/Tue Jul 17 06:40:15 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 06:35 PM, Sebastian Reichel wrote:
> Hi Mark,
> 
> Some SPI slave devices have more than one chip select [0]. Rob suggested
> to use the following DT notation for this [1]:
> 
> spi-controller {
>     slave@0 {
>         reg = <0>, <1>;
>     };
> };
> 
> I think this makes sense from a DT point of view, but this needs
> quite some changes in the SPI core. I tried to find out, how to
> implement the suggestion in the last few days and I see two
> possibilities:
> 
> 1. Register two SPI Linux devices from one DT node. This needs the
>    fewest changes in SPI core. But we loose the one-to-one mapping
>    of DT nodes to devices. I have a feeling, that this will backfire.
> 
> 2. Add support for multiple chip-select to spi_device and modify
>    the transfer functions to make use of this. Unfortunately this
>    would require changing all spi controller as far as I can see?
> 

Hi,

I believe that has been discussed before recently, but I can't find it in
the archives.

My preferred solution would to have something like
i2c_new_secondary_device(), but for SPI. This way the driver that binds to
the compatible string can allocate devices for additional chip selects as
necessary. Also make use of the reg-names property the same way as in I2C.

The only catch here is that locking in the SPI core needs to be re-worked,
since you can't allocate SPI devices from within another SPI device's probe
function. Something like
https://github.com/analogdevicesinc/linux/commit/b5cc8460b959e530413ffbf9b93d8012c80d05df

- Lars
