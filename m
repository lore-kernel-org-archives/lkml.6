Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F13BECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9ACB21476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ttkeC51G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9ACB21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeIOGsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57014 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeIOGsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8F1SwDQ119105;
        Sat, 15 Sep 2018 01:31:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 from : mime-version : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=m7k3/NeflEMdfE01xpPI7kTDb4VHxozrR026ED1VUSo=;
 b=ttkeC51G3l7/qWyUOcrbMN7aAE1hCYFxTjp/yTpph5llrqfJGB7n2VzH9kqnW7NITVm4
 2zho0B9FpFSaPGco9RTJWUEN0FZHrkwrtff7+T73QzJVsN4/JcRquXk6I5k5aFJ2pnsD
 LIei6aWHr8XYpZUSNPvf0u4O64wrWu9J7tVrZqa242HNruTi5zYnlI3yJmRr1r4hsq5l
 qsxPCuC2QTN2QkbnK08NNMKMgGuXCkiDVqtWBzzeEly5wq/BiUjjAOWOUzq2L3cVj2Pm
 IKD0CwNFn4YKvWNX2N734OpjSbC3VICJAwAusCcwJC1NNS4XkdZ16+z27/omWOq5po2E 7w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mc5uu1pkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Sep 2018 01:31:06 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8F1V5V6024349
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 Sep 2018 01:31:05 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8F1V3rp029213;
        Sat, 15 Sep 2018 01:31:04 GMT
Received: from [10.159.141.100] (/10.159.141.100)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 18:31:03 -0700
Message-ID: <5B9C60D4.30106@oracle.com>
Date:   Fri, 14 Sep 2018 18:31:00 -0700
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nao.horiguchi@gmail.com,
        kirill.shutemov@linux.intel.com, khandual@linux.vnet.ibm.com,
        steven.sistare@oracle.com
Subject: Re: [PATCH V2 0/6] VA to numa node information
References: <1536783844-4145-1-git-send-email-prakash.sangappa@oracle.com> <20180913084011.GC20287@dhcp22.suse.cz> <375951d0-f103-dec3-34d8-bbeb2f45f666@oracle.com> <20180913171016.55dca2453c0773fc21044972@linux-foundation.org> <3c77cc75-976f-1fb8-9380-cc6ab9854a26@intel.com>
In-Reply-To: <3c77cc75-976f-1fb8-9380-cc6ab9854a26@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9016 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809150012
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2018 5:25 PM, Dave Hansen wrote:
> On 09/13/2018 05:10 PM, Andrew Morton wrote:
>>> Also, VMAs having THP pages can have a mix of 4k pages and hugepages.
>>> The page walks would be efficient in scanning and determining if it is
>>> a THP huge page and step over it. Whereas using the API, the application
>>> would not know what page size mapping is used for a given VA and so would
>>> have to again scan the VMA in units of 4k page size.
>>>
>>> If this sounds reasonable, I can add it to the commit / patch description.
> As we are judging whether this is a "good" interface, can you tell us a
> bit about its scalability?  For instance, let's say someone has a 1TB
> VMA that's populated with interleaved 4k pages.  How much data comes
> out?  How long does it take to parse?  Will we effectively deadlock the
> system if someone accidentally cat's the wrong /proc file?

For the worst case scenario you describe, it would be one line(range) 
for each 4k. Which would
be similar to what you get with  '/proc/*/pagemap'. The amount of data 
copied out at a
time is based on the buffer size used in the kernel. Which is 1024. That 
is if one line(one range)
printed is about 40 bytes(char), that means  about 25 lines per copy 
out.  Main concern would
be holding  'mmap_sem' lock, which can cause hangs. When the 1024 buffer 
gets filled the
mmap_sem is dropped and the buffer content is copied out to the user 
buffer. Then the
mmap_sem lock is reacquired and the page walk continues as needed until 
the specified user
buffer size is filed or till end of process address space is reached.

One potential issue could be that there is  a large VA range with all 
pages populated from
one numa node, then the page walk could take longer while holding 
mmap_sem lock. This
can be addressed by dropping and re-acquiring the mmap_sem lock after 
certain number of
pages have been walked(Say 512 - which is what happens in 
'/proc/*/pagemap' case).

>
> /proc seems like a really simple way to implement this, but it seems a
> *really* odd choice for something that needs to collect a large amount
> of data.  The lseek() stuff is a nice addition, but I wonder if it's
> unwieldy to use in practice.  For instance, if you want to read data for
> the VMA at 0x1000000 you lseek(fd, 0x1000000, SEEK_SET, right?  You read
> ~20 bytes of data and then the fd is at 0x1000020.  But, you're getting
> data out at the next read() for (at least) the next page, which is also
> available at 0x1001000.  Seems funky.  Do other /proc files behave this way?
>
Yes, SEEK_SET to the VA.  The lseek offset is the process VA. So it is 
not going to be
different from reading a normal text file.  Expect that  /proc files are 
special. Ex In
/proc/*/pagemap' file case, read enforces that seek/file offset and the 
user buffer size
passed in to  be a  multiple of the pagemap_entry_t  size or else the 
read would fail.

The usage for numa_vamaps file will be to SEEK_SET to the VA from where 
VA range
to numa node information needs to be read.

The  'fd' offset is not taken into consideration here, just the VA. Say 
each va range to numa
node id printed is about 40 bytes(chars). Now if  the read only read 20 
bytes, it would have read
part of the line. Subsequent read would read the remaining bytes of the 
line, which will
be stored in the kernel buffer.


