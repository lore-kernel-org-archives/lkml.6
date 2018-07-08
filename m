Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D237DC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A25208A2
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A25208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbeGHLRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 07:17:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754064AbeGHLRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 07:17:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4439783207;
        Sun,  8 Jul 2018 11:17:12 +0000 (UTC)
Received: from krava (ovpn-204-62.brq.redhat.com [10.40.204.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id DA9402156889;
        Sun,  8 Jul 2018 11:17:08 +0000 (UTC)
Date:   Sun, 8 Jul 2018 13:17:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Janne Huttunen <janne.huttunen@nokia.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jaroslav =?utf-8?B?xaBrYXJ2YWRh?= <jskarvad@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf script python: Fix dict reference counting
Message-ID: <20180708111707.GA7092@krava>
References: <1530860024-12653-1-git-send-email-janne.huttunen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530860024-12653-1-git-send-email-janne.huttunen@nokia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sun, 08 Jul 2018 11:17:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Sun, 08 Jul 2018 11:17:12 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 09:53:44AM +0300, Janne Huttunen wrote:
> The dictionaries are attached to the parameter tuple that steals the
> references. The code should not decrement the reference counters
> explicitly. Otherwise the objects might be released while they are
> still in use which may cause perf crashes, assertions or just plain
> weird behavior like unexpected data changes in stored objects.
> 
> Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>
> ---
>  tools/perf/util/scripting-engines/trace-event-python.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index 46e9e19..60fce44 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -908,14 +908,11 @@ static void python_process_tracepoint(struct perf_sample *sample,
>  	if (_PyTuple_Resize(&t, n) == -1)
>  		Py_FatalError("error resizing Python tuple");
>  
> -	if (!dict) {
> +	if (!dict)
>  		call_object(handler, t, handler_name);
> -	} else {
> +	else
>  		call_object(handler, t, default_handler_name);
> -		Py_DECREF(dict);
> -	}
>  
> -	Py_XDECREF(all_entries_dict);
>  	Py_DECREF(t);
>  }
>  
> @@ -1235,7 +1232,6 @@ static void python_process_general_event(struct perf_sample *sample,
>  
>  	call_object(handler, t, handler_name);
>  
> -	Py_DECREF(dict);
>  	Py_DECREF(t);

so the dict is released when the tuple is released?

jirka
