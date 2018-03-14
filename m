Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751899AbeCNTjx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:39:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751302AbeCNTjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:39:52 -0400
Subject: Re: [PATCH] perf vendor events: fix processing for xfs
To: Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1521047452-28565-1-git-send-email-john.garry@huawei.com>
 <20180314185355.GC27335@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>, <wcohen@redhat.com>,
        <sukadev@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <fa4f4c83-1a1a-761f-9259-ce21ee000fc3@huawei.com>
Date: Wed, 14 Mar 2018 19:39:25 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180314185355.GC27335@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.230]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2018 18:53, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 15, 2018 at 01:10:52AM +0800, John Garry escreveu:
>> In the recently introduced support for vendor subdirectory,
>> the checking for directory entries under xfs (or any other fs
>> which does not support dirent.d_type) is missing the check
>> for links for current and parent directory. This can result
>> in a broken pmu_events.c being generated.
>>
>> Fix this by adding the appropriate check in is_leaf_dir().
>
> So I'll lookup the patch that introduced the patch and squash this one
> with it, so that we don't break 'git bisect' on ppc.

Right, so it's going to be "perf vendor events: add support for pmu 
events vendor subdirectory".

BTW, I don't think it's specifically ppc which was broken, but just when 
building from xfs.

Much appreciated,
John

>
> - Arnaldo
>
>> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index 1c01844..db3a594 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -873,7 +873,10 @@ static int is_leaf_dir(const char *fpath)
>>  		return 0;
>>
>>  	while ((dir = readdir(d)) != NULL) {
>> -		if (dir->d_type == DT_DIR && dir->d_name[0] != '.') {
>> +		if (!strcmp(dir->d_name, ".") || !strcmp(dir->d_name, ".."))
>> +			continue;
>> +
>> +		if (dir->d_type == DT_DIR) {
>>  			res = 0;
>>  			break;
>>  		} else if (dir->d_type == DT_UNKNOWN) {
>> --
>> 1.9.1
>
> .
>
