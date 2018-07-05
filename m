Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DD5C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7797E24105
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N07aiU5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7797E24105
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754015AbeGENE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:04:59 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46607 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753409AbeGENE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:04:57 -0400
Received: by mail-pf0-f193.google.com with SMTP id l123-v6so5380153pfl.13;
        Thu, 05 Jul 2018 06:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xneApVQhoM3lV2tl06Heq18mOx0ICboKmnBqRRvMyfk=;
        b=N07aiU5R0VuEtIhVErw5kAy7ioJk1HM4BktEcY+yWoKpeWjmpiBdxJFmWJhD/kvBO+
         w3Hbdgeu5W5ywG5kgAqWjCrfWBqpfysZ2wvniZVW+rMIZkw0OCtav/8/Y8rmq2RMVNFQ
         doNtWuslVlXH4HOllTB1egBHybzqolAIMYOIOIHQbCYYkEGA2w+bta513z3U8BGYNzgl
         ezdx3VXFoENj37GIOn1OZ3D8pMa2HgpzoiAE5ZbsOvkkLQnEf7/DOzb2v86lK8QRXxmx
         WhZD21xaagmJeCfLLbxgFUB58tHYyG2m9nrmOKDOd/9yBQVp3X3C2FXyA70DFKRwBtDd
         V/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xneApVQhoM3lV2tl06Heq18mOx0ICboKmnBqRRvMyfk=;
        b=GZ+xQYZ0M1/HOWFz35bCawWiVmNvBtZrOTg5kuczG8R+AW0o0igSgc7fmJXPbQrG3t
         +GnRopQot2mO+S1XYaMRrHFx5AgxtcBKddUmtHs0Vfemt5S3OUWe+k/j9CAfgML+zOzV
         abrGwI9uUqjzU/PUR69m9Pgm5H1UHe5+SIZ3QYZtCaP1iDhAHT88QBVcYJxRaWIFqphP
         FpzYRd+s0Mi47KTdNcmfvq90SCcs6mM17aEe1CS1N2P/6BLBZvyvUiC8zST+3d+rEKhc
         i9jL7TY02kdpmQZIop0EpVaShdObhzMZuQONNM5NZsQ+YUvbMeg5yrRbkzeSNNWMGubY
         seMg==
X-Gm-Message-State: APt69E0Lpuhyve+xWvMoPvg2O27U6Jgv63kOJfrptHvw1WJmqy39erwt
        SgOdMZxXQsmlg/SqEsl4yKA2hQ==
X-Google-Smtp-Source: AAOMgpdsBshrYfPZe49Q8SPZjgpXqf/742bL3oWGoKXLYyaCLDpIGScdbd+ZkcJHCJEO8uPhDBgftg==
X-Received: by 2002:a65:5245:: with SMTP id q5-v6mr5499566pgp.67.1530795896917;
        Thu, 05 Jul 2018 06:04:56 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t63-v6sm3884154pgt.57.2018.07.05.06.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:04:56 -0700 (PDT)
Subject: Re: [PATCH] watchdog: add module parameter "force_no_reboot" for iTCO
To:     "Tian, Baofeng" <baofeng.tian@intel.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0038B620BAC72941BCBF48AEB892976C02CADE1E@shsmsx102.ccr.corp.intel.com>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E1BFEB@shsmsx102.ccr.corp.intel.com>
 <140371d6-4bbb-6377-a570-5253c5f98e0e@roeck-us.net>
 <EEBA739CCF11FE49B73E1FB4690F5EE649E29D27@SHSMSX101.ccr.corp.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <b83a8cd9-b81e-cce3-1b34-f88d38fe414e@roeck-us.net>
