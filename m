Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1074C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D6E8213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WApThJJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6E8213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbeK1Bn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:43:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:36098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbeK1Bn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:43:58 -0500
Received: from quaco.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEE6D21104;
        Tue, 27 Nov 2018 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543329949;
        bh=X6x56D+vlszlWYO7Ff7W+ANaSTJL/n/+0iR0Ps7WMoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WApThJJPNdpLH2Xvk/mJrIeAbqqp2xSqBLu+/alx4ohsW/VnpICH///aCGYUSWzKK
         OhjsR6mtS0a6FKA/8o8t3zkldWJRNfNeVGhfB575c/5x3WyDajVW/YEWKGB8ltJQl5
         kKG01DtA4CYgwmap79F8MA8O4tvYpjRAg//77dfo=
Received: by quaco.infradead.org (Postfix, from userid 1000)
        id A31AF41114; Tue, 27 Nov 2018 11:45:44 -0300 (-03)
Date:   Tue, 27 Nov 2018 11:45:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH V2 1/3] perf tools: Add fallback functions for cases
 where cpumode is insufficient
Message-ID: <20181127144544.GG15747@kernel.org>
References: <20181106210712.12098-1-adrian.hunter@intel.com>
 <20181106210712.12098-2-adrian.hunter@intel.com>
 <20181127141036.GF15747@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127141036.GF15747@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 27, 2018 at 11:10:36AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Nov 06, 2018 at 11:07:10PM +0200, Adrian Hunter escreveu:
> > For branch stacks or branch samples, the sample cpumode might not be
> > correct because it applies only to the sample 'ip' and not necessary to
> > 'addr' or branch stack addresses. Add fallback functions that can be used
> > to deal with those cases
> 
> I've split this into two, and the first is causing this:
> 
> root@quaco ~]# perf top
> perf: Segmentation fault
> -------- backtrace --------
> perf[0x59baca]
> /lib64/libc.so.6(+0x385bf)[0x7fa2775dc5bf]
> perf(perf_env__arch+0x34)[0x4b4514]
> perf(perf_env__single_address_space+0x1b)[0x57944b]
> perf(perf_session__new+0x17c)[0x4fdb3c]
> perf(cmd_top+0x162c)[0x45109c]
> perf[0x4a621e]
> perf(main+0x61c)[0x42cbfc]
> /lib64/libc.so.6(__libc_start_main+0xf2)[0x7fa2775c8412]
> perf(_start+0x2d)[0x42ce2d]
> [root@quaco ~]#
> 
> Its the case where the env info comes from the running machine, via
> uname(), I'm working on a fix.

So I'll graft this just before your patch.

- Arnaldo

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 59f38c7693f8..4c23779e271a 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -166,7 +166,7 @@ const char *perf_env__arch(struct perf_env *env)
 	struct utsname uts;
 	char *arch_name;
 
-	if (!env) { /* Assume local operation */
+	if (!env || !env->arch) { /* Assume local operation */
 		if (uname(&uts) < 0)
 			return NULL;
 		arch_name = uts.machine;
