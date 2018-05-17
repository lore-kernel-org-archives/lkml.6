Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeEQKCg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:02:36 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26656 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751734AbeEQKCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:02:34 -0400
From: Amelie DELAUNAY <amelie.delaunay@st.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] rtc: stm32: rework register management to prepare
 other version of RTC
Thread-Topic: [PATCH v2 1/3] rtc: stm32: rework register management to prepare
 other version of RTC
Thread-Index: AQHT56zdIFfUMey7YkaJdUNLAGLcjKQyt0oAgADj+YA=
Date: Thu, 17 May 2018 10:01:49 +0000
Message-ID: <d08bcefc-7698-a968-7a35-ed9ab62bd623@st.com>
References: <1525880770-22263-1-git-send-email-amelie.delaunay@st.com>
 <1525880770-22263-2-git-send-email-amelie.delaunay@st.com>
 <20180516202552.GA24496@piout.net>
In-Reply-To: <20180516202552.GA24496@piout.net>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BC83BF313F6C64AA957102629CD0575@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4HA2ggY032082

Hi,

On 05/16/2018 10:25 PM, Alexandre Belloni wrote:
> Hi,
> 
> On 09/05/2018 17:46:08+0200, Amelie Delaunay wrote:
>>   static void stm32_rtc_wpr_unlock(struct stm32_rtc *rtc)
>>   {
>> -	writel_relaxed(RTC_WPR_1ST_KEY, rtc->base + STM32_RTC_WPR);
>> -	writel_relaxed(RTC_WPR_2ND_KEY, rtc->base + STM32_RTC_WPR);
>> +	struct stm32_rtc_registers regs = rtc->data->regs;
> 
> regs should probably be a pointer to ensure that no copy is made. I've
> actually checked and it doesn't make a difference because gcc is smart
> enough to not make the copy.
> 

...

>>   static irqreturn_t stm32_rtc_alarm_irq(int irq, void *dev_id)
>>   {
>>   	struct stm32_rtc *rtc = (struct stm32_rtc *)dev_id;
>> -	unsigned int isr, cr;
>> +	struct stm32_rtc_registers regs = rtc->data->regs;
>> +	struct stm32_rtc_events evts = rtc->data->events;
> 
> Ditto for evts.
>

I prepare a v3 with const struct stm32_rtc_registers *regs and const 
struct stm32_rtc_events *evts.

>> +	unsigned int status, cr;
>>   
>>   	mutex_lock(&rtc->rtc_dev->ops_lock);
>>   
>> -	isr = readl_relaxed(rtc->base + STM32_RTC_ISR);
>> -	cr = readl_relaxed(rtc->base + STM32_RTC_CR);
>> +	status = readl_relaxed(rtc->base + regs.isr);
>> +	cr = readl_relaxed(rtc->base + regs.cr);
>>   
>> -	if ((isr & STM32_RTC_ISR_ALRAF) &&
>> +	if ((status & evts.alra) &&
>>   	    (cr & STM32_RTC_CR_ALRAIE)) {
>>   		/* Alarm A flag - Alarm interrupt */
>>   		dev_dbg(&rtc->rtc_dev->dev, "Alarm occurred\n");
> 
> ...
> 
>> @@ -641,7 +710,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
>>   
>>   	/*
>>   	 * After a system reset, RTC_ISR.INITS flag can be read to check if
>> -	 * the calendar has been initalized or not. INITS flag is reset by a
>> +	 * the calendar has been initialized or not. INITS flag is reset by a
>>   	 * power-on reset (no vbat, no power-supply). It is not reset if
>>   	 * rtc_ck parent clock has changed (so RTC prescalers need to be
>>   	 * changed). That's why we cannot rely on this flag to know if RTC
>> @@ -666,7 +735,7 @@ static int stm32_rtc_probe(struct platform_device *pdev)
>>   			 "alarm won't be able to wake up the system");
>>   
>>   	rtc->rtc_dev = devm_rtc_device_register(&pdev->dev, pdev->name,
>> -			&stm32_rtc_ops, THIS_MODULE);
>> +						&stm32_rtc_ops, THIS_MODULE);
>>   	if (IS_ERR(rtc->rtc_dev)) {
>>   		ret = PTR_ERR(rtc->rtc_dev);
>>   		dev_err(&pdev->dev, "rtc device registration failed, err=%d\n",
> 
> Those two changes should go into a separate cleanup patch.
> 

OK, new patch for these two changes in v3.

Thanks for reviewing,
Amelie
