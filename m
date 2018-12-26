Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC74C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D583E20645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 19:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545853634;
	bh=M1rP1mYXkev6giQwOvX687DR73Gh6LjTnuYFu1hagXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=myZ3TzvSi5QsA2lNrgVYypWwntOW3hA54BgFgpqPVxm7R/gSuDz91lxBA1Ay6e7Ir
	 yYS7aDVUie6wQNu+v2uoKFuokBFTKonmhobhEKqt1hmY5SXByhCknc23Cp3ipZjMCN
	 S+hDd2Nr77Ia7PIL9E2gyQsKfiGYR/cTRNKifB7Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeLZTrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 14:47:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbeLZTrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 14:47:13 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7EF8214D8;
        Wed, 26 Dec 2018 19:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545853633;
        bh=M1rP1mYXkev6giQwOvX687DR73Gh6LjTnuYFu1hagXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPdLZj9Z/am7sinYV1wmHFP7JTLyjjX0Ep1T5fmqKKGQFfU49bszd4vTFzVt16ciF
         9Lo7lRDtLXmw+h7CDz7JdCSykQ73PqwairUEqK09m4DS1SCjVTENfyDjHzGqw019V+
         E4WNsI8vq5MxW6LOxaPv4y2d+FNrHekXAY3CVL1g=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6D565403A8; Wed, 26 Dec 2018 16:47:10 -0300 (-03)
Date:   Wed, 26 Dec 2018 16:47:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        =?utf-8?Q?Ond=C5=99ej_Lyson=C4=9Bk?= <olysonek@redhat.com>
Subject: Re: [PATCH] perf python: Do not force closing original perf
 descriptor in evlist.get_pollfd
Message-ID: <20181226194710.GB19471@kernel.org>
References: <20181226112121.5285-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181226112121.5285-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 26, 2018 at 12:21:21PM +0100, Jiri Olsa escreveu:
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

Applied.

- Arnaldo
 
> Reported-by: Ondřej Lysoněk <olysonek@redhat.com>
> Link: http://lkml.kernel.org/n/tip-ru9hmsaliew8p01kr0050mvg@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

-- 

- Arnaldo
