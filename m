Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21371C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0718256F1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRPkIloe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0718256F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932073AbeFYJoz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:44:55 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52693 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754998AbeFYJoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:44:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id p126-v6so8489095wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KgzUsT5klp3mH+Bs9uLjhA8WoqAAQnIELCbF/ZgvuUE=;
        b=bRPkIloeOe4Ki5yJFakry4UdMKBBhGV76cb8uMShjV17zIiBePU3iS2GOOIB5oF+W6
         XgSymg7KE/fWCcXExsaaqIqwQtUEs8aJrRhebeE9bStVoiwxOeoog7odETiI6gB7RdPF
         GKG/WgLOEfaMEbuynskcYCir9CJRiT7CUyc7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KgzUsT5klp3mH+Bs9uLjhA8WoqAAQnIELCbF/ZgvuUE=;
        b=IElsYryf5iCVgpPpXgFEpPHevy3GMrUkzXmYVbUK4nZtewoEBRVL/alktFy7R02U0l
         04HAGgooiPP24UkEztjwDTOevlOPkgyLY0X7NW3a2xk4IwZkD6+V+PRdoGN6MPjhLEjG
         RqDWgKtbnTO52ca4bYMXrH6kQdYoIFpkPOPHOn+npdq2T2wCFMqMB6lsTG2HFebmOppJ
         ihNbanX4n8/Wa5/evkUyzGJu1wWE2UHXCxvVd+AFH273YO3ZFq39vtsI1Gw36vZFAEPA
         m1OErHy5ycJb/FuWaPscrM09gsd0/Kg3bHqJ84crwotekyMpDJOvi4hn8/awxJePIyDY
         GOMg==
X-Gm-Message-State: APt69E2WAFKfvq+6h5fKFQRzyz5NAKgdpjjfEap8hXy+nX83Btjc6C4Q
        INhVnbVBmwEdxWOAZYMaKEMzRw==
X-Google-Smtp-Source: ADUXVKKOAxwS24httRL2quGKLO1PJUs4PFVbulIIKHbdypCbJQi7BhI4eh3MeIxAieRnlc7tEM+hXg==
X-Received: by 2002:a1c:3fc2:: with SMTP id m185-v6mr385587wma.37.1529919855820;
        Mon, 25 Jun 2018 02:44:15 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:a134:e815:db69:bcb1? ([2001:41d0:fe90:b800:a134:e815:db69:bcb1])
        by smtp.googlemail.com with ESMTPSA id 137-v6sm14823441wmv.28.2018.06.25.02.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 02:44:15 -0700 (PDT)
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection
 framework
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
 <20180620043415.57yvgzlye4l7wdqy@vireshk-i7>
 <fc2ef4e9-7ec8-c644-9495-e33f000531b2@linaro.org>
 <CAJZ5v0gBC_ZzUBJcNEmeAbDLrJA6K9SqohS0GXtUANKc4o+T_g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <df526d9f-706c-3875-17c2-06c52fcf1ddf@linaro.org>
Date:   Mon, 25 Jun 2018 11:44:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gBC_ZzUBJcNEmeAbDLrJA6K9SqohS0GXtUANKc4o+T_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2018 10:20, Rafael J. Wysocki wrote:
> Hi Daniel,
> 
> On Mon, Jun 25, 2018 at 12:40 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> Hi Rafael,
>>
>> do you think this patch is acceptable for merging ?
> 
> Well, it needs a bit of work still IMO, but let me comment on the patch itself.
> 
> Also, can you point me to the code using it that you have, please?
> I'd like to try to switch powerclamp over to it.


Sure, here it is:

https://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=thermal/idle-inject-v4




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

