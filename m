Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D920C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578932087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549293048;
	bh=WAFq2wUui/q2T7y0cEZV/uZS8m5oWEXMUofQzELXJcc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=K6VrRkQA2eXmdJ9Nuq+xfO4+XXg3SNOobSNTnAR6PydGhDRvqKd3pBX2opmV9LSYJ
	 c14tyN3WaWOTejyb4+QJtvO+Bym5oCzIYgkVw2x4lu4IdmH2kCMBZFoh36KCffX8jv
	 6RITW0emQCYpIHBB6080/nD72X2nIbPXkkePDqrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfBDPKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:10:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbfBDPKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:10:46 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62E082082E;
        Mon,  4 Feb 2019 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549293045;
        bh=WAFq2wUui/q2T7y0cEZV/uZS8m5oWEXMUofQzELXJcc=;
        h=Date:From:To:Cc:Subject:From;
        b=VjqbHOTzm3C1CBMUzMSb7ay4NhajgGomwXsZkcExIZzupOSvpTzdG/vnyvnIefm70
         qIyOOhpoMixujB4WhNG+hpYRWOySBf68KqEWU9LymFbT6ZjdKoDlFmOCpZ7CyYnnDV
         aBj0hPsRbTuFUeMS3P1ZY5Li19FArPnnJBM3gU00=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 33EAA4034F; Mon,  4 Feb 2019 12:10:42 -0300 (-03)
Date:   Mon, 4 Feb 2019 12:10:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Tony Jones <tonyj@suse.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: perf: python3 + tests attr.py failing
Message-ID: <20190204151042.GH5593@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this now when building with PYTHON=python3, can you take a look?
For now I'm reinstalling python2-devel and building with it, i.e.
removing that PYTHON=python3 make command line variable.

[root@quaco ~]# perf test -v perf_event_attr
16: Setup struct perf_event_attr                          :
--- start ---
test child forked, pid 23937
  File "/home/acme/libexec/perf-core/tests/attr.py", line 325
    except Unsup, obj:
                ^
SyntaxError: invalid syntax
test child finished with -1
---- end ----
Setup struct perf_event_attr: FAILED!
[root@quaco ~]# find

Reverting back to building with python2-devel makes it work:

make O=/tmp/build/perf -C tools/perf install-bin

[acme@quaco perf]$ ldd ~/bin/perf | grep python
	libpython2.7.so.1.0 => /lib64/libpython2.7.so.1.0 (0x00007fe283792000)
[acme@quaco perf]$

[root@quaco ~]# perf test perf_event_attr
16: Setup struct perf_event_attr                          : Ok
[root@quaco ~]#

- Arnaldo
