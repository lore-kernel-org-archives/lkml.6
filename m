Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8AFC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9281120853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tcy+sO6P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9281120853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbeINJAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 05:00:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34164 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbeINJAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 05:00:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so3728157pgv.1;
        Thu, 13 Sep 2018 20:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=lGcrGDA1wxPanjdBisEuaFxzu6HRzbjiVluJYiEPoOs=;
        b=Tcy+sO6P6Cwtew7oT+Vdp+CZdyyhsXuY1H7JHx0ZPiJeZ7XXZJWABxYRaFiccPwgTE
         sutXLPxXgpdNL2xZKfWCxilabrCmDjV4rgdj90Ni0WgEIFiAzfdd4KQEUebBt8XKXwrz
         G4NZk5F8NcLyVmIApxqIFK5of2Epkru4tUOcZz2XbA1l1T3g8uWwpg85rJ/otM7lycFR
         V6dgcs52KYCSPNro6lWPDqpgXQYbh76XllpV3mBAuk4Tg/vLRBKTUIQzk9UrdWbfMqy5
         ryMRo4d1DaaD/5J6z47pYh7sWFpdT+PU44PHlaginGF9UeLsOttZbEIRbB9OvLpM1Ski
         Fdsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language;
        bh=lGcrGDA1wxPanjdBisEuaFxzu6HRzbjiVluJYiEPoOs=;
        b=aHdBmPPCYfqEOYrDyytq+mDFvIllNj9boVe1aXFrq612ZwxlA99HLyyIP/nku/xsE9
         EebKp8exUaPq0HBcFRFejs1e5W8TYLHD7VN9N3stRHGF/28H8KxNp47hKJEzHAtkOhoB
         y+M8zA5bdK4yxRfLKOpfwOqAbf0DcCMS3mnjTXzltmuX0kH3yMJhyaRjv6RCP9/xTF6m
         /EqJoXjy2A+LaZGRwm/yCmX1gcVXzuPbRkTpZQ+EM/625vs8zP4vNtrTheDrAsJAgvyO
         JNf5LsiXSh9W9D6BYlY5PwzrFHZTSNf1DvrO9M/qiOhelMwALh7MNiwRBsyQDLtEgEWO
         fqug==
X-Gm-Message-State: APzg51BRZYV+JffoB3SXTyAYQW6yBzpXvLMqBhIM2MbOVmXHyQBxua5E
        1kxaYN5J1ULtgfRsT7QHxQWtPIWe
X-Google-Smtp-Source: ANB0VdatvdheKdZaAwaD8FR7wMxtVP4xTkV4PRO8ToGky7tB/lzybPns+ibNqMk36G7NIUMNcintlA==
X-Received: by 2002:a63:4044:: with SMTP id n65-v6mr9493978pga.90.1536896892658;
        Thu, 13 Sep 2018 20:48:12 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 6-v6sm11744453pfr.115.2018.09.13.20.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 20:48:11 -0700 (PDT)
Subject: Re: [PATCH i2c-next v6] i2c: aspeed: Handle master/slave combined irq
 events properly
To:     =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c@vger.kernel.org, jarkko.nikula@linux.intel.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        James Feist <james.feist@linux.intel.com>
References: <20180911233302.GA18799@roeck-us.net>
 <5698ca34-14c9-8d05-c4e6-5acf85ff9d14@linux.intel.com>
 <20180912013449.GA12612@roeck-us.net>
 <7fd98646-fb5a-be4d-ce37-84b74e0fa8b3@linux.intel.com>
 <20180912195844.GA6893@roeck-us.net>
 <da7f4691-7428-3114-32bb-e0171f6c7228@linux.intel.com>
 <20180912203059.GA18201@roeck-us.net>
 <fb185839-3ae0-01dc-09e8-f22db55ecb04@kaod.org>
 <3f86e75f-1502-eae8-0633-d087937111c8@roeck-us.net>
 <f47b3050-3abd-caa4-cc71-4b13ef60e2c0@kaod.org>
 <20180913155703.GA22605@roeck-us.net>
 <2c481986-7ee0-4887-5c9b-64e2cd9d8c04@kaod.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b4da2b68-e6e3-e068-cd6e-9e638aa67889@roeck-us.net>
