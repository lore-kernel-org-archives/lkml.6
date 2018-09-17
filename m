Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A29ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 01:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C277520883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 01:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2XBHk4pJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C277520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbeIQGo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:44:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51300 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeIQGo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:44:59 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8H1JpxA082411;
        Mon, 17 Sep 2018 01:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=TNrQ6zDEnYw/4IEUrPo3Z6M2AaOc9QCBgyF02lGyDX8=;
 b=2XBHk4pJm2/3X0k1K9CTcJG4VdfMbtJ6cObiqfxweS9R4aRy1xuaXTbUvmxWpM4kLbWZ
 4dhDsTcgoo6iGcgI5lODE8hBuikz+JjrZrwrpwgDSZk7+xMzWJ55FPMD1xA7hlcULpae
 Gt0XINa1qro7/bPxmf6S8cY+foCw2DrEAOMKZk7XuHhtja6crtWIQSBwb3/tt0LGiO+L
 LR2nySdEPvepEueLC7K08TcPTIxY7MYpx8032BWcjPTBihGg1NNZdUnnWE4XJIx5CTw0
 rMOhc5zq4qmCWwm32UBkNZdz7EACIOljH+DDWqFObghmADaO87snq04XNp17i4UVqVTJ kQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2mgt1pbfm3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 01:19:51 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8H1Jotc007571
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 01:19:51 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8H1Jnt4015372;
        Mon, 17 Sep 2018 01:19:50 GMT
Received: from [10.182.70.168] (/10.182.70.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Sep 2018 18:19:49 -0700
Subject: Re: [PATCH 1/6] xenbus: prepare data structures and parameter for
 xenwatch multithreading
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-2-git-send-email-dongli.zhang@oracle.com>
 <04d7dee9-3011-512a-09b0-0e8dcbdd99d6@oracle.com>
Cc:     jgross@suse.com, paul.durrant@citrix.com, wei.liu2@citrix.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com,
        srinivas.eeda@oracle.com
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <797673a8-fa7e-0bfc-332e-4e0190c8d1ed@oracle.com>
Date:   Mon, 17 Sep 2018 09:20:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <04d7dee9-3011-512a-09b0-0e8dcbdd99d6@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9018 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809170012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 09/17/2018 04:17 AM, Boris Ostrovsky wrote:
> 
> 
> On 9/14/18 3:34 AM, Dongli Zhang wrote:
> 
>> +
>> +struct mtwatch_info {
>> +    /*
>> +     * The mtwatch_domain is put on both a hash table and a list.
>> +     * domain_list is used to optimize xenbus_watch un-registration.
>> +     *
>> +     * The mtwatch_domain is removed from domain_hash (with state set
>> +     * to MTWATCH_DOMAIN_DOWN) when its refcnt is zero. However, it is
>> +     * left on domain_list until all events belong to such
>> +     * mtwatch_domain are processed in mtwatch_thread().
> 
> 
> Do we really need to keep mwatch_domain on both lists? Why is keeping it on,
> say, only the hash not sufficient?

In the state of the art xenbus, when a watch is unregistered (e.g.,
unregister_xenbus_watch()), we need to traverse the list 'watch_events' to
remove all inflight/pending events (for such watch) from 'watch_events'.

About this patch set, as each domain would have its own event list, we need to
traverse the list of each domain to remove the pending events for the watch to
be unregistered.

E.g.,
unregister_xenbus_watch()-->unregister_mtwatch()-->unregister_all_mtwatch() in
[PATCH 2/6] xenbus: implement the xenwatch multithreading framework.

To traverse a hash table is not as efficient as traversing a list. That's why a
domain is kept on both the hash table and list.

> 
>> +     *
>> +     * While there may exist two mtwatch_domain with the same domid on
>> +     * domain_list simultaneously,
> 
> 
> How is it possible to have two domids on the list at the same time? Don't you
> want to remove it (which IIUIC means moving it to the purge list) when domain is
> destroyed?

Here is one case (suppose the domid/frontend-id is 9):

1. Suppose the last pv driver device is removed from domid=9, and therefore the
reference count of per-domU xenwatch thread for domid=9 (which we call as old
thread below) should be removed. We remove it from hash table (it is left in the
list).

Here we cannot remove the domain from the list immediately because there might
be pending events being processed by the corresponding per-domU xenwatch thread.
If we remove it from the list while there is related watch being unregistered as
mentioned for last question, we may hit page fault when processing watch event.

2. Now the administrator attaches new pv device to domid=9 immediately and
therefore reference count is initially set to 1. The per-domU xenwatch thread
for domid=9 (called new thread) is created again. It is inserted to both the
hash table and list.

3. As the old thread for domid=9 might still be on the list, we would have two
threads for domid=9 (one old one to be removed and one newly inserted one to be
used by new pv devices).

Dongli Zhang

> 
> 
> -boris
> 
> 
>> +      *  all mtwatch_domain on hash_hash
>> +     * should have unique domid.
>> +     */
>> +    spinlock_t domain_lock;
>> +    struct hlist_head domain_hash[MTWATCH_HASH_SIZE];
>> +    struct list_head domain_list;
>> +
>> +    /*
>> +     * When a per-domU kthread is going to be destroyed, it is put
>> +     * on the purge_list, and will be flushed by purge_work later.
>> +     */
>> +    struct work_struct purge_work;
>> +    spinlock_t purge_lock;
>> +    struct list_head purge_list;
>> +};
> 
> 
