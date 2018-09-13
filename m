Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F37FC617C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59A702150D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 15:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A702150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbeIMVH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 17:07:27 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:45051 "EHLO
        7.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbeIMVH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 17:07:26 -0400
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Sep 2018 17:07:24 EDT
Received: from player687.ha.ovh.net (unknown [10.109.159.157])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3DA7115DF02
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 17:49:16 +0200 (CEST)
Received: from zorba.kaod.org (LFbn-1-10605-110.w90-89.abo.wanadoo.fr [90.89.196.110])
        (Authenticated sender: postmaster@kaod.org)
        by player687.ha.ovh.net (Postfix) with ESMTPSA id 27D432C00B4;
        Thu, 13 Sep 2018 17:48:59 +0200 (CEST)
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
To:     Guenter Roeck <linux@roeck-us.net>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Feist <james.feist@linux.intel.com>
References: <1f34fe8c-69ef-5f2d-25dc-d5f6037cc558@linux.intel.com>
 <20180911204107.GA26017@roeck-us.net>
 <e5135af4-9105-214f-5de2-65cc03804222@linux.intel.com>
 <CACPK8Xdv3aP_zOHAL0WMgwvkpBHAUesU7OdhW==jgvXjRmt-Zw@mail.gmail.com>
 <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
 <20180912195844.GA6893@roeck-us.net>
 <da7f4691-7428-3114-32bb-e0171f6c7228@linux.intel.com>
 <20180912203059.GA18201@roeck-us.net>
 <fb185839-3ae0-01dc-09e8-f22db55ecb04@kaod.org>
 <3f86e75f-1502-eae8-0633-d087937111c8@roeck-us.net>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f47b3050-3abd-caa4-cc71-4b13ef60e2c0@kaod.org>
Date:   Thu, 13 Sep 2018 17:48:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3f86e75f-1502-eae8-0633-d087937111c8@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 9726649298681957248
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrjeeigdeltdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/2018 03:33 PM, Guenter Roeck wrote:
> On 09/12/2018 10:45 PM, Cédric Le Goater wrote
> 
> [ ... ]
> 
>>> ---
>>> qemu:
>>>
>>> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
>>> index c762c73..0d4aa08 100644
>>> --- a/hw/i2c/aspeed_i2c.c
>>> +++ b/hw/i2c/aspeed_i2c.c
>>> @@ -180,6 +180,33 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)
>>>       return (bus->cmd >> I2CD_TX_STATE_SHIFT) & I2CD_TX_STATE_MASK;
>>>   }
>>>   +static void aspeed_i2c_handle_rx_cmd(AspeedI2CBus *bus)
>>> +{
>>> +    int ret;
>>> +
>>> +    if (!(bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST))) {
>>> +        return;
>>> +    }
>>
>> it deserves a comment to understand which scenario we are trying to handle.
>>
>>> +    if (bus->intr_status & I2CD_INTR_RX_DONE) {
>>> +        return;
>>> +    }
>>
>> should be handled in aspeed_i2c_bus_handle_cmd() I think
>>
> 
> I moved those two checks into the calling code.

