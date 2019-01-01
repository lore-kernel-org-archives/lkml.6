Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89092C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 18:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618B221019
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 18:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfAASAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 13:00:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39014 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfAASAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 13:00:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 706BAC07EFFF;
        Tue,  1 Jan 2019 18:00:54 +0000 (UTC)
Received: from krava (ovpn-204-83.brq.redhat.com [10.40.204.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id 977815C71A;
        Tue,  1 Jan 2019 18:00:52 +0000 (UTC)
Date:   Tue, 1 Jan 2019 19:00:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: perf: Use strcmp(str, "const") instead of strncmp(str, "const",
 sizeof("const"))
Message-ID: <20190101180051.GB9613@krava>
References: <20181220122601.62bf8858@gandalf.local.home>
 <20181220185553.GA22971@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220185553.GA22971@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 01 Jan 2019 18:00:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 03:55:53PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Dec 20, 2018 at 12:26:01PM -0500, Steven Rostedt escreveu:
> > As strncmp(str, "const", sizeof("const") is exactly the same as
> > strcmp(str, "const") use that instead, otherwise it is confusing.
> > 
> > sizeof("const") includes the nul terminator ('\0') of the string
> > "const", and that means strncmp() will only return a match if str and
> > "const" are exactly the same, which is what strcmp() does.
> 
> There are more of those, that are there from time immemorial, lemme see
> if the original intention can be found... 
> 
> commit 26d330226b9cf6208daae9b0b3697980c8fb51d8
> Author: Jiri Olsa <jolsa@redhat.com>
> Date:   Tue Aug 7 15:20:47 2012 +0200
> 
>     perf tools: Support for DWARF mode callchain
> 
> ----------------
> 
> I thought this could be because at the time strchr was used and thus the
> name would be in a buffer followed by ',' or other separator, but
> strtok_r() was used, so your patch should simplify things.

yea, strtok_r returns null-terminated string containing the next token,
so there's always trailing null terminator.. so those strncmp calls
work properly

jirka
