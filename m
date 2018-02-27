Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbeB0J7Y (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 04:59:24 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42959 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752537AbeB0J7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 04:59:15 -0500
Subject: Re: [PATCH v2 07/11] perf vendor events: add support for arch
 standard events
To: Jiri Olsa <jolsa@redhat.com>
References: <1519401932-205051-1-git-send-email-john.garry@huawei.com>
 <1519401932-205051-8-git-send-email-john.garry@huawei.com>
 <20180227094848.GF21033@krava>
CC: <ak@linux.intel.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <namhyung@kernel.org>, <wcohen@redhat.com>, <will.deacon@arm.com>,
        <ganapatrao.kulkarni@cavium.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <0dcf5646-2e1d-db10-b15c-2d9439180771@huawei.com>
Date: Tue, 27 Feb 2018 09:58:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180227094848.GF21033@krava>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2018 09:48, Jiri Olsa wrote:
> On Sat, Feb 24, 2018 at 12:05:28AM +0800, John Garry wrote:
>
> SNIP
>
>> +static int save_arch_std_events(void *data, char *name, char *event,
>> +				char *desc, char *long_desc, char *pmu,
>> +				char *unit, char *perpkg, char *metric_expr,
>> +				char *metric_name, char *metric_group)
>> +{
>> +	struct event_struct *es;
>> +	struct stat *sb = data;
>> +
>> +	es = malloc(sizeof(*es));
>> +	if (!es)
>> +		return -ENOMEM;
>> +	memset(es, 0, sizeof(*es));
>> +	FOR_ALL_EVENT_STRUCT_FIELDS(ADD_EVENT_FIELD);
>> +	list_add_tail(&es->list, &arch_std_events);
>> +	return 0;
>> +out_free:
>> +	FOR_ALL_EVENT_STRUCT_FIELDS(FREE_EVENT_FIELD);
>> +	free(es);
>> +	return -ENOMEM;
>> +}
>> +
>>  static void print_events_table_suffix(FILE *outfp)
>>  {
>>  	fprintf(outfp, "{\n");
>> @@ -391,6 +469,27 @@ static char *real_event(const char *name, char *event)
>>  	return event;
>>  }
>>
>> +static int
>> +try_fixup(const char *fn, char *arch_std, char **event, char **desc,
>> +	  char **name, char **long_desc, char **pmu, char **filter,
>> +	  char **perpkg, char **unit, char **metric_expr, char **metric_name,
>> +	  char **metric_group)
>> +{
>> +	/* try to find matching event from arch standard values */
>> +	struct event_struct *es;
>> +
>> +	list_for_each_entry(es, &arch_std_events, list) {
>> +		if (!strcmp(arch_std, es->event+sizeof(EVENT_PREFIX))) {
>
> I spent some time figuring out how this can work when there's on '=' in EVENT_PREFIX
> is this because sizeof returns +1 size for NULL char also?

Right, sizeof(EVENT_PREFIX)=6 strlen(EVENT_PREFIX)=5

EVENT_PREFIX is "event"

Thank you,
John

>
> thanks,
> jirka
>
> .
>