ok

 
>>> +    aspeed_i2c_set_state(bus, I2CD_MRXD);
>>> +    ret = i2c_recv(bus->bus);
>>> +    if (ret < 0) {
>>> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
>>> +        ret = 0xff;
>>> +    } else {
>>> +        bus->intr_status |= I2CD_INTR_RX_DONE;
>>> +    }
>>> +    bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
>>> +    if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
>>> +        i2c_nack(bus->bus);
>>> +    }
>>> +    bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
>>> +    aspeed_i2c_set_state(bus, I2CD_MACTIVE);
>>> +}
>>> +
>>>   /*
>>>    * The state machine needs some refinement. It is only used to track
>>>    * invalid STOP commands for the moment.
>>> @@ -188,7 +215,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>>>   {
>>>       bus->cmd &= ~0xFFFF;
>>>       bus->cmd |= value & 0xFFFF;
>>> -    bus->intr_status = 0;> +    bus->intr_status &= I2CD_INTR_RX_DONE;
>>
>> it deserves a comment to understand which scenario we are trying to handle.
>>    
> 
> Ok. FWIW, I wonder if intr_status should be touched here in the first place,
> but I neither have the hardware nor a datasheet, so I don't know if any bits
> are auto-cleared.

I just pushed a patch on my branch with some more explanation : 

	https://github.com/legoater/qemu/commits/aspeed-3.1

> 
>>>       if (bus->cmd & I2CD_M_START_CMD) {
>>>           uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
>>> @@ -227,22 +254,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>>>       }
>>>         if (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) {
>>> -        int ret;
>>> -
>>> -        aspeed_i2c_set_state(bus, I2CD_MRXD);
>>> -        ret = i2c_recv(bus->bus);
>>> -        if (ret < 0) {
>>> -            qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
>>> -            ret = 0xff;
>>> -        } else {
>>> -            bus->intr_status |= I2CD_INTR_RX_DONE;
>>> -        }
>>> -        bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
>>> -        if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
>>> -            i2c_nack(bus->bus);
>>> -        }
>>> -        bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
>>> -        aspeed_i2c_set_state(bus, I2CD_MACTIVE);
>>> +        aspeed_i2c_handle_rx_cmd(bus);
>>>       }
>>>         if (bus->cmd & I2CD_M_STOP_CMD) {
>>> @@ -263,6 +275,7 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
>>>                                    uint64_t value, unsigned size)
>>>   {
>>>       AspeedI2CBus *bus = opaque;
>>> +    int status;
>>>         switch (offset) {
>>>       case I2CD_FUN_CTRL_REG:
>>> @@ -283,9 +296,16 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
>>>           bus->intr_ctrl = value & 0x7FFF;
>>>           break;
>>>       case I2CD_INTR_STS_REG:
>>> +        status = bus->intr_status;
>>>           bus->intr_status &= ~(value & 0x7FFF);
>>> -        bus->controller->intr_status &= ~(1 << bus->id);
>>> -        qemu_irq_lower(bus->controller->irq);
>>> +        if (!bus->intr_status) {
>>> +            bus->controller->intr_status &= ~(1 << bus->id);
>>> +            qemu_irq_lower(bus->controller->irq);
>>> +        }
>>
>> That part below is indeed something to fix. I had a similar patch.
>>
> 
> Should I split it out as separate patch ? Alternatively, if you submitted
> your patch already, I'll be happy to use it as base for mine.

See below. 

Thanks a lot,

C. 

From dea796e8d35ba7a70e4b14fbc30ff970a347b195 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 13 Sep 2018 17:44:32 +0200
Subject: [PATCH] aspeed/i2c: lower bus interrupt when all interrupts have been
 cleared
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Also include some documentation on the interrupt status bits and how
they should be cleared. Also, the model does not implement correctly
the RX_DONE bit behavior which should be cleared to allow more data to
be received. Yet to be fixed.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/i2c/aspeed_i2c.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index c762c7366ad9..275377c2ab38 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -52,6 +52,13 @@
 #define I2CD_AC_TIMING_REG2     0x08       /* Clock and AC Timing Control #1 */
 #define I2CD_INTR_CTRL_REG      0x0c       /* I2CD Interrupt Control */
 #define I2CD_INTR_STS_REG       0x10       /* I2CD Interrupt Status */
+
+#define   I2CD_INTR_SLAVE_ADDR_MATCH       (0x1 << 31) /* 0: addr1 1: addr2 */
+#define   I2CD_INTR_SLAVE_ADDR_RX_PENDING  (0x1 << 30)
+/* bits[19-16] Reserved */
+
+/* All bits below are cleared by writing 1 */
+#define   I2CD_INTR_SLAVE_INACTIVE_TIMEOUT (0x1 << 15)
 #define   I2CD_INTR_SDA_DL_TIMEOUT         (0x1 << 14)
 #define   I2CD_INTR_BUS_RECOVER_DONE       (0x1 << 13)
 #define   I2CD_INTR_SMBUS_ALERT            (0x1 << 12) /* Bus [0-3] only */
@@ -59,11 +66,16 @@
 #define   I2CD_INTR_SMBUS_DEV_ALERT_ADDR   (0x1 << 10) /* Removed */
 #define   I2CD_INTR_SMBUS_DEF_ADDR         (0x1 << 9)  /* Removed */
 #define   I2CD_INTR_GCALL_ADDR             (0x1 << 8)  /* Removed */
-#define   I2CD_INTR_SLAVE_MATCH            (0x1 << 7)  /* use RX_DONE */
+#define   I2CD_INTR_SLAVE_ADDR_RX_MATCH    (0x1 << 7)  /* use RX_DONE */
 #define   I2CD_INTR_SCL_TIMEOUT            (0x1 << 6)
 #define   I2CD_INTR_ABNORMAL               (0x1 << 5)
 #define   I2CD_INTR_NORMAL_STOP            (0x1 << 4)
 #define   I2CD_INTR_ARBIT_LOSS             (0x1 << 3)
+
+/*
+ * TODO: handle correctly I2CD_INTR_RX_DONE which needs to be cleared
+ * to allow next data to be received.
+ */
 #define   I2CD_INTR_RX_DONE                (0x1 << 2)
 #define   I2CD_INTR_TX_NAK                 (0x1 << 1)
 #define   I2CD_INTR_TX_ACK                 (0x1 << 0)
@@ -284,8 +296,10 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
         break;
     case I2CD_INTR_STS_REG:
         bus->intr_status &= ~(value & 0x7FFF);
-        bus->controller->intr_status &= ~(1 << bus->id);
-        qemu_irq_lower(bus->controller->irq);
+        if (!bus->intr_status) {
+            bus->controller->intr_status &= ~(1 << bus->id);
+            qemu_irq_lower(bus->controller->irq);
+        }
         break;
     case I2CD_DEV_ADDR_REG:
         qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
-- 
2.17.1