Date:   Thu, 13 Sep 2018 20:48:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2c481986-7ee0-4887-5c9b-64e2cd9d8c04@kaod.org>
Content-Type: multipart/mixed;
 boundary="------------E9005F7A05CA14521919FD16"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------E9005F7A05CA14521919FD16
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/13/2018 09:35 AM, Cédric Le Goater wrote:
> On 09/13/2018 05:57 PM, Guenter Roeck wrote:
>> On Thu, Sep 13, 2018 at 05:48:59PM +0200, Cédric Le Goater wrote:
>>> On 09/13/2018 03:33 PM, Guenter Roeck wrote:
>> [ ... ]
>>>>>>    /*
>>>>>>     * The state machine needs some refinement. It is only used to track
>>>>>>     * invalid STOP commands for the moment.
>>>>>> @@ -188,7 +215,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
>>>>>>    {
>>>>>>        bus->cmd &= ~0xFFFF;
>>>>>>        bus->cmd |= value & 0xFFFF;
>>>>>> -    bus->intr_status = 0;> +    bus->intr_status &= I2CD_INTR_RX_DONE;
>>>>>
>>>>> it deserves a comment to understand which scenario we are trying to handle.
>>>>>     
>>>>
>>>> Ok. FWIW, I wonder if intr_status should be touched here in the first place,
>>>> but I neither have the hardware nor a datasheet, so I don't know if any bits
>>>> are auto-cleared.
>>>
>>> I just pushed a patch on my branch with some more explanation :
>>>
>>> 	https://github.com/legoater/qemu/commits/aspeed-3.1
>>>
>> That seems to suggest that none of the status bits auto-clears, and that
>> the above code clearing intr_status should be removed entirely.
>> Am I missing something ?
> 
> You are right. I just pushed another version of the previous patch with this
> new hunk :
> 
> @@ -188,7 +200,6 @@ static void aspeed_i2c_bus_handle_cmd(As
>   {
>       bus->cmd &= ~0xFFFF;
>       bus->cmd |= value & 0xFFFF;
> -    bus->intr_status = 0;
>   
>       if (bus->cmd & I2CD_M_START_CMD) {
>           uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
> 
> 
> The QEMU palmetto and witherspoon machines seem to behave fine. Can you give
> it a try ?
> 

Works fine for me for all affected qemu platforms.

How do you want to proceed with the qemu patches ? I attached my patches
for reference. Maybe you can add them to your tree if they are ok and submit
the entire series together to the qemu mailing list ?

Thanks,
Guenter

--------------E9005F7A05CA14521919FD16
Content-Type: text/x-patch;
 name="0001-aspeed-i2c-Handle-receive-command-in-separate-functi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-aspeed-i2c-Handle-receive-command-in-separate-functi.pa";
 filename*1="tch"

From 9eb05b7f6d7ceb2919fa8b865772ab9207d1afed Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Sep 2018 16:35:20 -0700
Subject: [PATCH 1/2] aspeed/i2c: Handle receive command in separate function

Receive command handling may have to be deferred if a previous receive
done interrupt was not yet acknowledged. Move receive command handling
into a separate function to prepare for the necessary changes.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/i2c/aspeed_i2c.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index de6b083..d81f865 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -192,6 +192,26 @@ static uint8_t aspeed_i2c_get_state(AspeedI2CBus *bus)
     return (bus->cmd >> I2CD_TX_STATE_SHIFT) & I2CD_TX_STATE_MASK;
 }
 
+static void aspeed_i2c_handle_rx_cmd(AspeedI2CBus *bus)
+{
+    int ret;
+
+    aspeed_i2c_set_state(bus, I2CD_MRXD);
+    ret = i2c_recv(bus->bus);
+    if (ret < 0) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
+        ret = 0xff;
+    } else {
+        bus->intr_status |= I2CD_INTR_RX_DONE;
+    }
+    bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
+    if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
+        i2c_nack(bus->bus);
+    }
+    bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
+    aspeed_i2c_set_state(bus, I2CD_MACTIVE);
+}
+
 /*
  * The state machine needs some refinement. It is only used to track
  * invalid STOP commands for the moment.
@@ -238,22 +258,7 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
     }
 
     if (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) {
-        int ret;
-
-        aspeed_i2c_set_state(bus, I2CD_MRXD);
-        ret = i2c_recv(bus->bus);
-        if (ret < 0) {
-            qemu_log_mask(LOG_GUEST_ERROR, "%s: read failed\n", __func__);
-            ret = 0xff;
-        } else {
-            bus->intr_status |= I2CD_INTR_RX_DONE;
-        }
-        bus->buf = (ret & I2CD_BYTE_BUF_RX_MASK) << I2CD_BYTE_BUF_RX_SHIFT;
-        if (bus->cmd & I2CD_M_S_RX_CMD_LAST) {
-            i2c_nack(bus->bus);
-        }
-        bus->cmd &= ~(I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST);
-        aspeed_i2c_set_state(bus, I2CD_MACTIVE);
+        aspeed_i2c_handle_rx_cmd(bus);
     }
 
     if (bus->cmd & I2CD_M_STOP_CMD) {
-- 
2.7.4


--------------E9005F7A05CA14521919FD16
Content-Type: text/x-patch;
 name="0002-aspeed-i2c-Fix-receive-done-interrupt-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-aspeed-i2c-Fix-receive-done-interrupt-handling.patch"

From b5e1879de9c347ab03a09d71f12d40aad0a16d6d Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Sep 2018 14:19:30 -0700
Subject: [PATCH 2/2] aspeed/i2c: Fix receive done interrupt handling

The AST2500 datasheet says:

I2CD10 Interrupt Status Register
       bit 2 Receive Done Interrupt status
             S/W needs to clear this status bit to allow next data receiving

The Rx interrrupt done interrupt status bit needs to be cleared
explicitly before the next byte can be received, and must therefore
not be auto-cleared. Also, receiving the next byte must be delayed
until the bit has been cleared.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/i2c/aspeed_i2c.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index d81f865..7ae99bc 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -257,7 +257,8 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
         aspeed_i2c_set_state(bus, I2CD_MACTIVE);
     }
 
-    if (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) {
+    if ((bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST)) &&
+        !(bus->intr_status & I2CD_INTR_RX_DONE)) {
         aspeed_i2c_handle_rx_cmd(bus);
     }
 
@@ -279,6 +280,7 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
                                  uint64_t value, unsigned size)
 {
     AspeedI2CBus *bus = opaque;
+    bool handle_rx;
 
     switch (offset) {
     case I2CD_FUN_CTRL_REG:
@@ -299,11 +301,17 @@ static void aspeed_i2c_bus_write(void *opaque, hwaddr offset,
         bus->intr_ctrl = value & 0x7FFF;
         break;
     case I2CD_INTR_STS_REG:
+        handle_rx = (bus->intr_status & I2CD_INTR_RX_DONE) &&
+                (value & I2CD_INTR_RX_DONE);
         bus->intr_status &= ~(value & 0x7FFF);
         if (!bus->intr_status) {
             bus->controller->intr_status &= ~(1 << bus->id);
             qemu_irq_lower(bus->controller->irq);
         }
+        if (handle_rx && (bus->cmd & (I2CD_M_RX_CMD | I2CD_M_S_RX_CMD_LAST))) {
+            aspeed_i2c_handle_rx_cmd(bus);
+            aspeed_i2c_bus_raise_interrupt(bus);
+        }
         break;
     case I2CD_DEV_ADDR_REG:
         qemu_log_mask(LOG_UNIMP, "%s: slave mode not implemented\n",
-- 
2.7.4


--------------E9005F7A05CA14521919FD16--
