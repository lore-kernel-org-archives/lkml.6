Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6DBC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A482A20834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 09:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9fnsOzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A482A20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbeK2UXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 15:23:15 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37872 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbeK2UXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 15:23:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so1410480wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 01:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tTQtuk91PFIZX41job444pfCTlo26ZNvb/53NKtx29c=;
        b=b9fnsOzXroOw3BmiywUj81c08faLoWBIBN9neCxXNXnf9H8hQD5DsqdhnCpZwdvPjx
         gKTV65XrpQokixtjpCy1cLJI/yywmCK+eNMvHKmdiskN660iQGzGW5ds239zHeTAeBdZ
         JJYS+LWgYttPN3Ko+lMJQzlQNXA8yJ2eVW/qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tTQtuk91PFIZX41job444pfCTlo26ZNvb/53NKtx29c=;
        b=tKSgjofM4EH6tWkos6xXNwYyw+VaYDa38mxxFXdS6d8YDbTconPPbsuE+xGnOS0qmh
         rDhQlKvtJfigMv96I7eMWxPF2rd6HBN3p/vefJhRWdzpPXuh0r8EntVFjNMSauWFA2iP
         m5zn1xJA5pz7vofvwrId7lurVvthEbHCtFiw0EZodzWdhY3JefsC/4LigbpSIZazzgoY
         RrIVCVNDdLbYFtOk5SAB6jb1BwdSdj5Wry2wUCoU023pJsVocxIiQosbHcw894Yk1uqs
         kgDuxDNl3EfzCmrrAHeeW/McDMJywGiJHZEJZAdbCzI3DDXrsx9pBe7UBuIGWnNVUHTw
         rinQ==
X-Gm-Message-State: AA+aEWbTCXbxFz0YsI9egz66VBHp/m9Xy61ZLQSjXSm1qwoR551Vuken
        SiZwNiapJ12CmbpZf+IXMXQGLg==
X-Google-Smtp-Source: AFSGD/WLKEy0DWZF3Eg49OqiQomlapu6F2gBvVqmjZ/tx+Eg5ZdcREg4Y6kJEQZOu17swp9OL3mQoA==
X-Received: by 2002:a1c:a9cf:: with SMTP id s198mr627579wme.120.1543483111909;
        Thu, 29 Nov 2018 01:18:31 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id m66sm1903933wmd.15.2018.11.29.01.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 01:18:31 -0800 (PST)
Subject: Re: [PATCH V5 1/2] base/drivers/arch_topology: Replace mutex with
 READ_ONCE / WRITE_ONCE
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        viresh.kumar@linaro.org, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
References: <1543325060-1599-1-git-send-email-daniel.lezcano@linaro.org>
 <20181128114454.GC4271@localhost.localdomain>
 <17ecb59a-7647-ce56-0715-bfe8d520dd18@linaro.org>
 <20181129070437.GD4271@localhost.localdomain>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <749fdda3-7af5-2899-5c91-c9a1c57025d3@linaro.org>
Date:   Thu, 29 Nov 2018 10:18:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129070437.GD4271@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2018 08:04, Juri Lelli wrote:

[ ... ]

>> With or without this patch, it is the case:
>>
>>                 task1                      task2
>>                   |                          |
>>   read("/sys/.../cpu1/cpu_capacity)          |
>>                   |                  write("/sys/.../cpu1/cpu_capacity")
>>   read("/sys/.../cpu2/cpu_capacity)          |
>>
>>
>> There is no guarantee userspace can have a consistent view of the
>> capacity. As soon as it reads a capacity, it can be changed in its back.
> 
> True, but w/o the mutex task1 could read different cpu_capacity values
> for a cluster (it actually can also with current implementation, we
> should grab the mutex in the read path as well if we want to avoid
> this). 

Even if the mutex is on the read path, the userspace can see different
capacities because it will read the cpu_capacity per cpu directory.

The mutex will be take when reading cpu0/cpu_capacity, not for
cpu[0-9]/cpu_capacity. Between two reads, a write can happen because the
lock is released in between.

Do you agree with the patch ? Or do you want me to drop it ?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

