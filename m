Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeDGOWf (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 10:22:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38726 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbeDGOWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 10:22:33 -0400
Subject: Re: [Xen-devel] [RFC 0/2] To introduce xenwatch multithreading (xen
 mtwatch)
To: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <1523100355-27647-1-git-send-email-dongli.zhang@oracle.com>
 <5c8c5c98-c16f-2df4-8582-90b5facc9f54@suse.com>
Cc: wei.liu2@citrix.com, boris.ostrovsky@oracle.com,
        ian.jackson@eu.citrix.com, srinivas.eeda@oracle.com
From: Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <6754eb61-15c0-3eac-d509-b81a5957cb82@oracle.com>
Date: Sat, 7 Apr 2018 22:22:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <5c8c5c98-c16f-2df4-8582-90b5facc9f54@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8855 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804070155
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juergen,

On 04/07/2018 07:59 PM, Juergen Gross wrote:
> On 07/04/18 13:25, Dongli Zhang wrote:
>> This is to introduce "xenwatch multithreading" (or "multithreaded xenwatch",
>> abbreviated as 'mtwatch'). The implementation of xen mtwatch involves below
>> components:
>>
>> * dom0 linux kernel
>> * xen toolstack
>>
>> Here are what the RFC is going to discuss:
>>
>> - what is the problem
>> - what is the objective
>> - what is the solution
> 
> Instead of creating one thread per domU, wouldn't it make much more
> sense to use another mechanism, e.g. a workqueue, to deliver the
> watch events? This would be one central place, wouldn't need any
> changes in Xen tools or complex mechanisms to select the correct
> thread, save resources, and domUs would benefit, too.

I think the xenwatch events of the same domU are expected to be processed in
order. I do not think we are able to guarantee the events of same domU are
processed in order with a central workqueue (unless it is an ordered workqueue).

Suppose an event callback function is stalled, we expected all following events
belong to the same domU are delayed until there is workaround/solution to
unblock the stalled function.

For instance, as mentioned in below mailing list archive, once the NIC is reset,
all in-flight packets are flushed and the stalled callback function moves
forward and complete. As all events (especially the events belong to the same
domU) are still queued, the pv device backend can disconnect correctly and
successfully. With a central workqueue, the following events belong to the same
domU are already processed so that the pv device backend may not disconnect
successfully.

https://lists.xenproject.org/archives/html/xen-devel/2016-06/msg00195.html

Dongli Zhang
