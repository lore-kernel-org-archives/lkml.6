Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDD0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D60820870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlIxJ+zO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D60820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbeGaPpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 11:45:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36751 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbeGaPpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 11:45:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id s7-v6so9141635pgv.3;
        Tue, 31 Jul 2018 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e3pbXDANbirJ5qJp8I3h1uCHLewTnLlrCEhLAsGXtO8=;
        b=ZlIxJ+zOXfa5cooSYUhzDhGA5YoU4B8AKiCxRfwtQWQL7s75vh0J5ko3c/Z+xMUec6
         Evs+Y5IsQJObiiZLZd3wg10W0fgIpnecVS63fKoG6ATq9+Y5DY3hJLE8D6bpHlJV3otk
         tXQ+JbAMGsz00qxUxOxtnzIXUkpEapZ0JE4yU6e8FO/vFgpxC/o2tmzQxENNHOpYMNYJ
         sN4b7QTRhYkOL61/IUyjFUF3EGQZKuTVExa2ONhfJmZqe/IuRhX8dlSTrkc0qVioUfGG
         EvOaKNbxgJOo7KvWTe/T34GffBpTqOgLhZ97yYKf7gUrr0umZO3L1ZbQqHcnt6MzPt7i
         6kBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e3pbXDANbirJ5qJp8I3h1uCHLewTnLlrCEhLAsGXtO8=;
        b=T0FDURqHZ2GRWxj9f+ifFXUAeY1M79l3O6PXgLOHifEuQFKujRWAk8d9IRSdtKzsib
         0tRcZhckJJpj5bMQ4kxFH31i0ESeh5y1uEVM5iQNSn7gxDlGYF2ht1t9NW7XtaeIRArW
         d0gYETHNiDlQKa4mjpz+2Dmx9781lzmFX2O4a3Opx047msrWlpASxNv+JHOn8aXM2mXU
         /o0/6lX8MvZfva0WFZUcd9D3jx72vmUP/03ZINoHNgnk90oiqQj3CHxE3uHfsTTz3ekP
         W9k68imamrM+Do8jnH+QRmuoBtu5jbcn4tl5VqRQXBL3V2VyNdUnxxrMxpoCVNw4+qll
         018A==
X-Gm-Message-State: AOUpUlGs9oBZ4UYzAnN9KhnQk1WEf8IJGBpgMQGTwgkYdXmK9iOIMHYZ
        fk99p7Majge4Lz9KV/S9rwY=
X-Google-Smtp-Source: AAOMgpcbXbvM8nYCawneenQh+TbxOKb/lD151bRs78RpkxNxsXRikJmLN82L5YAY4zED4KJdzv0UmQ==
X-Received: by 2002:a62:aa02:: with SMTP id e2-v6mr22122762pff.211.1533045906690;
        Tue, 31 Jul 2018 07:05:06 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s184-v6sm22695376pfb.56.2018.07.31.07.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 07:05:05 -0700 (PDT)
Subject: Re: [PATCH v2] watchdog: add driver for the MEN 16z069 IP-Core
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mmoese@suse.de
References: <20180716072510.6939-1-jthumshirn@suse.de>
 <20180731135740.yfk7k2jy2f4magbo@linux-x5ow.site>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <10ed6a6c-4218-c166-def6-51be43e28b27@roeck-us.net>
Date:   Tue, 31 Jul 2018 07:05:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731135740.yfk7k2jy2f4magbo@linux-x5ow.site>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/31/2018 06:57 AM, Johannes Thumshirn wrote:
> On Mon, Jul 16, 2018 at 09:25:10AM +0200, Johannes Thumshirn wrote:
>> Add a driver for the MEN 16z069 Watchdog and Reset Controller IP-Core.
>>
>> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> Wim,
> Any comments about this driver? The merge window is about to open and
> I haven't heard any statement from you if you want to take it for
> 4.19.
> 

Wim,

This applies to the other watchdog patches I have lined up for v4.19.
Any chance for you to pull those into your tree to avoid missing the
commit window ?

Thanks,
Guenter
