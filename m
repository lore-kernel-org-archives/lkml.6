Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeC2EX6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 00:23:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40964 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeC2EX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 00:23:57 -0400
Subject: Re: [Xen-devel] [PATCH v2 1/1] xen-netback: process malformed sk_buff
 correctly to avoid BUG_ON()
To: Eric Dumazet <eric.dumazet@gmail.com>
References: <1522295463-469-1-git-send-email-dongli.zhang@oracle.com>
 <2c741a81-23b3-fa26-89b2-6c3d94b20b96@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, paul.durrant@citrix.com, wei.liu2@citrix.com
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <1abfb88c-050a-8054-c237-fe66b0a59eab@oracle.com>
Date: Thu, 29 Mar 2018 12:24:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <2c741a81-23b3-fa26-89b2-6c3d94b20b96@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8846 signatures=668695
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803290046
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 03/29/2018 12:03 PM, Eric Dumazet wrote:
> 
> 
> On 03/28/2018 08:51 PM, Dongli Zhang wrote:
>> The "BUG_ON(!frag_iter)" in function xenvif_rx_next_chunk() is triggered if
>> the received sk_buff is malformed, that is, when the sk_buff has pattern
>> (skb->data_len && !skb_shinfo(skb)->nr_frags). Below is a sample call
>> stack:
>>
>> ...
> 
> 
>>
>> The issue is hit by xen-netback when there is bug with other networking
>> interface (e.g., dom0 physical NIC), who has generated and forwarded
>> malformed sk_buff to dom0 vifX.Y. It is possible to reproduce the issue on
>> purpose with below sample code in a kernel module:
>>
>> skb->dev = dev; // dev of vifX.Y
>> skb->len = 386;
>> skb->data_len = 352;
>> skb->tail = 98;
>> skb->end = 384;
>> skb_shinfo(skb)->nr_frags = 0;
>> dev->netdev_ops->ndo_start_xmit(skb, dev);
>>
> 
> This would be a serious bug in the provider of such skb.

/nods

> 
> Are you sure you do not have instead an skb with a chain of skbs ?
> 
> (skb_shinfo(skb)->frag_list would be not NULL)

I am sure the skb_shinfo(skb)->frag_list is NULL.

> 
> Maybe your driver is wrongly advertising NETIF_F_FRAGLIST
> 
> commit 2167ca029c244901831 would be the bug origin then...

Unlike the new linux version (whose BUG_ON() does not panic the server), the
BUG_ON() in prior old kernel version would panic xen dom0 server and then people
would always blame xen paravirtual driver.

Indeed, xen-netback did not process the malformed sk_buff appropriately on rx
path. The issue is not hit with old dom0 kernel, when I am running the debug
module (as shown in below link) to generate a malformed sk_buff on purpose.

https://lists.xenproject.org/archives/html/xen-devel/2018-03/msg03176.html

Dongli Zhang
