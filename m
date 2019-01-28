Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0C5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2483214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 12:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfA1MvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 07:51:17 -0500
Received: from mleia.com ([178.79.152.223]:34294 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726611AbfA1MvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 07:51:16 -0500
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 06FFA43E303;
        Mon, 28 Jan 2019 12:51:14 +0000 (GMT)
Subject: Re: [PATCH] pinctrl: remove unused 'pinconf-config' debugfs interface
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laurent Meunier <laurent.meunier@st.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@arm.linux.org.uk>
References: <20190120151357.11106-1-vz@mleia.com>
 <CACRpkdYn+LgeRaL4=UPLGYxdCpnoj8r3Yp=A6yHADr=fhB_UFg@mail.gmail.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <8f8bacae-bc90-d1c7-b2eb-6f4a03d34cc7@mleia.com>
Date:   Mon, 28 Jan 2019 14:51:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdYn+LgeRaL4=UPLGYxdCpnoj8r3Yp=A6yHADr=fhB_UFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20190128_125114_057231_14F37254 
X-CRM114-Status: GOOD (  23.72  )
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 01/28/2019 02:36 PM, Linus Walleij wrote:
> On Sun, Jan 20, 2019 at 4:14 PM Vladimir Zapolskiy <vz@mleia.com> wrote:
> 
>> The main goal of the change is to remove .pin_config_dbg_parse_modify
>> callback before a driver with its support appears. So far the in-kernel
>> interface did not attract any users since its introduction 5 years ago.
>>
>> Originally .pin_config_dbg_parse_modify callback and the associated
>> 'pinconf-config' debugfs file were introduced in commit f07512e615dd
>> ("pinctrl/pinconfig: add debug interface"), a short description of
>> 'pinconf-config' usage for debugging can be expressed this way:
>>
>> Write to 'pinconf-config' (see pinconf_dbg_config_write() function):
>>
>> % echo -n modify $map_type $device_name $state_name $pin_name $config > \
>>         /sys/kernel/debug/pinctrl/$pinctrl/pinconf-config
>>
>> It supposes to update a global (therefore single!) 'pinconf_dbg_conf'
>> variable with an alternative setting, the arguments should match
>> an existing pinconf device and some registered pinctrl mapping 'map':
>>
>> * $map_type is either 'config_pin' or 'config_group', it should match
>>   'map->type' value of PIN_MAP_TYPE_CONFIGS_PIN or
>>    PIN_MAP_TYPE_CONFIGS_GROUP accordingly,
>> * $device_name should match 'map->dev_name' string value,
>> * $state_name should match 'map->name' string value,
>> * $pin_name should match 'map->data.configs.group_or_pin' string value,
>>
>> If all above has matched, then $config is a new value to be set by calling
>> pinconfops->pin_config_dbg_parse_modify(pctldev, config, matched_config).
>>
>> After a successful write into 'pinconf-config' a user can read the file
>> to get information about that single modified pin configuration.
>>
>> The fact is .pin_config_dbg_parse_modify callback has never been defined
>> in 'struct pinconf_ops' of any pinconf driver, thus an actual modification
>> of a pin or group state on any present pinconf controller does not happen,
>> and it declares that all related code is no more than dead code.
>>
>> I discovered the issue while attempting to add .pin_config_dbg_parse_modify
>> support in some drivers and found that too short 'MAX_NAME_LEN' set by
>>
>>   drivers/pinctrl/pinconf.c:372:#define MAX_NAME_LEN 15
>>
>> is practically insufficient to store a regular pinctrl device name,
>> which are like 'e6060000.pin-controller-sh-pfc' or pin names like
>> 'MX6QDL_PAD_ENET_REF_CLK', thus it is another indicator that the code
>> is barely usable, insufficiently tested and unprepossessing.
>>
>> Of course it might be possible to increase MAX_NAME_LEN, and then add
>> .pin_config_dbg_parse_modify callbacks to the drivers, but the whole
>> idea of such a limited debug option looks inviable. A more flexible
>> way to functionally substitute the original approach is to implicitly
>> or explicitly use pinctrl_select_state() function whenever needed.
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> Cc: Laurent Meunier <laurent.meunier@st.com>
>> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
> 
> This is fine, the build robot is complaining of some missing
> prototype though, probably some implicit include that
> disappeared when you removed <linux/pinctrl/machine.h>
> from the <linux/pinctrl/pinconf.h> file.
> 
> Will you send a v2 with this fixed? (I think just leaving the
> include in place would be a quickfix.)
> 

Fortunately it has been already done, please check the sent v2 with one
earned Reviewed-by tag from Richard:

* https://patchwork.ozlabs.org/patch/1029536/
* https://patchwork.ozlabs.org/patch/1029537/

Thank you for your approval of the change in general!

--
Best wishes,
Vladimir
