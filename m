Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbeCVQ3D (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 12:29:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751687AbeCVQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 12:29:01 -0400
Subject: Re: [RFC PATCH 1/8] mm: mmap: unmap large mapping by section
To: Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Cc: Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1521581486-99134-1-git-send-email-yang.shi@linux.alibaba.com>
 <1521581486-99134-2-git-send-email-yang.shi@linux.alibaba.com>
 <20180321131449.GN23100@dhcp22.suse.cz>
 <8e0ded7b-4be4-fa25-f40c-d3116a6db4db@linux.alibaba.com>
 <cf87ade4-5a5c-3919-0fc6-acc40e12659b@linux.alibaba.com>
 <20180321212355.GR23100@dhcp22.suse.cz>
 <952dcae2-a73e-0726-3cc5-9b6a63b417b7@linux.alibaba.com>
 <20180322091008.GZ23100@dhcp22.suse.cz>
 <8b4407dd-78f6-2f6f-3f45-ddb8a2d805c8@linux.alibaba.com>
 <20180322161316.GD28468@bombadil.infradead.org>
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Thu, 22 Mar 2018 17:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322161316.GD28468@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18032216-0040-0000-0000-00000425E441
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032216-0041-0000-0000-00002628EDF8
Message-Id: <e36daca9-8bf0-5fad-d68b-a3116cc1a75e@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803220190
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2018 17:13, Matthew Wilcox wrote:
> On Thu, Mar 22, 2018 at 09:06:14AM -0700, Yang Shi wrote:
>> On 3/22/18 2:10 AM, Michal Hocko wrote:
>>> On Wed 21-03-18 15:36:12, Yang Shi wrote:
>>>> On 3/21/18 2:23 PM, Michal Hocko wrote:
>>>>> On Wed 21-03-18 10:16:41, Yang Shi wrote:
>>>>>> proc_pid_cmdline_read(), it calls access_remote_vm() which need acquire
>>>>>> mmap_sem too, so the mmap_sem scalability issue will be hit sooner or later.
>>>>> Ohh, absolutely. mmap_sem is unfortunatelly abused and it would be great
>>>>> to remove that. munmap should perform much better. How to do that safely
>>> The full vma will have to be range locked. So there is nothing small or large.
>>
>> It sounds not helpful to a single large vma case since just one range lock
>> for the vma, it sounds equal to mmap_sem.
> 
> But splitting mmap_sem into pieces is beneficial for this case.  Imagine
> we have a spinlock / rwlock to protect the rbtree 

Which is more or less what I'm proposing in the speculative page fault series:
https://lkml.org/lkml/2018/3/13/1158

This being said, having a per VMA lock could lead to tricky dead lock case,
when merging multiple VMA happens in parallel since multiple VMA will have to
be locked at the same time, grabbing those lock in a fine order will be required.

> ... / arg_start / arg_end
> / ...  and then each VMA has a rwsem (or equivalent).  access_remote_vm()
> would walk the tree and grab the VMA's rwsem for read while reading
> out the arguments.  The munmap code would have a completely different
> VMA write-locked.
> 
