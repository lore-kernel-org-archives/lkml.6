Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A55C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEF22073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfBDUhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:37:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:22035 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfBDUhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:37:41 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 38A4281F13;
        Mon,  4 Feb 2019 20:37:41 +0000 (UTC)
Received: from krava (ovpn-204-43.brq.redhat.com [10.40.204.43])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2AFF575C6E;
        Mon,  4 Feb 2019 20:37:38 +0000 (UTC)
Date:   Mon, 4 Feb 2019 21:37:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Jones <tonyj@suse.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: perf: python3 + tests attr.py failing
Message-ID: <20190204203738.GE4794@krava>
References: <20190204151042.GH5593@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204151042.GH5593@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 04 Feb 2019 20:37:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 12:10:42PM -0300, Arnaldo Carvalho de Melo wrote:
> Noticed this now when building with PYTHON=python3, can you take a look?
> For now I'm reinstalling python2-devel and building with it, i.e.
> removing that PYTHON=python3 make command line variable.
> 
> [root@quaco ~]# perf test -v perf_event_attr
> 16: Setup struct perf_event_attr                          :
> --- start ---
> test child forked, pid 23937
>   File "/home/acme/libexec/perf-core/tests/attr.py", line 325
>     except Unsup, obj:
>                 ^
> SyntaxError: invalid syntax
> test child finished with -1
> ---- end ----
> Setup struct perf_event_attr: FAILED!

hum, I built the same way like you 'make PYTHON=python3'
[root@krava perf]# ldd ./perf | grep python
        libpython3.6m.so.1.0 => /lib64/libpython3.6m.so.1.0 (0x00007f4ca7cc4000)

and get 'Ok result'

[root@krava perf]# ./perf test attr
16: Setup struct perf_event_attr                          : Ok
48: Synthesize attr update                                : Ok


[root@krava perf]# python3 --version
Python 3.6.8
[root@krava perf]# rpm -qa | grep python3-devel
python3-devel-3.6.8-1.fc28.x86_64

which Fedora are you on 29? I'm on 28

jirka

> [root@quaco ~]# find
> 
> Reverting back to building with python2-devel makes it work:
> 
> make O=/tmp/build/perf -C tools/perf install-bin
> 
> [acme@quaco perf]$ ldd ~/bin/perf | grep python
> 	libpython2.7.so.1.0 => /lib64/libpython2.7.so.1.0 (0x00007fe283792000)
> [acme@quaco perf]$
> 
> [root@quaco ~]# perf test perf_event_attr
> 16: Setup struct perf_event_attr                          : Ok
> [root@quaco ~]#
> 
> - Arnaldo
