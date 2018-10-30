Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B4DC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7907F20823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1+csxoJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7907F20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbeJaAkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:40:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbeJaAkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:40:01 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E76C2075D;
        Tue, 30 Oct 2018 15:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540914361;
        bh=DMI+mSbPqcMaQ969uXQVoOY12d/BWqdimfujq818P58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1+csxoJLjYkHapcy4k1ylWBjohOc13+h3Y51f/ZH+47Hp4/nhVRJRAEI0ViSo7g4D
         oV8Evx9altWSL/tVNhXIv9B12J0ColCli2ssIe7eoG8Unb022KCak/FBz7TaJ9xjfQ
         8PvMxd9XRIXKWMnuGJBaGFYh9uoyp6odKwcH0Kr4=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id A0B0A142C5F; Tue, 30 Oct 2018 12:45:52 -0300 (-03)
Date:   Tue, 30 Oct 2018 12:45:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     leo.yan@linaro.org, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Miller <davem@davemloft.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH] perf cs-etm: Correct CPU mode for samples
Message-ID: <20181030154552.GH23310@kernel.org>
References: <1540883908-17018-1-git-send-email-leo.yan@linaro.org>
 <20181030143226.GA23310@kernel.org>
 <20181030150449.GB8344@leoy-ThinkPad-X240s>
 <20181030151137.GF23310@kernel.org>
 <b00357d2-10ab-e75e-6748-13341641f107@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b00357d2-10ab-e75e-6748-13341641f107@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Oct 30, 2018 at 05:30:55PM +0200, Adrian Hunter escreveu:
