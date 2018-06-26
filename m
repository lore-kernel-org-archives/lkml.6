Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4331AC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E419F26768
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GcrVpNQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E419F26768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933185AbeFZJOx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:14:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41468 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932353AbeFZJOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:14:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5Q9Ecak021391;
        Tue, 26 Jun 2018 09:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=RiKVJrMLUbUf4w3eqQBCxYpMa/N8hLVV4DCM37pEFEo=;
 b=GcrVpNQ7vW7mUdSUWtk+mifMoNllDwBkY0brAUjM0HIEq61vyVE9z0t72eYCnMc2UYWj
 iAp8vqwhsdSW3typbYrg5yQHU0pn4km3orMefu6nNYX+/qLb4DjA2nksi1pRUkYIP9wI
 MTftOGEp0W06zMNQ9ANOcpZVteLKv7bFnsPxazutRXzLfVwir5k7YaUYc755LD4J4OhB
 A5QeNgpGesrk2fhZCcfaccAmA4adty13f9YPV97vEb7+/CHCZOeLWWiqaQsnWfoLFtCc
 /uKJR8A3mKslZgg1Av+xU9Nl7BuccUwWOyo6+phh08upG7QUQEQ9DY7CmrTPuMWxcWNv OA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2ju242b40x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 09:14:42 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5Q9Efgf021773
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jun 2018 09:14:41 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5Q9EeMi027875;
        Tue, 26 Jun 2018 09:14:40 GMT
Received: from [10.186.53.178] (/10.186.53.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 26 Jun 2018 02:14:40 -0700
Subject: Re: general protection fault in find_device
To:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.cz, clm@fb.com,
        dsterba@suse.com, jbacik@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000e5da7e056ee43449@google.com>
 <45200a61-58c3-b7f0-d8e4-5108f8369ac5@suse.com>
 <20180618133228.GL24375@twin.jikos.cz>
 <d1bbc78f-da5d-1f87-e9f5-a6bec6650e9a@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <d59c40af-3659-0cc7-58d6-8a2d6568b60d@oracle.com>
Date:   Tue, 26 Jun 2018 17:17:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d1bbc78f-da5d-1f87-e9f5-a6bec6650e9a@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8935 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=8 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806260105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



(Sorry for the delay in replay due to my vacation).

Thanks Nikolay. more below.

On 06/18/2018 09:43 PM, Nikolay Borisov wrote:
> 
> 
> On 18.06.2018 16:32, David Sterba wrote:
>> On Mon, Jun 18, 2018 at 10:03:18AM +0300, Nikolay Borisov wrote:
>>> So this suggests some inconsistency on fs_devices->devices list. On a
>>> quick look indeed it doesn't seem clear what the locking rules for this
>>> list are. In device_list_add in the !device case a device is added with
>>> fs_devices->device_list_Mutex held and using list_add_rcu. In the same
>>> function if we want to read the list ie invoke find_devices (because we
>>> have found an fsid) we are using plain list_for_each_entry (ie not the
>>> _rcu version and i don't see device_list_mutex being held while
>>> iterating the list). Additionally in btrfs_free_extra_devids the
>>> fs_devices->devices list is iterated with uuid_mutex being held and not
>>> device_list_mutex. In open_fs_devices we don't get any protection
>>> whatsoever while reading the list.
>>
>> The uuid_mutex or device_list_mutex is provided by a caller up the
>> stack.
>>
>>> Same thing in
>>> btrfs_find_next_active_device. If the list is supposed to be
>>> RCU-protected then the rules are:
>>>
>>> 1. There needs to be an out of band (ie not RCU) mutual exclusion of
>>> modifiers
>>
>> that's device_list_mutex for fs_devices::devices
>>
>>> 2. Iterating the list should use _rcu list primitives.
>>>
>>> Currently I don't see those 2 invariants being enforced in every code path.
>>
>> Where is it not enforced for example?
> 
> Admittedly I didn't check the whole call chain but for example in
> find_device it's used "naked". Perhaps putting some lockdep_assert in
> various places dealing with fs_devices->devices list would help ?
>>
>> If the device_list_mutex is held, list traversal does not use
>> list_for_each_entry_rcu, otherwise it does (eg the DEV_INFO ioctl or
>> btrfs_show_devname).
>>
>> The problem that triggers this report is IMO in device_list_add that
>> uses the device list unprotected. Anand sent patches for that, but they
>> were titled as 'cleanups' so I skipped them for the merge window.

  Ah. sorry to confuse you. Will consolidate fixes into github
  (also reviewing David's fixes as well) and will use syz to confirm.

Thanks, Anand

>> Candidate fixes are:
>>
>> https://patchwork.kernel.org/patch/10437705/
>> https://patchwork.kernel.org/patch/10437713/
> Yep those 2 definitely look like fixing unlocked accesses to
> fs_devices->devices list


>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-btrfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
