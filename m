Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750734AbeDKE2b (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 00:28:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750723AbeDKE23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 00:28:29 -0400
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
 <20180409132928.GA25722@redhat.com>
 <84c1e60f-8aad-a0ce-59af-4fcb3f77df94@linux.vnet.ibm.com>
 <20180410110633.GA29063@redhat.com>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Wed, 11 Apr 2018 09:58:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410110633.GA29063@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18041104-0020-0000-0000-000004107121
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041104-0021-0000-0000-000042A4986A
Message-Id: <c3bd7507-977e-67b5-9ab0-d70b4908a6f2@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804110041
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oleg,

On 04/10/2018 04:36 PM, Oleg Nesterov wrote:
> Hi Ravi,
>
> On 04/10, Ravi Bangoria wrote:
>>> and what if __mmu_notifier_register() fails simply because signal_pending() == T?
>>> see mm_take_all_locks().
>>>
>>> at first glance this all look suspicious and sub-optimal,
>> Yes. I should have added checks for failure cases.
>> Will fix them in v3.
> And what can you do if it fails? Nothing except report the problem. But
> signal_pending() is not the unlikely or error condition, it should not
> cause the tracing errors.

...

> Plus mm_take_all_locks() is very heavy... BTW, uprobe_mmap_callback() is
> called unconditionally. Whatever it does, can we at least move it after
> the no_uprobe_events() check? Can't we also check MMF_HAS_UPROBES?

Sure, I'll move it after these conditions.

> Either way, I do not feel that mmu_notifier is the right tool... Did you
> consider the uprobe_clear_state() hook we already have?

Ah! This is really a good idea. We don't need mmu_notifier then.

Thanks for suggestion,
Ravi
