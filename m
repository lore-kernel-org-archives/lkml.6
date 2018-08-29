Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28F1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761AB205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6fr3mXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761AB205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbeH2Rvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:51:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:45224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbeH2Rvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:51:53 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D5320856;
        Wed, 29 Aug 2018 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535550889;
        bh=QlQC2GuDv0TaBwxZ8bdgSfd6jD/QlOOlOD18YhDxcRg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B6fr3mXI9ZM7LnACrtIe/4leQVEeZyreL5YsAhQQNzY8IIu0GzV5uqfjC5LgL7STq
         7oSG+aQwg0dF+xcewz02wMrya9VpOiRKUowavwA8IICDuCxk41P0PHwOzS5ntl3lEf
         MHw7Rz01bKxsr9rWFqPatEMxNu7Q0Me8HWYLVuhg=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 049F0141C3F; Wed, 29 Aug 2018 10:54:40 -0300 (-03)
Date:   Wed, 29 Aug 2018 10:54:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] perf script: callchain handling is not useful
Message-ID: <20180829135440.GA25381@kernel.org>
References: <CABPqkBTT-PSP+0sZc-EyrRtOLfLVPxOxwuDpxhGhGZLOe5L0CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBTT-PSP+0sZc-EyrRtOLfLVPxOxwuDpxhGhGZLOe5L0CA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 28, 2018 at 07:41:31PM -0700, Stephane Eranian escreveu:
> Hi,
> 
> I am doing the following simple collection with callchain and load profiling:
> 
> $ perf record -g -d -e cpu/event=0xd0,umask=0x81/pp  my_test_program
> 
> But when I type:
> $ perf script -F ip,addr
> ffff9d4821346878
>         ffffffff9d58df25
>         ffffffff9d58e054
>         ffffffff9d5965bb
>         ffffffff9d640650
>         ffffffff9d697d06
>         ffffffff9d63ec60
>         ffffffff9d640322
>         ffffffff9d64070c
>         ffffffff9d455a60
>                   7030c7
> 
> ffff9d4638ba84a0
>         ffffffff9d5df447
>         ffffffff9d5eaf4a
>         ffffffff9d63e165
>         ffffffff9d63e439
>         ffffffff9d697d98
>         ffffffff9d63ec60
>         ffffffff9d640322
>         ffffffff9d64070c
>         ffffffff9d455a60
>                   7030c7
> I also see the callchain and it is not clear which is the IP. Further
> more parsing becomes more difficult because of multiple lines per
> sample. I understand that multiline is likely because of
> symbolization. But if I don't want symbolization, it should be
> possible to print all in one line.

Humm, to have this not break possibly existing scripts, perhaps we can
have something like:

  $ perf script -F ip,-callchain,addr

?

And if asked explicitely for the callchain, then it gets added in the
same line?

- Arnaldo


> The current output is not very useful. You expect perf script to give
> you one line per sample and only what you want. Callchain != IP.
> 
> I think the following should happen:
>   - do not print callchain when asked for the IP. Create a callchain filter.
>   - print callchain on the same line, much like what is done for brstack
> 
> It is not clear to me why callchain and ip were lumped together.
> Any opinion on my proposal?
> Thanks.
