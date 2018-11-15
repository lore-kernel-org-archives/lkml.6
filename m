Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E459C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E452022419
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 10:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvO+NqzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E452022419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbeKOVAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 16:00:48 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38406 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbeKOVAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 16:00:47 -0500
Received: by mail-wr1-f66.google.com with SMTP id e3-v6so20713939wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 02:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kdwkk+JTkwoXHDdx2SngHAYYQSmEf+5XoiDD0mwKm4s=;
        b=PvO+NqzXOPVFlAiX3vowkHW1DEg9nocq4YRC40D8UdKuM5sVRLE9hMAWnHW1rIwxoH
         rqFMzdVOs/+uo0IFDTMDS6EQTsQ7/n1iJiJefzxkHSbaxSHJt30uQ0cNPiFbrLd2tTnL
         pYfry0Fp5yagkWqzaevO279/aDvH8n5pjp0F4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kdwkk+JTkwoXHDdx2SngHAYYQSmEf+5XoiDD0mwKm4s=;
        b=LbH4pqqb7LuDeR+xyn7GV0imlZEPYNN2aqWTeNyqzN4FBbZ2HKmNCqKf0mmIG1l/ze
         O6Y6ULWxaLVe+KPcSXTnGVf1YFmLC1zFmJgt9r81W5sm1EZkwcX2sPlk04XRJ703pyJW
         wx3m7QBmk3kE/Z40nAO9/yHNYowySrfGt2BrXQSFmWtfAH+3V9qSXQAKlvUlofolLLQh
         oZleicD6eslzTS4L9oNs9bTQBYO10sUGrCGPT0NQimYF645pOew2xl6fN/IeLHsZXF+m
         nHPX364AhC0F9bdDahGk6/jPd7TCCo5ojN1dKMZdbQJLIP63d2lZ3yjQ6zbJf+dcNJVq
         fuVA==
X-Gm-Message-State: AGRZ1gJOEBEiWh89DJHetytZ08SEwfKkB8NnY4ErzmJTV10+gaelLX9d
        QSqHYlraQOODzsXzoLdnsbR4eg==
X-Google-Smtp-Source: AJdET5ecJB3CGXTzCTC7c8fDNmolqvreyLb0zj7OCAdX/gXl9YCcjsI8a5GsRScwj1fFyio2+lwspA==
X-Received: by 2002:adf:f20a:: with SMTP id p10-v6mr5294508wro.293.1542279206016;
        Thu, 15 Nov 2018 02:53:26 -0800 (PST)
Received: from [192.168.0.19] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id z3-v6sm15113093wma.6.2018.11.15.02.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 02:53:25 -0800 (PST)
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
References: <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <20181016141610.639b9000@gandalf.local.home>
 <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
 <20181016144123.24c47b38@gandalf.local.home>
 <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
 <20181016150328.3450d718@gandalf.local.home>
 <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
 <20181017223334.29ca2837@vmware.local.home>
 <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
 <20181018091706.62310b38@gandalf.local.home>
 <20181019041740.GB141835@joelaf.mtv.corp.google.com>
 <8a75f2d5-f1bd-504e-b545-ae2e2f61ca8f@codeaurora.org>
 <20181019095122.0f1c0946@gandalf.local.home>
 <9cafe321-87f6-98a3-3bda-c2f7a3d7fc67@codeaurora.org>
 <20181019111205.5c8e98e8@gandalf.local.home>
 <1e6cc1fa5263b9edfcf7567d3f9f65fd@codeaurora.org>
 <38099043-f5ed-6d81-bf94-13f61cfa8507@linaro.org>
 <8f65f83b-8cd9-5e35-c324-30b86390906e@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ed648cc5-0748-8bcc-5ebb-ce6dbc7d4fee@linaro.org>
Date:   Thu, 15 Nov 2018 10:53:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <8f65f83b-8cd9-5e35-c324-30b86390906e@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/11/18 10:33, Sai Prakash Ranjan wrote:
> On 11/13/2018 3:14 PM, Srinivas Kandagatla wrote:
>> Hi Sai,
>>
>>
>>
>> On 25/10/18 15:36, saiprakash.ranjan@codeaurora.org wrote:
>>> "If I disable dma node and LS-UART0, then I don't see any crash and
>>> ftrace also works fine"
>>>
>>> And one more observation is that even without ftrace cmdline, if I use
>>> earlycon and disable dma, I face the same crash.
>>>
>>> So basically this seems to be some kind of earlycon and dma issue and
>>> not ftrace(I can be wrong).
>>>
>>> So adding Srinivas for more info on this dma node.
>>
>> Its Interesting that my old email conversations with SBoyd show that I 
>> have investigated this issue in early 2016!
>>
>> My analysis so far:
>>
>> This reason for such behavior is due the common iface clock
>> (GCC_BLSP1_AHB_CLK) across multiple drivers(serial ports, bam dma
>> and other low speed devices).
>> The code flow in DB410C is bit different, as the uart0 is first
>> attempted to set as console and then uart1, this ordering triggers
>> pm state change uart_change_pm(state, UART_PM_STATE_OFF) from serial
>> core while setting up uart0, this would go and disable all the
>> clocks for uart0.
>> As uart1 is not setup Yet, and earlycon is still active, any
>> attempts by earlycon to write to registers would trigger a system
>> reboot as the clock was just disabled by uart0 change_pm code.
>>
>> This can even be triggered with any drivers like spi which uses same
>> clock I guess.
>>
>> Hope it helps,
>>
>> Either earlycon needs to reference the clocks or those clocks needs to
>> be marked always-on (but only with earlycon).
>>
>>>
>>> Also just for a note: apq8096-db820c.dtsi shows UART0 is disabled 
>>> because
>>> bootloader does not allow access to it. Could this also be the case 
>>> for db410c?
>> No, this is not the case with DB410c. DB820c has added restrictions in 
>> TZ, I think new booloaders should have solved this issue.
>>
>>
> 
> Hi Srinivas,
> 
> Thanks a lot for pointing out the cause of crash.
> I just tried setting GCC_BLSP1_AHB_CLK with flag CLK_IS_CRITICAL and the
> crash disappears.
> 
> But I suppose setting CLK_IS_CRITICAL is not the solution?
> 

Yes, this is not the solution, but it proves that the hand-off between 
booloaders and kernel is the issue.

In general there is wider issue with resources hand-off between 
bootloader and kernel.

There has been some proposal in the past by Viresh for a new framework 
called boot-constriants (https://lkml.org/lkml/2017/12/14/440) which am 
not sure if its still actively looked at. But something similar should 
be the way to address such issues.

--srini




> Thanks,
> Sai
