Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94080ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6332147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 19:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1kTQKSvW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6332147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeIRAfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:35:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51270 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIRAfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:35:43 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8HIwx5F136811;
        Mon, 17 Sep 2018 19:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=wmS5HWIEUmhfQKgs++2RqDM6ZKIsrH2zBNpncpIy1bI=;
 b=1kTQKSvWoC6xAeEIxZZZe2KFMHB4Rm1UhuFX2iNWD37V+1Ai7ofv/HjXF1SS7JhUPF1t
 NHqwWLY9fzEd7Fd5IX48geuOQH3cTWSbHOQ52ZfsyWHU3eB2Ceua/fyT3/BsXPCuwl+a
 zIZ/hA4RNRSI8CadLtyOy1wBOjvcNBf5bRmLQCojg/v7MxrDMXpnfWzaTcmIO6qyoCAv
 56odwQdwy6jxPFUCeD4HScMOphlkKxy1RaRKUi2p+KFU6UkoEOGdRtGsUrmFRTAcG/8R
 jtpAoo2XZWYOU78d6Ll8vnD7DSqVrAzNEEbHewrTkHZXXqRy44MzAZctrNoXFbnxE90w 7g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2mgtqqr6mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 19:06:55 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8HJ6smA004126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 19:06:54 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8HJ6pcT008186;
        Mon, 17 Sep 2018 19:06:51 GMT
Received: from dhcp-burlington7-2nd-B-east-10-152-55-162.usdhcp.oraclecorp.com (/10.152.32.65)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Sep 2018 12:06:51 -0700
Subject: Re: [PATCH 1/6] xenbus: prepare data structures and parameter for
 xenwatch multithreading
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, paul.durrant@citrix.com, wei.liu2@citrix.com,
        konrad.wilk@oracle.com, roger.pau@citrix.com,
        srinivas.eeda@oracle.com
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-2-git-send-email-dongli.zhang@oracle.com>
 <04d7dee9-3011-512a-09b0-0e8dcbdd99d6@oracle.com>
 <797673a8-fa7e-0bfc-332e-4e0190c8d1ed@oracle.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Openpgp: preference=signencrypt
Autocrypt: addr=boris.ostrovsky@oracle.com; prefer-encrypt=mutual; keydata=
 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
 Jg6OxFYd01z+a+oL
Message-ID: <68418036-ae16-b58c-71d8-bb177fb30b51@oracle.com>
Date:   Mon, 17 Sep 2018 15:08:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <797673a8-fa7e-0bfc-332e-4e0190c8d1ed@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9019 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809170188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/18 9:20 PM, Dongli Zhang wrote:
> Hi Boris,
>
> On 09/17/2018 04:17 AM, Boris Ostrovsky wrote:
>>
>> On 9/14/18 3:34 AM, Dongli Zhang wrote:
>>
>>> +
>>> +struct mtwatch_info {
>>> +    /*
>>> +     * The mtwatch_domain is put on both a hash table and a list.
>>> +     * domain_list is used to optimize xenbus_watch un-registration.
>>> +     *
>>> +     * The mtwatch_domain is removed from domain_hash (with state set
>>> +     * to MTWATCH_DOMAIN_DOWN) when its refcnt is zero. However, it is
>>> +     * left on domain_list until all events belong to such
>>> +     * mtwatch_domain are processed in mtwatch_thread().
>>
>> Do we really need to keep mwatch_domain on both lists? Why is keeping it on,
>> say, only the hash not sufficient?
> In the state of the art xenbus, when a watch is unregistered (e.g.,
> unregister_xenbus_watch()), we need to traverse the list 'watch_events' to
> remove all inflight/pending events (for such watch) from 'watch_events'.
>
> About this patch set, as each domain would have its own event list, we need to
> traverse the list of each domain to remove the pending events for the watch to
> be unregistered.
>
> E.g.,
> unregister_xenbus_watch()-->unregister_mtwatch()-->unregister_all_mtwatch() in
> [PATCH 2/6] xenbus: implement the xenwatch multithreading framework.
>
> To traverse a hash table is not as efficient as traversing a list. That's why a
> domain is kept on both the hash table and list.


Keeping the same object on two lists also has costs. More importantly
IMO, it increases chances on introducing a bug  when people update one
instance but not the other.


>
>>> +     *
>>> +     * While there may exist two mtwatch_domain with the same domid on
>>> +     * domain_list simultaneously,
>>
>> How is it possible to have two domids on the list at the same time? Don't you
>> want to remove it (which IIUIC means moving it to the purge list) when domain is
>> destroyed?
> Here is one case (suppose the domid/frontend-id is 9):
>
> 1. Suppose the last pv driver device is removed from domid=9, and therefore the
> reference count of per-domU xenwatch thread for domid=9 (which we call as old
> thread below) should be removed. We remove it from hash table (it is left in the
> list).
>
> Here we cannot remove the domain from the list immediately because there might
> be pending events being processed by the corresponding per-domU xenwatch thread.
> If we remove it from the list while there is related watch being unregistered as
> mentioned for last question, we may hit page fault when processing watch event.


Don't you need to grab domain->domain_mutex to remove the driver?
Meaning that events for that mtwatch thread cannot be processed?

In any case, I think that having two mtwatch_domains for the same domain
should be avoided. (and if you keep the hash list only then this issue
gets resolved automatically ;-))


-boris


>
> 2. Now the administrator attaches new pv device to domid=9 immediately and
> therefore reference count is initially set to 1. The per-domU xenwatch thread
> for domid=9 (called new thread) is created again. It is inserted to both the
> hash table and list.
>
> 3. As the old thread for domid=9 might still be on the list, we would have two
> threads for domid=9 (one old one to be removed and one newly inserted one to be
> used by new pv devices).
>
> Dongli Zhang
>
>>
>> -boris
>>
>>
>>> +      *  all mtwatch_domain on hash_hash
>>> +     * should have unique domid.
>>> +     */
>>> +    spinlock_t domain_lock;
>>> +    struct hlist_head domain_hash[MTWATCH_HASH_SIZE];
>>> +    struct list_head domain_list;
>>> +
>>> +    /*
>>> +     * When a per-domU kthread is going to be destroyed, it is put
>>> +     * on the purge_list, and will be flushed by purge_work later.
>>> +     */
>>> +    struct work_struct purge_work;
>>> +    spinlock_t purge_lock;
>>> +    struct list_head purge_list;
>>> +};
>>

