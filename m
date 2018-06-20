Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B11C1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C4620874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 02:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeIz012o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C4620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754204AbeFTCSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 22:18:30 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39618 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753486AbeFTCS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 22:18:27 -0400
Received: by mail-pg0-f65.google.com with SMTP id w12-v6so727720pgc.6;
        Tue, 19 Jun 2018 19:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZuEx+PegYJPJVjw1sLJKD+dvjD9rvSL1M9HUmFIXwxM=;
        b=CeIz012oN11sJ5h1g20hK+7cidzhTiw1T89pM4bVUNtH9dMJYkMWBUU/LcxS/O8CSR
         l8eezns2irdcZ5aBlYHEdpSQG63Pa7SHeZQgdSAZx8Rfy0vs/ZukvgYMmixjXwT+Ggy4
         pRfkdy9iU50ZGIa3nyxsS3TcEhsHWDatxUAPrQyE/zL9IC8OL5zsqcyy0arFE0oXJybA
         SIJy6i+WZegtmCXGb4mwZ8LcLWnn7SqEJJq5gYG3NsmkcznWPSxSN11VgySsdq+LLx3/
         FksrcHgngVc2SJJWpoCk86iFko/K85FYuUrGfayntrWvYxvUejmoDyFQExVOSVeHSJBs
         RVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZuEx+PegYJPJVjw1sLJKD+dvjD9rvSL1M9HUmFIXwxM=;
        b=M42tJ6FIQVjDTUwLV2QdplP799wEUQGAOlJa55SOfpW4HVQ8RuNcZzQJ3NmsBfeoBF
         wPPcQI6qAYLZLAfjyAWaSBmZnrXjbpdvyt+KiDqpe9c7+4u2nio3p8DQW0BJaoAy7O/8
         DwugWRHBK+sjg0xTWYj+VvzhV6NQn2TTwXVAQB3KgHZQguVn3f9hSkDdj7r3bWtyI0O3
         ul9xflScDuDHhDOYSg1BR7ybnDEoc/ORkl1kvgCQI/m6KbZBEct8T0oJy+nwpj+vZkoB
         1aS19P2h1dTjdgRnMlLbQ4SQoillQXEne+itOKc9UR68HoMzgx8JB6FFo6UWs8a3597h
         MKHQ==
X-Gm-Message-State: APt69E3r/+KxACszDVV55gLceXxQlVXJxiaTdErmNoRAOAmKMTnJoxBJ
        mLeYfgnKtPUceqSBF8CL8Q8w6Q==
X-Google-Smtp-Source: ADUXVKJCWPzunoEErZUxM9DBokWehuxyU9NXkfaigjiPfwcnd1+dROILhpZ5Qmb+0uU1te+rea06sQ==
X-Received: by 2002:a63:8dca:: with SMTP id z193-v6mr16954644pgd.451.1529461106234;
        Tue, 19 Jun 2018 19:18:26 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id s27-v6sm1302170pfk.184.2018.06.19.19.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 19:18:25 -0700 (PDT)
Subject: Re: [PATCH 3.18 00/21] 3.18.113-stable review
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180612164825.401145490@linuxfoundation.org>
 <5b20444c.1c69fb81.cb5e6.5a8d@mx.google.com>
 <20180613044055.GA32451@kroah.com> <7hfu1qw7o8.fsf@baylibre.com>
 <20180614155127.GA9178@roeck-us.net> <7hbmc6nvk2.fsf@baylibre.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <76857598-9f31-8d7f-39aa-84ec60fa419e@roeck-us.net>
Date:   Tue, 19 Jun 2018 19:18:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <7hbmc6nvk2.fsf@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/2018 05:36 PM, Kevin Hilman wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> 
>> On Wed, Jun 13, 2018 at 05:09:11PM -0700, Kevin Hilman wrote:
>>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
>>>
>>>> On Tue, Jun 12, 2018 at 03:08:12PM -0700, kernelci.org bot wrote:
>>>>> stable-rc/linux-3.18.y boot: 52 boots: 28 failed, 18 passed with 1 offline, 5 conflicts (v3.18.112-22-gb0582263e3c9)
>>>>>
>>>>> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-3.18.y/kernel/v3.18.112-22-gb0582263e3c9/
>>>>> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.y/kernel/v3.18.112-22-gb0582263e3c9/
>>>>>
>>>>> Tree: stable-rc
>>>>> Branch: linux-3.18.y
>>>>> Git Describe: v3.18.112-22-gb0582263e3c9
>>>>> Git Commit: b0582263e3c9810fd887ca92d19cb9ff30a4d9f6
>>>>> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>>>>> Tested: 24 unique boards, 12 SoC families, 13 builds out of 183
>>>
>>> [...]
>>>
>>>>
>>>> That is a lot of new failures, did the whole lab fail, or is this really
>>>> a problem in v3.18.112 here?
>>>
>>> Whole lab failure (more precisely, lab operator failure)  ;)
>>>
>>> gak, I updated the rootfs images to the latest buildroot, which forced
>>> me to upgrade the kernel headers used to build the rootfs from v3.10 to
>>> v4.4.  So I guess it's no surprise that every single board panic'd as
>>> soon as it hit userspace.
>>>
>> I build my root file systems with buildroot, and had a similar problem. My fix
>> was to patch buildroot to let me use older linux headers.
> 
> Could you share the patch?
> 

Try git@github.com:groeck/buildroot.git branch local-2018.05.

Guenter
