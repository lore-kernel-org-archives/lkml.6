Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554AAC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAAA320671
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 20:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAA320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbeGZVX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 17:23:57 -0400
Received: from smtprelay0105.hostedemail.com ([216.40.44.105]:43515 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730285AbeGZVX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 17:23:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id E6AEE100E806B;
        Thu, 26 Jul 2018 20:05:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sink74_4d3b098418a54
X-Filterd-Recvd-Size: 4088
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Jul 2018 20:05:30 +0000 (UTC)
Message-ID: <00bf258587510ee96a27918293bd4d75622512c6.camel@perches.com>
Subject: Re: [RFC PATCH] checkpatch: check for function calls with struct or
 union on stack
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 26 Jul 2018 13:05:29 -0700
In-Reply-To: <20180726122807.fad0566951e36d930edb6874@linux-foundation.org>
References: <1236369d28b2f1f5389ff652c4eb89e699e6481e.camel@perches.com>
         <20180726122533.104f6eea950853ef50ebc680@linux-foundation.org>
         <20180726122807.fad0566951e36d930edb6874@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-07-26 at 12:28 -0700, Andrew Morton wrote:
> On Thu, 26 Jul 2018 12:25:33 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > I'll give it a spin, see how noisy it is.
> 
> Actually, I would prefer if the message, changelog and title
> used the term "passed by value".  It's a more familiar term
> and it is possible for a passed-by-value aggregate to in fact 
> be passed in registers.

RFC, No worries, I'll change it if it's OK.

I'm testing it right now against the last 5000 commits
(which takes awhile here) via

$ git log --no-merges --format=oneline -5000 | \
  cut -f1 -d" " | \
  while read commit ; do \
    echo $commit; \
    ./scripts/checkpatch.pl --git $commit --types=aggregate_on_stack --quiet --no-summary ; \
  done

It doesn't seem noisy at all, but maybe there are a few
known structs like "struct timespec64" that could be
excluded.

The only real hits so far are:

commit f2fb56afba11426ee5c9603b28a9827c530909c0
WARNING: Unusual use of 'struct msm_display_topology' on stack
#28374: FILE: drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:149:
+enum dpu_rm_topology_name
+dpu_rm_get_topology_name(struct msm_display_topology topology)
+{

WARNING: Unusual use of 'struct msm_display_topology' on stack
#29021: FILE: drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:796:
+static int _dpu_rm_populate_requirements(
+		struct dpu_rm *rm,
+		struct drm_encoder *enc,
+		struct drm_crtc_state *crtc_state,
+		struct drm_connector_state *conn_state,
+		struct dpu_rm_requirements *reqs,
+		struct msm_display_topology req_topology)
+{

WARNING: Unusual use of 'struct msm_display_topology' on stack
#29203: FILE: drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c:978:
+int dpu_rm_reserve(
+		struct dpu_rm *rm,
+		struct drm_encoder *enc,
+		struct drm_crtc_state *crtc_state,
+		struct drm_connector_state *conn_state,
+		struct msm_display_topology topology,
+		bool test_only)
+{

WARNING: Unusual use of 'struct msm_display_topology' on stack
#29443: FILE: drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h:133:
+int dpu_rm_reserve(struct dpu_rm *rm,
+		struct drm_encoder *drm_enc,
+		struct drm_crtc_state *crtc_state,
+		struct drm_connector_state *conn_state,
+		struct msm_display_topology topology,
+		bool test_only);

WARNING: Unusual use of 'struct msm_display_topology' on stack
#29506: FILE: drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h:196:
+enum dpu_rm_topology_name
+dpu_rm_get_topology_name(struct msm_display_topology topology);

and

33477d84c26bbfa626da2c032e567a90dd70a528
WARNING: Unusual use of 'struct cppc_perf_fb_ctrs' on stack
#45: FILE: drivers/cpufreq/cppc_cpufreq.c:307:
+static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+{

WARNING: Unusual use of 'struct cppc_perf_fb_ctrs' on stack
#45: FILE: drivers/cpufreq/cppc_cpufreq.c:307:
+static int cppc_get_rate_from_fbctrs(struct cppc_cpudata *cpu,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t0,
+				     struct cppc_perf_fb_ctrs fb_ctrs_t1)
+{

