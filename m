Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbeCTPew (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 11:34:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:55922 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCTPet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 11:34:49 -0400
Message-ID: <5AB12A0E.2060704@ORACLE.COM>
Date: Tue, 20 Mar 2018 17:34:38 +0200
From: Liran Alon <LIRAN.ALON@ORACLE.COM>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        idan.brown@ORACLE.COM, yuval.shaia@ORACLE.COM
Subject: Re: [PATCH] net: dev_forward_skb(): Scrub packet's per-netns info
 only when crossing netns
References: <1520953642-8145-1-git-send-email-liran.alon@oracle.com> <20180320.104759.796804827689233281.davem@davemloft.net>
In-Reply-To: <20180320.104759.796804827689233281.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8837 signatures=668693
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803200127
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/03/18 16:47, David Miller wrote:
> From: Liran Alon <liran.alon@oracle.com>
> Date: Tue, 13 Mar 2018 17:07:22 +0200
>
>> Before this commit, dev_forward_skb() always cleared packet's
>> per-network-namespace info. Even if the packet doesn't cross
>> network namespaces.
>
> There was a lot of discussion about this patch.
>
> Particularly whether it could potentially break current
> users or not.
>
> If this is resolved and the patch should still be applied,
> please repost and the folks involved in this dicussion should
> add their ACKs.
>
> Thanks.
>

The problem is that I don't think we have reached an agreement.
I would be happy to here your opinion on the issue at hand here.

I personally don't understand why we should maintain 
backwards-comparability to this behaviour. How would a user rely on the 
fact that skb->mark is scrubbed when it is passed between 2 netdevs on 
the same netns but only when it is passed between very specific netdev 
type (one of them being veth-peers).
This behaviour seems to have been created by mistake.
This feature is not documented to user-mode and I don't see why it is 
legit for the user to rely on it.

In addition, even if we do want to maintain backwards-comparability to 
this behaviour, I think it is enough to have an opt-in flag in 
/proc/sys/net/core/ that when set to 1 will activate the fix in 
dev_forward_skb() provided by this patch. That would also be a very 
simple change to the patch provided here.

Do you agree? Or do you think we should have a flag per netdev like 
suggested in other replies to this thread?

Thanks,
-Liran