Date:   Thu, 5 Jul 2018 06:04:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <EEBA739CCF11FE49B73E1FB4690F5EE649E29D27@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2018 11:28 PM, Tian, Baofeng wrote:
> Hi, Roeck
> 
> Yes, this patch is for add a parameter to TCO to prevent reboot happen if you don't want to reboot system
> and want to stay here to check some HW status, logs, etc for debug purpose.
> 
> Under some android related stability test, developer want to stay at the crash and use debug tools(LTB)
> to check more information, this is the purpose of this patch.
> 
The watchdog doesn't even start with the module parameter set.
If the purpose is to disable the watchdog, just stop it by closing
the watchdog daemon, or don't run the watchdog daemon in the first
place, or blacklist the module.

Guenter

> Thanks
> Tim
> 
> -----Original Message-----
> From: Guenter Roeck [mailto:groeck7@gmail.com] On Behalf Of Guenter Roeck
> Sent: Monday, July 2, 2018 9:21 PM
> To: Tian, Baofeng <baofeng.tian@intel.com>; wim@linux-watchdog.org; linux-watchdog@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] watchdog: add module parameter "force_no_reboot" for iTCO
> 
> On 07/02/2018 12:30 AM, Tian, Baofeng wrote:
>> From: "Tian, Baofeng" <baofeng.tian@intel.com
>> <mailto:baofeng.tian@intel.com>>
>> Subject: [PATCH] watchdog: add module parameter "force_no_reboot" for
>> iTCO
>>
>> Setting "force_no_reboot" parameter to true (y/Y/1) will have the
>> effect to prevent to reset the NO_REBOOT flag thus preventing the iTCO
>> to reboot the platform, if not set or set to false, then system will
>> reboot after about 30s.
>>
>> Signed-off-by: Tian, Baofeng <baofeng.tian@intel.com
>> <mailto:baofeng.tian@intel.com>>
> 
> Your e-mail address is messed up.
> 
>> ---
>>    drivers/watchdog/iTCO_wdt.c | 11 ++++++++++-
>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
>> index 347f038..255318b 100644
>> --- a/drivers/watchdog/iTCO_wdt.c
>> +++ b/drivers/watchdog/iTCO_wdt.c
>> @@ -131,6 +131,11 @@ module_param(turn_SMI_watchdog_clear_off, int,
>> 0);
>>    MODULE_PARM_DESC(turn_SMI_watchdog_clear_off,
>>         "Turn off SMI clearing watchdog (depends on
>> TCO-version)(default=1)");
>>
>> +static bool force_no_reboot;
>> +module_param(force_no_reboot, bool, 0);
>> +MODULE_PARM_DESC(force_no_reboot,
>> +           "Prevents the watchdog rebooting the platform
>> +(default=0)");
>> +
>>    /*
>>     * Some TCO specific functions
>>     */
>> @@ -243,6 +248,10 @@ static int iTCO_wdt_start(struct watchdog_device
>> *wd_dev)
>>         struct iTCO_wdt_private *p = watchdog_get_drvdata(wd_dev);
>>         unsigned int val;
>>
>> +     /* force_no_reboot will prevent to unset NO_REBOOT bit */
>> +     if (force_no_reboot)
>> +           return -EIO;
>> +
> It seems to me that this flag prevents the watchdog from being started, and on top it would return an unreasonable error (-EIO).
> 
> I don't see the point of this patch, sorry.
> 
> Guenter
> 
>>         spin_lock(&p->io_lock);
>>
>>         iTCO_vendor_pre_start(p->smi_res, wd_dev->timeout); @@ -250,7
>> +259,7 @@ static int iTCO_wdt_start(struct watchdog_device *wd_dev)
>>         /* disable chipset's NO_REBOOT bit */
>>         if (p->update_no_reboot_bit(p->no_reboot_priv, false)) {
>>               spin_unlock(&p->io_lock);
>> -           pr_err("failed to reset NO_REBOOT flag, reboot disabled by
>> hardware/BIOS\n");
>> +           pr_err("failed to reset NO_REBOOT flag, reboot disabled by
>> +hardware/BIOS/rc_cmd\n");
>>               return -EIO;
>>         }
>>
>> --
>> 2.7.4
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

