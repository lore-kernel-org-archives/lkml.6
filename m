Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751169AbeCGIHk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 03:07:40 -0500
Received: from mga18.intel.com ([134.134.136.126]:18150 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeCGIHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 03:07:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,434,1515484800";
   d="scan'208";a="25883178"
Subject: Re: [PATCH 6/7] perf auxtrace: Make auxtrace_queues__add_buffer()
 allocate struct buffer
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
 <1520327598-1317-7-git-send-email-adrian.hunter@intel.com>
 <20180306202542.GA3701@kernel.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3f3b67de-4807-f87a-3861-db4a0f908add@intel.com>
Date: Wed, 7 Mar 2018 10:06:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180306202542.GA3701@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/18 22:25, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 06, 2018 at 11:13:17AM +0200, Adrian Hunter escreveu:
>> In preparation for supporting AUX area sampling buffers,
>> auxtrace_queues__add_buffer() needs to be more generic. To that end, move
>> memory allocation for struct buffer into it.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/util/auxtrace.c | 54 +++++++++++++++++++++-------------------------
>>  1 file changed, 24 insertions(+), 30 deletions(-)
>>
>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
>> index fb357a00dd86..e1aff91c54a8 100644
>> --- a/tools/perf/util/auxtrace.c
>> +++ b/tools/perf/util/auxtrace.c
>> @@ -308,7 +308,11 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
>>  				       struct auxtrace_buffer *buffer,
>>  				       struct auxtrace_buffer **buffer_ptr)
>>  {
>> -	int err;
>> +	int err = -ENOMEM;
>> +
>> +	buffer = memdup(buffer, sizeof(*buffer));
> 
> this is a bit strange, why not make buffer a local variable in this
> function then?

Do you mean the following?

	struct auxtrace_buffer *new_buf;

	new_buf = memdup(buffer, sizeof(*buffer));

> 
>> +	if (!buffer)
>> +		return -ENOMEM;
>>  
>>  	if (session->one_mmap) {
>>  		buffer->data = buffer->data_offset - session->one_mmap_offset +
>> @@ -316,24 +320,28 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
>>  	} else if (perf_data__is_pipe(session->data)) {
>>  		buffer->data = auxtrace_copy_data(buffer->size, session);
>>  		if (!buffer->data)
>> -			return -ENOMEM;
>> +			goto out_free;
>>  		buffer->data_needs_freeing = true;
>>  	} else if (BITS_PER_LONG == 32 &&
>>  		   buffer->size > BUFFER_LIMIT_FOR_32_BIT) {
>>  		err = auxtrace_queues__split_buffer(queues, idx, buffer);
>>  		if (err)
>> -			return err;
>> +			goto out_free;
>>  	}
>>  
>>  	err = auxtrace_queues__queue_buffer(queues, idx, buffer);
>>  	if (err)
>> -		return err;
>> +		goto out_free;
>>  
>>  	/* FIXME: Doesn't work for split buffer */
>>  	if (buffer_ptr)
>>  		*buffer_ptr = buffer;
>>  
>>  	return 0;
>> +
>> +out_free:
>> +	auxtrace_buffer__free(buffer);
>> +	return err;
>>  }
>>  
>>  static bool filter_cpu(struct perf_session *session, int cpu)
>> @@ -348,36 +356,22 @@ int auxtrace_queues__add_event(struct auxtrace_queues *queues,
>>  			       union perf_event *event, off_t data_offset,
>>  			       struct auxtrace_buffer **buffer_ptr)
>>  {
>> -	struct auxtrace_buffer *buffer;
>> -	unsigned int idx;
>> -	int err;
>> +	struct auxtrace_buffer buffer = {
>> +		.pid = -1,
>> +		.tid = event->auxtrace.tid,
>> +		.cpu = event->auxtrace.cpu,
>> +		.data_offset = data_offset,
>> +		.offset = event->auxtrace.offset,
>> +		.reference = event->auxtrace.reference,
>> +		.size = event->auxtrace.size,
>> +	};
>> +	unsigned int idx = event->auxtrace.idx;
>>  
>>  	if (filter_cpu(session, event->auxtrace.cpu))
>>  		return 0;
>>  
>> -	buffer = zalloc(sizeof(struct auxtrace_buffer));
>> -	if (!buffer)
>> -		return -ENOMEM;
>> -
>> -	buffer->pid = -1;
>> -	buffer->tid = event->auxtrace.tid;
>> -	buffer->cpu = event->auxtrace.cpu;
>> -	buffer->data_offset = data_offset;
>> -	buffer->offset = event->auxtrace.offset;
>> -	buffer->reference = event->auxtrace.reference;
>> -	buffer->size = event->auxtrace.size;
>> -	idx = event->auxtrace.idx;
>> -
>> -	err = auxtrace_queues__add_buffer(queues, session, idx, buffer,
>> -					  buffer_ptr);
>> -	if (err)
>> -		goto out_err;
>> -
>> -	return 0;
>> -
>> -out_err:
>> -	auxtrace_buffer__free(buffer);
>> -	return err;
>> +	return auxtrace_queues__add_buffer(queues, session, idx, &buffer,
>> +					   buffer_ptr);
>>  }
>>  
>>  static int auxtrace_queues__add_indexed_event(struct auxtrace_queues *queues,
>> -- 
>> 1.9.1
> 
