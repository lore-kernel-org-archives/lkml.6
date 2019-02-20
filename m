Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA1DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7969921738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EOL+ZWfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfBTADg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:03:36 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:40852 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfBTADg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:03:36 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1JNx1GW082842;
        Wed, 20 Feb 2019 00:02:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=gfATYa55n+jW6sujzmXKFVyH/9xKyPiskuX1RgL782I=;
 b=EOL+ZWfG14CC1fIBhsKRlmFe+3jozjdbeuDOJ9Jan5dsfWb7hAj0T98SlddYlbTVe0dl
 0+LHU/wgEpD+5fZPfRSS9cUyoUcYKfbG1dbEPl2WzFYGAiZRkUC85YlACzAp9jjfF8Fg
 mzkQ0Xg5LYm9sPYisAKElC+Y/bHjfZTxYOIQdL8SunhvixnYiQ7aIziYZFdqceUD56cH
 VixZvCMWR8/wASCKcwkje8MDL+KbQW1FWviXdwnxqpG4RVrGtBQKAFagZIZgchah5bPn
 yjnVcJZDecr57VwrxqjN4/H/wF+0Uw8/jZjnA9oOc50d+DEoeHGNWDZ0tMq8MIbuSXxA 3Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qp81e6ptp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 00:02:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1K02JUv001440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Feb 2019 00:02:19 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1K02HXF029677;
        Wed, 20 Feb 2019 00:02:17 GMT
Received: from localhost.localdomain (/108.49.136.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Feb 2019 16:02:16 -0800
Date:   Tue, 19 Feb 2019 19:02:10 -0500
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     Julien Grall <julien.grall@arm.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave P Martin <dave.martin@arm.com>
Subject: Re: xen/evtchn and forced threaded irq
Message-ID: <20190220000209.GA4091@localhost.localdomain>
References: <5e256d9a-572c-e01e-7706-407f99245b00@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e256d9a-572c-e01e-7706-407f99245b00@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=946 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902190162
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 05:31:10PM +0000, Julien Grall wrote:
> Hi all,
> 
> I have been looking at using Linux RT in Dom0. Once the guest is started,
> the console is ending to have a lot of warning (see trace below).
> 
> After some investigation, this is because the irq handler will now be threaded.
> I can reproduce the same error with the vanilla Linux when passing the option
> 'threadirqs' on the command line (the trace below is from 5.0.0-rc7 that has
> not RT support).
> 
> FWIW, the interrupt for port 6 is used to for the guest to communicate with
> xenstore.
> 
> From my understanding, this is happening because the interrupt handler is now
> run in a thread. So we can have the following happening.
> 
>    Interrupt context            |     Interrupt thread
>                                 |  
>    receive interrupt port 6     |
>    clear the evtchn port        |
>    set IRQF_RUNTHREAD	        |
>    kick interrupt thread        |
>                                 |    clear IRQF_RUNTHREAD
>                                 |    call evtchn_interrupt
>    receive interrupt port 6     |
>    clear the evtchn port        |
>    set IRQF_RUNTHREAD           |
>    kick interrupt thread        |
>                                 |    disable interrupt port 6
>                                 |    evtchn->enabled = false
>                                 |    [....]
>                                 |
>                                 |    *** Handling the second interrupt ***
>                                 |    clear IRQF_RUNTHREAD
>                                 |    call evtchn_interrupt
>                                 |    WARN(...)
> 
> I am not entirely sure how to fix this. I have two solutions in mind:
> 
> 1) Prevent the interrupt handler to be threaded. We would also need to
> switch from spin_lock to raw_spin_lock as the former may sleep on RT-Linux.
> 
> 2) Remove the warning

I think access to evtchn->enabled is racy so (with or without the warning) we can't use it reliably.

Another alternative could be to queue the irq if !evtchn->enabled and handle it in evtchn_write() (which is where irq is supposed to be re-enabled).


-boris


> 
> None of them are ideals. Do you have an opionion/better suggestion?
> 
> [  127.192087] Interrupt for port 6, but apparently not enabled; per-user 0000000078d39c7f
> [  127.200333] WARNING: CPU: 0 PID: 2553 at drivers/xen/evtchn.c:167 evtchn_interrupt+0xfc/0x120
> [  127.208799] Modules linked in:
> [  127.211939] CPU: 0 PID: 2553 Comm: irq/52-evtchn:x Tainted: G        W
>   5.0.0-rc7-00023-g2a3d41623699 #1257
> [  127.222374] Hardware name: ARM Juno development board (r2) (DT)
> [  127.228381] pstate: 40000005 (nZcv daif -PAN -UAO)
> [  127.233256] pc : evtchn_interrupt+0xfc/0x120
> [  127.237607] lr : evtchn_interrupt+0xfc/0x120
> [  127.241952] sp : ffff000012d2bd60
> [  127.245347] x29: ffff000012d2bd60 x28: ffff00001015d608
> [  127.250741] x27: ffff8008b39de400 x26: ffff00001015d330
> [  127.256137] x25: ffff00001015d2d4 x24: 0000000000000001
> [  127.261532] x23: ffff00001015d570 x22: 0000000000000034
> [  127.266926] x21: 0000000000000000 x20: ffff8008b7f02400
> [  127.272322] x19: ffff8008b3aba000 x18: 0000000000000037
> [  127.277717] x17: 0000000000000000 x16: 0000000000000000
> [  127.283112] x15: 00000000fffffff0 x14: 0000000000000000
> [  127.288507] x13: 3030303030207265 x12: 000000000000000c
> [  127.293902] x11: ffff000010ea0a88 x10: 0000000000000000
> [  127.299297] x9 : 00000000fffb9fff x8 : 0000000000000000
> [  127.304701] x7 : 0000000000000001 x6 : ffff8008bac5c240
> [  127.310087] x5 : ffff8008bac5c240 x4 : 0000000000000000
> [  127.315483] x3 : ffff8008bac64708 x2 : ffff8008b39de400
> [  127.320877] x1 : 893ac9b38837b800 x0 : 0000000000000000
> [  127.326272] Call trace:
> [  127.328802]  evtchn_interrupt+0xfc/0x120
> [  127.332804]  irq_forced_thread_fn+0x38/0x98
> [  127.337066]  irq_thread+0x190/0x238
> [  127.340636]  kthread+0x134/0x138
> [  127.343942]  ret_from_fork+0x10/0x1c
> [  127.347593] ---[ end trace 1d3fa385877cc18b ]---
> 
> 
> Cheers,
> 
> -- 
> Julien Grall
