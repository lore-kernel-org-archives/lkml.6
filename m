Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbeCVABC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 20:01:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34412 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753614AbeCVAA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 20:00:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Mar 2018 20:00:58 -0400
From: okaya@codeaurora.org
To: Casey Leedom <leedom@chelsio.com>
Cc: netdev@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ganesh GR <ganeshgr@chelsio.com>, linux-kernel@vger.kernel.org,
        Michael Werner <werner@chelsio.com>,
        SWise OGC <swise@opengridcomputing.com>
Subject: Re: [PATCH v4 12/17] net: cxgb4/cxgb4vf: Eliminate duplicate barriers
 on weakly-ordered archs
In-Reply-To: <BY2PR1201MB0983417DC5ECAB85834A84DBC8AA0@BY2PR1201MB0983.namprd12.prod.outlook.com>
References: <1521513753-7325-1-git-send-email-okaya@codeaurora.org>,<1521513753-7325-13-git-send-email-okaya@codeaurora.org>
 <BY2PR1201MB0983417DC5ECAB85834A84DBC8AA0@BY2PR1201MB0983.namprd12.prod.outlook.com>
Message-ID: <11820921c76403bca743c382287aee05@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-21 19:03, Casey Leedom wrote:
> [[ Appologies for the DUPLICATE email.  I forgot to tell my Mail Agent 
> to
>    use Plain Text. -- Casey ]]
> 
>   I feel very uncomfortable with these proposed changes.  Our team is 
> right
> in the middle of trying to tease our way through the various platform
> implementations of writel(), writel_relaxed(), __raw_writel(), etc. in 
> order
> to support x86, PowerPC, ARM, etc. with a single code base.  This is
> complicated by the somewhat ... "fuzzily defined" semantics and varying
> platform implementations of all of these APIs.  (And note that I'm just
> picking writel() as an example.)
> 
>   Additionally, many of the changes aren't even in fast paths and are 
> thus
> unneeded for performance.
> 
>   Please don't make these changes.  We're trying to get this all sussed 
> out.
> 

I was also given the feedback to look at performance critical path only. 
I am in the process of revisiting the patches.

If you can point me to the ones that are important, I can try to limit 
the changes to those only.

If your team wants to do it, I can drop this patch as well.

I think the semantics of write API is clear. What was actually 
implemented is another story.

I can share a few of my findings.

A portable driver needs to do this.

descriptor update in mem
wmb ()
writel_relaxed ()
mmiowb ()

Using __raw_write() is wrong as it can get reordered.

Using wmb()+writel() is also wrong for performance reasons.

If something is unclear, please ask.

> 
