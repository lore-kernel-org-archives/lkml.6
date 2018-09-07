Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172C5C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B762D20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 18:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B762D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbeIGXgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:36:20 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:57040 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeIGXgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:36:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id D6CF3C0C58;
        Fri,  7 Sep 2018 18:54:03 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MX0bZZ97UUf4; Fri,  7 Sep 2018 18:54:03 +0000 (UTC)
Received: from [192.168.1.87] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 035EEC0D43;
        Fri,  7 Sep 2018 18:53:51 +0000 (UTC)
Subject: Re: [PATCH 1/2] Fix cg_read_strcmp()
To:     Jay Kamat <jgkamat@fb.com>
Cc:     linux-kselftest@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Tejun Heo <tj@kernel.org>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, jaygkamat@gmail.com,
        Shuah Khan <shuah@kernel.org>
References: <20180905010827.27743-1-jgkamat@fb.com>
 <20180907164924.13789-1-jgkamat@fb.com>
 <20180907164924.13789-2-jgkamat@fb.com>
 <bed84882-b194-7e45-0db6-08b02bc672d5@kernel.org> <86worxmabx.fsf@fb.com>
From:   Shuah Khan <shuah@kernel.org>
Message-ID: <d7c24fda-484d-85ae-50db-3c3639366be2@kernel.org>
Date:   Fri, 7 Sep 2018 12:53:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <86worxmabx.fsf@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 12:28 PM, Jay Kamat wrote:
> 
> Shuah Khan writes:
> 
>> On 09/07/2018 10:49 AM, jgkamat@fb.com wrote:
>>> From: Jay Kamat <jgkamat@fb.com>
>>>
>>> Fix a couple issues with cg_read_strcmp(), to improve correctness of
>>> cgroup tests
>>> - Fix cg_read_strcmp() always returning 0 for empty "needle" strings
>>> - Fix a memory leak in cg_read_strcmp()
>>>
>>> Fixes: 84092dbcf901 ("selftests: cgroup: add memory controller self-tests")
>>>
>>> Signed-off-by: Jay Kamat <jgkamat@fb.com>
>>> ---
>>>  tools/testing/selftests/cgroup/cgroup_util.c | 17 ++++++++++++++---
>>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
>>> index 1e9e3c470561..8b644ea39725 100644
>>> --- a/tools/testing/selftests/cgroup/cgroup_util.c
>>> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
>>> @@ -89,17 +89,28 @@ int cg_read(const char *cgroup, const char *control, char *buf, size_t len)
>>>  int cg_read_strcmp(const char *cgroup, const char *control,
>>>  		   const char *expected)
>>>  {
>>> -	size_t size = strlen(expected) + 1;
>>> +	size_t size;
>>>  	char *buf;
>>> +	int ret;
>>> +
>>> +	/* Handle the case of comparing against empty string */
>>> +	if (!expected)
>>> +		size = 32;
>>
>> This doesn't look right. I would think expected shouldn't be null?
>> It gets used below.
>>
>>> +	else
>>> +		size = strlen(expected) + 1;
>>>
>>>  	buf = malloc(size);
>>>  	if (!buf)
>>>  		return -1;
>>>
>>> -	if (cg_read(cgroup, control, buf, size))
>>> +	if (cg_read(cgroup, control, buf, size)) {
>>> +		free(buf);
>>>  		return -1;
>>> +	}
>>>
>>> -	return strcmp(expected, buf);
>>> +	ret = strcmp(expected, buf);
>>
>> If expected is null, what's the point in running the test?
>> Is  empty "needle" string a valid test scenario?
> 
> There are a couple places where an empty "needle" string is used currently:
> 
> - cg_test_proc_killed (newly added in the next patch): Verify cgroup.procs is
>   empty (there are no processes running)
> - test_memcg_oom_events: Verify cgroup.procs is empty

Yes I see the empty neede string usage now.
> 
> Previously, when passing in an empty needle string, this function would always
> return 0, as the size allocated (1) would not be enough to read any data in
> 'cg_read', and strcmp would compare two null strings.

Thanks for explaining this. Yes this fix is good. This would be good information
to add to the change log.

Could you please add this to the change log and send v2. I will pull these in for
the next rc.

thanks,
-- Shuah
