Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753581AbeCUVMq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 17:12:46 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53062 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbeCUVMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 17:12:44 -0400
Subject: Re: [PATCH] x86/xen: Delay get_cpu_cap until stack canary is
 established
To: Jason Andryuk <jandryuk@gmail.com>, Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20180319165804.10636-1-jandryuk@gmail.com>
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <c3075b0c-a60b-0809-e34b-223701a53b84@oracle.com>
Date: Wed, 21 Mar 2018 17:14:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319165804.10636-1-jandryuk@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8839 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19/2018 12:58 PM, Jason Andryuk wrote:
> Commit 2cc42bac1c79 ("x86-64/Xen: eliminate W+X mappings") introduced a
> call to get_cpu_cap, which is fstack-protected.  This is works on x86-64
> as commit 4f277295e54c ("x86/xen: init %gs very early to avoid page
> faults with stack protector") ensures the stack protector is configured,
> but it it did not cover x86-32.
>
> Delay calling get_cpu_cap until after xen_setup_gdt has initialized the
> stack canary.  Without this, a 32bit PV machine crashes early
> in boot.
> (XEN) Domain 0 (vcpu#0) crashed on cpu#0:
> (XEN) ----[ Xen-4.6.6-xc  x86_64  debug=n  Tainted:    C ]----
> (XEN) CPU:    0
> (XEN) RIP:    e019:[<00000000c10362f8>]
>
> And the PV kernel IP corresponds to init_scattered_cpuid_features
>    0xc10362f8 <+24>:    mov    %gs:0x14,%eax
>
> Fixes 2cc42bac1c79 ("x86-64/Xen: eliminate W+X mappings")
>
> Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
>


Applied to for-linus-4.17

-boris
