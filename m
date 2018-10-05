Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4161C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAE1208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqB/sX4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CAE1208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbeJEWgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbeJEWgs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:36:48 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47DFD2087D;
        Fri,  5 Oct 2018 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538753855;
        bh=P41mfq5J3Vq5AtzEwzXjvsU8hVaC8m6JKxprlgK5v+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SqB/sX4uMey1OZAmAf236ul4VKM304TcFes4l0glFdpzmov/L8sQqK+txYLWqLJ4w
         jNzMNky6/zQeBAk9oIf84c1fStmt3vasVzdESCKO6Tsi5M8fZv0c/XL/ct5UPRrWog
         3amPmngw7yQ3cgcItZuwz5HTNea23nz2f/ejog9E=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id F2E7D141DDC; Fri,  5 Oct 2018 12:37:31 -0300 (-03)
Date:   Fri, 5 Oct 2018 12:37:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Colin Patrick McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [PATCH v3] tools/lib/traceevent: Replace str_error_r() with an
 open coded implementation
Message-ID: <20181005153731.GC20250@kernel.org>
References: <20181002175539.2ac894c7@gandalf.local.home>
 <20181005113056.55b23c31@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005113056.55b23c31@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 05, 2018 at 11:30:56AM -0400, Steven Rostedt escreveu:
> Bah, I now get warnings that sys_nerr and sys_errlist are deprecated.
> 
> OK, so going back to just using the racy strerror() should be good
> enough, as this incompatibility with strerror_r() is a disaster!

I've been there, done that... ;-) Check:

tools/lib/str_error_r.c
tools/lib/bpf/str_error.c

The trick: have this function in a separate file, so that _GNU_SOURCE
doesn't get in the way...

- Arnaldo
