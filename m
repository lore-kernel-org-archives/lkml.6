Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C87DECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05D4620881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mkb8tamH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05D4620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeINXVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:21:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33836 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeINXVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:21:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8EI4BmP143088;
        Fri, 14 Sep 2018 18:05:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=EWscqU7EF63v27EsIoJmrbB2/s8O6H++OEmYpQdt6oo=;
 b=Mkb8tamHjn30y8Jhym7GAyS7Ti97NJJzxjWAXwljw1H7fNfBYgxYzw0k9xtxRg5a8Ppc
 M+RYvZw3yjdHfqWOUvibQVRiVW8MQ/S502xV2hEzqtQ+EB7HUHb66czrINBfQaeJ3lLu
 +QWMigc+A8aZ4frEETuKlbSCoO12008lnujkLKqQpsA27Mtfv//6S6VCCvVrFGvw+2j3
 gZ7mb1aXjtpO1hRY5MSkSZ+gRxA2AZV4nRqClYplhoOLZdyCD4Np5fdCpG/XhfsQfnsn
 aWjHNaMrfjTCVM+LCByISrFbRtXRj65CGvL75j/lgom0dzAH7I0k4xYtCfuCirbHK7jc Hg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2mc6cq8hbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 18:05:01 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8EI4x7F015108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 18:04:59 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8EI4x03002311;
        Fri, 14 Sep 2018 18:04:59 GMT
Received: from dhcp-10-159-150-22.vpn.oracle.com (/10.159.150.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 11:04:58 -0700
Subject: Re: [PATCH V2 0/6] VA to numa node information
To:     Steven Sistare <steven.sistare@oracle.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        khandual@linux.vnet.ibm.com
References: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
 <20180913084011.GC20287@dhcp22.suse.cz>
 <375951d0-f103-dec3-34d8-bbeb2f45f666@oracle.com>
 <20180914055637.GH20287@dhcp22.suse.cz>
 <91988f05-2723-3120-5607-40fabe4a170d@oracle.com>
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
Message-ID: <a26a71cb-101b-e7a2-9a2f-78995538dbca@oracle.com>
Date:   Fri, 14 Sep 2018 11:04:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <91988f05-2723-3120-5607-40fabe4a170d@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9016 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=876
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/18 9:01 AM, Steven Sistare wrote:
> On 9/14/2018 1:56 AM, Michal Hocko wrote:
>> On Thu 13-09-18 15:32:25, prakash.sangappa wrote:
>>>
>>> The proc interface provides an efficient way to export address range
>>> to numa node id mapping information compared to using the API.
>> Do you have any numbers?
>>
>>> For example, for sparsely populated mappings, if a VMA has large portions
>>> not have any physical pages mapped, the page walk done thru the /proc file
>>> interface can skip over non existent PMDs / ptes. Whereas using the
>>> API the application would have to scan the entire VMA in page size units.
>> What prevents you from pre-filtering by reading /proc/$pid/maps to get
>> ranges of interest?
> That works for skipping holes, but not for skipping huge pages.  I did a
> quick experiment to time move_pages on a 3 GHz Xeon and a 4.18 kernel.
> Allocate 128 GB and touch every small page.  Call move_pages with nodes=NULL
> to get the node id for all pages, passing 512 consecutive small pages per
> call to move_nodes. The total move_nodes time is 1.85 secs, and 55 nsec
> per page.  Extrapolating to a 1 TB range, it would take 15 sec to retrieve
> the numa node for every small page in the range.  That is not terrible, but
> it is not interactive, and it becomes terrible for multiple TB.
>

Also, for valid VMAs in  'maps' file, if the VMA is sparsely populated 
with  physical pages,
the page walk can skip over non existing page table entires (PMDs) and 
so can be faster.

For example  reading va range of a 400GB VMA which has few pages mapped
in beginning and few pages at the end and the rest of VMA does not have 
any pages, it
takes 0.001s using the /proc interface. Whereas with move_page() api 
passing 1024
consecutive small pages address, it takes about 2.4secs. This is on a 
similar system
running 4.19 kernel.



