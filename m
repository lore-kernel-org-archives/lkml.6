Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C17BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7A52133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV1K12ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7A52133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbeK0Xdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:33:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729417AbeK0Xdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:33:46 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA54E2146D;
        Tue, 27 Nov 2018 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543322158;
        bh=CynnjIUZpT7n9I0BqKXdUfByPT/CiCJoaataWnDD/yI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hV1K12ieRn1wXRKD/N3GOiJzhpcqdX1GMqp5kGp4u3CcG+FRXMY4fZF3zJsOfbrBW
         CWrQ5YsqaGxvKpM6PuJdQAiZrW9dpR7bNEgvqPRZQji9K13apintV6EA3Zs37FRnSf
         dzbUuVB3qvvwmW8eH+v0tU/mG6Ax9PmU1tTyUFZQ=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id 4A9734111A; Mon, 26 Nov 2018 16:41:45 -0300 (-03)
Date:   Mon, 26 Nov 2018 16:41:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH 1/5] perf tools: Add fallback functions for cases where
 cpumode is insufficient
Message-ID: <20181126194145.GE18491@kernel.org>
References: <20181031091043.23465-1-adrian.hunter@intel.com>
 <20181031091043.23465-2-adrian.hunter@intel.com>
 <20181105172946.GH11147@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C313381@IRSMSX106.ger.corp.intel.com>
 <20181105193615.GG7077@kernel.org>
 <363DA0ED52042842948283D2FC38E4649C3133B4@IRSMSX106.ger.corp.intel.com>
 <20181126190217.GC18491@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126190217.GC18491@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 26, 2018 at 04:02:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Nov 05, 2018 at 07:53:17PM +0000, Hunter, Adrian escreveu:
> > > From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
> > > Em Mon, Nov 05, 2018 at 07:21:44PM +0000, Hunter, Adrian escreveu:
> > > > > > +static bool machine__single_ku_as(struct machine *machine) {
> > > > > > +	return strcmp(perf_env__arch(machine->env), "sparc"); }

> > > > > Can we avoid having this strcmp be done repeatedly?

> > > > It is only done if there are mapping errors

> > > > > Can we avoid having this strcmp be done repeatedly? I.e. just
> > > > > make this a boolean initialized at session start, when
> > > > > machine->env is setup, so we'd have:

> > > > >    machine->single_address_space

> > > > > Instead of a function?

> > > > Sure  thing.
> 
> Have you sent an update to this patch series addressing the concerns? I
> think that renaming that _fb to __fallback and having this
> machine->single_address_space is what is missing, I'll try to take a
> stab at this now and have it in my perf/core branch soon.
 
> But you have this already done, please send it.

So, here is the patch on top of yours and at the end a patch that I'm
inserting just before yours, please check and ack, thanks:

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index da523d99be4b..4506aa7fa557 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2592,25 +2592,13 @@ int machine__get_kernel_start(struct machine *machine)
 	return err;
 }
 
-/*
- * machine__single_ku_as - Machine has same address space for kernel and user.
- * @machine: machine object
- *
- * Some architectures have a single address space for kernel and user addresses,
- * which makes it possible to determine if an address is in kernel space or user
- * space.
- */
-static bool machine__single_ku_as(struct machine *machine)
-{
-	return strcmp(perf_env__arch(machine->env), "sparc");
-}
 
 u8 machine__addr_cpumode(struct machine *machine, u8 cpumode, u64 addr)
 {
 	u8 addr_cpumode = cpumode;
 	bool kernel_ip;
 
-	if (!machine__single_ku_as(machine))
+	if (!machine->env->single_address_space)
 		goto out;
 
 	kernel_ip = machine__kernel_ip(machine, addr);


commit 5aabc18da787f7f6785b4027c63a89592e4e2c03
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Mon Nov 26 16:25:25 2018 -0300

    perf env: Record if a arch has a single user/kernel address space
    
    Some architectures have a single address space for kernel and user
    addresses, which makes it possible to determine if an address is in
    kernel space or user space. Some don't, e.g.: sparc.
    
    Cache that info in perf_env so that, for instance, code needing to
    fallback failed symbol lookups at the kernel space in single address
    space arches can lookup at userspace.
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: David Ahern <dsahern@gmail.com>
    Cc: David Miller <davem@davemloft.net>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Leo Yan <leo.yan@linaro.org>
    Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Wang Nan <wangnan0@huawei.com>
    Link: https://lkml.kernel.org/n/tip-4jb2rusqml7utgebiaf51k77@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 59f38c7693f8..d1cae06a2dfc 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -8,6 +8,16 @@
 
 struct perf_env perf_env;
 
+/*
+ * Some architectures have a single address space for kernel and user
+ * addresses, which makes it possible to determine if an address is in kernel
+ * space or user space. Some don't, e.g.: sparc
+ */
+void perf_env__init_single_address_space(struct perf_env *env)
+{
+	env->single_address_space = strcmp(perf_env__arch(env), "sparc");
+}
+
 void perf_env__exit(struct perf_env *env)
 {
 	int i;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index d01b8355f4ca..a79898f6417d 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -60,6 +60,12 @@ struct perf_env {
 	struct cpu_topology_map	*cpu;
 	struct cpu_cache_level	*caches;
 	int			 caches_cnt;
+	/*
+         * Some architectures have a single address space for kernel and user
+         * addresses, which makes it possible to determine if an address is in
+         * kernel space or user space. Some don't, e.g.: sparc
+         */
+	bool			single_address_space;
 	struct numa_node	*numa_nodes;
 	struct memory_node	*memory_nodes;
 	unsigned long long	 memory_bsize;
@@ -72,6 +78,8 @@ void perf_env__exit(struct perf_env *env);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
+void perf_env__init_single_address_space(struct perf_env *env);
+
 int perf_env__read_cpu_topology_map(struct perf_env *env);
 
 void cpu_cache_level__free(struct cpu_cache_level *cache);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7d2c8ce6cfad..164d56229135 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -150,6 +150,8 @@ struct perf_session *perf_session__new(struct perf_data *data,
 		session->machines.host.env = &perf_env;
 	}
 
+	perf_env__init_single_address_space(session->machines.host.env);
+
 	if (!data || perf_data__is_write(data)) {
 		/*
 		 * In O_RDONLY mode this will be performed when reading the
