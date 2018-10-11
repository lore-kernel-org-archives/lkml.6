Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18218C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3C62087D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0thmDlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA3C62087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeJKPta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:49:30 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38054 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeJKPta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:49:30 -0400
Received: by mail-wr1-f68.google.com with SMTP id a13-v6so8617862wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 01:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8YNI/ynpxtc1MMPZLrTm2ztWQSUT8vdadXnmraZ8mGM=;
        b=O0thmDlMz4Ivwo0J8HquUt+VaS2fcMkTTwg4PkU3zKNMdth/2ZxizRuY75LKLTRcAs
         Oa/54ij9Ol0+fdixlK9/6xBo1Rj5f7OXc+TZ0tGJIaFKDplIvc3BYQKBlWbgg07b3G7d
         z3nLKdVmVaUXUw9udNYYePpFnNqcIYQh/4bus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8YNI/ynpxtc1MMPZLrTm2ztWQSUT8vdadXnmraZ8mGM=;
        b=OGFrYa0FUVf/HYAl1T1YvKAgLMh3kmpkNKtaiQ+EUqRASEucWQWquTxRqhquHBDiYi
         1zzCOog983oDsxaMj2qslrP34GDCZ6EyilhdJcF3XQobo7aVIV2a8tZP9WkFeg2sfLwr
         5MOS/MU8fVi8J+8zqMCL4jY0Cc0VP1r2wjlvtHi0MVl7d/R2COUkGUb9db+OLVXpXKMQ
         cmK4jwNfvJGXVV21Gjng4U55j26r/7OY9abTtcIPzZ1hQHxE2FWr0bB0kgUmn/EGlyY1
         KUL+RRkBj0rL29h2X6G7LRTWoMEdWaCMPR2zfQgmIruSUFUTiRRlKceUKV+oDnb0i3Yw
         VPdQ==
X-Gm-Message-State: ABuFfog7vVOoeKIZBNxjFjGvVmKDiFWCAt0PQXiZtb/1OofXZx95RBMn
        2Y55cEoorW9meOSw5016eqMQkQ==
X-Google-Smtp-Source: ACcGV61wLbphv412LD/hN7QjOydhjCuqugfiq21f4770xFQ4AOQXHKbNi7Ff/74c4Iq8XVoWVMBmbg==
X-Received: by 2002:a5d:620b:: with SMTP id y11-v6mr596393wru.105.1539246197303;
        Thu, 11 Oct 2018 01:23:17 -0700 (PDT)
Received: from [192.168.0.40] (147.46.88.92.rev.sfr.net. [92.88.46.147])
        by smtp.googlemail.com with ESMTPSA id 63-v6sm4679052wmd.5.2018.10.11.01.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 01:23:16 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] Introduce thermal pressure
To:     Lukasz Luba <l.luba@partner.samsung.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        amit.kachhap@gmail.com, viresh.kumar@linaro.org,
        javi.merino@kernel.org, edubezval@gmail.com,
        linux-pm@vger.kernel.org, quentin.perret@arm.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
References: <CGME20181009162509epcas1p4fdd2e23039caa24586a4a52c6d2e7336@epcas1p4.samsung.com>
 <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
 <20181010153553eucas1p1b8f74f4aa45751ef029805fd118affc1~cSUmU58-F2963929639eucas1p1L@eucas1p1.samsung.com>
 <e2091e7e-b6e6-950d-ebab-18ba2de9264f@linaro.org>
 <20181011073510eucas1p100bfadd6055a523cd1e92b07bfacfc10~cfaLHcbIo1401014010eucas1p1d@eucas1p1.samsung.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f099ded8-e074-da18-2eac-e07a5a99af18@linaro.org>
Date:   Thu, 11 Oct 2018 10:23:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181011073510eucas1p100bfadd6055a523cd1e92b07bfacfc10~cfaLHcbIo1401014010eucas1p1d@eucas1p1.samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2018 09:35, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 10/10/2018 06:54 PM, Daniel Lezcano wrote:
>> On 10/10/2018 17:35, Lukasz Luba wrote:
>>> Hi Thara,
>>>
>>> I have run it on Exynos5433 mainline.
>>> When it is enabled with step_wise thermal governor,
>>> some of my tests are showing ~30-50% regression (i.e. hackbench),
>>> dhrystone ~10%.
>>>
>>> Could you tell me which thermal governor was used in your case?
>>> Please also share the name of that benchmark, i will give it a try.
>>> Is it single threaded compute-intensive?
>>
>> aobench AFAICT
>>
>> It would be interesting if you can share the thermal profile of your board.
>>
> Thanks for the benchmark name.
> It was tested on Samsung TM2 device with Exynos 5433 with debian.
> Thermal stuff you can find in mainline:
> arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi

By thermal profile, I was meaning a figure with the temperature
regulation (temperature idle, then workload, then temperature increase,
mitigated temperature, end of workload, temperature decrease).

The thermal description looks wrong in the DT. I suggest to experiment
the series with the DT fixed.

eg. from hi6220.dtsi


                thermal-zones {

                        cls0: cls0 {
                                polling-delay = <1000>;
                                polling-delay-passive = <100>;
                                sustainable-power = <3326>;

                                /* sensor ID */
                                thermal-sensors = <&tsensor 2>;

                                trips {
                                        threshold: trip-point@0 {
                                                temperature = <65000>;
                                                hysteresis = <0>;
                                                type = "passive";
                                        };

                                        target: trip-point@1 {
                                                temperature = <75000>;
                                                hysteresis = <0>;
                                                type = "passive";
                                        };
                                };

                                cooling-maps {
                                        map0 {
                                                trip = <&target>;
                                                cooling-device = <&cpu0
THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
                                        };
                                };
                        };
                };

Note the cooling devices are *passive*


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

