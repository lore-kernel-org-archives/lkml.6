Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeDFLpV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 07:45:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:34860 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752092AbeDFLpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 07:45:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,415,1517904000";
   d="scan'208";a="218122328"
Subject: Re: [PATCH 7/7] perf auxtrace: Make auxtrace_queues__add_buffer() do
 CPU filtering
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <1520327598-1317-1-git-send-email-adrian.hunter@intel.com>
 <1520327598-1317-8-git-send-email-adrian.hunter@intel.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <e2233900-d1aa-8e5e-7618-c7a7f0457e2c@intel.com>
Date: Fri, 6 Apr 2018 14:44:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520327598-1317-8-git-send-email-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo

I just saw you have patch 6 but still not this one.

Regards
Adrian

On 06/03/18 11:13, Adrian Hunter wrote:
> In preparation for supporting AUX area sampling buffers,
> auxtrace_queues__add_buffer() needs to be more generic. To that end, move
> CPU filtering into it.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/auxtrace.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index e1aff91c54a8..857de69a5361 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -302,6 +302,13 @@ static int auxtrace_queues__split_buffer(struct auxtrace_queues *queues,
>  	return 0;
>  }
>  
> +static bool filter_cpu(struct perf_session *session, int cpu)
> +{
> +	unsigned long *cpu_bitmap = session->itrace_synth_opts->cpu_bitmap;
> +
> +	return cpu_bitmap && cpu != -1 && !test_bit(cpu, cpu_bitmap);
> +}
> +
>  static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
>  				       struct perf_session *session,
>  				       unsigned int idx,
> @@ -310,6 +317,9 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
>  {
>  	int err = -ENOMEM;
>  
> +	if (filter_cpu(session, buffer->cpu))
> +		return 0;
> +
>  	buffer = memdup(buffer, sizeof(*buffer));
>  	if (!buffer)
>  		return -ENOMEM;
> @@ -344,13 +354,6 @@ static int auxtrace_queues__add_buffer(struct auxtrace_queues *queues,
>  	return err;
>  }
>  
> -static bool filter_cpu(struct perf_session *session, int cpu)
> -{
> -	unsigned long *cpu_bitmap = session->itrace_synth_opts->cpu_bitmap;
> -
> -	return cpu_bitmap && cpu != -1 && !test_bit(cpu, cpu_bitmap);
> -}
> -
>  int auxtrace_queues__add_event(struct auxtrace_queues *queues,
>  			       struct perf_session *session,
>  			       union perf_event *event, off_t data_offset,
> @@ -367,9 +370,6 @@ int auxtrace_queues__add_event(struct auxtrace_queues *queues,
>  	};
>  	unsigned int idx = event->auxtrace.idx;
>  
> -	if (filter_cpu(session, event->auxtrace.cpu))
> -		return 0;
> -
>  	return auxtrace_queues__add_buffer(queues, session, idx, &buffer,
>  					   buffer_ptr);
>  }
> 
