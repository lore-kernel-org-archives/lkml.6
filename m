Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09903C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC2F20684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 08:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zfgp6zwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfBWIJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 03:09:46 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44914 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfBWIJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 03:09:45 -0500
Received: by mail-yb1-f195.google.com with SMTP id j85so1795272ybg.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 00:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J8/WNnvcRkZFRyKH0YtNAngMTMrhvhGst1IsnfFKbow=;
        b=Zfgp6zwGz7GaXPTO9iGMqT+BoKfp0Bp7lWCPaLUAMHusAcyXp8nh96ryX7GEcpnzlB
         31xig2RknzeKRcERDbukerKyP4f8un+94CnKx1njmMsrZsu7ko2YcnX6ZNiyJG7Zqg69
         iwZuBiXWUsplxsukJD/cVj7DvMcfB35j32fX10gxcvcQAYFA4uxvfuDvEIhXwB7HmsI4
         0qcJyRYLgN96lEIpLFA9BtJQB0URDa6ZhkVOS9DLGIoy/S6k9RqRdXhmccNGCJvj6puA
         a6xrlzf84rhWSO/WoBejpwbSDClPkYDOEBHkk22L7mE/KPL1SLvu3RJSyZsxwckOOBup
         6xuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=J8/WNnvcRkZFRyKH0YtNAngMTMrhvhGst1IsnfFKbow=;
        b=JJwUDEs/Xp8bGaC1yLhhoB/yI17XyxQRImtyYG8yepPuNMuJ9duHAG6K7Sas4HqbYC
         z2a2DVkLluwqmU5L3fX7wsT+43qLae5WYCZjpQF08c37j5MYW00iug3hV2jQYPmFVw4l
         zCYqwqmJHZ2v9m5TSPic1AhrNbWi48rZEMLaBZ61aUYm5RHMMngVdNvu7rd7Tz8s4gP2
         i2OLlz6T9j3mXIgSPAN4x94oCVCx1TStlayQMXE8Aqe1yRc4eM1VxdhMc52iNAYRxC/m
         nIp3wuI53P2bjjZNT5xmR8nM6vP3yGtUIRe1KumAuwVEziYMj5VaT3L5NYGyfGtZqnAz
         D4Xw==
X-Gm-Message-State: AHQUAua0MvsXgxA/Q/l1TmqD06czwTj0BE2tqfibb+hSbOqlL3D317FG
        MdmUhXFoQY0oWR4fzdg8hhh+tCdNy8s=
X-Google-Smtp-Source: AHgI3Ib19lU/+7505e+9cdaA7NwQWTyRatlcnJmiNINVBLC0iL9g9yQIUCbc6+O7HCQM+7OyePj7nQ==
X-Received: by 2002:a25:c43:: with SMTP id 64mr6543272ybm.457.1550909384167;
        Sat, 23 Feb 2019 00:09:44 -0800 (PST)
Received: from yubo-2 ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id 21sm1304196ywg.55.2019.02.23.00.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 00:09:43 -0800 (PST)
Date:   Sat, 23 Feb 2019 03:09:42 -0500
From:   YU Bo <tsu.yubo@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sergio.paracuellos@gmail.com, quytelda@tamalin.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        yuzibode@126.com
Subject: Re: [PATCH] staging/ks7070: Removed unused varibale
Message-ID: <20190223080941.ufsdrtxz4cewkik7@yubo-2>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
        sergio.paracuellos@gmail.com, quytelda@tamalin.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        yuzibode@126.com
References: <20190223063939.18261-1-tsu.yubo@gmail.com>
 <20190223074320.GA921@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190223074320.GA921@kroah.com>
User-Agent: NeoMutt/20180512-62-03f98a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 08:43:20AM +0100, Greg KH wrote:
>On Sat, Feb 23, 2019 at 01:39:39AM -0500, Bo YU wrote:
>> From: Bo Yu <tsu.yubo@gmail.com>
>>
>> Compiling the kernel with W=1 results in the following warning:
>>
>> drivers/staging/ks7010/ks_hostif.c:465:6: warning: variable ‘mib_val_type’
>> set but not used [-Wunused-but-set-variable]
>>   u16 mib_val_type;
>>
>> drivers/staging/ks7010/ks_hostif.c:464:6: warning: variable ‘mib_val_size’
>> set but not used [-Wunused-but-set-variable]
>>     u16 mib_val_size;
>>
>> drivers/staging/ks7010/ks_hostif.c:786:6: warning: variable ‘result_code’
>> set but not used [-Wunused-but-set-variable]
>>       u16 result_code;
>>
>> Remove these variables.
>>
>> Rebase on next-20190222
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>> Cc: Quytelda Kahja <quytelda@tamalin.org>
>>
>> Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
>> ---
>>  drivers/staging/ks7010/ks_hostif.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
>> index d938b0997a53..913d8996437a 100644
>> --- a/drivers/staging/ks7010/ks_hostif.c
>> +++ b/drivers/staging/ks7010/ks_hostif.c
>> @@ -461,13 +461,9 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
>>  	struct net_device *dev = priv->net_dev;
>>  	u32 mib_status;
>>  	u32 mib_attribute;
>> -	u16 mib_val_size;
>> -	u16 mib_val_type;
>>
>>  	mib_status = get_dword(priv);
>>  	mib_attribute = get_dword(priv);
>> -	mib_val_size = get_word(priv);
>> -	mib_val_type = get_word(priv);
>
>The function get_word() actually does something to the priv structure,
>so you just broke the driver :(
>
>>
>>  	if (mib_status) {
>>  		netdev_err(priv->net_dev, "attribute=%08X, status=%08X\n",
>> @@ -783,9 +779,7 @@ void hostif_ps_adhoc_set_confirm(struct ks_wlan_private *priv)
>>  static
>>  void hostif_infrastructure_set_confirm(struct ks_wlan_private *priv)
>>  {
>> -	u16 result_code;
>>
>> -	result_code = get_word(priv);
>>  	priv->infra_status = 1;	/* infrastructure mode set */
>>  	hostif_sme_enqueue(priv, SME_MODE_SET_CONFIRM);
>
>Same here, odds are you just broke things :(
>
>Please be more careful.
Ok, I have through get_word() and get_byte() before modifing the code.
I think it should be better to encapsulate get_word without return value to do some operations
like that? right?
>
>greg k-h
