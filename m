Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754080AbeDMJ7x (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 05:59:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751847AbeDMJ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 05:59:52 -0400
Subject: Re: [PATCH] mm: vmalloc: Remove double execution of vunmap_page_range
To: Chintan Pandya <cpandya@codeaurora.org>, vbabka@suse.cz,
        labbott@redhat.com, catalin.marinas@arm.com, hannes@cmpxchg.org,
        f.fainelli@gmail.com, xieyisheng1@huawei.com,
        ard.biesheuvel@linaro.org, richard.weiyang@gmail.com,
        byungchul.park@lge.com
References: <1523611019-17679-1-git-send-email-cpandya@codeaurora.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 13 Apr 2018 15:29:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <1523611019-17679-1-git-send-email-cpandya@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041309-0044-0000-0000-00000546DA24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041309-0045-0000-0000-0000288718F2
Message-Id: <a623e12b-bb5e-58fa-c026-de9ea53c5bd9@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130093
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13/2018 02:46 PM, Chintan Pandya wrote:
> Unmap legs do call vunmap_page_range() irrespective of
> debug_pagealloc_enabled() is enabled or not. So, remove
> redundant check and optional vunmap_page_range() routines.

vunmap_page_range() tears down the page table entries and does
not really flush related TLB entries normally unless page alloc
debug is enabled where it wants to make sure no stale mapping is
still around for debug purpose. Deferring TLB flush improves
performance. This patch will force TLB flush during each page
table tear down and hence not desirable.
