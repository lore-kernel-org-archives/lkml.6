Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeDII3g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:29:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750952AbeDII3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:29:35 -0400
Subject: Re: [PATCH v2 9/9] perf probe: Support SDT markers having reference
 counter (semaphore)
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: oleg@redhat.com, peterz@infradead.org, srikar@linux.vnet.ibm.com,
        rostedt@goodmis.org, acme@kernel.org, ananth@linux.vnet.ibm.com,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        alexis.berlemont@gmail.com, corbet@lwn.net, dan.j.williams@intel.com,
        jolsa@redhat.com, kan.liang@intel.com, kjlx@templeofstupid.com,
        kstewart@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        milian.wolff@kdab.com, mingo@redhat.com, namhyung@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, pc@us.ibm.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, fengguang.wu@intel.com, jglisse@redhat.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180404083110.18647-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180404083110.18647-10-ravi.bangoria@linux.vnet.ibm.com>
 <20180409162856.df4c32b840eb5f2ef8c028f1@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Mon, 9 Apr 2018 13:59:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409162856.df4c32b840eb5f2ef8c028f1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18040908-0020-0000-0000-0000040F982C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040908-0021-0000-0000-000042A3B794
Message-Id: <643a8fb2-fb96-8dbe-9f36-2540bd8a1de5@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090093
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On 04/09/2018 12:58 PM, Masami Hiramatsu wrote:
> Hi Ravi,
>
> On Wed,  4 Apr 2018 14:01:10 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>> @@ -2054,15 +2060,21 @@ char *synthesize_probe_trace_command(struct probe_trace_event *tev)
>>  	}
>>  
>>  	/* Use the tp->address for uprobes */
>> -	if (tev->uprobes)
>> +	if (tev->uprobes) {
>>  		err = strbuf_addf(&buf, "%s:0x%lx", tp->module, tp->address);
>> -	else if (!strncmp(tp->symbol, "0x", 2))
>> +		if (uprobe_ref_ctr_is_supported() &&
>> +		    tp->ref_ctr_offset &&
>> +		    err >= 0)
>> +			err = strbuf_addf(&buf, "(0x%lx)", tp->ref_ctr_offset);
> If the kernel doesn't support uprobe_ref_ctr but the event requires
> to increment uprobe_ref_ctr, I think we should (at least) warn user here.

pr_debug("A semaphore is associated with %s:%s and seems your kernel doesn't support it.\n"
         tev->group, tev->event);

Looks good?

>> @@ -776,14 +784,21 @@ static char *synthesize_sdt_probe_command(struct sdt_note *note,
>>  {
>>  	struct strbuf buf;
>>  	char *ret = NULL, **args;
>> -	int i, args_count;
>> +	int i, args_count, err;
>> +	unsigned long long ref_ctr_offset;
>>  
>>  	if (strbuf_init(&buf, 32) < 0)
>>  		return NULL;
>>  
>> -	if (strbuf_addf(&buf, "p:%s/%s %s:0x%llx",
>> -				sdtgrp, note->name, pathname,
>> -				sdt_note__get_addr(note)) < 0)
>> +	err = strbuf_addf(&buf, "p:%s/%s %s:0x%llx",
>> +			sdtgrp, note->name, pathname,
>> +			sdt_note__get_addr(note));
>> +
>> +	ref_ctr_offset = sdt_note__get_ref_ctr_offset(note);
>> +	if (uprobe_ref_ctr_is_supported() && ref_ctr_offset && err >= 0)
>> +		err = strbuf_addf(&buf, "(0x%llx)", ref_ctr_offset);
> We don't have to care about uprobe_ref_ctr support here, because
> this information will be just cached, not directly written to
> uprobe_events.

Sure, will remove the check.

Thanks for the review :).
Ravi
