Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeBIQLC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:11:02 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49258 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeBIQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:11:01 -0500
Subject: Re: [RFC 2/2] Introduce sysctl(s) for the migration costs
To: Mike Galbraith <efault@gmx.de>, Rohit Jain <rohit.k.jain@oracle.com>,
        linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, joelaf@google.com,
        jbacik@fb.com, riel@redhat.com, juri.lelli@redhat.com,
        dhaval.giani@oracle.com
References: <1518128395-14606-1-git-send-email-rohit.k.jain@oracle.com>
 <1518128395-14606-3-git-send-email-rohit.k.jain@oracle.com>
 <1518148447.24350.34.camel@gmx.de>
From: Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <dcc94ac7-e910-9114-2976-ac61f0ade215@oracle.com>
Date: Fri, 9 Feb 2018 11:10:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1518148447.24350.34.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8799 signatures=668665
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=844
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802090205
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/2018 10:54 PM, Mike Galbraith wrote:
> On Thu, 2018-02-08 at 14:19 -0800, Rohit Jain wrote:
>> This patch introduces the sysctl for sched_domain based migration costs.
>> These in turn can be used for performance tuning of workloads.
> 
> With this patch, we trade 1 completely bogus constant (cost is really
> highly variable) for 3, twiddling of which has zero effect unless you
> trigger a domain rebuild afterward, which is neither mentioned in the
> changelog, nor documented.
> 
> bogo-numbers++ is kinda hard to love.

Yup, the domain rebuild is missing.

I am no fan of tunables, the fewer the better, but one of the several flaws
of the single figure for migration cost is that it ignores the very large
difference in cost when migrating between near vs far levels of the cache hierarchy.
Migration between CPUs of the same core should be free, as they share L1 cache.
Rohit defined a tunable for it, but IMO it could be hard coded to 0. Migration 
between CPUs in different sockets is the most expensive and is represented by
the existing sysctl_sched_migration_cost tunable.  Migration between CPUs in
the same core cluster, or in the same socket, is somewhere in between, as
they share L2 or L3 cache.  We could avoid a separate tunable by setting it to
sysctl_sched_migration_cost / 10.

- Steve
