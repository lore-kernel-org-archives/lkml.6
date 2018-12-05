Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8EFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A1C20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jqSTKWxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A1C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeLEMIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:08:36 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44191 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeLEMIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:08:35 -0500
Received: by mail-qk1-f195.google.com with SMTP id n12so11652428qkh.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 04:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:subject:to:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=80z8sAXrzioX/M9snlmmPT25Ar2yQCBN+Ggh2f6cgAs=;
        b=jqSTKWxbD22+6in93uifCUbqjhuwnQ/DIpCxm5MBkAEGdnjGrBWMbGpJ4VKADV5UlK
         pGhM57Ah65bNngeuEt8slkrGxylH0ErfN89ljgDa3gLcUh6Ffk7EMFxRipH2dtj4ayND
         s1nCGYPVLsndcYhT4aP46Hq+1mFh33jdr3fPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=80z8sAXrzioX/M9snlmmPT25Ar2yQCBN+Ggh2f6cgAs=;
        b=pictqZJ6HtA14yhAUwUGXN5sUGjjDPV4vGPwC6NAP20ajxFgDpt01duGh3hhcWSdzp
         +LTMYqjN5T6qHrq7m+GaMTIqXIQheHveMQnzw9o+Jlym5DdBY9O0p+GgeLtD/vEnZrmS
         ug4A+l2urMqpyg8PhqYnQ+87DWTX0ts4dlWkEFumXFTBfANAnhYTOvzLjWfamtcrFGVZ
         cx++Ip7AcuN3+OZ8IIFYEaGKljBtrmBf2HDzyzwT8eci/K8XU5IpA+vcrVhXhhasoY/h
         fQHncDnAtVr2IjZIFxbJi2yVhmukoklDX2FrfMU+bt01hFgeInMJScY2+QvR8trDJ+u/
         u83g==
X-Gm-Message-State: AA+aEWY8utNG3pUdBnDK2C12ykOmtssPI7/5IkH7Us0TnTYL6JQMqV3D
        JHeVOgK2gFS8/C/cFng6aYZjJw==
X-Google-Smtp-Source: AFSGD/UPjIhVjsytaCsmu4M3HSM1lZDirZ9q0nDvSYJ9BF+nsp14LPBj/tM1/Rk/XB6hlmLxN9LLvw==
X-Received: by 2002:a37:b785:: with SMTP id h127mr21608819qkf.294.1544011713816;
        Wed, 05 Dec 2018 04:08:33 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.29])
        by smtp.gmail.com with ESMTPSA id n3sm12723811qtc.81.2018.12.05.04.08.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 04:08:32 -0800 (PST)
Cc:     Rafael David Tinoco <rafael.tinoco@linaro.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net, Yuchung Cheng <ycheng@google.com>,
        Nandita Dukkipati <nanditad@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.19 000/139] 4.19.7-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
 <716b46ef-03da-9656-92fd-3823f31f5ce6@linaro.org>
 <20181205065851.GA16346@kroah.com>
From:   Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <e38e63a3-c898-61e8-2140-73e9f05aec33@linaro.org>
Date:   Wed, 5 Dec 2018 10:08:28 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181205065851.GA16346@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 4:58 AM, Greg Kroah-Hartman wrote:
> On Tue, Dec 04, 2018 at 07:09:46PM -0200, Rafael David Tinoco wrote:
>> On 12/4/18 8:48 AM, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.19.7 release.
>>> There are 139 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Thu Dec  6 10:36:22 UTC 2018.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.7-rc1.gz
>>> or in the git tree and branch at:
>>> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
>>> and the diffstat can be found below.
>>>
>>> thanks,
>>>
>>> greg k-h
>>
>> During functional tests for this v4.19 release, we faced a PANIC,
>> described bellow, but unlikely related to this specific v4.19 version.
>>
>> First a WARN() at tcp_output.c:
>>
>> tcp_send_loss_probe():
>> ...
>> 	/* Retransmit last segment. */
>> 	if (WARN_ON(!skb))
>> 		goto rearm_timer;
>> ...
>>
>> [  173.557528] WARNING: CPU: 1 PID: 0 at
>> /srv/oe/build/tmp-rpb-glibc/work-shared/juno/kernel-source/net/ipv4/tcp_output.c:2485
>> tcp_send_loss_probe+0x164/0x1e8
>> [  173.571425] Modules linked in: crc32_ce crct10dif_ce fuse
>> [  173.576804] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.19.7-rc1 #1
>> [  173.583014] Hardware name: ARM Juno development board (r2) (DT)
> 
> So only this one machine saw this failure?
> 
> If you can reproduce it again, bisection would be great to do if
> possible.

Yes, the only machine... I'm afraid this issue is intermittent and
depends on TCP Tail Loss and a specific race causing the NULL
dereference, so bisection would be tricky since it has happened
independently of the functional test that was running. I have also
copied authors for the Tail Loss code to check if they got any clues
even without KASAN data.

Thank you,
-
Rafael D. Tinoco

