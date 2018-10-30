Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF80C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0E720840
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:05:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0E720840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbeJaD7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:59:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58774 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbeJaD7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:59:49 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 297B1140C2541;
        Tue, 30 Oct 2018 12:05:06 -0700 (PDT)
Date:   Tue, 30 Oct 2018 12:05:05 -0700 (PDT)
Message-Id: <20181030.120505.464794090075003498.davem@davemloft.net>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, wangnan0@huawei.com,
        jolsa@kernel.org, namhyung@kernel.org, kan.liang@intel.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCHES/RFC] Re: A concern about overflow ring buffer mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <0247fca0-5a94-9a83-cefa-282804316729@linux.intel.com>
References: <4f84468f-37d9-cf1b-12c1-514ef74b6a48@linux.intel.com>
        <20181029130331.GC21857@kernel.org>
        <0247fca0-5a94-9a83-cefa-282804316729@linux.intel.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Oct 2018 12:05:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liang, Kan" <kan.liang@linux.intel.com>
Date: Mon, 29 Oct 2018 10:33:06 -0400

> The problem is that users have to wait tens of minutes to see perf
> top results on the screen in KNL. Before that, there is nothing but
> a black screen.

I'm actually curious why so I started digging last night.

First, I made perf top exit when it is done synthesizing existing
threads and profiled this during a full workload.

It takes about 3 seconds on this 128 cpu sparc64 system.

Some curious things in there, first of all we spend a lot of time
looking for the hugetlbfs mount point.

And sure enough the FS ABI code keeps reparsing the entire
/proc/mounts file every time hugetlbfs__mountpoint() is called.  It's
logic is that if the mountpoint wasn't found on a previous call it
rechecks everything.  For perf's usage, this is unnecessary overhead.

Simply mounting hugetlbfs gave me half a second back in startup time,
so I was down to 2.5 seconds from 3 seconds already.

Next I found that perf execution time during thread synthesis is
dominated by sscanf() processing.  So I went into the history books
and found that back in the 3.x days we parsed the file by hand, so I
brought that code back and extended it for what mmap2 events need.

That patch is at the end of this email, ignore the XXX bits as I was
too lazy to remove all of the mmap timeout code but I am absolutely
certain that is the right thing to do.

This gave me another half second or so back, and startup to this end
of thread synthesization is now less than 2 seconds for this workload.

Next, I let the perf top startup continue up until right before the
display thread is started.  This takes a minute or more total, and is
dominated by:

 time   seconds   seconds    calls   s/call   s/call  name
 28.30     12.70    12.70  1927341     0.00     0.00  __hists__add_entry
 12.77     18.43     5.73 27844359     0.00     0.00  sort__dso_cmp
 10.21     23.01     4.58 23074107     0.00     0.00  sort__sym_cmp
  8.29     26.73     3.72  1050281     0.00     0.00  dso__find_symbol
  4.95     28.95     2.22 106607184     0.00     0.00  perf_hpp__is_dynamic_entry

The histogram code is _insanely_ expensive and the algorithmic
complexity is quite high.  It does rbtree walks, doing a dso
comparison and then a symbol comparison at each and every step in the
walk.  The symbol comparison is a full blown strcmp() and the
histogram table in this situation is huge.

This is where the real problems are, not in the simple mmap processing
and other places where we've put timouts and other hacks that really
don't try to address the fundamental problems perf has in these
situations.

Thanks.

diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index bc64618..70597fd 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -317,6 +318,30 @@ static int perf_event__synthesize_fork(struct perf_tool *tool,
 	return 0;
 }
 
+static int dec(char ch)
+{
+	if ((ch >= '0') && (ch <= '9'))
+		return ch - '0';
+	return -1;
+}
+
+static int dec2u64(const char *ptr, u64 *long_val)
+{
+	const char *p = ptr;
+
+	*long_val = 0;
+	while (*p) {
+		const int dec_val = dec(*p);
+
+		if (dec_val < 0)
+			break;
+
+		*long_val = (*long_val * 10) + dec_val;
+		p++;
+	}
+	return p - ptr;
+}
+
 int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 				       union perf_event *event,
 				       pid_t pid, pid_t tgid,
@@ -327,13 +352,12 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 {
 	char filename[PATH_MAX];
 	FILE *fp;
-	unsigned long long t;
-	bool truncation = false;
-	unsigned long long timeout = proc_map_timeout * 1000000ULL;
 	int rc = 0;
 	const char *hugetlbfs_mnt = hugetlbfs__mountpoint();
 	int hugetlbfs_mnt_len = hugetlbfs_mnt ? strlen(hugetlbfs_mnt) : 0;
 
+	(void) proc_map_timeout; /* XXX */
+
 	if (machine__is_default_guest(machine))
 		return 0;
 
@@ -350,87 +374,99 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 	}
 
 	event->header.type = PERF_RECORD_MMAP2;
