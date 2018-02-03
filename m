Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752608AbeBCQYq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 11:24:46 -0500
Received: from m15-42.126.com ([220.181.15.42]:8673 "EHLO m15-42.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751644AbeBCQYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 11:24:38 -0500
X-Originating-IP: [123.139.75.126]
Date: Sun, 4 Feb 2018 00:24:25 +0800 (CST)
From: "Zhang Bo" <zbsdta@126.com>
To: "Marcus Folkesson" <marcus.folkesson@gmail.com>
Cc: dmitry.torokhov@gmail.com, DRivshin@allworx.com, robh@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhang.bo19@zte.com.cn
Subject: Re:Re: [PATCH] Input: matrix_keypad - fix keypad does not response
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
 20160729(86883.8884) Copyright (c) 2002-2018 www.mailtech.cn 126com
In-Reply-To: <20180203134450.GC707@gmail.com>
References: <20180203120046.10988-1-zbsdta@126.com>
 <20180203134450.GC707@gmail.com>
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <718216bd.37a7.1615c7bb222.Coremail.zbsdta@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: KsqowAAn2L464nVaxlmRAA--.10791W
X-CM-SenderInfo: h2evv3bd6rjloofrz/1tbijhrhSVpD3+f30gAAs4
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w13GOqrl022427

At 2018-02-03 21:44:50, "Marcus Folkesson" <marcus.folkesson@gmail.com> wrote:
>> diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
>> index 1f316d66e6f7..13fe51824637 100644
>> --- a/drivers/input/keyboard/matrix_keypad.c
>> +++ b/drivers/input/keyboard/matrix_keypad.c
>> @@ -169,7 +169,8 @@ static void matrix_keypad_scan(struct work_struct *work)
>>  	/* Enable IRQs again */
>>  	spin_lock_irq(&keypad->lock);
>>  	keypad->scan_pending = false;
>> -	enable_row_irqs(keypad);
>> +	if (keypad->stopped == false)
>> +		enable_row_irqs(keypad);
>>  	spin_unlock_irq(&keypad->lock);
>>  }
>>  
>> @@ -202,14 +203,16 @@ static int matrix_keypad_start(struct input_dev *dev)
>>  {
>>  	struct matrix_keypad *keypad = input_get_drvdata(dev);
>>  
>> +	spin_lock_irq(&keypad->lock);
>>  	keypad->stopped = false;
>> -	mb();
>>  
>>  	/*
>>  	 * Schedule an immediate key scan to capture current key state;
>>  	 * columns will be activated and IRQs be enabled after the scan.
>>  	 */
>> -	schedule_delayed_work(&keypad->work, 0);
>> +	if (keypad->scan_pending == false)
>> +		schedule_delayed_work(&keypad->work, 0);
>> +	spin_unlock_irq(&keypad->lock);
>>  
>>  	return 0;
>>  }
>> @@ -218,14 +221,17 @@ static void matrix_keypad_stop(struct input_dev *dev)
>>  {
>>  	struct matrix_keypad *keypad = input_get_drvdata(dev);
>>  
>> +	spin_lock_irq(&keypad->lock);
>>  	keypad->stopped = true;
>> -	mb();
>> -	flush_work(&keypad->work.work);
>>  	/*
>>  	 * matrix_keypad_scan() will leave IRQs enabled;
>>  	 * we should disable them now.
>>  	 */
>> -	disable_row_irqs(keypad);
>> +	if (keypad->scan_pending == false)
>> +		disable_row_irqs(keypad);
>> +	spin_unlock_irq(&keypad->lock);
>> +
>> +	flush_work(&keypad->work.work);
>>  }
>
>
>Hum, I think we should use spin_lock_irqsave/spin_lock_irqrestore
>instead to be on the safe side. 
>I don't see how we could guarantee that irqs is allways enabled when
>calling spin_lock_irq().

spin_lock_irq and  spin_unlock_irq are called in matrix_keypad_stop and matrix_keypad_start
which are in suspend and resume,  they run in process context, matrix_keypad_scan runs in
worker which is in process context also.