> On 30/10/18 5:11 PM, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Oct 30, 2018 at 11:04:49PM +0800, leo.yan@linaro.org escreveu:
> >> Hi Arnaldo,
> >>
> >> On Tue, Oct 30, 2018 at 11:32:26AM -0300, Arnaldo Carvalho de Melo wrote:
> >>> Em Tue, Oct 30, 2018 at 03:18:28PM +0800, Leo Yan escreveu:
> >>>> Since commit 9042f5e3539e ("perf tools: Stop fallbacking to kallsyms
> >>>> for vdso symbols lookup"), the kernel address cannot be properly parsed
> >>>> to kernel symbol with command 'perf script -k vmlinux'.  The reason is
> >>>> CoreSight samples is always to set CPU mode as PERF_RECORD_MISC_USER,
> >>>> thus it fails to find corresponding map/dso in below flows:
> >>>>
> >>>>   process_sample_event()
> >>>>     `-> machine__resolve()
> >>>> 	  `-> thread__find_map(thread, sample->cpumode, sample->ip, al);
> >>>>
> >>>> In this flow it needs to pass argument 'sample->cpumode' to tell what's
> >>>> the CPU mode, before it always passed PERF_RECORD_MISC_USER but without
> >>>> any failure until the commit 9042f5e3539e ("perf tools: Stop fallbacking
> >>>> to kallsyms for vdso symbols lookup") has been merged.  The reason is
> >>>> even with the wrong CPU mode the function thread__find_map() firstly
> >>>> fails to find map but it will rollback to find kernel map for vdso
> >>>> symbols lookup.  In the latest code it has removed the fallback code,
> >>>> thus if CPU mode is PERF_RECORD_MISC_USER then it cannot find map
> >>>> anymore with kernel address.
> >>>>
> >>>> This patch is to correct samples CPU mode setting, it creates a new
> >>>> helper function cs_etm__cpu_mode() to tell what's the CPU mode based on
> >>>> the address with the info from machine structure; this patch has a bit
> >>>> extension to check not only kernel and user mode, but also check for
> >>>> host/guest and hypervisor mode.  Finally this patch uses the function
> >>>> in instruction and branch samples and also apply in cs_etm__mem_access()
> >>>> for a minor polishing.
> >>>
> >>> Mathieu, can I have your Acked-by, please? Leo, thanks for acting so
> >>> quickly on this one! 
> >>
> >> Thanks for reivewing.  Yeah, let's wait for Mathieu reviewing as well,
> >> as I know he is travelling so might be delay a bit.
> > 
> > I'm tentatively applying the patch, as this needs fixing ASAP, and I
> > take that you have tested it and it cured the problem for you, so should
> > be a good indication for the acceptance of the patch.
> > 
> > We can always fix some detail later.
> >  
> >> Just remind, we might need the similiar change for util/intel-pt.c and
> >> util/intel-bts.c when generate samples, otherwise they might have the
> >> same regression for kernel symbols.  I am not the best person to change
> >> these two files, but bring up this for attention.
 
> > Right, I think Adrian is working on it, Adrian?
 
> Yes although I am more concerned with branches from user space to kernel
> space and vice versa, which this patch doesn't deal with.  Also there are
> many cpumode issues in perf tools, and really the only way to deal with
> them simply at the moment is to put back the fallback for arches other
> than sparc i.e.

We can do that, sure, but the opportunity to fix at least some of those
problems and then make this fallback not to take place looks reasonable,
for instance, I have this patch now in my local tree, from David, that
posted just as a way to show part of the problem, parts of the commit
message I wrote, parts are from David:

commit 54ac9007e6cb77c37ebf4f5e3debb23075cc90f0
Author: David S. Miller <davem@davemloft.net>
Date:   Tue Oct 30 12:12:26 2018 -0300

    perf callchain: Honour the ordering of PERF_CONTEXT_{USER,KERNEL,etc}
    
    When processing using 'perf report -g caller', which is the default, we
    ended up reverting the callchain entries received from the kernel, but
    simply reverting trows away the information that tells that from a point
    onwards the addresses are for userspace, kernel, guest kernel, guest
    user, hypervisor.
    
    The idea is that if we are walking backwards, for each cluster of
    non-cpumode entries we have to first scan backwards for the next one and
    use that for the cluster.
    
    This seems silly and more expensive than it needs to be but it is enough
    for a initial fix.
    
    The code here is really complicated because it is intimately intertwined
    with the lbr and branch handling, as well as this callchain order,
    further fixes will be needed to properly take into account the cpumode
    in those cases.
    
    Another problem with ORDER_CALLER is that the NULL "0" IP that is at the
    end of most callchains shows up at the top of the histogram because
    every callchain contains it and with ORDER_CALLER it is the first entry.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Souvik Banerjee <souvik1997@gmail.com>
    Cc: Wang Nan <wangnan0@huawei.com>
    Cc: stable@vger.kernel.org # 4.19
    Link: https://lkml.kernel.org/n/tip-2wt3ayp6j2y2f2xowixa8y6y@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 111ae858cbcb..8ee8ab39d8ac 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2140,6 +2140,27 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	return 0;
 }
 
+static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
+			     struct callchain_cursor *cursor,
+			     struct symbol **parent,
+			     struct addr_location *root_al,
+			     u8 *cpumode, int ent)
+{
+	int err = 0;
+
+	while (--ent >= 0) {
+		u64 ip = chain->ips[ent];
+
+		if (ip >= PERF_CONTEXT_MAX) {
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al, cpumode, ip,
+					       false, NULL, NULL, 0);
+			break;
+		}
+	}
+	return err;
+}
+
 static int thread__resolve_callchain_sample(struct thread *thread,
 					    struct callchain_cursor *cursor,
 					    struct perf_evsel *evsel,
@@ -2246,6 +2267,12 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	}
 
 check_calls:
+	if (callchain_param.order != ORDER_CALLEE) {
+		err = find_prev_cpumode(chain, thread, cursor, parent, root_al,
+					&cpumode, chain->nr - first_call);
+		if (err)
+			return (err < 0) ? err : 0;
+	}
 	for (i = first_call, nr_entries = 0;
 	     i < chain_nr && nr_entries < max_stack; i++) {
 		u64 ip;
@@ -2260,9 +2287,15 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 			continue;
 #endif
 		ip = chain->ips[j];
-
 		if (ip < PERF_CONTEXT_MAX)
                        ++nr_entries;
+		else if (callchain_param.order != ORDER_CALLEE) {
+			err = find_prev_cpumode(chain, thread, cursor, parent,
+						root_al, &cpumode, j);
+			if (err)
+				return (err < 0) ? err : 0;
+			continue;
+		}
 
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
