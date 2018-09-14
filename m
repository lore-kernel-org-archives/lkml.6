Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5ABECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB8820881
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1kw4y0QD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DB8820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeINXXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:23:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59536 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbeINXXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:23:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8EI5s82099765;
        Fri, 14 Sep 2018 18:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=aw2uVSSo4luOAl/xmtZULD2VmfXuOLhxnuIUVhofiRc=;
 b=1kw4y0QDuGOSuEP37IUhGxdzbDfBT1LoAGgxnhoSnYo50oviaCaPz3Vi9BRYtllW+u7v
 8VEB3PwvpwQiw6mQaHgsEaDIJZjS0yl3ZQdiPRb46IZE3XpreTIrCSIX5JRu5GNXWtM5
 SPRmverA1EAcHzHOn4OsGnEB8AXxcYrVF7G886MpFxJz9rNdjVz5Hsw7+dbIxVchyN2u
 Du7mRO52uzw9JJYLvgRLqoxlRNFVmj7e3HEqGa5PlX2UtZhLRUE7WGeatozipBqzOHR7
 ECg6fE4leArW5stb2gYTWYognYAV0rH28W1NlAVAnaP+4IdTTH9LPJjN5BhG6oZvEt2d CA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2mc72r8frr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 18:08:03 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8EI7uxU023541
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Sep 2018 18:07:57 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8EI7tx0004297;
        Fri, 14 Sep 2018 18:07:55 GMT
Received: from dhcp-10-159-150-22.vpn.oracle.com (/10.159.150.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Sep 2018 11:07:55 -0700
Subject: Re: [RFC PATCH] Add /proc/<pid>/numa_vamaps for numa node information
To:     Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Anshuman Khandual <khandual@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        n-horiguchi@ah.jp.nec.com, Ulrich Drepper <drepper@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Horiguchi Naoya <nao.horiguchi@gmail.com>,
        steven.sistare@oracle.com
References: <2ce01d91-5fba-b1b7-2956-c8cc1853536d@intel.com>
 <33f96879-351f-674a-ca23-43f233f4eb1d@linux.vnet.ibm.com>
 <82d2b35c-272a-ad02-692f-2c109aacdfb6@oracle.com>
 <8569dabb-4930-aa20-6249-72457e2df51e@intel.com>
 <51145ccb-fc0d-0281-9757-fb8a5112ec24@oracle.com>
 <c72fea44-59f3-b106-8311-b5eae2d254e7@intel.com>
 <addeaadc-5ab2-f0c9-2194-dd100ae90f3a@oracle.com>
 <aaca3180-7510-c008-3e12-8bbe92344ef4@intel.com>
 <94ee0b6c-4663-0705-d4a8-c50342f6b483@oracle.com>
 <CAG48ez1YhHKTDHZoH2tEFaLk4LcCSw5G60=+KpGRaMQxvw1qLw@mail.gmail.com>
 <20180914062132.GI20287@dhcp22.suse.cz>
 <CAG48ez2RSn-EQkf-ahs41tOKpzt23JMGYZxUtWMRPe8c5jAq-A@mail.gmail.com>
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
Message-ID: <a1834be4-0f8e-9d07-1013-7477d3a5e6be@oracle.com>
Date:   Fri, 14 Sep 2018 11:07:53 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez2RSn-EQkf-ahs41tOKpzt23JMGYZxUtWMRPe8c5jAq-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9016 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809140185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/18 5:49 AM, Jann Horn wrote:
> On Fri, Sep 14, 2018 at 8:21 AM Michal Hocko <mhocko@kernel.org> wrote:
>> On Fri 14-09-18 03:33:28, Jann Horn wrote:
>>> On Wed, Sep 12, 2018 at 10:43 PM prakash.sangappa
>>> <prakash.sangappa@oracle.com> wrote:
>>>> On 05/09/2018 04:31 PM, Dave Hansen wrote:
>>>>> On 05/07/2018 06:16 PM, prakash.sangappa wrote:
>>>>>> It will be /proc/<pid>/numa_vamaps. Yes, the behavior will be
>>>>>> different with respect to seeking. Output will still be text and
>>>>>> the format will be same.
>>>>>>
>>>>>> I want to get feedback on this approach.
>>>>> I think it would be really great if you can write down a list of the
>>>>> things you actually want to accomplish.  Dare I say: you need a
>>>>> requirements list.
>>>>>
>>>>> The numa_vamaps approach continues down the path of an ever-growing list
>>>>> of highly-specialized /proc/<pid> files.  I don't think that is
>>>>> sustainable, even if it has been our trajectory for many years.
>>>>>
>>>>> Pagemap wasn't exactly a shining example of us getting new ABIs right,
>>>>> but it sounds like something along those is what we need.
>>>> Just sent out a V2 patch.  This patch simplifies the file content. It
>>>> only provides VA range to numa node id information.
>>>>
>>>> The requirement is basically observability for performance analysis.
>>>>
>>>> - Need to be able to determine VA range to numa node id information.
>>>>     Which also gives an idea of which range has memory allocated.
>>>>
>>>> - The proc file /proc/<pid>/numa_vamaps is in text so it is easy to
>>>>     directly view.
>>>>
>>>> The V2 patch supports seeking to a particular process VA from where
>>>> the application could read the VA to  numa node id information.
>>>>
>>>> Also added the 'PTRACE_MODE_READ_REALCREDS' check when opening the
>>>> file /proc file as was indicated by Michal Hacko
>>> procfs files should use PTRACE_MODE_*_FSCREDS, not PTRACE_MODE_*_REALCREDS.
>> Out of my curiosity, what is the semantic difference? At least
>> kernel_move_pages uses PTRACE_MODE_READ_REALCREDS. Is this a bug?
> No, that's fine. REALCREDS basically means "look at the caller's real
> UID for the access check", while FSCREDS means "look at the caller's
> filesystem UID". The ptrace access check has historically been using
> the real UID, which is sorta weird, but normally works fine. Given
> that this is documented, I didn't see any reason to change it for most
> things that do ptrace access checks, even if the EUID would IMO be
> more appropriate. But things that capture caller credentials at points
> like open() really shouldn't look at the real UID; instead, they
> should use the filesystem UID (which in practice is basically the same
> as the EUID).
>
> So in short, it depends on the interface you're coming through: Direct
> syscalls use REALCREDS, things that go through the VFS layer use
> FSCREDS.

So in this case can the REALCREDS check be done in the read() system call
when reading the /proc file instead of the open call?



