Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754291AbeDMKkm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 06:40:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753634AbeDMKkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 06:40:40 -0400
Subject: Re: [PATCH] mm: vmalloc: Remove double execution of vunmap_page_range
To: Chintan Pandya <cpandya@codeaurora.org>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>, vbabka@suse.cz,
        labbott@redhat.com, catalin.marinas@arm.com, hannes@cmpxchg.org,
        f.fainelli@gmail.com, xieyisheng1@huawei.com,
        ard.biesheuvel@linaro.org, richard.weiyang@gmail.com,
        byungchul.park@lge.com
References: <1523611019-17679-1-git-send-email-cpandya@codeaurora.org>
 <a623e12b-bb5e-58fa-c026-de9ea53c5bd9@linux.vnet.ibm.com>
 <8da9f826-2a3d-e618-e512-4fc8d45c16f2@codeaurora.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 13 Apr 2018 16:10:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <8da9f826-2a3d-e618-e512-4fc8d45c16f2@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041310-0020-0000-0000-000004117EDE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041310-0021-0000-0000-000042A5B0FF
Message-Id: <bbef0a92-f81b-5ba8-c5c1-d8c08444955b@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130099
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13/2018 03:47 PM, Chintan Pandya wrote:
> 
> 
> On 4/13/2018 3:29 PM, Anshuman Khandual wrote:
>> On 04/13/2018 02:46 PM, Chintan Pandya wrote:
>>> Unmap legs do call vunmap_page_range() irrespective of
>>> debug_pagealloc_enabled() is enabled or not. So, remove
>>> redundant check and optional vunmap_page_range() routines.
>>
>> vunmap_page_range() tears down the page table entries and does
>> not really flush related TLB entries normally unless page alloc
>> debug is enabled where it wants to make sure no stale mapping is
>> still around for debug purpose. Deferring TLB flush improves
>> performance. This patch will force TLB flush during each page
>> table tear down and hence not desirable.
>>
> Deferred TLB invalidation will surely improve performance. But force
> flush can help in detecting invalid access right then and there. I

Deferred TLB invalidation was a choice made some time ago with the
commit db64fe02258f1507e ("mm: rewrite vmap layer") as these vmalloc
mappings wont be used other than inside the kernel and TLB gets
flushed when they are reused. This way it can still avail the benefit
of deferred TLB flushing without exposing itself to invalid accesses.

> chose later. May be I should have clean up the vmap tear down code
> as well where it actually does the TLB invalidation.
> 
> Or make TLB invalidation in free_unmap_vmap_area() be dependent upon
> debug_pagealloc_enabled().

Immediate TLB invalidation needs to be dependent on debug_pagealloc_
enabled() and should be done only for debug purpose. Contrary to that
is not desirable.
