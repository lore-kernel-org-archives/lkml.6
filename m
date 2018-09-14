Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1ECFC6183
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9B620833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kP1THocf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9B620833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeINVQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:16:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35738 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeINVQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:16:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8EFwUEQ182337;
        Fri, 14 Sep 2018 16:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=z9Kta2CLh+6MM66j0LFKZeeazV/bLlIDsd3aiyQ4Enk=;
 b=kP1THocfuNn31+YydkAegyzac6C43TH/bPYlHkCWiLEFjP9UYVenNIU2sXWWR2xx6Mka
 39aOxWXx0gu6rKhVqc89s+xKcV8CTVT9AyafFI0YGih17XrlhKfKg9OF56JgDS2MDFqK
 KUvo616IrE+WZh/uIlz5ZOYwlApfV0By0rrMoGEPTfuDPhDFvBayZDekfsSuwpS59Wdq
 u0ibaM98GO3smFypUI2flKuCPaZ2b45GSHRKsbftuKDpWDX1pLR3dUJ1o02Uxg+evrzP
 PoA959p74IXmwE9O0ApxMVr4Z5SITl3xwJZ8C+iL1BLoS5Ap1pNSM56RQLuiPc8GfTkR NA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2mc5utyygq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 16:01:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8EG1Pjc026414
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 16:01:25 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8EG1OQR003261;
        Fri, 14 Sep 2018 16:01:24 GMT
Received: from [10.39.254.239] (/10.39.254.239)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 09:01:24 -0700
Subject: Re: [PATCH V2 0/6] VA to numa node information
To:     Michal Hocko <mhocko@kernel.org>,
        "prakash.sangappa" <prakash.sangappa@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dave.hansen@intel.com, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        khandual@linux.vnet.ibm.com
References: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com>
 <20180913084011.GC20287@dhcp22.suse.cz>
 <375951d0-f103-dec3-34d8-bbeb2f45f666@oracle.com>
 <20180914055637.GH20287@dhcp22.suse.cz>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <91988f05-2723-3120-5607-40fabe4a170d@oracle.com>
Date:   Fri, 14 Sep 2018 12:01:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180914055637.GH20287@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9015 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=12 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/2018 1:56 AM, Michal Hocko wrote:
> On Thu 13-09-18 15:32:25, prakash.sangappa wrote:
>> On 09/13/2018 01:40 AM, Michal Hocko wrote:
>>> On Wed 12-09-18 13:23:58, Prakash Sangappa wrote:
>>>> For analysis purpose it is useful to have numa node information
>>>> corresponding mapped virtual address ranges of a process. Currently,
>>>> the file /proc/<pid>/numa_maps provides list of numa nodes from where pages
>>>> are allocated per VMA of a process. This is not useful if an user needs to
>>>> determine which numa node the mapped pages are allocated from for a
>>>> particular address range. It would have helped if the numa node information
>>>> presented in /proc/<pid>/numa_maps was broken down by VA ranges showing the
>>>> exact numa node from where the pages have been allocated.
>>>>
>>>> The format of /proc/<pid>/numa_maps file content is dependent on
>>>> /proc/<pid>/maps file content as mentioned in the manpage. i.e one line
>>>> entry for every VMA corresponding to entries in /proc/<pids>/maps file.
>>>> Therefore changing the output of /proc/<pid>/numa_maps may not be possible.
>>>>
>>>> This patch set introduces the file /proc/<pid>/numa_vamaps which
>>>> will provide proper break down of VA ranges by numa node id from where the
>>>> mapped pages are allocated. For Address ranges not having any pages mapped,
>>>> a '-' is printed instead of numa node id.
>>>>
>>>> Includes support to lseek, allowing seeking to a specific process Virtual
>>>> address(VA) starting from where the address range to numa node information
>>>> can to be read from this file.
>>>>
>>>> The new file /proc/<pid>/numa_vamaps will be governed by ptrace access
>>>> mode PTRACE_MODE_READ_REALCREDS.
>>>>
>>>> See following for previous discussion about this proposal
>>>>
>>>> https://marc.info/?t=152524073400001&r=1&w=2
>>> It would be really great to give a short summary of the previous
>>> discussion. E.g. why do we need a proc interface in the first place when
>>> we already have an API to query for the information you are proposing to
>>> export [1]
>>>
>>> [1] http://lkml.kernel.org/r/20180503085741.GD4535@dhcp22.suse.cz
>>
>> The proc interface provides an efficient way to export address range
>> to numa node id mapping information compared to using the API.
> 
> Do you have any numbers?
> 
>> For example, for sparsely populated mappings, if a VMA has large portions
>> not have any physical pages mapped, the page walk done thru the /proc file
>> interface can skip over non existent PMDs / ptes. Whereas using the
>> API the application would have to scan the entire VMA in page size units.
> 
> What prevents you from pre-filtering by reading /proc/$pid/maps to get
> ranges of interest?

That works for skipping holes, but not for skipping huge pages.  I did a 
quick experiment to time move_pages on a 3 GHz Xeon and a 4.18 kernel.  
Allocate 128 GB and touch every small page.  Call move_pages with nodes=NULL 
to get the node id for all pages, passing 512 consecutive small pages per 
call to move_nodes. The total move_nodes time is 1.85 secs, and 55 nsec 
per page.  Extrapolating to a 1 TB range, it would take 15 sec to retrieve 
the numa node for every small page in the range.  That is not terrible, but 
it is not interactive, and it becomes terrible for multiple TB.

>> Also, VMAs having THP pages can have a mix of 4k pages and hugepages.
>> The page walks would be efficient in scanning and determining if it is
>> a THP huge page and step over it. Whereas using the API, the application
>> would not know what page size mapping is used for a given VA and so would
>> have to again scan the VMA in units of 4k page size.
> 
> Why does this matter for something that is for analysis purposes.
> Reading the file for the whole address space is far from a free
> operation. Is the page walk optimization really essential for usability?
> Moreover what prevents move_pages implementation to be clever for the
> page walk itself? In other words why would we want to add a new API
> rather than make the existing one faster for everybody.

One could optimize move pages.  If the caller passes a consecutive range
of small pages, and the page walk sees that a VA is mapped by a huge page, 
then it can return the same numa node for each of the following VA's that fall 
into the huge page range. It would be faster than 55 nsec per small page, but 
hard to say how much faster, and the cost is still driven by the number of 
small pages. 
 
>> If this sounds reasonable, I can add it to the commit / patch description.
> 
> This all is absolutely _essential_ for any new API proposed. Remember that
> once we add a new user interface, we have to maintain it for ever. We
> used to be too relaxed when adding new proc files in the past and it
> backfired many times already.

An offhand idea -- we could extend /proc/pid/numa_maps in a backward compatible
way by providing a control interface that is poked via write() or ioctl().
Provide one control "do-not-combine".  If do-not-combine has been set, then
the read() function returns a separate line for each range of memory mapped
on the same numa node, in the existing format.

- Steve
