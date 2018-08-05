Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62310C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED1621898
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 14:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMKKhd6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED1621898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbeHEQqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 12:46:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40424 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeHEQqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 12:46:12 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so4537250plp.7;
        Sun, 05 Aug 2018 07:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JjpHn7RBzggnN4vJTpPrEUbsht/E7fP5GnOYxXF0J/o=;
        b=GMKKhd6Zs2js9W/LyECx0DJqlSp+SkAp/44ZqXJSx7bx282v9wPPQgraLqNjaoq9n6
         eSqnv2lLoAeMuZxGccMZvM0SXauVHthp8SahOwZB1yZLHWItT4vyv/OC3iHvOquopGGR
         SglunmwNUexfeeWnGhboj+FYEh6tz1YeEPN2JBIUxqoB848pJ/oFUNUsMvSHkvh+Bjvp
         PVAGQHlY9NgeCzWztx68NbM+cSYCSUHcix25X+hKVvzCDvUXmwzLrMQkHmi5QgeUpmYh
         PSK4FBYFvM0Ch9dqROdQe4ljVtVd5Sn9/0qpz07xZkOjsquqI3JMG4pQkFJq7eUrvqeK
         8pyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JjpHn7RBzggnN4vJTpPrEUbsht/E7fP5GnOYxXF0J/o=;
        b=pZJvzaXqMgoBofHLcnx+T8GJgdLiUgWPWyXY92oTQmxxDLDcokDw8zX88/C1m5BOE6
         ulCrAlp1u/FlMrdPABc1VSW6go0E5JSV2U2H4JNtJIEzGxn01BiActr/DUWGbkwwCfGL
         z8vipzHWRUwHdiLtjgS1P41AcR+27se08fAeLcSDRUf4XyECUBXiF6WDmEeIpYuZxscn
         ZQ6DVg5UeSRZcGGozEmOVpHb9fzpdGBP4URW+tDUqYfm5t2AR8ZYQrajpB0sY4DerRky
         Ejml34aguc38h2SKOqKkDueVLx3CG5y2+l9YgY7vvsUUPlaDEV6mBTlNQwDpV2GPHhIf
         i+NQ==
X-Gm-Message-State: AOUpUlH18T/kdlF5kyX+ImaVwYxidV5KOiyOAaqyoYOC0he4Ed2uoWxy
        QrZI5zug0J3nS5FWm6pOOm3ge8st
X-Google-Smtp-Source: AAOMgpdota4ECJc5PN3q0v/iLBCxqzC7LVP1hGOxWyMbLir6ubnU5pseCxLzfaTrVvo/Mq6Ly773XQ==
X-Received: by 2002:a17:902:d70d:: with SMTP id w13-v6mr10615936ply.229.1533480082925;
        Sun, 05 Aug 2018 07:41:22 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e82-v6sm19743436pfd.40.2018.08.05.07.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 07:41:21 -0700 (PDT)
Subject: Re: [PATCH 4.4 000/124] 4.4.146-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
References: <20180804082702.434482435@linuxfoundation.org>
 <CA+G9fYsZtw-OHh2cKC0VG5zwdKOMvnOx-cAVfp2qfY_drFQ4_Q@mail.gmail.com>
 <20180805134952.GA15972@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <18c8f409-219f-b2ed-4202-5e69d767949a@roeck-us.net>
Date:   Sun, 5 Aug 2018 07:41:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180805134952.GA15972@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2018 06:49 AM, Greg Kroah-Hartman wrote:
> On Sun, Aug 05, 2018 at 05:24:21PM +0530, Naresh Kamboju wrote:
>> On 4 August 2018 at 14:29, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org> wrote:
>>> This is the start of the stable review cycle for the 4.4.146 release.
>>> There are 124 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Mon Aug  6 08:26:39 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>>          https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.146-rc1.gz
>>> or in the git tree and branch at:
>>>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> Results from Linaro’s test farm.
>> No regressions on arm64, arm and x86_64.
> 
> Really?  How did you all miss the netfilter bug that was introduced by
> this series?
> 

If I understand the related exchange correctly, this bug exists upstream as well,
and no one caught it there either. I am also not sure if there are secondary
conditions, such as the number of multicast groups. Given that, I don't really
feel that bad. On the contrary, kudos to Nathan for catching it.

This just shows that our testing is not perfect and needs to improve further.

Guenter
