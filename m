Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF535C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946AA213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfBYOU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:20:27 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:46772 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726099AbfBYOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:20:26 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436727|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.143813-0.0160668-0.84012;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07423;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.E1A5L6L_1551104418;
Received: from 172.16.10.102(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.E1A5L6L_1551104418)
          by smtp.aliyun-inc.com(10.147.41.138);
          Mon, 25 Feb 2019 22:20:19 +0800
Subject: Re: [RFC v9 2/5] dt-bindings: pstore-block: new support for blkoops
To:     Rob Herring <robh@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        boot-architecture@lists.linaro.org
References: <1550577170-18761-1-git-send-email-liaoweixiong@allwinnertech.com>
 <1550577170-18761-3-git-send-email-liaoweixiong@allwinnertech.com>
 <20190222153631.GA2612@bogus>
From:   liaoweixiong <liaoweixiong@allwinnertech.com>
Message-ID: <0a68e565-6516-04a4-f74f-355e74a2afa8@allwinnertech.com>
Date:   Mon, 25 Feb 2019 22:20:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190222153631.GA2612@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019-02-22 23:36, Rob Herring wrote:
> +boot-architecture list
> 
> On Tue, Feb 19, 2019 at 07:52:47PM +0800, liaoweixiong wrote:
>> Create DT binding document for blkoops.
>>
>> Signed-off-by: liaoweixiong <liaoweixiong@allwinnertech.com>
>> ---
>>  .../devicetree/bindings/pstore/blkoops.txt         | 53 ++++++++++++++++++++++
>>  MAINTAINERS                                        |  1 +
>>  2 files changed, 54 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pstore/blkoops.txt
>>
>> diff --git a/Documentation/devicetree/bindings/pstore/blkoops.txt b/Documentation/devicetree/bindings/pstore/blkoops.txt
>> new file mode 100644
>> index 0000000..5462915
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pstore/blkoops.txt
>> @@ -0,0 +1,53 @@
>> +Blkoops oops logger
>> +===================
>> +
>> +Blkoops provides a block partition for oops, excluding panics now, so they can
>> +be recovered after a reboot.
>> +
>> +Any space of block device will be used for a circular buffer of oops records.
>> +These records have a configurable size, with a size of 0 indicating that they
>> +should be disabled.
>> +
>> +At least one of "block-device" and "total_size" must be set.
>> +
>> +At least one of "dmesg-size" or "pmsg-size" must be set non-zero.
>> +
>> +Required properties:
>> +
>> +- compatible: must be "blkoops".
>> +
>> +Optional properties:
>> +
>> +- block-device: The block device to use. Most of the time, it is a partition of
>> +		device. If block-device is NULL, no block device is effective
>> +		and the data will be lost after rebooting.
>> +		It accept the following variants:
>> +		1) <hex_major><hex_minor> device number in hexadecimal
>> +		   represents itself no leading 0x, for example b302.
>> +		2) /dev/<disk_name> represents the device number of disk
>> +		3) /dev/<disk_name><decimal> represents the device number of
>> +		   partition - device number of disk plus the partition number
>> +		4) /dev/<disk_name>p<decimal> - same as the above, that form is
>> +		   used when disk name of partitioned disk ends on a digit.
>> +		5) PARTUUID=00112233-4455-6677-8899-AABBCCDDEEFF representing
>> +		   the unique id of a partition if the partition table provides
>> +		   it. The UUID may be either an EFI/GPT UUID, or refer to an
>> +		   MSDOS partition using the format SSSSSSSS-PP, where SSSSSSSS
>> +		   is a zero-filled hex representation of the 32-bit
>> +		   "NT disk signature", and PP is a zero-filled hex
>> +		   representation of the 1-based partition number.
>> +		6) PARTUUID=<UUID>/PARTNROFF=<int> to select a partition in
>> +		   relation to a partition with a known unique id.
>> +		7) <major>:<minor> major and minor number of the device
>> +		   separated by a colon.
> 
> No.
> 
> I didn't suggest to go look at PARTUUID to copy it into the binding, but 
> rather to point out that the kernel can already mount by UUID. 
> Specifying the UUID in DT is also not what I suggested. My suggestion is 
> to define a known UUID so that the kernel (and bootloaders, userspace, 
> the world) can just know the UUID. Just like the EFI system partition. 
> Now this means you have to get it defined in the UEFI specification 
> (or maybe EBBR[1]). If you want help with how to do that, the 
> boot-architecture list is a good place to start.
> 

Thanks for your suggestion. I don't know whether it is a good idea to
define a known UUID for pstore/blk in the UEFI specification. This
property is only used for pstore/blk to know which block device it can
use. It only works on linux. I think more thorough and rigorous
consideration is needed.
Besides that, mbr partition table has no partition UUID, how can it to
be compatible with mbr?

> major/minor numbers are a Linux thing, so they don't go in DT.
> /dev/* is Linux thing, so it doesn't go in DT.
> 
> You can always define all these parameters as kernel command line 
> options and avoid DT. That would also make this work on *all* systems, 
> not just DT based systems. (Though I still believe that the partition 
> should be discoverable.)
> 

The pstore/blk has already support command line. It now has 3
configuration methods, they are kconfig, DT and module parameters. I
will cancel DT support on next version until we discuss a viable
approach by this mail and than i will submit other patches to implement
DT. Is this ok?

> Rob
> 
> [1] https://github.com/ARM-software/ebbr
> 

-- 
liaoweixiong
