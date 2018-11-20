Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43647C4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE6952075B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE6952075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbeKTVwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:52:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbeKTVwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:52:36 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEB6830B9334;
        Tue, 20 Nov 2018 11:23:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.92])
        by smtp.corp.redhat.com (Postfix) with SMTP id 15B635D9CB;
        Tue, 20 Nov 2018 11:23:55 +0000 (UTC)
Date:   Tue, 20 Nov 2018 12:23:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Krister Johansen <kjlx@templeofstupid.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCHv2] perf tools: Restore proper cwd on return from mnt ns
Message-ID: <20181120112352.GE8967@krava>
References: <20181101170001.30019-1-jolsa@kernel.org>
 <20181119161006.GA13850@kernel.org>
 <20181120105618.GD8967@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120105618.GD8967@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 20 Nov 2018 11:23:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 11:56:18AM +0100, Jiri Olsa wrote:
> On Mon, Nov 19, 2018 at 08:10:06AM -0800, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Nov 01, 2018 at 06:00:01PM +0100, Jiri Olsa escreveu:
> > > Adding the current working directory to be part of the cookie
> > > and restoring it in the nsinfo__mountns_exit call.
> >  
> > > diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
> > > index cf8bd123cf73..fb0458b7e6aa 100644
> > > --- a/tools/perf/util/namespaces.c
> > > +++ b/tools/perf/util/namespaces.c
> > 
> > > @@ -199,9 +201,13 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
> > >  	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
> > >  		return;
> >   
> > > +	oldcwd = get_current_dir_name();
> > 
> > Breaks the build with bionic (Android), where get_current_dir_name() is
> > not available:
> > 
> > /tmp/build/perf/libperf.a(libperf-in.o):hist.c:function nsinfo__mountns_enter: error: undefined reference to 'get_current_dir_name'
> > collect2: error: ld returned 1 exit status
> > Makefile.perf:534: recipe for target '/tmp/build/perf/perf' failed
> > make[2]: *** [/tmp/build/perf/perf] Error 1
> > Makefile.perf:206: recipe for target 'sub-make' failed
> > make[1]: *** [sub-make] Error 2
> > Makefile:69: recipe for target 'all' failed
> > make: *** [all] Error 2
> > make: Leaving directory '/git/linux/tools/perf'
> > [root@seventh ~]# 
> > 
> > The container builds are ongoing, its possoble that this becomes an
> > issue in uCLibc, wasn't on musl libc (Alpine Linux).
> 
> will check, thanks

how about this one?

thanks,
jirka


---
When reporting on 'record' server we try to retrieve/use
the mnt namespace of the profiled tasks. We use following
API with cookie to hold the return namespace, roughly:

  nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc)
    setns(newns, 0);
  ...
  new ns related open..
  ...
  nsinfo__mountns_exit(struct nscookie *nc)
    setns(nc->oldns)

Once finished we setns to old namespace, which also sets the
current working directory (cwd) to "/", trashing the cwd we had.

This is mostly fine, because we use absolute paths almost everywhere,
but it screws up perf diff:

  # perf diff
  failed to open perf.data: No such file or directory  (try 'perf record' first)
  ...

Adding the current working directory to be part of the cookie
and restoring it in the nsinfo__mountns_exit call.

v2: get rid of _GNU_SOURCE get_current_dir_name call [acme]

Cc: Krister Johansen <kjlx@templeofstupid.com>
Fixes: 843ff37bb59e ("perf symbols: Find symbols in different mount namespace")
Link: http://lkml.kernel.org/n/tip-zg3vz7kjr86cco7lo91v8yhj@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/namespaces.c | 25 +++++++++++++++++++++++--
 tools/perf/util/namespaces.h |  1 +
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index cf8bd123cf73..b759a7ad87e7 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -18,6 +18,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+#include <asm/bug.h>
 
 struct namespaces *namespaces__new(struct namespaces_event *event)
 {
@@ -180,12 +181,20 @@ void nsinfo__put(struct nsinfo *nsi)
 		nsinfo__delete(nsi);
 }
 
+static char *get_current_dir(void)
+{
+	char path[PATH_MAX];
+
+	return getcwd(path, PATH_MAX) ? strdup(path) : NULL;
+}
+
 void nsinfo__mountns_enter(struct nsinfo *nsi,
 				  struct nscookie *nc)
 {
 	char curpath[PATH_MAX];
 	int oldns = -1;
 	int newns = -1;
+	char *oldcwd = NULL;
 
 	if (nc == NULL)
 		return;
@@ -199,9 +208,13 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (snprintf(curpath, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
 		return;
 
+	oldcwd = get_current_dir();
+	if (!oldcwd)
+		return;
+
 	oldns = open(curpath, O_RDONLY);
 	if (oldns < 0)
-		return;
+		goto errout;
 
 	newns = open(nsi->mntns_path, O_RDONLY);
 	if (newns < 0)
@@ -210,11 +223,14 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 	if (setns(newns, CLONE_NEWNS) < 0)
 		goto errout;
 
+	nc->oldcwd = oldcwd;
 	nc->oldns = oldns;
 	nc->newns = newns;
 	return;
 
 errout:
+	if (oldcwd)
+		free(oldcwd);
 	if (oldns > -1)
 		close(oldns);
 	if (newns > -1)
@@ -223,11 +239,16 @@ void nsinfo__mountns_enter(struct nsinfo *nsi,
 
 void nsinfo__mountns_exit(struct nscookie *nc)
 {
-	if (nc == NULL || nc->oldns == -1 || nc->newns == -1)
+	if (nc == NULL || nc->oldns == -1 || nc->newns == -1 || !nc->oldcwd)
 		return;
 
 	setns(nc->oldns, CLONE_NEWNS);
 
+	if (nc->oldcwd) {
+		WARN_ON_ONCE(chdir(nc->oldcwd));
+		free(nc->oldcwd);
+	}
+
 	if (nc->oldns > -1) {
 		close(nc->oldns);
 		nc->oldns = -1;
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index cae1a9a39722..d5f46c09ea31 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -38,6 +38,7 @@ struct nsinfo {
 struct nscookie {
 	int			oldns;
 	int			newns;
+	char			*oldcwd;
 };
 
 int nsinfo__init(struct nsinfo *nsi);
-- 
2.17.2

