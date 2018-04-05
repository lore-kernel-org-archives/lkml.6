Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeDELdJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 07:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbeDELdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 07:33:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8744E217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 5 Apr 2018 08:33:05 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] perf auxtrace: Make auxtrace_queues__add_buffer()
 allocate struct buffer
Message-ID: <20180405113305.GA31899@kernel.org>
References: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
 <1520327598-1317-7-git-send-email-adrian.hunter@intel.com>
 <20180306202542.GA3701@kernel.org>
 <3f3b67de-4807-f87a-3861-db4a0f908add@intel.com>
 <20180307141154.GE3701@kernel.org>
 <d2ca2f6f-4b60-b22c-98f3-900cc544bf99@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2ca2f6f-4b60-b22c-98f3-900cc544bf99@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 05, 2018 at 09:17:01AM +0300, Adrian Hunter escreveu:
> On 07/03/18 16:11, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Mar 07, 2018 at 10:06:50AM +0200, Adrian Hunter escreveu:
> >> On 06/03/18 22:25, Arnaldo Carvalho de Melo wrote:
> >>> Em Tue, Mar 06, 2018 at 11:13:17AM +0200, Adrian Hunter escreveu:
> >>>> In preparation for supporting AUX area sampling buffers,
> >>>> auxtrace_queues__add_buffer() needs to be more generic. To that end, move
> >>>> memory allocation for struct buffer into it.
> >>>>
> >>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >>>> ---
> >>>>  tools/perf/util/auxtrace.c | 54 +++++++++++++++++++++-------------------------
> >>>>  1 file changed, 24 insertions(+), 30 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> >>>> index fb357a00dd86..e1aff91c54a8 100644
> >>>> --- a/tools/perf/util/auxtrace.c
> >>>> +++ b/tools/perf/util/auxtrace.c
> >>>> @@ -308,7 +308,11 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
> >>>>  				       struct auxtrace_buffer *buffer,
> >>>>  				       struct auxtrace_buffer **buffer_ptr)
> >>>>  {
> >>>> -	int err;
> >>>> +	int err = -ENOMEM;
> >>>> +
> >>>> +	buffer = memdup(buffer, sizeof(*buffer));
> >>>
> >>> this is a bit strange, why not make buffer a local variable in this
> >>> function then?
> >>
> >> Do you mean the following?
> >>
> >> 	struct auxtrace_buffer *new_buf;
> >>
> >> 	new_buf = memdup(buffer, sizeof(*buffer));
> > 
> > I hadn't noticed that you were using buffer as both r and l value :-\
> > 
> > If all you want is to receive that buffer, duplicate it and then use
> > just the duplicate, not needing any reference to the original buffer,
> > then your code is correct, it just looked strange from a quick look, so
> > nevermind, I'll continue processing this one and the others.
> 
> Looks like this patch and patch 7 "perf auxtrace: Make
> auxtrace_queues__add_buffer() do CPU filtering" got left behind.  They still
> apply cleanly.

Thanks for the reminder, I'll process it.

- Arnaldo
