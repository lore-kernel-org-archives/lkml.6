Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3986C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F1B20840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbfAPE7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 23:59:21 -0500
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:60332 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728034AbfAPE7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 23:59:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 1631718045A60;
        Wed, 16 Jan 2019 04:59:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: train58_6e54b26c3325c
X-Filterd-Recvd-Size: 1964
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 16 Jan 2019 04:59:18 +0000 (UTC)
Message-ID: <7c07519607d08c0afe448a03fb2010bce13cd77f.camel@perches.com>
Subject: Re: [PATCH v12 01/16] tracing: Use str_has_prefix() in
 synth_event_create()
From:   Joe Perches <joe@perches.com>
To:     Tom Zanussi <zanussi@kernel.org>, rostedt@goodmis.org
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Tue, 15 Jan 2019 20:59:16 -0800
In-Reply-To: <aa6e33335e1ff99c7ac3d00fa5e27faaad04f981.1547589128.git.tom.zanussi@linux.intel.com>
References: <cover.1547589128.git.tom.zanussi@linux.intel.com>
         <aa6e33335e1ff99c7ac3d00fa5e27faaad04f981.1547589128.git.tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-01-15 at 16:05 -0600, Tom Zanussi wrote:
> Since we now have a str_has_prefix() that returns the length, we can
> use that instead of explicitly calculating it.
[]
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
[]
> @@ -1200,8 +1200,7 @@ static int synth_event_create(int argc, const char **argv)
>  
>  	/* This interface accepts group name prefix */
>  	if (strchr(name, '/')) {
> -		len = sizeof(SYNTH_SYSTEM "/") - 1;
> -		if (strncmp(name, SYNTH_SYSTEM "/", len))
> +		if ((len = str_has_prefix(name, SYNTH_SYSTEM "/")) == 0)

Since this is a single test, and not multiple if/else if
blocks, I believe this would read better on two lines

		len = str_has_prefix(name, SYNTH_SYSTEM "/");
		if (len == 0)

>  			return -EINVAL;
>  		name += len;
>  	}


