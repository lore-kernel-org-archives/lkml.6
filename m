Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFC4C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4B82086C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4B82086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeIFKUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:20:03 -0400
Received: from mail1.windriver.com ([147.11.146.13]:46427 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbeIFKUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:20:03 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w865k4EQ016554
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 5 Sep 2018 22:46:04 -0700 (PDT)
Received: from [128.224.162.194] (128.224.162.194) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.408.0; Wed, 5 Sep
 2018 22:46:03 -0700
Subject: Re: [PATCH] sysctl: kselftests: use kernel module instead of built-in
To:     Shuah Khan <shuah@kernel.org>, <mcgrof@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1536114044-31236-1-git-send-email-Lei.Yang@windriver.com>
 <8aeffc5f-ed8c-b418-5db3-ef0299456002@kernel.org>
From:   lei yang <lei.yang@windriver.com>
Message-ID: <9bbc49fe-5043-d03e-a359-215e71ed3a42@windriver.com>
Date:   Thu, 6 Sep 2018 13:48:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <8aeffc5f-ed8c-b418-5db3-ef0299456002@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [128.224.162.194]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月06日 00:47, Shuah Khan wrote:
> On 09/04/2018 08:20 PM, Lei Yang wrote:
>> It uses modprobe $TEST_DRIVER in sysctl.sh, so update
>> config to use "m" instead
>>
>> Signed-off-by: Lei Yang <Lei.Yang@windriver.com>
>> ---
>>   tools/testing/selftests/sysctl/config | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/sysctl/config b/tools/testing/selftests/sysctl/config
>> index 6ca1480..fc263ef 100644
>> --- a/tools/testing/selftests/sysctl/config
>> +++ b/tools/testing/selftests/sysctl/config
>> @@ -1 +1 @@
>> -CONFIG_TEST_SYSCTL=y
>> +CONFIG_TEST_SYSCTL=m
>>
> What happens if it is a built-in? Can you elaborate in the changelog
>
> On that note we might have other cases that do modprobe in scripts and
> run into the same issue you are trying to solve. :)

I double-checked again, found that it doesn't work on either with 
built-in or kernel module
if it's built-in, modprobe test_sysctl still return 0, so it doesn't 
matter it's a built-in or module.

but the problem is that test_modprobe check module load before modprobe 
execute , I'll sent a V2 patch to fix this and keep its build-in config 
untouched


if changes nothing

1) when  CONFIG_TEST_SYSCTL=y
root@intel-x86-64:/tmp/sysctl# ./sysctl.sh
Checking production write strict setting ... ok
./sysctl.sh: /sys/module/test_sysctl/ not present
You must have the following enabled in your kernel:
CONFIG_TEST_SYSCTL=y
root@intel-x86-64:/tmp/sysctl# zcat /proc/config.gz |grep TEST_SYS
CONFIG_TEST_SYSCTL=y



2) when CONFIG_TEST_SYSCTL=m
root@intel-x86-64:/tmp/sysctl# ./sysctl.sh
Checking production write strict setting ... ok
./sysctl.sh: /sys/module/test_sysctl/ not present
You must have the following enabled in your kernel:
CONFIG_TEST_SYSCTL=y
root@intel-x86-64:/tmp/sysctl# zcat /proc/config.gz |grep TEST_SYS
CONFIG_TEST_SYSCTL=m


Lei

> thanks,

> -- Shuah

