Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB36C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 09:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2871420883
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 09:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W9RNM+us"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2871420883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbeKJTRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 14:17:35 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41120 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728836AbeKJTRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 14:17:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAA4mdr0025635;
        Sat, 10 Nov 2018 04:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=pfx1TFE9SqKPTZ6J5gT7UQ8NGm3Ks/6WXg0s+rirskU=;
 b=W9RNM+usHGxxkgQmMU5u3dTiTRKD7bcWQmIQoTn9+P2iyC8LbV/jo9924f6xmfTvOHNg
 VuJVcH0qfq7mRz4TaZExq2CqebLBbxdih4qDFE70lK8HE5An0eL0HVPrDNfPmd6IALiE
 N4+5F8+kNJOiMzg7cBqYBZQp4uvqGsqYoHL8UD0/MbBZAlMOltIfX6VBj57/CeeMRc7B
 0BxzmEo70ZV99yt0R/90hA75ep8eUBWWPUIWm/+YF/ouHiUk68/uO6UN9f5fInFzZnFi
 N1zi8sDJAFFVKkyDoHRasfSp0IpkrRfN/Od84MC9L7x9OBPGE9TdyzsbmI8w1cOUYYhP Dw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nnprtr4db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Nov 2018 04:48:39 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAA4mbDn010474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Nov 2018 04:48:38 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAA4malg007089;
        Sat, 10 Nov 2018 04:48:36 GMT
Received: from dhcp-10-159-156-150.vpn.oracle.com (/10.159.156.150)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Nov 2018 20:48:36 -0800
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
Subject: Re: [PATCH V2 0/6] VA to numa node information
To:     Michal Hocko <mhocko@kernel.org>,
        Steven Sistare <steven.sistare@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        khandual@linux.vnet.ibm.com
References: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
 <20180913084011.GC20287@dhcp22.suse.cz>
 <375951d0-f103-dec3-34d8-bbeb2f45f666@oracle.com>
 <20180914055637.GH20287@dhcp22.suse.cz>
 <91988f05-2723-3120-5607-40fabe4a170d@oracle.com>
 <20180924171443.GI18685@dhcp22.suse.cz>
Message-ID: <41af45a9-c428-ccd8-ca10-c355d22c56a7@oracle.com>
Date:   Fri, 9 Nov 2018 20:48:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924171443.GI18685@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9072 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=11 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=976
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811100041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/24/18 10:14 AM, Michal Hocko wrote:
> On Fri 14-09-18 12:01:18, Steven Sistare wrote:
>> On 9/14/2018 1:56 AM, Michal Hocko wrote:
> [...]
>>> Why does this matter for something that is for analysis purposes.
>>> Reading the file for the whole address space is far from a free
>>> operation. Is the page walk optimization really essential for usability?
>>> Moreover what prevents move_pages implementation to be clever for the
>>> page walk itself? In other words why would we want to add a new API
>>> rather than make the existing one faster for everybody.
>> One could optimize move pages.  If the caller passes a consecutive range
>> of small pages, and the page walk sees that a VA is mapped by a huge page,
>> then it can return the same numa node for each of the following VA's that fall
>> into the huge page range. It would be faster than 55 nsec per small page, but
>> hard to say how much faster, and the cost is still driven by the number of
>> small pages.
> This is exactly what I was arguing for. There is some room for
> improvements for the existing interface. I yet have to hear the explicit
> usecase which would required even better performance that cannot be
> achieved by the existing API.
>

Above mentioned optimization to move_pages() API helps when scanning
mapped huge pages, but does not help if there are large sparse mappings
with few pages mapped. Otherwise, consider adding page walk support in
the move_pages() implementation, enhance the API(new flag?) to return
address range to numa node information. The page walk optimization
would certainly make a difference for usability.

We can have applications(Like Oracle DB) having processes with large sparse
mappings(in TBs)  with only some areas of these mapped address range
being accessed, basically  large portions not having page tables backing 
it.
This can become more prevalent on newer systems with multiple TBs of
memory.

Here is some data from pmap using move_pages() API  with optimization.
Following table compares time pmap takes to print address mapping of a
large process, with numa node information using move_pages() api vs pmap
using /proc numa_vamaps file.

Running pmap command on a process with 1.3 TB of address space, with
sparse mappings.

                        ~1.3 TB sparse      250G dense segment with hugepages.
move_pages              8.33s              3.14
optimized move_pages    6.29s              0.92
/proc numa_vamaps       0.08s              0.04

  
Second column is pmap time on a 250G address range of this process, which maps
hugepages(THP & hugetlb).

