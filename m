Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C167C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD70220820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 10:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPm0jJEF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD70220820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390729AbeKVVLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 16:11:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33340 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbeKVVLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 16:11:05 -0500
Received: by mail-wm1-f68.google.com with SMTP id 79so9223566wmo.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 02:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wfww+FBFd4hlavB3dPG1cOwKmF7S6p4Liq6g9oEA8q4=;
        b=DPm0jJEFBS07EFk8uWPzgmemL3QeX+CDh18Q0RgkG6SGmMV+Vu+USn67cX8CbGjatv
         Uno1yZKB/SS6J6VoxhLtXVQnroxAPaiWMF7SKnkSWx5PaSfHwYhehl7mm/k4vbOCqt7h
         aNgUk7xWD98YBdDQ/stwNtVUQn9MZ2+PJQ1sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wfww+FBFd4hlavB3dPG1cOwKmF7S6p4Liq6g9oEA8q4=;
        b=pf+Rvv8G4tEQKakvj/fxRFkyt6vB/fEbZZ4VH0to2AuK2mefVemcE8+H60LqQzijqY
         LCbqdUBbZtKKR2/kTgbRHqjf8aAuYE1XSGq3hEwGmb/lDIpivRbMFfZbmst3Er9E3BKQ
         uhbY1GgthFW6c1zuhi13or8YkOzbKRGI9zWvA9K5PKGm0lPsGH/LIk8eziL+M1OBm4Ue
         T3uAkUCn48mSHB+3dSyUmNVOyqlkDOq1rbWvWn/aGgN8XRGWAAC+Ex+JKzQ0eWSKFbgi
         6RsJVCUBLP42y14aqmDPdx1Jgyy8fwMXM6bQubhuOWtW+eTsTV6xUNPR8kCHtCpfygVL
         gtRw==
X-Gm-Message-State: AGRZ1gJEojtA3OJYIcOSWz7rVRyfrvk8u03QCurghxqr7Y2VY0BKmDCP
        Q+OzrL5hU5bhkglp6uISjjO3aw==
X-Google-Smtp-Source: AJdET5c1COHQZXpjzSWnSbLCAvayNRQHyu9HbLhcx9aWaFSphIjZysoropyVABJBDHosOX2felnpbw==
X-Received: by 2002:a1c:5d4f:: with SMTP id r76-v6mr8997837wmb.25.1542882734083;
        Thu, 22 Nov 2018 02:32:14 -0800 (PST)
Received: from [192.168.0.40] (189.35.136.77.rev.sfr.net. [77.136.35.189])
        by smtp.googlemail.com with ESMTPSA id x8sm11996874wrd.53.2018.11.22.02.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 02:32:13 -0800 (PST)
Subject: Re: [PATCH 4/4] base/drivers/topology: Default dmpis-mhz if they are
 not set in DT
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Quentin Perret <quentin.perret@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <1540830201-2947-1-git-send-email-daniel.lezcano@linaro.org>
 <1540830201-2947-4-git-send-email-daniel.lezcano@linaro.org>
 <20181030085845.az2dstibnrcl7im4@vireshk-i7>
 <3c3890d2-8b46-797d-328f-bd5dee11b22d@linaro.org>
 <20181122042900.u6eefkbw32vvi6xm@vireshk-i7>
 <b507cf16-aa78-303e-7459-ad380266317e@linaro.org>
 <20181122103114.epqwwta5ug7v5l55@vireshk-i7>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c03adc3b-8416-fa51-43b0-b65f482b5809@linaro.org>
Date:   Thu, 22 Nov 2018 11:32:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181122103114.epqwwta5ug7v5l55@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2018 11:31, Viresh Kumar wrote:
> On 22-11-18, 11:29, Daniel Lezcano wrote:
>> Oh ... actually raw_capacity is not needed at all!
> 
> It is required as another routine writes some values to it I believe :)

Let's see if I can remove it.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

