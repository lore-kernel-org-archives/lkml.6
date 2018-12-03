Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1785C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E024206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E024206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLCWVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:21:39 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43152 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeLCWVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:21:38 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id EFD932601FF
Subject: Re: [PATCH v3 2/8] mfd / platform: cros_ec: move lightbar attributes
 to its own driver.
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gwendal@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, bleung@chromium.org,
        Olof Johansson <olof@lixom.net>
References: <20181127121849.23975-1-enric.balletbo@collabora.com>
 <20181127121849.23975-3-enric.balletbo@collabora.com>
 <20181203103619.GD26661@dell>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <59c6fa0a-e5d5-0e4a-9393-0c9a8b26332d@collabora.com>
Date:   Mon, 3 Dec 2018 23:21:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181203103619.GD26661@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 3/12/18 11:36, Lee Jones wrote:
> On Tue, 27 Nov 2018, Enric Balletbo i Serra wrote:
> 
>> The entire way how cros sysfs attibutes are created is broken.
>> cros_ec_lightbar should be its own driver and its attributes should be
>> associated with a lightbar driver not the mfd driver. In order to retain
>> the path, the lightbar attributes are attached to the cros_class.
> 
> I'm not exactly clear on what a lightbar is, but shouldn't it live in
> the appropriate subsystem.  Like LED for example?
> 

The lightbar is a four-color indicator available on some Chromebook, but the
fact that can you can program this lightbar with different sequences, including
user defined sequences makes the device a bit special and very chrome platform
specific. The same happens with the VBC driver.

Other subdevices like, rtc, keyboard, usbpd charger,etc. are already in their
subsystems.

>> The patch also adds the sysfs documentation.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>> Changes in v3:
>> - Removed unneded check for ec_dev.
>>
>> Changes in v2:
>> - Removed the two exported functions to attach/detach to the cros_class.
>> - Use dev_warn instead of dev_err when adding the lightbar.
>>
>>  ...sfs-class-chromeos-driver-cros-ec-lightbar | 74 +++++++++++++++
>>  drivers/mfd/cros_ec_dev.c                     | 24 ++---
>>  drivers/mfd/cros_ec_dev.h                     |  6 --
>>  drivers/platform/chrome/Kconfig               | 10 ++
>>  drivers/platform/chrome/Makefile              |  3 +-
>>  drivers/platform/chrome/cros_ec_lightbar.c    | 95 ++++++++++++++-----
>>  include/linux/mfd/cros_ec.h                   |  1 -
>>  7 files changed, 172 insertions(+), 41 deletions(-)
>>  create mode 100644 Documentation/ABI/testing/sysfs-class-chromeos-driver-cros-ec-lightbar
> 
