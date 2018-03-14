Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeCNPnf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 11:43:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:22725 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751731AbeCNPne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 11:43:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="41985438"
Date: Wed, 14 Mar 2018 08:43:17 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com
Subject: Re: [PATCH] perf stat: Add support for s390 transaction counters
Message-ID: <20180314154317.GG13724@tassilo.jf.intel.com>
References: <20180312103807.45069-1-tmricht@linux.vnet.ibm.com>
 <87tvtk64ld.fsf@linux.intel.com>
 <f7240f60-2a1d-58f9-8d6f-05d27557620a@linux.vnet.ibm.com>
 <20180314131850.GA27335@kernel.org>
 <a863f62d-e460-639a-b69b-3437b9d4e4c5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a863f62d-e460-639a-b69b-3437b9d4e4c5@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> S390 has no support for Elision and uses transaction begin/end/abort
> instructions. The CPU measurement counter facility provides counters for
> transaction end and transaction abort.

You don't need to implement the el-* events.

> I have used this table (taken from arch/x86/events/intel/core.c) as giudeline:
> /* Haswell special events */
> EVENT_ATTR_STR(tx-start,        tx_start,       "event=0xc9,umask=0x1");
> EVENT_ATTR_STR(tx-commit,       tx_commit,      "event=0xc9,umask=0x2");
> EVENT_ATTR_STR(tx-abort,        tx_abort,       "event=0xc9,umask=0x4");
> EVENT_ATTR_STR(tx-capacity,     tx_capacity,    "event=0x54,umask=0x2");
> EVENT_ATTR_STR(tx-conflict,     tx_conflict,    "event=0x54,umask=0x1");
> EVENT_ATTR_STR(el-start,        el_start,       "event=0xc8,umask=0x1");
> EVENT_ATTR_STR(el-commit,       el_commit,      "event=0xc8,umask=0x2");
> EVENT_ATTR_STR(el-abort,        el_abort,       "event=0xc8,umask=0x4");
> EVENT_ATTR_STR(el-capacity,     el_capacity,    "event=0x54,umask=0x2");
> EVENT_ATTR_STR(el-conflict,     el_conflict,    "event=0x54,umask=0x1");
> EVENT_ATTR_STR(cycles-t,        cycles_t,       "event=0x3c,in_tx=1");
> EVENT_ATTR_STR(cycles-ct,       cycles_ct,      "event=0x3c,in_tx=1,in_tx_cp=1");
> 
> 
> So s390 can only support tx_commit and tx-abort symbolic names.
> None of them show up in the transactions_attrs and transaction_limited_attrs
> string variables used in builtin-stat.c file.

We could change perf stat to fall back to only tx commit and tx abort.
We already did that for one limited case.

-Andi
