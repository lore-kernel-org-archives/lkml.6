Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555B5ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2972B20831
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 18:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2972B20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeJYC6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 22:58:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:13827 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbeJYC6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 22:58:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 11:28:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,421,1534834800"; 
   d="scan'208";a="100372709"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by fmsmga004.fm.intel.com with ESMTP; 24 Oct 2018 11:28:54 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 7CFC730137B; Wed, 24 Oct 2018 11:28:54 -0700 (PDT)
Date:   Wed, 24 Oct 2018 11:28:54 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/2] perf: Add munmap callback
Message-ID: <20181024182854.GH6218@tassilo.jf.intel.com>
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
 <20181024162334.GG6218@tassilo.jf.intel.com>
 <20181024163208.GC15106@kernel.org>
 <18d5fcf4-84b2-806c-eb2c-787b96e0fb90@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18d5fcf4-84b2-806c-eb2c-787b96e0fb90@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > void perf_event_mmap(struct vm_area_struct *vma)
> > {
> >          struct perf_mmap_event mmap_event;
> > 
> >          if (!atomic_read(&nr_mmap_events))
> >                  return;
> > <SNIP>
> > }
> > 
> 
> Thanks. I'll add the nr_mmap_events check in V2.

No, that's the wrong check here. The PEBS flush is independent of mmap
events being requested.

If anything would need to check for any PEBS events active, which
would need a new counter.  I think the easiest is to just check if 
this_cpu_ptr(&sched_cb_list)
is empty, which should be good enough.

-Andi
