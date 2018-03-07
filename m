Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933537AbeCGTjf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 14:39:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:45410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754039AbeCGTjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 14:39:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00DC52172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 7 Mar 2018 16:39:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Agustin Vega-Frias <agustinv@codeaurora.org>,
        Andi Kleen <ak@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        timur@codeaurora.org
Subject: Re: [RFC V3 1/3] perf, tools: Support wildcards on pmu name in
 dynamic pmu events
Message-ID: <20180307193930.GW3701@kernel.org>
References: <1520345084-42646-1-git-send-email-agustinv@codeaurora.org>
 <1520345084-42646-2-git-send-email-agustinv@codeaurora.org>
 <20180307160224.GN3701@kernel.org>
 <d3bd59db56fbc13b931ae45573bf94d8@codeaurora.org>
 <20180307185415.GK25017@tassilo.jf.intel.com>
 <20180307190509.GQ3701@kernel.org>
 <20180307190543.GR3701@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307190543.GR3701@kernel.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 07, 2018 at 04:05:43PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Mar 07, 2018 at 04:05:09PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Mar 07, 2018 at 10:54:15AM -0800, Andi Kleen escreveu:
> > > > Sorry about that. That's probably because FNM_EXTMATCH is a GNU extension,
> > > > not POSIX, and the Alpine and Android runtimes likely don't implement
> > > > that...
> > > > I'll send a fix reverting back to the strncmp to ignore the uncore_ prefix,
> > > > and dropping that extension.
> > > 
> > > Just don't set it? Even the basic glob patterns are useful.
> > 
> > Or use:
> > 
> > #ifndef FNM_EXTMATCH
> > #define FNM_EXTMATCH 0
> > #endif
> > 
> > So on systems without it, its not used, while on GNU systems, we have
> > that functionality (pretty fancy, someone may need that... ;-))
> 
> I'll try this route, btw, no need to send more patches for now.

So, with the patch at the end of this message, it works now in those
systems:

[root@jouet ~]# dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-11)
   6 amazonlinux:2                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
   7 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   8 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  10 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)

I stopped the test at this point to process some more patches, will
restart the tests with those extra patches and if all goes well with the
other 46 build environments, push upstream, thanks.

- Arnaldo

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 316ac073aa78..18473be7d787 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -9,6 +9,13 @@
 #define YYDEBUG 1
 
 #include <fnmatch.h>
+/*
+ * GNU extension, so better define it to 0 for systems such
+ * as Android and Alpine Linux.
+ */
+#ifndef FNM_EXTMATCH
+#define FNM_EXTMATCH 0
+#endif
 #include <linux/compiler.h>
 #include <linux/list.h>
 #include <linux/types.h>
