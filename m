Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A971C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF0E20883
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AF0E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbeKQIJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 03:09:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:38466 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeKQIJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 03:09:37 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 13:55:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,241,1539673200"; 
   d="scan'208";a="250366881"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 16 Nov 2018 13:55:27 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1gNm5H-000E38-02; Sat, 17 Nov 2018 05:55:27 +0800
Date:   Sat, 17 Nov 2018 05:55:00 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Matt Mullins <mmullins@fb.com>
Cc:     kbuild-all@01.org, ast@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, kernel-team@fb.com,
        Matt Mullins <mmullins@fb.com>, Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: support raw tracepoints in modules
Message-ID: <201811170557.4EtvwhsA%fengguang.wu@intel.com>
References: <20181109220632.3944136-1-mmullins@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109220632.3944136-1-mmullins@fb.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Matt-Mullins/bpf-support-raw-tracepoints-in-modules/20181110-144839
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master

smatch warnings:
kernel/trace/bpf_trace.c:1284 bpf_event_notify() error: potential null dereference 'btm'.  (kzalloc returns null)

vim +/btm +1284 kernel/trace/bpf_trace.c

  1269	
  1270	#ifdef CONFIG_MODULES
  1271	int bpf_event_notify(struct notifier_block *nb, unsigned long op, void *module)
  1272	{
  1273		struct bpf_trace_module *btm, *tmp;
  1274		struct module *mod = module;
  1275	
  1276		if (mod->num_bpf_raw_events == 0)
  1277			return 0;
  1278	
  1279		mutex_lock(&bpf_module_mutex);
  1280	
  1281		switch (op) {
  1282		case MODULE_STATE_COMING:
  1283			btm = kzalloc(sizeof(*btm), GFP_KERNEL);
> 1284			btm->module = module;
  1285			list_add(&btm->list, &bpf_trace_modules);
  1286			break;
  1287		case MODULE_STATE_GOING:
  1288			list_for_each_entry_safe(btm, tmp, &bpf_trace_modules, list) {
  1289				if (btm->module == module) {
  1290					list_del(&btm->list);
  1291					kfree(btm);
  1292					break;
  1293				}
  1294			}
  1295			break;
  1296		}
  1297	
  1298		mutex_unlock(&bpf_module_mutex);
  1299	
  1300		return 0;
  1301	}
  1302	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
