Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbeCNWqR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 18:46:17 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44592 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeCNWqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 18:46:16 -0400
Subject: Re: [PATCH] [v3] xen: remove pre-xen3 fallback handlers
To: Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Cc: David Laight <David.Laight@aculab.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@suse.com>
References: <20180313210652.3484599-1-arnd@arndb.de>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <7c25f7f5-1b54-695e-be5f-6d06d4e89bfa@oracle.com>
Date: Wed, 14 Mar 2018 18:47:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313210652.3484599-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8832 signatures=668690
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803140241
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 05:06 PM, Arnd Bergmann wrote:
> The legacy hypercall handlers were originally added with
> a comment explaining that "copying the argument structures in
> HYPERVISOR_event_channel_op() and HYPERVISOR_physdev_op() into the local
> variable is sufficiently safe" and only made sure to not write
> past the end of the argument structure, the checks in linux/string.h
> disagree with that, when link-time optimizations are used:
>
> In function 'memcpy',
>     inlined from 'pirq_query_unmask' at drivers/xen/fallback.c:53:2,
>     inlined from '__startup_pirq' at drivers/xen/events/events_base.c:529:2,
>     inlined from 'restore_pirqs' at drivers/xen/events/events_base.c:1439:3,
>     inlined from 'xen_irq_resume' at drivers/xen/events/events_base.c:1581:2:
> include/linux/string.h:350:3: error: call to '__read_overflow2' declared with attribute error: detected read beyond size of object passed as 2nd parameter
>    __read_overflow2();
>    ^
>
> Further research turned out that only Xen 3.0.2 or earlier required the
> fallback at all, while all versions in use today don't need it.
> As far as I can tell, it is not even possible to run a mainline kernel
> on those old Xen releases, at the time when they were in use, only
> a patched kernel was supported anyway.
>
> Fixes: cf47a83fb06e ("xen/hypercall: fix hypercall fallback code for very old hypervisors")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> [v2] use a table lookup instead of a switch/case statement, after
> multiple suggestions.
> [v3] remove that file completely

(+Jan who added this file originally)

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
