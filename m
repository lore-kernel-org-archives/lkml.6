Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEA4C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581102077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 11:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 581102077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeICPVt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 11:21:49 -0400
Received: from hermes.aosc.io ([199.195.250.187]:48630 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbeICPVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 11:21:48 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id 61326FF699;
        Mon,  3 Sep 2018 11:01:55 +0000 (UTC)
Date:   Mon, 03 Sep 2018 19:01:47 +0800
In-Reply-To: <20180903102022.fkxfkxadkt4vpbmb@flea>
References: <20180830154518.29507-1-embed3d@gmail.com> <20180830154518.29507-22-embed3d@gmail.com> <20180831091137.wkbbipssyd6mqfbt@flea> <f01ec2f202c7e2e5a7e0c822b2f9a8f0c55a9ea4.camel@aosc.io> <20180903102022.fkxfkxadkt4vpbmb@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [linux-sunxi] Re: [PATCH v3 21/30] iio: adc: sun4i-gpadc-iio: add support for H3 thermal sensor
To:     maxime.ripard@bootlin.com,
        Maxime Ripard <maxime.ripard@bootlin.com>
CC:     Philipp Rossak <embed3d@gmail.com>, mark.rutland@arm.com,
        geert+renesas@glider.be, linux-iio@vger.kernel.org,
        robh+dt@kernel.org, linux-sunxi@googlegroups.com,
        clabbe.montjoie@gmail.com, pmeerw@pmeerw.net, lee.jones@linaro.org,
        lars@metafoo.de, quentin.schulz@bootlin.com, linux@armlinux.org.uk,
        wens@csie.org, devicetree@vger.kernel.org, arnd@arndb.de,
        vilhelm.gray@gmail.com, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, rdunlap@infradead.org,
        arnaud.pouliquen@st.com, linux-kernel@vger.kernel.org,
        lukas@wunner.de, knaack.h@gmx.de, eugen.hristev@microchip.com,
        jic23@kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <AFDFF5AB-8BF6-4461-A5C2-D628A2F22E2E@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年9月3日 GMT+08:00 下午6:20:22, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Fri, Aug 31, 2018 at 05:51:41PM +0800, Icenowy Zheng wrote:
>> Personally I suggest to leave out all SID or calibration related
>> patches here.
>> 
>> Currently we seems to be wrongly converting SID to big endian,
>however,
>> the orgnization of the THS calibration data on H6 shows that it's
>> surely little endian:
>> 
>> It consists a temperature value in 1/10 celsuis as unit, and some
>> thermal register readout values, which are the values read out at the
>> given temperature, and every value here (the temperature and the
>> readout) are all half word length.
>> 
>> Let the temperature value be AABB, the two readout values be XXYY and
>> ZZWW, the oragnization is:
>> BB AA YY XX WW ZZ ** ** .
>> 
>> When converting the SID to big endian, it becomes:
>> XX YY AA BB ** ** ZZ WW ,
>> which is non-sense, and not able to do sub-word cell addressing.
>> 
>> Maxime, should I drop the LE2BE conversion in SID driver? (I doubt
>> whether it will break compatibility.)
>
>This is exposed to the userspace, so no.

Please note the LE2BE totally breaks the SID addressing.

Without it dropped all cells must be referenced with
4 byte word as unit, and half word addressing of
SID is thus not possible. The driver will also need then to split
the half words if needed.

I think this is kind of hardware misbehavior, and not a simple
UAPI change, so the UAPI stability shouldn't affect this change.

>
>Maxime
>> 
