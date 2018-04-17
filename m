Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbeDQXnh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 19:43:37 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60306 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751164AbeDQXnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 19:43:35 -0400
Subject: Re: [PATCH v4 3/3] mm: restructure memfd code
To: Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180415182119.4517-1-mike.kravetz@oracle.com>
 <20180415182119.4517-4-mike.kravetz@oracle.com>
From: Khalid Aziz <khalid.aziz@oracle.com>
Organization: Oracle Corp
Message-ID: <3bcdcaba-3364-c633-2d9d-3df27c2a8f7c@oracle.com>
Date: Tue, 17 Apr 2018 17:42:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180415182119.4517-4-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8866 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804170204
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/2018 12:21 PM, Mike Kravetz wrote:
> With the addition of memfd hugetlbfs support, we now have the situation
> where memfd depends on TMPFS -or- HUGETLBFS.  Previously, memfd was only
> supported on tmpfs, so it made sense that the code resided in shmem.c.
> In the current code, memfd is only functional if TMPFS is defined.  If
> HUGETLFS is defined and TMPFS is not defined, then memfd functionality
> will not be available for hugetlbfs.  This does not cause BUGs, just a
> lack of potentially desired functionality.
> 
> Code is restructured in the following way:
> - include/linux/memfd.h is a new file containing memfd specific
>    definitions previously contained in shmem_fs.h.
> - mm/memfd.c is a new file containing memfd specific code previously
>    contained in shmem.c.
> - memfd specific code is removed from shmem_fs.h and shmem.c.
> - A new config option MEMFD_CREATE is added that is defined if TMPFS
>    or HUGETLBFS is defined.
> 
> No functional changes are made to the code: restructuring only.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   fs/Kconfig               |   3 +
>   fs/fcntl.c               |   2 +-
>   include/linux/memfd.h    |  16 +++
>   include/linux/shmem_fs.h |  13 --
>   mm/Makefile              |   1 +
>   mm/memfd.c               | 345 +++++++++++++++++++++++++++++++++++++++++++++++
>   mm/shmem.c               | 324 --------------------------------------------
>   7 files changed, 366 insertions(+), 338 deletions(-)
>   create mode 100644 include/linux/memfd.h
>   create mode 100644 mm/memfd.c

Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
