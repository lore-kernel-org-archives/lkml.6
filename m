Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968307AbeE2WV3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 18:21:29 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45162 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967686AbeE2WVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 18:21:23 -0400
Subject: Re: [PATCH 2/2] fs, elf: drop MAP_FIXED usage from elf_map
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, libhugetlbfs@googlegroups.com
References: <20171129144219.22867-1-mhocko@kernel.org>
 <20171129144219.22867-3-mhocko@kernel.org>
 <93ce964b-e352-1905-c2b6-deedf2ea06f8@oracle.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c0e447b3-4ba7-239e-6550-64de7721ad28@oracle.com>
Date: Tue, 29 May 2018 15:21:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <93ce964b-e352-1905-c2b6-deedf2ea06f8@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8908 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805290237
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick heads up.  I noticed a change in libhugetlbfs testing starting
with v4.17-rc1.

V4.16 libhugetlbfs test results
********** TEST SUMMARY
*                      2M            
*                      32-bit 64-bit 
*     Total testcases:   110    113   
*             Skipped:     0      0   
*                PASS:   105    111   
*                FAIL:     0      0   
*    Killed by signal:     4      1   
*   Bad configuration:     1      1   
*       Expected FAIL:     0      0   
*     Unexpected PASS:     0      0   
*    Test not present:     0      0   
* Strange test result:     0      0   
**********

v4.17-rc1 (and later) libhugetlbfs test results
********** TEST SUMMARY
*                      2M            
*                      32-bit 64-bit 
*     Total testcases:   110    113   
*             Skipped:     0      0   
*                PASS:    98    111   
*                FAIL:     0      0   
*    Killed by signal:    11      1   
*   Bad configuration:     1      1   
*       Expected FAIL:     0      0   
*     Unexpected PASS:     0      0   
*    Test not present:     0      0   
* Strange test result:     0      0   
**********

I traced the 7 additional (32-bit) killed by signal results to this
commit 4ed28639519c fs, elf: drop MAP_FIXED usage from elf_map.

libhugetlbfs does unusual things and even provides custom linker scripts.
So, in hindsight this change in behavior does not seem too unexpected.  I
JUST discovered this while running libhugetlbfs tests for an unrelated
issue/change and, will do some analysis to see exactly what is happening.

Also, will take it upon myself to run libhugetlbfs test suite on a
regular (at least weekly) basis.
-- 
Mike Kravetz
