Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeDRU0u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 16:26:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43476 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeDRU0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 16:26:48 -0400
Subject: Re: [RFC PATCH] fs: introduce ST_HUGE flag and set it to tmpfs and
 hugetlbfs
To: Yang Shi <yang.shi@linux.alibaba.com>, viro@zeniv.linux.org.uk,
        nyc@holomorphy.com, kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2804a1d0-9d68-ac43-3041-9490147b52b5@oracle.com>
Date: Wed, 18 Apr 2018 13:26:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8867 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804180184
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/17/2018 02:08 PM, Yang Shi wrote:
> And, set the flag for hugetlbfs as well to keep the consistency, and the
> applications don't have to know what filesystem is used to use huge
> page, just need to check ST_HUGE flag.

For hugetlbfs, setting such a flag would be for consistency only.  mapping
hugetlbfs files REQUIRES huge page alignment and size.

If an application would want to take advantage of this flag for tmpfs, it
needs to map at a fixed address (MAP_FIXED) for huge page alignment.  So,
it will need to do one of the 'mmap tricks' to get a mapping at a suitably
aligned address.  

IIRC, there is code to 'suitably align' DAX mappings to appropriate huge page
boundaries.  Perhaps, something like this could be added for tmpfs mounted
with huge=?  Of course, this would not take into account 'length' but may
help some.

-- 
Mike Kravetz
