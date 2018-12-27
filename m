Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E818EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 12:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF4E214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 12:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545915296;
	bh=kV7yBKvJ+4izBSMdETYPkC5qSNUzBwavP6i5zH4Jr30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1kZSY6uESSBiygIoqxYOTK/J0W2YWA4SW8UrIHw4jbGXiFW5PXh7MIUf5KuLxt1q4
	 MlBmYbr+iqauJrkGQBiK7YmMHfl9NpO46QSiI7WZI31OGyxOA21UIqYsuSoadzbVrO
	 +kBBtQsh4uyvWFLRe7JoNFh/nTdQIxIo9ackKO6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeL0Myz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 07:54:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbeL0Myz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 07:54:55 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44BD42148D;
        Thu, 27 Dec 2018 12:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545915294;
        bh=kV7yBKvJ+4izBSMdETYPkC5qSNUzBwavP6i5zH4Jr30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWuzO09oSzfeWdMIdaYeSoqy0jvuTixOPTwQLMVlMmaL/m/BeiYcxYngHnHmSnmW8
         UDrgVkTN4jU4A5jfZAs+5xWbcYb3gQMmXpAGB9ljOUlx5nmKcC3+a2y81F6WFxwpGy
         ojOU3LKDzQEw9/TEs72wCd5idipPKsf0FKmKp4zw=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DC488403A8; Thu, 27 Dec 2018 09:54:51 -0300 (-03)
Date:   Thu, 27 Dec 2018 09:54:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        =?utf-8?Q?Ond=C5=99ej_Lyson=C4=9Bk?= <olysonek@redhat.com>,
        Jaroslav =?utf-8?B?xaBrYXJ2YWRh?= <jskarvad@redhat.com>
Subject: Re: [PATCH] perf python: Do not force closing original perf
 descriptor in evlist.get_pollfd
Message-ID: <20181227125451.GA25753@kernel.org>
References: <20181226112121.5285-1-jolsa@kernel.org>
 <20181227080638.GA2313@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181227080638.GA2313@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 27, 2018 at 09:06:38AM +0100, Jiri Olsa escreveu:
> On Wed, Dec 26, 2018 at 12:21:21PM +0100, Jiri Olsa wrote:
> > Ondřej reported that when compiled with python3, the python
> > extension regress in evlist.get_pollfd function behaviour.
> > 
> > The evlist.get_pollfd creates file objects from evlist's fds
> > and returns them in the list. The python3 version also sets
> > them to 'close the original descriptor' when the object die
> > (is closed), by passing True via 'closefd' arg in PyFile_FromFd
> > call.
> > 
> > The python's closefd doc says:
> >   If closefd is False, the underlying file descriptor will be kept open
> >   when the file is closed.
> > 
> > That's why following line in python3 closes all evlist fds:
> >   evlist.get_pollfd()
> > 
> > the returned list is immediately destroyed and that takes
> > down the original events fds.
> > 
> > Passing closefd as False to PyFile_FromFd to fix this.
> > 
> > Reported-by: Ondřej Lysoněk <olysonek@redhat.com>
> > Link: http://lkml.kernel.org/n/tip-ru9hmsaliew8p01kr0050mvg@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> oops, forgot to add.. and cc-ing Jaroslav Škarvada
> 
> Fixes: 66dfdff03d19 ("perf tools: Add Python 3 support")

Thanks, added the Fixes: and Cc: Jaroslav,

- Arnaldo
