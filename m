Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4B4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26E52086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 12:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFru0LbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26E52086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeJLTwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:52:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47080 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbeJLTwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:52:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id v5-v6so5857890plz.13;
        Fri, 12 Oct 2018 05:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xhYIggIpeEn8sTmgTHVvnz0DVtwqj5X/9sD4mWFzXKw=;
        b=CFru0LbFWekrE8bkPCQgayonNkGf6+Fo/ZrRVSKaTBPWioH4/F+th+2/0GTIHtFKhE
         hEFxvQ902KN1RI0rNbNyFnsq+fQjAdcH/I4cgDK7drcQuDgzrlhaw1BYtmZh5Xmpo3Yf
         8AVLSo/gHOAPcoQE516GIxoMqf0fKNl6fY7/HrOOAGN/3wAMl0VlyOd+35bVP/+/kv7V
         URRWNNpdkU1BRp68/n4F26F/DTGKM4jb7HPHcLkqmbrp9DKzIL4Dxl9IFnn5A/iQh0ep
         EoZjxizhDgzNlnrEmjIC7bnFwP2GSTnfDqhIlVWwHYSWkQzmplKcRDZAWAex5No69dE+
         9mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xhYIggIpeEn8sTmgTHVvnz0DVtwqj5X/9sD4mWFzXKw=;
        b=T+AeIfFLx+JdM0Ct4SNriuYHkM8ZuiY7XGtqhNaaA3VRobEZDK9C32FcIXy4GtZY75
         qnl9biHn5oZwMqRW0rqLkXzON3p1IiZCSYr5nS20hVLGGLa874A524raznB+YEcfhrBZ
         L1eu138Q/mex12/AZ/4zoDm39YpM8MAMUDKokuueribfA4HRXPY1XsptVpe6ksqTHlYc
         PbCrg/QSGt8JzdGj21ONNv5KJluRYFAE2X/Xg88rae7s4/cPOU2SJQPKc/KL/phO2tdk
         NwqS6pCiBfB8byKwcbEdfsh68Bh0N3Nn1bzzvBBbKjmzXL8pvgHY68ZUGeXVuq9Gb02x
         Gqug==
X-Gm-Message-State: ABuFfohWXMhUwtG2gnyTDw1MBwSeVZLpZsyoTztT2YTnOX6bXQuIz3tW
        8k5DyddmY4vKC80tDkDHlg++zN29
X-Google-Smtp-Source: ACcGV61h84TCgMMEhIrf+kC+RW8P9UMwBD/A+5Tdz6pkkQlTEHdTSgxPiAQI9P6xSbetcabb5ZnXEQ==
X-Received: by 2002:a17:902:4181:: with SMTP id f1-v6mr5593360pld.248.1539346842285;
        Fri, 12 Oct 2018 05:20:42 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id p84-v6sm2253059pfi.22.2018.10.12.05.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 05:20:41 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/35] 4.9.133-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181011152520.174949126@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <df9b09c5-b231-5b8f-7b26-7efcac86ddcf@roeck-us.net>
Date:   Fri, 12 Oct 2018 05:20:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011152520.174949126@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 08:35 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.133 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat Oct 13 15:25:09 UTC 2018.
> Anything received after that time might be too late.
> 


[preliminary]

powerpc:allmodconfig:

drivers/macintosh/rack-meter.c: In function 'get_cpu_idle_time':
drivers/macintosh/rack-meter.c:94:9: error: implicit declaration of function 'nsecs_to_cputime64'

Guenter
