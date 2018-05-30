Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753570AbeE3PAo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 11:00:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55154 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751693AbeE3PAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 11:00:41 -0400
Subject: Re: [PATCH 2/2] fs, elf: drop MAP_FIXED usage from elf_map
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>, libhugetlbfs@googlegroups.com
References: <20171129144219.22867-1-mhocko@kernel.org>
 <20171129144219.22867-3-mhocko@kernel.org>
 <93ce964b-e352-1905-c2b6-deedf2ea06f8@oracle.com>
 <c0e447b3-4ba7-239e-6550-64de7721ad28@oracle.com>
 <20180530080212.GA27180@dhcp22.suse.cz>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e7705544-04fe-c382-f6d0-48d0680b46f2@oracle.com>
Date: Wed, 30 May 2018 08:00:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180530080212.GA27180@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8909 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1805300167
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/30/2018 01:02 AM, Michal Hocko wrote:
> On Tue 29-05-18 15:21:14, Mike Kravetz wrote:
>> Just a quick heads up.  I noticed a change in libhugetlbfs testing starting
>> with v4.17-rc1.
>>
>> V4.16 libhugetlbfs test results
>> ********** TEST SUMMARY
>> *                      2M            
>> *                      32-bit 64-bit 
>> *     Total testcases:   110    113   
>> *             Skipped:     0      0   
>> *                PASS:   105    111   
>> *                FAIL:     0      0   
>> *    Killed by signal:     4      1   
>> *   Bad configuration:     1      1   
>> *       Expected FAIL:     0      0   
>> *     Unexpected PASS:     0      0   
>> *    Test not present:     0      0   
>> * Strange test result:     0      0   
>> **********
>>
>> v4.17-rc1 (and later) libhugetlbfs test results
>> ********** TEST SUMMARY
>> *                      2M            
>> *                      32-bit 64-bit 
>> *     Total testcases:   110    113   
>> *             Skipped:     0      0   
>> *                PASS:    98    111   
>> *                FAIL:     0      0   
>> *    Killed by signal:    11      1   
>> *   Bad configuration:     1      1   
>> *       Expected FAIL:     0      0   
>> *     Unexpected PASS:     0      0   
>> *    Test not present:     0      0   
>> * Strange test result:     0      0   
>> **********
>>
>> I traced the 7 additional (32-bit) killed by signal results to this
>> commit 4ed28639519c fs, elf: drop MAP_FIXED usage from elf_map.
>>
>> libhugetlbfs does unusual things and even provides custom linker scripts.
>> So, in hindsight this change in behavior does not seem too unexpected.  I
>> JUST discovered this while running libhugetlbfs tests for an unrelated
>> issue/change and, will do some analysis to see exactly what is happening.
> 
> I am definitely interested about further details. Are there any messages
> in the kernel log?
>

Yes, new messages associated with the failures.

[   47.570451] 1368 (xB.linkhuge_nof): Uhuuh, elf segment at 00000000a731413b requested but the memory is mapped already
[   47.606991] 1372 (xB.linkhuge_nof): Uhuuh, elf segment at 00000000a731413b requested but the memory is mapped already
[   47.641351] 1376 (xB.linkhuge_nof): Uhuuh, elf segment at 00000000a731413b requested but the memory is mapped already
[   47.726138] 1384 (xB.linkhuge): Uhuuh, elf segment at 0000000090b9eaf6 requested but the memory is mapped already
[   47.773169] 1393 (xB.linkhuge): Uhuuh, elf segment at 0000000090b9eaf6 requested but the memory is mapped already
[   47.817788] 1402 (xB.linkhuge): Uhuuh, elf segment at 0000000090b9eaf6 requested but the memory is mapped already
[   47.857338] 1406 (xB.linkshare): Uhuuh, elf segment at 0000000018430471 requested but the memory is mapped already
[   47.956355] 1427 (xB.linkshare): Uhuuh, elf segment at 0000000018430471 requested but the memory is mapped already
[   48.054894] 1448 (xB.linkhuge): Uhuuh, elf segment at 0000000090b9eaf6 requested but the memory is mapped already
[   48.071221] 1451 (xB.linkhuge): Uhuuh, elf segment at 0000000090b9eaf6 requested but the memory is mapped already

Just curious, the addresses printed in those messages does not seem correct.
They should be page aligned.  Correct?  I think that %p conversion in the
pr_info() may doing something wrong.

Also, the new failures in question are indeed being built with custom linker
scripts designed for use with binutils older than 2.16 (really old).  So, no
new users should encounter this issue (I think).  It appears that this may
only impact old applications built long ago with pre-2.16 binutils.
-- 
Mike Kravetz
