Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeCGOMB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:12:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751189AbeCGOMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:12:00 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72EF2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 7 Mar 2018 11:11:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] perf auxtrace: Make auxtrace_queues__add_buffer()
 allocate struct buffer
Message-ID: <20180307141154.GE3701@kernel.org>
References: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
 <1520327598-1317-7-git-send-email-adrian.hunter@intel.com>
 <20180306202542.GA3701@kernel.org>
 <3f3b67de-4807-f87a-3861-db4a0f908add@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f3b67de-4807-f87a-3861-db4a0f908add@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 07, 2018 at 10:06:50AM +0200, Adrian Hunter escreveu:
> On 06/03/18 22:25, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Mar 06, 2018 at 11:13:17AM +0200, Adrian Hunter escreveu:
> >> In preparation for supporting AUX area sampling buffers,
> >> auxtrace_queues__add_buffer() needs to be more generic. To that end, move
> >> memory allocation for struct buffer into it.
> >>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  tools/perf/util/auxtrace.c | 54 +++++++++++++++++++++-------------------------
> >>  1 file changed, 24 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> >> index fb357a00dd86..e1aff91c54a8 100644
> >> --- a/tools/perf/util/auxtrace.c
> >> +++ b/tools/perf/util/auxtrace.c
> >> @@ -308,7 +308,11 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
> >>  				       struct auxtrace_buffer *buffer,
> >>  				       struct auxtrace_buffer **buffer_ptr)
> >>  {
> >> -	int err;
> >> +	int err = -ENOMEM;
> >> +
> >> +	buffer = memdup(buffer, sizeof(*buffer));
> > 
> > this is a bit strange, why not make buffer a local variable in this
> > function then?
> 
> Do you mean the following?
> 
> 	struct auxtrace_buffer *new_buf;
> 
> 	new_buf = memdup(buffer, sizeof(*buffer));

I hadn't noticed that you were using buffer as both r and l value :-\

If all you want is to receive that buffer, duplicate it and then use
just the duplicate, not needing any reference to the original buffer,
then your code is correct, it just looked strange from a quick look, so
nevermind, I'll continue processing this one and the others.

Thanks,

- Arnaldo
 
> > 
> >> +	if (!buffer)
> >> +		return -ENOMEM;
> >>  
> >>  	if (session->one_mmap) {
> >>  		buffer->data = buffer->data_offset - session->one_mmap_offset +
> >> @@ -316,24 +320,28 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
> >>  	} else if (perf_data__is_pipe(session->data)) {
> >>  		buffer->data = auxtrace_copy_data(buffer->size, session);
> >>  		if (!buffer->data)
> >> -			return -ENOMEM;
> >> +			goto out_free;
> >>  		buffer->data_needs_freeing = true;
> >>  	} else if (BITS_PER_LONG == 32 &&
> >>  		   buffer->size > BUFFER_LIMIT_FOR_32_BIT) {
> >>  		err = auxtrace_queues__split_buffer(queues, idx, buffer);
> >>  		if (err)
> >> -			return err;
> >> +			goto out_free;
> >>  	}
> >>  
> >>  	err = auxtrace_queues__queue_buffer(queues, idx, buffer);
> >>  	if (err)
> >> -		return err;
> >> +		goto out_free;
> >>  
> >>  	/* FIXME: Doesn't work for split buffer */
> >>  	if (buffer_ptr)
> >>  		*buffer_ptr = buffer;
> >>  
> >>  	return 0;
> >> +
> >> +out_free:
> >> +	auxtrace_buffer__free(buffer);
> >> +	return err;
> >>  }
> >>  
> >>  static bool filter_cpu(struct perf_session *session, int cpu)
> >> @@ -348,36 +356,22 @@ int auxtrace_queues__add_event(struct auxtrace_queues *queues,
> >>  			       union perf_event *event, off_t data_offset,
> >>  			       struct auxtrace_buffer **buffer_ptr)
> >>  {
> >> -	struct auxtrace_buffer *buffer;
> >> -	unsigned int idx;
> >> -	int err;
> >> +	struct auxtrace_buffer buffer = {
> >> +		.pid = -1,
> >> +		.tid = event->auxtrace.tid,
> >> +		.cpu = event->auxtrace.cpu,
> >> +		.data_offset = data_offset,
> >> +		.offset = event->auxtrace.offset,
> >> +		.reference = event->auxtrace.reference,
> >> +		.size = event->auxtrace.size,
> >> +	};
> >> +	unsigned int idx = event->auxtrace.idx;
> >>  
> >>  	if (filter_cpu(session, event->auxtrace.cpu))
> >>  		return 0;
> >>  
> >> -	buffer = zalloc(sizeof(struct auxtrace_buffer));
> >> -	if (!buffer)
> >> -		return -ENOMEM;
> >> -
> >> -	buffer->pid = -1;
> >> -	buffer->tid = event->auxtrace.tid;
> >> -	buffer->cpu = event->auxtrace.cpu;
> >> -	buffer->data_offset = data_offset;
> >> -	buffer->offset = event->auxtrace.offset;
> >> -	buffer->reference = event->auxtrace.reference;
> >> -	buffer->size = event->auxtrace.size;
> >> -	idx = event->auxtrace.idx;
> >> -
> >> -	err = auxtrace_queues__add_buffer(queues, session, idx, buffer,
> >> -					  buffer_ptr);
> >> -	if (err)
> >> -		goto out_err;
> >> -
> >> -	return 0;
> >> -
> >> -out_err:
> >> -	auxtrace_buffer__free(buffer);
> >> -	return err;
> >> +	return auxtrace_queues__add_buffer(queues, session, idx, &buffer,
> >> +					   buffer_ptr);
> >>  }
> >>  
> >>  static int auxtrace_queues__add_indexed_event(struct auxtrace_queues *queues,
> >> -- 
> >> 1.9.1
> > 
