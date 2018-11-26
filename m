Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F58C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F202086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 19:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PsTFnbc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F202086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbeK0GX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 01:23:28 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:60576 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeK0GX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 01:23:28 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 3304824E083B;
        Mon, 26 Nov 2018 11:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1543260501; bh=wftyrKsUmroNh89usYtNK2o903693/PJTlzIUE+2TQs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=PsTFnbc+qp/2GKyBv84W4jYozcbj7upt+o1wP+cfwrzH37v37G1K5A9G7UrPuCox7
         d6SvPVc6eiSh9qLOg9cwf41SK6JxbTosNCd7dAHnexvhpr29YFpU+SFtnjDSvXmF1M
         A+jBmVu62NfKTeyXBNzQJlcmvQI+5/5fa3BJz6CSTr7pmFJrIZKEdzl5vErGt1/hzs
         TRAWkkmozL//qqVCwX7Jx36Cu8i2bXleG21YMwYTbg6TxvlKgwJ0Xb74QpuZn9tEv7
         b0ZZYHXjg2RtvXD54sj1YPg2vIZ9ko4MzZWor3dgfasysX6oTGXUbp75xbkEx0Ic46
         SzrqcLJvkQ2uw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2D297392C;
        Mon, 26 Nov 2018 11:28:19 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 26 Nov 2018 11:28:18 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 26 Nov 2018 20:28:17 +0100
Received: from [10.0.2.15] (10.107.19.169) by DE02WEHTCA.internal.synopsys.com
 (10.225.19.80) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 26 Nov
 2018 20:28:16 +0100
Subject: Re: [PATCH] i3c: master: dw: split dw-i3c-master.c into master and
 bus specific parts
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        vitor <vitor.soares@synopsys.com>
CC:     <wsa@the-dreams.de>, <linux-i2c@vger.kernel.org>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <arnd@arndb.de>, <psroka@cadence.com>, <agolec@cadence.com>,
        <adouglas@cadence.com>, <bfolta@cadence.com>, <dkos@cadence.com>,
        <alicja@cadence.com>, <cwronka@cadence.com>, <sureshp@cadence.com>,
        <rafalc@cadence.com>, <thomas.petazzoni@bootlin.com>, <nm@ti.com>,
        <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
        <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <geert@linux-m68k.org>, <linus.walleij@linaro.org>,
        <Xiang.Lin@synaptics.com>, <linux-gpio@vger.kernel.org>,
        <nsekhar@ti.com>, <pgaj@cadence.com>, <peda@axentia.se>,
        <mshettel@codeaurora.org>, <swboyd@chromium.org>,
        <joao.pinto@synopsys.com>
References: <ade2c1a8d1eb48681b01ccdc9bed22caf5e96c4b.1542904564.git.soares@synopsys.com>
 <20181122210202.6af50fcc@bbrezillon>
 <6d513e04-3a57-1989-429c-64631101c5a2@synopsys.com>
 <20181123135004.7fd1cd58@bbrezillon>
 <83115f47-1326-cb33-a7dc-4bc8ff95befa@synopsys.com>
 <20181126133550.51469816@bbrezillon>
 <4e9c0461-02a3-80b2-c9b7-2e9ea9b38f8b@synopsys.com>
 <20181126195618.352eafb1@bbrezillon> <20181126200855.0caa45b0@bbrezillon>
From:   vitor <vitor.soares@synopsys.com>
Message-ID: <b7f59793-aaaa-95ff-fe7d-943e558f65b5@synopsys.com>
Date:   Mon, 26 Nov 2018 19:28:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126200855.0caa45b0@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.107.19.169]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 26/11/18 19:08, Boris Brezillon wrote:
> On Mon, 26 Nov 2018 19:56:18 +0100
> Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>   
>>>       - for the others it will easy the SoC integration avoiding
>>> duplicated work and doing things from scratch.
>> What would be duplicated? You want to support a new SoC, just add a new
>> entry in the of_match_table and you're done. When you need to add
>> SoC/integration specific stuff, create a struct and attach a different
>> instance per-compatible so that each SoC can have its own configuration
>> (or even init sequence if needed). That's how we do for pretty much all
>> IPs out there, why should designware ones be different?
> To be more specific, I'd like a real example that shows why the
> separation is needed.

Ok no problem. We can delay this for PCI and other rules support.


