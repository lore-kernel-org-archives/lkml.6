Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753825AbeEaFlP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 01:41:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:20892 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752003AbeEaFlO (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 01:41:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,462,1520924400";
   d="scan'208";a="44155829"
Subject: Re: [PATCH] perf util: Add more PMU fields for perf script python
To: Andi Kleen <ak@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com, yao.jin@intel.com
References: <1527690045-17987-1-git-send-email-yao.jin@linux.intel.com>
 <20180530174346.GE30764@tassilo.jf.intel.com>
From: "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <177a0a85-fd48-494e-e48b-4e88712c09d3@linux.intel.com>
Date: Thu, 31 May 2018 13:41:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180530174346.GE30764@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/2018 1:43 AM, Andi Kleen wrote:
> On Wed, May 30, 2018 at 10:20:45PM +0800, Jin Yao wrote:
>> When doing pmu sampling and then running a script with
>> perf script -s script.py, the process_event function gets
>> dictionary with some fields from the perf ring buffer
>> (like ip, sym, callchain etc).
>>
>> But we miss quite a few fields we report now, for example,
>> LBRs,data source,weight,transaction,iregs,uregs,and etc.
>>
>> This patch reports these fields for perf script python
>> processing.
> 
> We need documentation and an example script using it.
> 

OK, I will add an example with some field explanations to 
Documentation/perf-script-python.txt.

>> +		PyObject *pyelem;
>> +
>> +		pyelem = PyDict_New();
>> +		if (!pyelem)
>> +			Py_FatalError("couldn't create Python dictionary");
>> +
> 
> I think we need a field for the dso here.
>

I will add new fields "from_dsoname" and "to_dsoname" in v2.

>> +		pydict_set_item_string_decref(pyelem, "from",
>> +		    PyLong_FromUnsignedLongLong(br->entries[i].from));
>> +		pydict_set_item_string_decref(pyelem, "to",
>> +		    PyLong_FromUnsignedLongLong(br->entries[i].to));
>> +		pydict_set_item_string_decref(pyelem, "mispred",
>> +		    PyLong_FromUnsignedLongLong(br->entries[i].flags.mispred));
>> +		pydict_set_item_string_decref(pyelem, "predicted",
>> +		    PyLong_FromUnsignedLongLong(br->entries[i].flags.predicted));
>> +		pydict_set_item_string_decref(pyelem, "in_tx",
>> +		    PyLong_FromUnsignedLongLong(br->entries[i].flags.in_tx));
>> +		pydict_set_item_string_decref(pyelem, "abort",
> 
> 
> These could be booleans.
> 
>> +		    PyLong_FromUnsignedLongLong(br->entries[i].flags.abort));
>> +		pydict_set_item_string_decref(pyelem, "cycles",
>> +		    PyLong_FromUnsignedLongLong(br->entries[i].flags.cycles));

I will use PyBool_FromLong() for mispred/predicted/in_tx/abort in v2.

> 
> Would be nice to get access to the binary code too (see how perf script
> brstackinsn does it). That could be a followon patch.
>

OK, fine, I will see how perf script brstackinsn does.

Thanks
Jin Yao

> Thanks,
> 
> -Andi
> 
