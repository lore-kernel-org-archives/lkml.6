Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F485C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EDAC2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zwbwhA08"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EDAC2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390325AbeGKVmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:42:52 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59120 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732861AbeGKVmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:42:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6BLXVhI051059;
        Wed, 11 Jul 2018 21:36:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=dA7RmU3n/xhmHIHGusZnXpIV4gJn7NSiOoV4o9pfMJM=;
 b=zwbwhA08ma81dgwQxkLUiXZs3wHmWuJQ/BOmp3CsWNr5t0DcOPqlzidnVPhH8iuTM+NQ
 eFAxb9LRh/avahIO4hXP+fJtB6GSL7Og2e43Ogajkfl+xqMQ5oR56loQ8qfQR8Pf4C8g
 P2HYr+9nhLe/AMZCPsLj9+1xxlPUHZe6KtmpkP31xvA+F+ChIr7O45ZOK2VftK0lOU2K
 3UwYPQjj5fLt98sloWm9vlAjFDiGcNmCs3kBzBxQ2WMP0dHN4MCmz+VXKp+eD7u1426/
 GEX3ZAJX8tOlPTs2Y/m2xYPypNAY6viLVgsgV1NekW0YLdcmKzJkFQVVHVyxJtOlcs5r mQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2k2p76817j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 21:36:20 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6BLaJBM004120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 21:36:19 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6BLaIxN015174;
        Wed, 11 Jul 2018 21:36:18 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 14:36:18 -0700
Subject: Re: [PATCH] mm/hugetlb: remove gigantic page support for HIGHMEM
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cannon Matthews <cannonmatthews@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180711195913.1294-1-mike.kravetz@oracle.com>
 <20180711205702.d4xeu552xgxjbse3@linux-r8p5>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c42f0174-f74f-8b3f-8b69-4885d10d3e15@oracle.com>
Date:   Wed, 11 Jul 2018 14:36:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711205702.d4xeu552xgxjbse3@linux-r8p5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110228
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 01:57 PM, Davidlohr Bueso wrote:
> On Wed, 11 Jul 2018, Mike Kravetz wrote:
> 
>> This reverts commit ee8f248d266e ("hugetlb: add phys addr to struct
>> huge_bootmem_page")
>>
>> At one time powerpc used this field and supporting code. However that
>> was removed with commit 79cc38ded1e1 ("powerpc/mm/hugetlb: Add support
>> for reserving gigantic huge pages via kernel command line").
>>
>> There are no users of this field and supporting code, so remove it.
> 
> Considering the title, don't you wanna also get rid of try_to_free_low()
> and something like the following, which I'm sure can be done fancier, and
> perhaps also thp?

Not really.  The intention is to only remove gigantic huge page support for
HIGHMEN systems.  Non-gigantic huge pages on HIGHMEN systems should still
work/be supported.  So, we do not want to make the config change or get
rid of try_to_free_low().

Actually, I simply wanted to revert the specific patch which enabled gigantic
huge pages on HIGHMEM systems.  I did see that check in try_to_free_low(),

	if (hstate_is_gigantic(h))
		return;

and considered for a minute turning that into a VM_BUG or WARN, but decided
to leave it as is.

Do you think the title should be changed to simply 'revert commit
ee8f248d266e'?

-- 
Mike Kravetz

> diff --git a/fs/Kconfig b/fs/Kconfig
> index ac474a61be37..849da70e35d6 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -192,8 +192,8 @@ config TMPFS_XATTR
> 
> config HUGETLBFS
>        bool "HugeTLB file system support"
> -       depends on X86 || IA64 || SPARC64 || (S390 && 64BIT) || \
> -                  SYS_SUPPORTS_HUGETLBFS || BROKEN
> +       depends on !HIGHMEM && (X86 || IA64 || SPARC64 || (S390 && 64BIT) || \
> +                  SYS_SUPPORTS_HUGETLBFS || BROKEN)
>        help
>          hugetlbfs is a filesystem backing for HugeTLB pages, based on
>          ramfs. For architectures that support it, say Y here and read
> 
> Thanks,
> Davidlohr
