Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751642AbeC2Ohc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 10:37:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:27532 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751164AbeC2Ohb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 10:37:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,376,1517904000";
   d="scan'208";a="37896179"
Subject: Re: [PATCH v3] x86,sched: allow topologies where NUMA nodes share an
 LLC
To: Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180329000024.GA16648@alison-desk.jf.intel.com>
 <alpine.DEB.2.21.1803291505590.1477@nanos.tec.linutronix.de>
 <20180329134723.GA4043@hirez.programming.kicks-ass.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>, Borislav Petkov <bp@alien8.de>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <596dcb0c-5bbc-f3be-203b-571170ee8f11@linux.intel.com>
Date: Thu, 29 Mar 2018 07:37:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180329134723.GA4043@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/2018 06:47 AM, Peter Zijlstra wrote:
> Further I think Dave argued that we should not change the llc-size,
> because while SNC presents a subset of the cache to local CPUs, for
> remote data the whole cache is still available, again something some
> applications might rely on.

BTW, I may have argued this in the past, but I don't think it's the best
thing to do.

If anything, we should optimize for the _users_ of this information: the
performance-sensitive ones who are digging up the cache topology.  They
are also likely to be the most NUMA-affinitized and stay node-local with
much of their memory traffic.  That would seem to point us in the
direction of enumerating two separate, half-sized LLCs "shared" only by
the slice when SNC mode is on.

That's what I've argued to the hardware folks lately, at least.
