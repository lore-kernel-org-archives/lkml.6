Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A8CECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8E520874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8E520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbeGXRz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:55:28 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:46348 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388366AbeGXRz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:55:27 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 97D02217C9;
        Tue, 24 Jul 2018 16:48:06 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo02-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HO0oZTgORUFj; Tue, 24 Jul 2018 16:48:06 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 4A75821783;
        Tue, 24 Jul 2018 16:47:53 +0000 (UTC)
Subject: Re: [PATCH kselftest-next] Add cgroup core selftests
To:     Roman Gushchin <guro@fb.com>, Claudio <claudiozumbo@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Claudio Zumbo <claudioz@fb.com>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        Shuah Khan <shuah@kernel.org>
References: <20180718173358.14007-1-claudiozumbo@gmail.com>
 <20180719170829.GB21770@castle.DHCP.thefacebook.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <5fa20088-3797-7252-43b1-c7ede9e142f8@kernel.org>
Date:   Tue, 24 Jul 2018 10:47:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719170829.GB21770@castle.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 11:08 AM, Roman Gushchin wrote:
> On Wed, Jul 18, 2018 at 07:33:58PM +0200, Claudio wrote:
>> This commit adds tests for some of the core functionalities
>> of cgroups v2.
>>
>> The commit adds tests for some core principles of croup V2 API:
>>
>> - test_cgcore_internal_process_constraint
>>
>>   Tests internal process constraint.
>>   You can't add a pid to a domain parent if a controller is enabled.
>>
>> - test_cgcore_top_down_constraint_enable
>>
>>    Tests that you can't enable a controller on a child if it's not enabled
>>    on the parent.
>>
>> - test_cgcore_top_down_constraint_disable
>>
>>   Tests that you can't disable a controller on a parent if it's
>>   enabled in a child.
>>
>> - test_cgcore_no_internal_process_constraint_on_threads
>>
>>   Tests that there's no internal process constrain on threaded cgroups.
>>   You can add threads/processes on a parent with a controller enabled.
>>
>> - test_cgcore_parent_becomes_threaded
>>
>>   Tests that when a child becomes threaded the parent type becomes
>>   domain threaded.
>>
>> - test_cgcore_invalid_domain
>>
>>   In a situation like:
>>
>>   A (domain threaded) - B (threaded) - C (domain)
>>
>>   it tests that C can't be used until it is turned into a threaded cgroup.
>>   The "cgroup.type" file will report "domain (invalid)" in these cases.
>>   Operations which fail due to invalid topology use EOPNOTSUPP as the errno.
>>
>> - test_cgcore_populated
>>
>>   In a situation like:
>>
>>   A(0) - B(0) - C(1)
>>          \ D(0)
>>
>>   It tests that A, B and C's "populated" fields would be 1 while D's 0.
>>   It tests that after the one process in C is moved to root, A,B and C's
>>   "populated" fields would flip to "0" and file modified events will
>>   be generated on the "cgroup.events" files of both cgroups.
>>
>> Signed-off-by: Claudio Zumbo <claudioz@fb.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Roman Gushchin <guro@fb.com>
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: kernel-team@fb.com
> 
> Looks good to me!
> 
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> Thank you!
> 

Thanks for the new test. I will queue this up for 4.19-rc1

-- Shuah
