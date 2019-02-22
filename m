Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2BDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B3520838
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550795401;
	bh=hT66cmdoY32XWRRvyyzRp/IoOFu5ptsUY9yNHgbAA5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=H7lTBJkIpJrdaY/6jslCru10GDuPtCe3Zwzvab8LRMJyqNTf6H7cBkyygjUNvFyJA
	 MMxivAe1KtkQuh1lmBhoEnPyLgnhvq0Z1Ym0Be92vPxYPw3/uNiXQtrhOD6Xa9X2Sl
	 sn7v2eqVpJ1IyJT2Ckq6o++CVGNjs/GVeJBXw/Po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfBVA37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:29:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:39950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbfBVA37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:29:59 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95673206B6;
        Fri, 22 Feb 2019 00:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550795398;
        bh=hT66cmdoY32XWRRvyyzRp/IoOFu5ptsUY9yNHgbAA5E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F0PHR2ZS11FxmuVs7WXVpt5cGJbUQ08GksOvLE0+9GyxXe7Tv+67m8W2JH22bIwSW
         AYACk97EXORAcNue2fgv7qynNBGTzDFywc72b9T5iZl7qm5bFVny7AY4CKu4g6OH80
         FYsYASkYOp9qebe2si+09wVwxq7M55lakJJMoiCQ=
Date:   Fri, 22 Feb 2019 09:29:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH] selftests/ftrace: Make the coloring POSIX compliant
Message-Id: <20190222092956.26cbe722d35202409890bea3@kernel.org>
In-Reply-To: <20190220161333.28109-1-juergh@canonical.com>
References: <20190220161333.28109-1-juergh@canonical.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juerg,

On Wed, 20 Feb 2019 17:13:33 +0100
Juerg Haefliger <juerg.haefliger@canonical.com> wrote:

> echo -e and \e are not POSIX. Depending on what /bin/sh is, we can get
> incorrect output like:
> $ -e -n [1] Basic trace file check
> $ -e 	[PASS]
> 
> Fix that by using \033 instead of \e and printf.

OK, as far as I can check with checkbashisms, echo -e is not acceptable.

$ checkbashisms ./ftracetest 
possible bashism in ./ftracetest line 176 (echo -e):
  echo -e "$@"
possible bashism in ./ftracetest line 177 (echo -e):
  [ "$LOG_FILE" ] && echo -e "$@" | strip_esc >> $LOG_FILE

So it should be fixed, even other shells support it.
(Or, update checkbashisms command...)

However,

>  prlog() { # messages
> -  echo -e "$@"
> -  [ "$LOG_FILE" ] && echo -e "$@" | strip_esc >> $LOG_FILE
> +  newline="\n"
> +  if [ "$1" = "-n" ] ; then
> +    newline=
> +    shift
> +  fi
> +  printf "$@$newline"
> +  [ "$LOG_FILE" ] && printf "$@$newline" | strip_esc >> $LOG_FILE

This doesn't work when prlog gets several arguments. (like the summary line)
for example I got below result.

# of passed: # of failed: # of unresolved: # of untested: # of unsupported: # of xfailed: # of undefined(test bug): 

Replacing $@ with $* shows correct result. Could you fix it?

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
