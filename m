Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DBCC6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66D522086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66D522086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbeJLWJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:09:26 -0400
Received: from mleia.com ([178.79.152.223]:33586 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728354AbeJLWJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 18:09:26 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id A30EB41F88C;
        Fri, 12 Oct 2018 15:36:40 +0100 (BST)
Subject: Re: [PATCH 5/7] mfd: ds90ux9xx: add I2C bridge/alias and link
 connection driver
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181008211205.2900-1-vz@mleia.com> <20181012060455.GV4939@dell>
 <c8f01b88-c14f-867d-d796-7464b2e8ccfb@mentor.com> <1584081.CVFmJobd6K@avalon>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <0be75b0d-eb61-02e5-a086-be6a9d32841a@mleia.com>
Date:   Fri, 12 Oct 2018 17:36:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1584081.CVFmJobd6K@avalon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20181012_153640_691231_9082FA3D 
X-CRM114-Status: GOOD (  24.34  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On 10/12/2018 04:12 PM, Laurent Pinchart wrote:
> Hi Vladimir,
> 
> (CC'ing Wolfram)
> 
> On Friday, 12 October 2018 10:32:32 EEST Vladimir Zapolskiy wrote:
>> On 10/12/2018 09:04 AM, Lee Jones wrote:
>>> On Tue, 09 Oct 2018, Vladimir Zapolskiy wrote:
>>>> From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>>>>
>>>> The change adds TI DS90Ux9xx I2C bridge/alias subdevice driver and
>>>> FPD Link connection handling mechanism.
>>>>
>>>> Access to I2C devices connected to a remote de-/serializer is done in
>>>> a transparent way, on established link detection event such devices
>>>> are registered on an I2C bus, which serves a local de-/serializer IC.
>>>>
>>>> The development of the driver was a collaborative work, the
>>>> contribution done by Balasubramani Vivekanandan includes:
>>>> * original simplistic implementation of the driver,
>>>> * support of implicitly specified devices in device tree,
>>>> * support of multiple FPD links for TI DS90Ux9xx,
>>>> * other kind of valuable review comments, clean-ups and fixes.
>>>>
>>>> Also Steve Longerbeam made the following changes:
>>>> * clear address maps after linked device removal,
>>>> * disable pass-through in disconnection,
>>>> * qualify locked status with non-zero remote address.
>>>>
>>>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>>>> ---
>>>>
>>>>  drivers/mfd/Kconfig                |   8 +
>>>>  drivers/mfd/Makefile               |   1 +
>>>>  drivers/mfd/ds90ux9xx-i2c-bridge.c | 764 +++++++++++++++++++++++++++++
>>>>  3 files changed, 773 insertions(+)
>>>>  create mode 100644 drivers/mfd/ds90ux9xx-i2c-bridge.c
>>>
>>> Shouldn't this live in drivers/i2c?
>>
>> no, the driver is not for an I2C controller of any kind, and the driver does
>> not register itself in the I2C subsystem by calling i2c_add_adapter() or
>> i2c_add_numbered_adapter() or i2c_mux_add_adapter() etc, this topic was
>> discussed with Wolfram also.
> 
> (Who is now on CC)
> 

Wolfram has copies of the drivers and discussion right from the beginning,
hopefully he won't get two copies ;)

>> Formally the driver converts the managed IC into a multi-address I2C
>> slave device, I understand that it does not sound like a well suited driver
>> for MFD, but ds90ux9xx-core.c and ds90ux9xx-i2c-bridge.c drivers are quite
>> tightly coupled.
> 
> As mentioned in other e-mails in this thread I don't think this should be 
> split out to a separate driver,> I would move the functionality to the 
> ds90ux9xx driver.

The proposal may have the grounds, but the I2C bridging functionality of ICs
is quite detached from all other ones, thus it found its place in the cell
driver per se.

> You may want to register an I2C mux, but as you have a single port, that
> could be overkill. I haven't studied in details how to best support this
> chip using the existing I2C subsystems APIs (which we may want to extend
> if it needed), but I believe that (in your use cases) the deserializer
> should be a child of the serializer, and modeled as an I2C device.
> 

Formally in OF terms to define a link between devices by a phandle should
be sufficient, panels are not the children of LVDS controllers under OF graph
constraints in DT representation, the panels become secondary in runtime
only, I'd like to reuse the concept. Also it adds a better sense of symmetry
of deserializer <-> serializer connections relatively to a SoC/data source.

--
Best wishes,
Vladimir
