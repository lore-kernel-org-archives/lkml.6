Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164829AbeCBDxB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 22:53:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1164778AbeCBDwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 22:52:55 -0500
Subject: Re: [RFC 3/4] trace_uprobe: Support SDT markers having semaphore
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        ananth@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, oleg@redhat.com,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <20180228075345.674-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180228075345.674-4-ravi.bangoria@linux.vnet.ibm.com>
 <20180301230741.bf15b2ab4c4913303e54884a@kernel.org>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Fri, 2 Mar 2018 09:24:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301230741.bf15b2ab4c4913303e54884a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18030203-0040-0000-0000-00000419BC61
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030203-0041-0000-0000-0000261CC245
Message-Id: <f646d7ae-5f03-c6bb-9118-de5fed5842dd@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803020041
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/01/2018 07:37 PM, Masami Hiramatsu wrote:
> On Wed, 28 Feb 2018 13:23:44 +0530
> Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:
>
>> @@ -502,6 +504,16 @@ static int create_trace_uprobe(int argc, char **argv)
>>  	for (i = 0; i < argc && i < MAX_TRACE_ARGS; i++) {
>>  		struct probe_arg *parg = &tu->tp.args[i];
>>  
>> +		/* This is not really an argument. */
>> +		if (argv[i][0] == '*') {
>> +			ret = kstrtoul(&(argv[i][1]), 0, &tu->sdt_offset);
>> +			if (ret) {
>> +				pr_info("Invalid semaphore address.\n");
>> +				goto error;
>> +			}
>> +			continue;
>> +		}
> So, this part should be done with parsing probe-point as I pointed.

Yes, will change it.

>> +static void sdt_increment_sem(struct trace_uprobe *tu)
>> +{
>> +	struct uprobe_map_info *info;
>> +	struct vm_area_struct *vma;
>> +	unsigned long vaddr;
>> +
>> +	uprobe_start_dup_mmap();
>> +	info = build_uprobe_map_info(tu->inode->i_mapping, tu->sdt_offset, false);
>> +	if (IS_ERR(info))
>> +		goto out;
>> +
>> +	while (info) {
>> +		down_write(&info->mm->mmap_sem);
>> +		vma = sdt_find_vma(info->mm, tu);
>> +		if (!vma)
>> +			goto cont;
>> +
>> +		vaddr = offset_to_vaddr(vma, tu->sdt_offset);
>> +		sdt_update_sem(info->mm, vaddr, 1);
>> +
>> +cont:
> Why would you use goto here?

Hmm.. sdt_find_vma() must return vma. Sure, will remove the goto.

Should I add a WARN_ON(!vma) ?

Thanks for the review,
Ravi
