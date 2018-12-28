Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26819C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 05:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D9021A49
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 05:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l8T5NLRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbeL1F00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 00:26:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53714 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbeL1F0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 00:26:25 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBS5Ourp082744;
        Fri, 28 Dec 2018 05:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=pnHc9AFp4BIyWXLGtCEOxxU11HausqGVbHVTUXXFtDk=;
 b=l8T5NLRhmqGJWKCI7TLZHtUHFWulUOu/smzn98FqdyBXEjWSwRlyfqSqZVUWvE9n4twp
 piW7F9U+nRS6Cbo7bKZvAJMXK8q/Dtu7c8T2VreCBPgoijESTomUDPWtr3chBue6ltEz
 5xPjVoDyMmYDoxhLCTPRXxy9dMJFplPHpBKhwFUf52uqHyOyw3pIaXR88YSrB1Z/bxws
 Wf50/3ke3RjxlC6QHfPqre17sdFJ2OIP3JO7LfI+zCct6oM4WrGtBvCRD2fuvJw5fxZv
 P1SumxiCXBh2BLDaFBSf7naeIzATKp6zAsaxNo5tEA8wBzSykfiGEX8MaZkmNrDwpR1U cw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2phdwqy9wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Dec 2018 05:26:13 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBS5QC9i010122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Dec 2018 05:26:12 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBS5QAd1026974;
        Fri, 28 Dec 2018 05:26:10 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Dec 2018 21:26:10 -0800
Subject: Re: bug report: hugetlbfs: use i_mmap_rwsem for more pmd sharing,
 synchronization
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        stable@vger.kernel.org, linux-mm@kvack.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <5c8be807-03cd-991d-c79b-3c10a4d6d67b@canonical.com>
 <29441ca1-82f1-2e4b-13f6-ad4fe9ed4d0f@oracle.com>
 <20181227184518.4c689fcdca88325b841dfc71@linux-foundation.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <bcf7e166-9d01-1085-fb28-b01f020c7a1d@oracle.com>
Date:   Thu, 27 Dec 2018 21:26:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181227184518.4c689fcdca88325b841dfc71@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9119 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=834
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812280048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/27/18 6:45 PM, Andrew Morton wrote:
> On Thu, 27 Dec 2018 11:24:31 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
>> It would be better to make an explicit check for mapping != null before
>> calling i_mmap_lock_write/try_to_unmap.  In this way, unrelated changes to
>> code above will not potentially lead to the possibility of mapping == null.
>>
>> I'm not sure what is the best way to handle this.  Below is an updated version
>> of the patch sent to Andrew.  I can also provide a simple patch to the patch
>> if that is easier.
>>
> 
> Below is the delta.  Please check it.  It seems to do more than the
> above implies.
> 
> Also, I have notes here that 
> 
> hugetlbfs-use-i_mmap_rwsem-for-more-pmd-sharing-synchronization.patch
> and
> hugetlbfs-use-i_mmap_rwsem-to-fix-page-fault-truncate-race.patch
> 
> have additional updates pending.  Due to emails such as
> 
> http://lkml.kernel.org/r/849f5202-2200-265f-7769-8363053e8373@oracle.com
> http://lkml.kernel.org/r/732c0b7d-5a4e-97a8-9677-30f3520893cb@oracle.com
> http://lkml.kernel.org/r/6b91dd42-b903-1f6c-729a-bd9f51273986@oracle.com
> 
> What's the status, please?
> 

There was a V3 of the patches which was Acked-by Kirill.   See,
http://lkml.kernel.org/r/20181224101349.jjjmk2hzwah6g64h@kshutemo-mobl1

The two V3 patches are:
http://lkml.kernel.org/r/20181222223013.22193-2-mike.kravetz@oracle.com
http://lkml.kernel.org/r/20181222223013.22193-3-mike.kravetz@oracle.com

The patch I sent in this thread was an update to the V3.  The delta you
created was based on V2.  So, the delta contains V2 -> V3 changes as well
as the changes mentioned in this thread.  My apologies for not noticing
and clarifying.

Let me know what you would like me to do to help.  I hate to send any
more patches right now as they might cause more confusion.
-- 
Mike Kravetz
