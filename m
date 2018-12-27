Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2624BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7F921741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbeL0IGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 03:06:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51190 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728809AbeL0IGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 03:06:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 310B658E38;
        Thu, 27 Dec 2018 08:06:42 +0000 (UTC)
Received: from krava (ovpn-204-89.brq.redhat.com [10.40.204.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 423F1608DD;
        Thu, 27 Dec 2018 08:06:39 +0000 (UTC)
Date:   Thu, 27 Dec 2018 09:06:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        =?utf-8?Q?Ond=C5=99ej_Lyson=C4=9Bk?= <olysonek@redhat.com>,
        Jaroslav =?utf-8?B?xaBrYXJ2YWRh?= <jskarvad@redhat.com>
Subject: Re: [PATCH] perf python: Do not force closing original perf
 descriptor in evlist.get_pollfd
Message-ID: <20181227080638.GA2313@krava>
References: <20181226112121.5285-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181226112121.5285-1-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 27 Dec 2018 08:06:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 12:21:21PM +0100, Jiri Olsa wrote:
> Ondřej reported that when compiled with python3, the python
> extension regress in evlist.get_pollfd function behaviour.
> 
> The evlist.get_pollfd creates file objects from evlist's fds
> and returns them in the list. The python3 version also sets
> them to 'close the original descriptor' when the object die
> (is closed), by passing True via 'closefd' arg in PyFile_FromFd
> call.
> 
> The python's closefd doc says:
>   If closefd is False, the underlying file descriptor will be kept open
>   when the file is closed.
> 
> That's why following line in python3 closes all evlist fds:
>   evlist.get_pollfd()
> 
> the returned list is immediately destroyed and that takes
> down the original events fds.
> 
> Passing closefd as False to PyFile_FromFd to fix this.
> 
> Reported-by: Ondřej Lysoněk <olysonek@redhat.com>
> Link: http://lkml.kernel.org/n/tip-ru9hmsaliew8p01kr0050mvg@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

oops, forgot to add.. and cc-ing Jaroslav Škarvada

Fixes: 66dfdff03d19 ("perf tools: Add Python 3 support")

jirka

> ---
>  tools/perf/util/python.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> index 47628e85c5eb..dda0ac978b1e 100644
> --- a/tools/perf/util/python.c
> +++ b/tools/perf/util/python.c
> @@ -939,7 +939,8 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
>  
>  		file = PyFile_FromFile(fp, "perf", "r", NULL);
>  #else
> -		file = PyFile_FromFd(evlist->pollfd.entries[i].fd, "perf", "r", -1, NULL, NULL, NULL, 1);
> +		file = PyFile_FromFd(evlist->pollfd.entries[i].fd, "perf", "r", -1,
> +				     NULL, NULL, NULL, 0);
>  #endif
>  		if (file == NULL)
>  			goto free_list;
> -- 
> 2.17.2
> 
