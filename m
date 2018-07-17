Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD197ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6833820C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 09:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6833820C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbeGQJe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 05:34:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728340AbeGQJe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 05:34:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACDBD402312B;
        Tue, 17 Jul 2018 09:02:49 +0000 (UTC)
Received: from krava (ovpn-204-223.brq.redhat.com [10.40.204.223])
        by smtp.corp.redhat.com (Postfix) with SMTP id 027022026D68;
        Tue, 17 Jul 2018 09:02:45 +0000 (UTC)
Date:   Tue, 17 Jul 2018 11:02:45 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com
Subject: Re: [PATCH 1/4] perf tools: Fix struct comm_str removal crash
Message-ID: <20180717090245.GB8631@krava>
References: <20180712142023.16915-1-jolsa@kernel.org>
 <20180712142023.16915-2-jolsa@kernel.org>
 <20180715130827.GA5071@danjae.aot.lge.com>
 <20180716102934.GA14153@krava>
 <20180717014940.GA9295@sejong>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717014940.GA9295@sejong>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 17 Jul 2018 09:02:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Tue, 17 Jul 2018 09:02:49 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 10:49:40AM +0900, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Mon, Jul 16, 2018 at 12:29:34PM +0200, Jiri Olsa wrote:
> > On Sun, Jul 15, 2018 at 10:08:27PM +0900, Namhyung Kim wrote:
> > 
> > SNIP
> > 
> > > > Because thread 2 first decrements the refcnt and only after then it
> > > > removes the struct comm_str from the list, the thread 1 can find this
> > > > object on the list with refcnt equls to 0 and hit the assert.
> > > > 
> > > > This patch fixes the thread 2 path, by removing the struct comm_str
> > > > FIRST from the list and only AFTER calling comm_str__put on it. This
> > > > way the thread 1 finds only valid objects on the list.
> > > 
> > > I'm not sure we can unconditionally remove the comm_str from the tree.
> > > It should be removed only if refcount is going to zero IMHO.
> > > Otherwise it could end up having multiple comm_str entry for a same
> > > name.
> > 
> > right, but it wouldn't crash ;-)
> > 
> > how about attached change, that actualy deals with the refcnt
> > race I'm running the tests now, seems ok so far
> 
> I think we can keep if the refcount is back to non-zero.  What about this?
> (not tested..)
> 
> 
> static struct comm_str *comm_str__get(cs)
> {
>     if (cs)
>         refcount_inc_no_warn(&cs->refcnt);  // should be added
>     return cs;
> }
> 
> static void comm_str__put(cs)
> {
>     if (cs && refcount_dec_and_test(&cs->refcnt)) {
>         down_write(&comm_str_lock);
>         /* might race with comm_str__findnew() */
>         if (!refcount_read(&cs->refcnt)) {
>             rb_erase(&cs->rb_node, &comm_str_root);
>             zfree(&cs->str);
>             free(cs);
>         }
>         up_write(&comm_str_lock);
>     }
> }

yea, it's more possitive than my patch
I'm testing attached patch, looks good so far

thanks,
jirka


---
diff --git a/tools/include/linux/refcount.h b/tools/include/linux/refcount.h
index 36cb29bc57c2..11e2be6f68a0 100644
--- a/tools/include/linux/refcount.h
+++ b/tools/include/linux/refcount.h
@@ -109,6 +109,14 @@ static inline void refcount_inc(refcount_t *r)
 	REFCOUNT_WARN(!refcount_inc_not_zero(r), "refcount_t: increment on 0; use-after-free.\n");
 }
 
+/*
+ * Pure refs increase without any chec/warn.
+ */
+static inline void refcount_inc_no_warn(refcount_t *r)
+{
+	atomic_inc(&r->refs);
+}
+
 /*
  * Similar to atomic_dec_and_test(), it will WARN on underflow and fail to
  * decrement when saturated at UINT_MAX.
diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 7798a2cc8a86..a2e338cf29d7 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -21,7 +21,7 @@ static struct rw_semaphore comm_str_lock = {.lock = PTHREAD_RWLOCK_INITIALIZER,}
 static struct comm_str *comm_str__get(struct comm_str *cs)
 {
 	if (cs)
-		refcount_inc(&cs->refcnt);
+		refcount_inc_no_warn(&cs->refcnt);
 	return cs;
 }
 
@@ -29,10 +29,12 @@ static void comm_str__put(struct comm_str *cs)
 {
 	if (cs && refcount_dec_and_test(&cs->refcnt)) {
 		down_write(&comm_str_lock);
-		rb_erase(&cs->rb_node, &comm_str_root);
+		if (refcount_read(&cs->refcnt) == 0) {
+			rb_erase(&cs->rb_node, &comm_str_root);
+			zfree(&cs->str);
+			free(cs);
+		}
 		up_write(&comm_str_lock);
-		zfree(&cs->str);
-		free(cs);
 	}
 }
 
