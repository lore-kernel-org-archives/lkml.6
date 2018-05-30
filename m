Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932135AbeE3Rnv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:43:51 -0400
Received: from mga03.intel.com ([134.134.136.65]:28133 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932106AbeE3Rnr (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:43:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,461,1520924400";
   d="scan'208";a="53494786"
Date: Wed, 30 May 2018 10:43:46 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Jin Yao <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf util: Add more PMU fields for perf script python
Message-ID: <20180530174346.GE30764@tassilo.jf.intel.com>
References: <1527690045-17987-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527690045-17987-1-git-send-email-yao.jin@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 10:20:45PM +0800, Jin Yao wrote:
> When doing pmu sampling and then running a script with
> perf script -s script.py, the process_event function gets
> dictionary with some fields from the perf ring buffer
> (like ip, sym, callchain etc).
> 
> But we miss quite a few fields we report now, for example,
> LBRs,data source,weight,transaction,iregs,uregs,and etc.
> 
> This patch reports these fields for perf script python
> processing.

We need documentation and an example script using it.

> +		PyObject *pyelem;
> +
> +		pyelem = PyDict_New();
> +		if (!pyelem)
> +			Py_FatalError("couldn't create Python dictionary");
> +

I think we need a field for the dso here.

> +		pydict_set_item_string_decref(pyelem, "from",
> +		    PyLong_FromUnsignedLongLong(br->entries[i].from));
> +		pydict_set_item_string_decref(pyelem, "to",
> +		    PyLong_FromUnsignedLongLong(br->entries[i].to));
> +		pydict_set_item_string_decref(pyelem, "mispred",
> +		    PyLong_FromUnsignedLongLong(br->entries[i].flags.mispred));
> +		pydict_set_item_string_decref(pyelem, "predicted",
> +		    PyLong_FromUnsignedLongLong(br->entries[i].flags.predicted));
> +		pydict_set_item_string_decref(pyelem, "in_tx",
> +		    PyLong_FromUnsignedLongLong(br->entries[i].flags.in_tx));
> +		pydict_set_item_string_decref(pyelem, "abort",


These could be booleans.

> +		    PyLong_FromUnsignedLongLong(br->entries[i].flags.abort));
> +		pydict_set_item_string_decref(pyelem, "cycles",
> +		    PyLong_FromUnsignedLongLong(br->entries[i].flags.cycles));

Would be nice to get access to the binary code too (see how perf script
brstackinsn does it). That could be a followon patch.

Thanks,

-Andi
