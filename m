Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4552C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 706122145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 14:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545056939;
	bh=kr3sBL/oDnCsdW8gWviezw7vvMHxsMln3Xww/Uv1XhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t3RH0rFsy1ollUQyRGui2wo9PyYv9FXBdxlSssYT51YY3A7VOEtKWEpnc7U7c4bu/
	 x0pg2IvYa8Wt7mCTSorB/oXne4m8Ex5O6aZJSqOV5Izkbar8QJz2nDHzSFwhmPbl23
	 mwgVXHBkWq6pW6QEPTm5hvizyrOc5NJj65eTgqTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732610AbeLQO26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 09:28:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:53254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732339AbeLQO26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 09:28:58 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DA19206A2;
        Mon, 17 Dec 2018 14:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545056937;
        bh=kr3sBL/oDnCsdW8gWviezw7vvMHxsMln3Xww/Uv1XhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c6mTvGw2GUjcAs9D2EudREyPez/syngr12Iute7TKkYlnmbdRsy4XpIhlFZEt4IpH
         rifTFVWXAbV0sOoPyi3+JhPdimCTC7oFMnR7hJ03kLRbxtVgWM7l9UhEWDDpz891WW
         0iNUTOHdA7pHqzk1so2JISnnnAg5wzBL6JY4ysmE=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 12C8F41B1D; Mon, 17 Dec 2018 11:28:54 -0300 (-03)
Date:   Mon, 17 Dec 2018 11:28:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tools/perf: fix silent build with 'make -s'
Message-ID: <20181217142854.GC26720@kernel.org>
References: <154504723398.564691.16359911285545406564.stgit@buzz>
 <1194e461-2385-bea9-dc85-d55d4ad89430@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1194e461-2385-bea9-dc85-d55d4ad89430@yandex-team.ru>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Dec 17, 2018 at 04:39:12PM +0300, Konstantin Khlebnikov escreveu:
> On 17.12.2018 14:47, Konstantin Khlebnikov wrote:
> > tools/perf/Makefile conflicts with option '-j'.
> > The rest options must be passed as is.
> > 
> > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > ---
> >   tools/perf/Makefile |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/Makefile b/tools/perf/Makefile
> > index 7902a5681fc8..989c3d2f847b 100644
> > --- a/tools/perf/Makefile
> > +++ b/tools/perf/Makefile
> > @@ -16,7 +16,7 @@
> >   #
> >   # We don't want to pass along options like -j:
> >   #
> > -unexport MAKEFLAGS
> > +MAKEFLAGS := $(filter --j% -j,$(MAKEFLAGS))
> >   #
> >   # Do a parallel build with multiple jobs, based on the number of CPUs online
> > 
> 
> Oops, this breaks static build because if LDFLAGS=-static is in command line then
> all assignments in makefile are ignored while Makefile.config have a lot of that.

Please next time use 'git blame' and read the cset where the behaviour
you think is wrong was introduced, then CC the involved persons.

In this case, this is the cset where that line was introduced:

commit 684f434cc05a122938b75e055d7d799f1dd58d55
Author: Ingo Molnar <mingo@kernel.org>
Date:   Fri Oct 4 11:11:32 2013 +0200

    tools/perf/build: Exclude MAKEFLAGS from nested invocation
    
    In case the user specifies MAKEFLAGS as an environment variable,
    or uses 'make -jN' explicitly, the options can conflict and result in:
    
        BUILD: Doing 'make -j8' parallel build
        make[1]: warning: -jN forced in submake: disabling jobserver mode.
        GEN common-cmds.h
        make[1]: *** write jobserver: Bad file descriptor.  Stop.
    
    Make sure we invoke the main makefile in a pristine state.
    
    Users who want to do something non-standard can use the:
    
      make -f Makefile.perf
    
    method to invoke the makefile.
    
    Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Link: http://lkml.kernel.org/n/tip-uen6hzTvkqqngqwjma9yoEgw@git.kernel.org
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 6f6f13a13bb6..74f52d8f9631 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -1,3 +1,10 @@
+#
+# This is a simple wrapper Makefile that calls the main Makefile.perf
+# with a -j option to do parallel builds
+#
+# If you want to invoke the perf build in some non-standard way then
+# you can use the 'make -f Makefile.perf' method to invoke it.
+#
 
 #
 # Clear out the built-in rules GNU make defines by default (such as .o targets),
@@ -5,6 +12,11 @@
 #
 .SUFFIXES:
 
+#
+# We don't want to pass along options like -j:
+#
+unexport MAKEFLAGS
+
 #
 # Do a parallel build with multiple jobs, based on the number of CPUs online
 # in this system: 'make -j8' on a 8-CPU system, etc.
@@ -18,14 +30,12 @@ ifeq ($(JOBS),)
   endif
 endif
 
-export JOBS
-
 define print_msg
   @printf '    BUILD: Doing '\''make \033[33m-j'$(JOBS)'\033[m'\'' parallel build\n'
 endef
 
 define make
-  @$(MAKE) -f Makefile.perf --no-print-directory -j$(JOBS) $@
+  @$(MAKE) -f Makefile.perf --no-print-directory -j$(JOBS) O=$(O) $@
 endef
 
 #
