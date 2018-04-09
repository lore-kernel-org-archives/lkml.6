Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbeDINcb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:32:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36338 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752246AbeDINc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:32:28 -0400
Subject: Re: [PATCH v2 7/9] trace_uprobe/sdt: Fix multiple update of same
 reference counter
To: Oleg Nesterov <oleg@redhat.com>
Cc: mhiramat@kernel.org, peterz@infradead.org, srikar@linux.vnet.ibm.com,
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
 <20180404083110.18647-8-ravi.bangoria@linux.vnet.ibm.com>
 <20180409131730.GA25631@redhat.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Mon, 9 Apr 2018 19:02:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409131730.GA25631@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18040913-0040-0000-0000-0000044B5E6D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040913-0041-0000-0000-000020EF82FF
Message-Id: <90d2fc35-0d58-1cab-a474-642192c7e1ff@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090144
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On 04/09/2018 06:47 PM, Oleg Nesterov wrote:
> On 04/04, Ravi Bangoria wrote:
>> +static void sdt_add_mm_list(struct trace_uprobe *tu, struct mm_struct *mm)
>> +{
>> +	struct mmu_notifier *mn;
>> +	struct sdt_mm_list *sml = kzalloc(sizeof(*sml), GFP_KERNEL);
>> +
>> +	if (!sml)
>> +		return;
>> +	sml->mm = mm;
>> +	list_add(&(sml->list), &(tu->sml.list));
>> +
>> +	/* Register mmu_notifier for this mm. */
>> +	mn = kzalloc(sizeof(*mn), GFP_KERNEL);
>> +	if (!mn)
>> +		return;
>> +
>> +	mn->ops = &sdt_mmu_notifier_ops;
>> +	__mmu_notifier_register(mn, mm);
>> +}
> I didn't read this version yet, just one question...
>
> So now it depends on CONFIG_MMU_NOTIFIER, yes? I do not see any changes in Kconfig
> files, this doesn't look right...

Yes, you are write. I'll make CONFIG_UPROBE_EVENTS dependent on
CONFIG_MMU_NOTIFIER.

Thanks,
Ravi