-	t = rdclock();
 
 	while (1) {
-		char bf[BUFSIZ];
-		char prot[5];
-		char execname[PATH_MAX];
+		char bf[BUFSIZ], *pbf = bf;
 		char anonstr[] = "//anon";
-		unsigned int ino;
+		char *execname;
 		size_t size;
 		ssize_t n;
+		u64 tmp;
 
 		if (fgets(bf, sizeof(bf), fp) == NULL)
 			break;
 
-		if ((rdclock() - t) > timeout) {
-			pr_warning("Reading %s time out. "
-				   "You may want to increase "
-				   "the time limit by --proc-map-timeout\n",
-				   filename);
-			truncation = true;
-			goto out;
-		}
-
-		/* ensure null termination since stack will be reused. */
-		strcpy(execname, "");
-
 		/* 00400000-0040c000 r-xp 00000000 fd:01 41038  /bin/cat */
-		n = sscanf(bf, "%"PRIx64"-%"PRIx64" %s %"PRIx64" %x:%x %u %[^\n]\n",
-		       &event->mmap2.start, &event->mmap2.len, prot,
-		       &event->mmap2.pgoff, &event->mmap2.maj,
-		       &event->mmap2.min,
-		       &ino, execname);
-
-		/*
- 		 * Anon maps don't have the execname.
- 		 */
-		if (n < 7)
+		n = hex2u64(pbf, &event->mmap2.start);
+		if (n < 0)
 			continue;
-
-		event->mmap2.ino = (u64)ino;
-
-		/*
-		 * Just like the kernel, see __perf_event_mmap in kernel/perf_event.c
-		 */
-		if (machine__is_host(machine))
-			event->header.misc = PERF_RECORD_MISC_USER;
-		else
-			event->header.misc = PERF_RECORD_MISC_GUEST_USER;
+		pbf += n + 1;
+		n = hex2u64(pbf, &event->mmap2.len);
+		if (n < 0)
+			continue;
+		pbf += n + 1;
 
 		/* map protection and flags bits */
 		event->mmap2.prot = 0;
 		event->mmap2.flags = 0;
-		if (prot[0] == 'r')
+		if (pbf[0] == 'r')
 			event->mmap2.prot |= PROT_READ;
-		if (prot[1] == 'w')
+		if (pbf[1] == 'w')
 			event->mmap2.prot |= PROT_WRITE;
-		if (prot[2] == 'x')
+		if (pbf[2] == 'x')
 			event->mmap2.prot |= PROT_EXEC;
 
-		if (prot[3] == 's')
+		if (pbf[3] == 's')
 			event->mmap2.flags |= MAP_SHARED;
 		else
 			event->mmap2.flags |= MAP_PRIVATE;
 
-		if (prot[2] != 'x') {
-			if (!mmap_data || prot[0] != 'r')
+		if (pbf[2] != 'x') {
+			if (!mmap_data || pbf[0] != 'r')
 				continue;
 
 			event->header.misc |= PERF_RECORD_MISC_MMAP_DATA;
 		}
 
-out:
-		if (truncation)
-			event->header.misc |= PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT;
+		pbf += 5;
+		n = hex2u64(pbf, &event->mmap2.pgoff);
+		if (n < 0)
+			continue;
+		pbf += n + 1;
+
+		n = hex2u64(pbf, &tmp);
+		if (n < 0)
+			continue;
+		event->mmap2.maj = tmp;
+		pbf += n + 1;
+
+		n = hex2u64(pbf, &tmp);
+		if (n < 0)
+			continue;
+		event->mmap2.min = tmp;
+		pbf += n + 1;
 
-		if (!strcmp(execname, ""))
-			strcpy(execname, anonstr);
+		n = dec2u64(pbf, &event->mmap2.ino);
+		if (n < 0)
+			continue;
+		pbf += n;
+
+		execname = strchr(pbf, '/');
+		if (!execname)
+			execname = strchr(pbf, '[');
+
+		/*
+		 * Anon map, skip.
+		 */
+		if (!execname)
+			continue;
+
+		pbf = strchr(execname, '\n');
+		if (!pbf)
+			continue;
+		*pbf = '\0';
+
+		/*
+		 * Just like the kernel, see __perf_event_mmap in kernel/perf_event.c
+		 */
+		if (machine__is_host(machine))
+			event->header.misc = PERF_RECORD_MISC_USER;
+		else
+			event->header.misc = PERF_RECORD_MISC_GUEST_USER;
 
 		if (hugetlbfs_mnt_len &&
 		    !strncmp(execname, hugetlbfs_mnt, hugetlbfs_mnt_len)) {
-			strcpy(execname, anonstr);
+			execname = anonstr;
 			event->mmap2.flags |= MAP_HUGETLB;
 		}
 
@@ -449,9 +485,6 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
 			rc = -1;
 			break;
 		}
-
-		if (truncation)
-			break;
 	}
 
 	fclose(fp);
