Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6647C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F64520843
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="06j8vPQV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F64520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389934AbeGKQwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:52:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44812 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733026AbeGKQwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:52:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6BGirVS035843;
        Wed, 11 Jul 2018 16:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=yvvJPtO6xiWM3JjD+Tnmb5/66cfjhiDerlZiJCl1t3M=;
 b=06j8vPQVd0V/b8oDh/XFSnl/S6vaElWwvjAFOTrzh0ewhQfjbalA7GqdjvaKhZ51gNCC
 +ojmvrBa4ZIIdFthCXXVZzmJQVy/8/0Mng0aZ/Vdysm3d7YQ2tvhORA9uGZmWbFCsdYD
 m/yqL1802VGQrqdrbuany9LdeiPnQZDRplXvuTQSmxpcVC5yQSiOI0NIFwG+lqwX8y78
 yzEjbWdge7t3YFpCwoW+3FL8sUSqRdyV2UfaVbbNkbxJ5egw4rCgZxLTlqI09TukkR1C
 JvYQIGVR+kjUxOt7nAKXvjqr4+BXl56cepLwO0Ogw7Fk5BC25Z1avUreiSA56GZpiQvP HA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2k2p7673ra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 16:47:28 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6BGlRMt030356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 16:47:27 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6BGlQGZ022844;
        Wed, 11 Jul 2018 16:47:26 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 09:47:26 -0700
Subject: Re: [PATCH] mm: hugetlb: don't zero 1GiB bootmem pages.
To:     Michal Hocko <mhocko@kernel.org>,
        Cannon Matthews <cannonmatthews@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nadia Yvette Chambers <nyc@holomorphy.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        andreslc@google.com, pfeiner@google.com, dmatlack@google.com,
        gthelen@google.com
References: <20180710184903.68239-1-cannonmatthews@google.com>
 <20180711124711.GA20172@dhcp22.suse.cz>
 <20180711124801.GO20050@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <3f639e81-f8d2-5010-4a4b-331d198b1ce9@oracle.com>
Date:   Wed, 11 Jul 2018 09:47:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711124801.GO20050@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 05:48 AM, Michal Hocko wrote:
> On Wed 11-07-18 14:47:11, Michal Hocko wrote:
>> On Tue 10-07-18 11:49:03, Cannon Matthews wrote:
>>> When using 1GiB pages during early boot, use the new
>>> memblock_virt_alloc_try_nid_raw() function to allocate memory without
>>> zeroing it.  Zeroing out hundreds or thousands of GiB in a single core
>>> memset() call is very slow, and can make early boot last upwards of
>>> 20-30 minutes on multi TiB machines.
>>>
>>> To be safe, still zero the first sizeof(struct boomem_huge_page) bytes
>>> since this is used a temporary storage place for this info until
>>> gather_bootmem_prealloc() processes them later.
>>>
>>> The rest of the memory does not need to be zero'd as the hugetlb pages
>>> are always zero'd on page fault.
>>>
>>> Tested: Booted with ~3800 1G pages, and it booted successfully in
>>> roughly the same amount of time as with 0, as opposed to the 25+
>>> minutes it would take before.
>>
>> The patch makes perfect sense to me. I wasn't even aware that it
>> zeroying memblock allocation. Thanks for spotting this and fixing it.
>>
>>> Signed-off-by: Cannon Matthews <cannonmatthews@google.com>
>>
>> I just do not think we need to to zero huge_bootmem_page portion of it.
>> It should be sufficient to INIT_LIST_HEAD before list_add. We do
>> initialize the rest explicitly already.
> 
> Forgot to mention that after that is addressed you can add
> Acked-by: Michal Hocko <mhocko@suse.com>

Cannon,

How about if you make this change suggested by Michal, and I will submit
a separate patch to revert the patch which added the phys field to
huge_bootmem_page structure.

FWIW,
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
