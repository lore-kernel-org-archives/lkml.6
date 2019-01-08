Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CF5C43444
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F5C2089F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfAHFPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:15:25 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:11274 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725838AbfAHFPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:15:25 -0500
X-IronPort-AV: E=Sophos;i="5.56,452,1539619200"; 
   d="scan'208";a="51530011"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 Jan 2019 13:15:17 +0800
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (unknown [10.167.33.85])
        by cn.fujitsu.com (Postfix) with ESMTP id 47EEB4BAC81A;
        Tue,  8 Jan 2019 13:15:15 +0800 (CST)
Received: from [10.167.225.53] (10.167.225.53) by
 G08CNEXCHPEKD03.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 8 Jan 2019 13:15:14 +0800
Subject: Re: [PATCH] xfs: correct statx's result_mask value
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     Eric Sandeen <sandeen@sandeen.net>, <linux-xfs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <suyanjun218@gmail.com>
References: <1546854790-5233-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190107175229.GJ12689@magnolia>
 <2b27e2ec-368b-d24c-8443-e265f87e417c@sandeen.net>
 <67e03af1-6e11-4236-76e6-6127b6cfb9b9@cn.fujitsu.com>
 <20190108050739.GQ12689@magnolia>
From:   "Su Yanjun <suyj.fnst@cn.fujitsu.com>" <suyj.fnst@cn.fujitsu.com>
Message-ID: <5c103aa0-8711-ceb3-38f8-dffe983526ff@cn.fujitsu.com>
Date:   Tue, 8 Jan 2019 13:15:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190108050739.GQ12689@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.53]
X-yoursite-MailScanner-ID: 47EEB4BAC81A.AE083
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: suyj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/2019 1:07 PM, Darrick J. Wong wrote:
> On Tue, Jan 08, 2019 at 12:58:43PM +0800, Su Yanjun <suyj.fnst@cn.fujitsu.com> wrote:
>>
>> On 1/8/2019 2:04 AM, Eric Sandeen wrote:
>>> On 1/7/19 11:52 AM, Darrick J. Wong wrote:
>>>> On Mon, Jan 07, 2019 at 04:53:10AM -0500, Su Yanjun wrote:
>>>>> For statx syscall, xfs return the wrong result_mask.
>>>>>
>>>>> Signed-off-by: Su Yanjun<suyj.fnst@cn.fujitsu.com>
>>>>> ---
>>>>>    fs/xfs/xfs_iops.c | 3 +++
>>>>>    1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
>>>>> index f48ffd7..3811457 100644
>>>>> --- a/fs/xfs/xfs_iops.c
>>>>> +++ b/fs/xfs/xfs_iops.c
>>>>> @@ -521,6 +521,9 @@ xfs_vn_getattr(
>>>>>    			stat->btime.tv_nsec = ip->i_d.di_crtime.t_nsec;
>>>>>    		}
>>>>>    	}
>>>>> +	
>>>>> +	/* Only return mask that we care */
>>>>> +	stat->result_mask &= request_mask;
>>>> Why not just:
>>>>
>>>> 	stat->result_mask = STATX_BASIC_STATS;
>>>>
>>>> at the top of the function?
>>>>
>>>> I don't see the need to mask off result_mask at all, since we could some
>>>> day elect to return more than what's in request_mask...
>> When we run xfstests with nfs, the generic/423 case runs failed. So i review
>> the nfs'
>> nfs_getattr code it does validate the request_mask.
>>
>> Then i review the xfs' getattr code, it has no such check. Whatever
>> request_mask
>>   is set, the stat's result_mask always the 0x7ff.
> Yes, statx can return more data than what userspace callers ask for:
>
>> Maybe it has Unclear semantics about statx's result_mask.
> "A filesystem may also fill in fields that the caller didn't ask for if
> it has values for them available and the information is available at no
> extra cost.  If this happens, the  corresponding  bits will be set in
> stx_mask."
>
> --D

I get it, then the testcase generic/423 may need update in xfstests.
Thanks for your reply.

>>>> ...waitaminute, are you seeing garbage in the result_mask that's
>>>> returned to userspace?  I also noticed the vfs stat functions declare
>>>> "struct kstat stat;" without explicitly zeroing the structure fields,
>>>> which means (I think) that we can leak stack information if the kernel
>>>> isn't built with the stackleak plugin?
>> No such problem.
>>> A clear problem statement and reproducer steps would be hugely useful
>>> here.
>>>
>>> -Eric
>> Thanks,
>> Su
>>
>>
>



