Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeCVJO7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:14:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752935AbeCVJOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:14:51 -0400
Date: Thu, 22 Mar 2018 10:14:48 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Petr Machata <petrm@mellanox.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf: python: Reference Py_None before returning it
Message-ID: <20180322091448.GA2972@krava>
References: <b1e565ecccf68064d8d54f37db5d028dda8fa522.1521675563.git.petrm@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1e565ecccf68064d8d54f37db5d028dda8fa522.1521675563.git.petrm@mellanox.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2018 at 12:57:32AM +0100, Petr Machata wrote:
> Python None objects are handled just like all the other objects with
> respect to their reference counting. Before returning Py_None, its
> reference count thus needs to be bumped.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/python.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index b1e999b..762d429 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -967,8 +967,10 @@ static PyObject *pyrf_evlist__read_on_cpu(struct pyrf_evlist *pevlist,
>  			return PyErr_NoMemory();
>  
>  		evsel = perf_evlist__event2evsel(evlist, event);
> -		if (!evsel)
> +		if (!evsel) {
> +			Py_INCREF(Py_None);
>  			return Py_None;
> +		}
>  
>  		pevent->evsel = evsel;
>  
> -- 
> 2.4.3
> 
