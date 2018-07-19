Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9C8ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C7B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCMyUC4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C7B20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbeGSODD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:03:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35964 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbeGSODD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:03:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id s7-v6so314955pgv.3;
        Thu, 19 Jul 2018 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eK7DK4EKZhKuTSwUdarYW60Hdi0X4ze2hasQ4ld8WCA=;
        b=eCMyUC4bJfdOqyR1K8s04XxD0KJBlLkmuzYhmN67dusF/jQ1kIpO/RjkvF62p1nazT
         qteC+7vSc/RvqSAce47CXbkwfbDBImWf/fFoN3AWmrMRYdw3mfA28wT6/wGws6FV9v8k
         3GyBsJymQ/MA0tBQBR9UiNarjFy1GfgE73sI2rTgAbzfA6voCWQ5CRXfS0FxSbDf+Zy2
         P4oKvS5f4RDvQSEi1P3CoiqS/lUsEns9GPt0xpZDLsmvKE/zMQEMUzR5Ja07hF0TPw9f
         E7pXmZp/Uqx/Df73yWXytlTPWhJC65xL2WozjktWaR7Lmwhr2F82Rdwp4QSZybAfHAyf
         QURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eK7DK4EKZhKuTSwUdarYW60Hdi0X4ze2hasQ4ld8WCA=;
        b=gx7MSWlap4YomrQfGQA1P71MaSNIjDGJPCywzaidsjOqmXXcmZ74hIuFEVp/y29lJ6
         z37u/ZVAQrj5Png4iEP1dsBnPVsmefGnXPiSBPaIqbbKxSgXdBRZ2SSy3CH7WZ5L5q4S
         2oI4iNOkenyt0Ss7S8WM3pnooA0Wqr2YukvnAWCmmxVKSPJ9rvG20cxzDV5jL3Pyd/81
         bkkPGjAFmb42IvFdjBVabpVSMHcxenOeWD6A099OheFdBdG3l27FeYA69VoR/iEVv56U
         tKyEVi1DjGAmlQKpMAsKQ/2IIoPl6lNB8jzlgxVjvSSm4Ve1h1P5CP9HEozc3WP9ZB2l
         eUEg==
X-Gm-Message-State: AOUpUlG/6X376VwDHOR8p6z7/k1vgnf0Y5cAae0unePXj87s5X+o73/p
        Co8aWGfCtDDVuI2Kk9INRb1KJLs9
X-Google-Smtp-Source: AAOMgpfcFjVU2Ad/cBtuVqJQ1i3zCx9ND4XJMVExiOwHPev6viaCEWJNbODhcT2hWt7/JhPO/DKLlA==
X-Received: by 2002:a65:5106:: with SMTP id f6-v6mr9810978pgq.72.1532006395382;
        Thu, 19 Jul 2018 06:19:55 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id o21-v6sm9740305pfa.54.2018.07.19.06.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:19:54 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] hwmon: ibmpowernv: Add attributes to
 enable/disable sensor groups
To:     Stewart Smith <stewart@linux.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        mpe@ellerman.id.au
Cc:     linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, ego@linux.vnet.ibm.com
References: <1531937610-6454-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1531937610-6454-3-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <87lga7r9rq.fsf@linux.vnet.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <06548ca9-8bc9-f0ec-7e75-1dd675972d13@roeck-us.net>
Date:   Thu, 19 Jul 2018 06:19:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <87lga7r9rq.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/18/2018 11:59 PM, Stewart Smith wrote:
> Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:
>> On-Chip-Controller(OCC) is an embedded micro-processor in POWER9 chip
>> which measures various system and chip level sensors. These sensors
>> comprises of environmental sensors (like power, temperature, current
>> and voltage) and performance sensors (like utilization, frequency).
>> All these sensors are copied to main memory at a regular interval of
>> 100ms. OCC provides a way to select a group of sensors that is copied
>> to the main memory to increase the update frequency of selected sensor
>> groups. When a sensor-group is disabled, OCC will not copy it to main
>> memory and those sensors read 0 values.
> 
> OCC is an implementation detail rather than a core part of this firmware
> API.
> 
> Why not something like this:
> 
> OPAL firmware provides the facility for some groups of sensors to be
> enabled/disabled at runtime to give the user the option of using the
> system resources for collecting these sensors or not.
> 
> For example, on POWER9 systems, the On Chip Controller (OCC) gathers
> various system and chip level sensors and maintains their values in main
> memory.
> 
> 
>> +static int init_sensor_group_data(struct platform_device *pdev,
>> +				  struct platform_data *pdata)
>> +{
>> +	struct sensor_group_data *sgrp_data;
>> +	struct device_node *groups, *sgrp;
>> +	enum sensors type;
>> +	int count = 0, ret = 0;
>> +
>> +	groups = of_find_node_by_path("/ibm,opal/sensor-groups");
>> +	if (!groups)
>> +		return ret;
> 
> Why not look for the compatible property?
> 
> 

For both, I don't really care either way. Can you folks get to an agreement
and let me know after you decided ?

Thanks,
Guenter
