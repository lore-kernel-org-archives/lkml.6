Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4BCC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6597820663
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 13:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfAFNZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 08:25:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfAFNZN (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 08:25:13 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5068586675;
        Sun,  6 Jan 2019 13:25:13 +0000 (UTC)
Received: from krava (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with SMTP id AA1395D9CB;
        Sun,  6 Jan 2019 13:25:10 +0000 (UTC)
Date:   Sun, 6 Jan 2019 14:25:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Poll for monitored tasks being alive in fork
 mode
Message-ID: <20190106132509.GA31228@krava>
References: <1546568897-16123-1-git-send-email-yao.jin@linux.intel.com>
 <20190104125441.GF5481@krava>
 <ec011f77-e08e-4471-4479-0cb0281fa79b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec011f77-e08e-4471-4479-0cb0281fa79b@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sun, 06 Jan 2019 13:25:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2019 at 11:16:40AM +0800, Jin, Yao wrote:
> 
> 
> On 1/4/2019 8:54 PM, Jiri Olsa wrote:
> > On Fri, Jan 04, 2019 at 10:28:17AM +0800, Jin Yao wrote:
> > > Following test shows the stat keeps running even if no longer
> > > task to monitor (mgen exits at ~5s).
> > > 
> > > perf stat -e cycles -p `pgrep mgen` -I1000 -- sleep 10
> > >              time             counts unit events
> > >       1.000148916      1,308,365,864      cycles
> > >       2.000379171      1,297,269,875      cycles
> > >       3.000556719      1,297,187,078      cycles
> > >       4.000914241        761,261,827      cycles
> > >       5.001306091      <not counted>      cycles
> > >       6.001676881      <not counted>      cycles
> > >       7.002046336      <not counted>      cycles
> > >       8.002405651      <not counted>      cycles
> > >       9.002766625      <not counted>      cycles
> > >      10.001395827      <not counted>      cycles
> > > 
> > > We'd better finish stat immediately if there's no longer task to
> > > monitor.
> > > 
> > > After:
> > > 
> > > perf stat -e cycles -p `pgrep mgen` -I1000 -- sleep 10
> > >              time             counts unit events
> > >       1.000180062      1,236,592,661      cycles
> > >       2.000421539      1,223,733,572      cycles
> > >       3.000609910      1,297,047,663      cycles
> > >       4.000807545      1,297,215,816      cycles
> > >       5.001001578      1,297,208,032      cycles
> > >       6.001390345        582,343,659      cycles
> > > sleep: Terminated
> > > 
> > > Now the stat exits immediately when the monitored tasks ends.
> > > 
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > ---
> > >   tools/perf/builtin-stat.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 63a3afc..71f3bc8 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -553,6 +553,13 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> > >   		if (interval || timeout) {
> > >   			while (!waitpid(child_pid, &status, WNOHANG)) {
> > > +				if (!is_target_alive(&target,
> > > +					evsel_list->threads) &&
> > > +					(child_pid != -1)) {
> > 
> > do we need that child_pid check? we just returned from waitpid
> > so we should be ok.. we just make the race window smaller
> > 
> > could we just do:
> > 
> > 				if (!is_target_alive(&target, evsel_list->threads)) {
> > 					kill(child_pid, SIGTERM);
> > 					break;
> > 				}
> > 
> 
> I think this code should be OK and I have tested yet. I have a question
> about the race condition, we really don't need a lock to protect the
> child_pid?
> 
> skip_signal()
> {
> 	/*
> 	 * render child_pid harmless
> 	 * won't send SIGTERM to a random
> 	 * process in case of race condition
> 	 * and fast PID recycling
> 	 */
> 	child_pid = -1;
> }
> 
> __run_perf_stat()
> {
> 	....
> 	kill(child_pid, SIGTERM);
> }
> 
> If child_pid is set by -1 in a small window between checking of child_pid
> and kill(), then kill(-1, SIGTERM) may happen. All processes except the kill
> process itself and init would receive SIGTERM.

ah right, -1 is special.. however that can still happen also
in the orginal patch.. how about we do something like below

jirka


---
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index acfd48db52dd..c322cb271180 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -583,6 +583,14 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 		if (interval || timeout) {
 			while (!waitpid(child_pid, &status, WNOHANG)) {
+				if (!is_target_alive(&target, evsel_list->threads)) {
+					int pid = child_pid;
+
+					if (pid != -1)
+						kill(pid, SIGTERM);
+					break;
+				}
+
 				nanosleep(&ts, NULL);
 				if (timeout)
 					break;
