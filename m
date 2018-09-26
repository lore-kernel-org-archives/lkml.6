Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9525DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF632086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 02:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4C2PT054"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF632086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbeIZJHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:07:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41856 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeIZJHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:07:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8Q2tAPF080529;
        Wed, 26 Sep 2018 02:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=RWvuFdlUYChsEp+26zZSjgciUKRiqPihrsXCuqdWVTI=;
 b=4C2PT054zYULZtv/jr/A/w8xqfwNGU4EamqE4y8IyxGLfIdI55DQhM1TkbFfGvI193R+
 /K4KEicP7GKmix8c5DcAO6rFU6NHzZQF7z2ARMoxyOCdSp/0hTjRay19eKoAJxm4s2cU
 7FQIvUA3JcnI3Gml5vdNvdQCAQtD5YyTjFFilhnf8/U8GSZZ5IOtOPP/5KSHD4sj+SrL
 HXuIqPZgjyjZpLhPI02e4ptoRA8sPYH6Z0MvJ6D0anyPVICXK9KFph6G+VkUnry5TSyu
 K5+CFEsNidAKUWgGlmXN+CBHjs9Qr7xQibjpUSUxQpl1csJ1XkEtVs0DhG0gyvLizIoO NA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2mnvtupfum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 02:56:31 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8Q2uUvs026132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 02:56:30 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8Q2uT8N003993;
        Wed, 26 Sep 2018 02:56:29 GMT
Received: from [10.182.70.168] (/10.182.70.168)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Sep 2018 19:56:29 -0700
Subject: Re: [Xen-devel] [PATCH 1/6] xenbus: prepare data structures and
 parameter for xenwatch multithreading
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <1536910456-13337-1-git-send-email-dongli.zhang@oracle.com>
 <1536910456-13337-2-git-send-email-dongli.zhang@oracle.com>
 <04d7dee9-3011-512a-09b0-0e8dcbdd99d6@oracle.com>
 <797673a8-fa7e-0bfc-332e-4e0190c8d1ed@oracle.com>
 <68418036-ae16-b58c-71d8-bb177fb30b51@oracle.com>
 <b9fb7162-48a7-624e-a2b0-d2e124e7c109@oracle.com>
 <20422e39-f812-554e-f711-186bc6e00005@oracle.com>
Cc:     jgross@suse.com, wei.liu2@citrix.com, konrad.wilk@oracle.com,
        srinivas.eeda@oracle.com, paul.durrant@citrix.com,
        roger.pau@citrix.com
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <7ae3b919-1e67-e4a0-22ac-92f8f91d4686@oracle.com>
Date:   Wed, 26 Sep 2018 10:57:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20422e39-f812-554e-f711-186bc6e00005@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9027 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809260028
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 09/26/2018 04:19 AM, Boris Ostrovsky wrote:
> On 9/25/18 1:14 AM, Dongli Zhang wrote:
>>
>> So far we have: (1) domain hash table, (2) domain list (where duplicate entries
>> may exist) and (3) purge list.
>>
>> Can I assume you would like to discard the domain list and only keep domain hash
>> table and purge list?
> 
> Yes, that's what I was thinking.
> 
>>
>> The purpose of the domain list is to facilitate the unregister_xenbus_watch() to
>> scan the pending events for all otherend id. Should we remove it? Xen hypervisor
>> used both a hash table and a list to manage struct domain.
> 
> 
> Your concern is that searching for a pending event in the hash is not
> especially efficient. Since you are hashing on domain_id, then
> unregister_single_mtwatch() should be pretty fast if searching in the
> hash table (in fact, it's faster than traversing the domain list).
> unregister_all_mtwatch() will indeed take longer since you will be
> checking empty buckets. Right?
> 
> How often do you expect will we call unregister_all_mtwatch() compared
> to unregister_single_mtwatch()?

In the patch set v1, unregister_all_mtwatch() is indeed never called.


The watch registered globally seems never (let's use "rarely") unregistered.
E.g., the be_watch (at node 'backend') is registered during initialization and
will be used during the lifecycle of a backend domain (dom0 or driver domain).

I agree that unregister_all_mtwatch() is not called so far and will not be used
very often in the future. The performance overhead is trivial.

Therefore, I would discard the domain list. Only 'domain hash' and 'purge list'
will be used.

> 
> 
>>
>>
>> About the duplicate entries in the domain list, can we change the flow like below:
>>
>> 1. Suppose the thread status is DOWN. To avoid having duplicate entries on the
>> domain list, instead of keeping the deprecated thread on domain list (until all
>> its events get processed), we move it to the purge list immediately.
>>
>> We will tag this deprecated thread so that the purge list would not purge it
>> unless all events belong to such thread get processed. We cannot purge it
>> immediately because the worker thread (to purge the purge list) would hang if
>> the deprecated thread is already stuck.
>>
>> In this flow, we may have duplicate entries on purge list, but not domain list.
>>
>> 2. During unregister_xenbus_watch(), we need to scan both the domain list and
>> purge list to remove pending events for the watch. In previous design, we only
>> scan domain lit.
>>
>>
>> One option is we allow the deprecated thread to resurrect and we would not move
>> the thread to purge list immediately when the thread is deprecated.
>>
>> Suppose when thread for domid=9 is needed, we would not create new one if the
>> deprecated one for domid=9 is still in domain list. Instead, we would resurrect
>> it, change its status and reuse it again. In this way, we would not have
>> duplicate entries on the domain list.
>>
>> I like the 1st option. I do not like to resurrect a deprecated thread again.
>> Would you please let me know how you think about it?
> 
> 
> Yes, I also think (1) is better --- you are walking the whole purge list
> anyway.

I will take (1).

when unregister_all_mtwatch(): scan both 'hash table' and 'purge list'.

The entries on the purge list are classified (tagged) as (1) can be purged
immediately, and (2) not purge until it completes all pending events.



Thank you very much!

Dongli Zhang

> 
> 
> -boris
> 
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
> 
