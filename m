Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3197620651
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 01:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sVri7sll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfAQBHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 20:07:20 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:56248 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfAQBHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 20:07:20 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0H14ESo136681;
        Thu, 17 Jan 2019 01:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=2yaE5uM2adhOSD1zdQ+y4kx25xSnvz/OGPo4CJW2q+w=;
 b=sVri7slljbsysR9z2s5ZjYVrvfLW+DMJjJ8rrqEiZlDrg0kkjBkwdQRBY5aSIB6D3ADq
 Kl/kQM3ZhFmcS+V29+9C9OskQ4iMLOadi99OqN5oc/SRRwxrN1aFHAss+m4naAYVRrNZ
 mGA1u46CAjtT2N8s7tn2oY9i6toYuuSk1LiDxQCI02oRc1plnkDcT3heGImfzBbQjcSH
 wXDtTdc++Uilo7osVEBKpUANDqXwmP64rLUlmRiD2ttZkfXSDpDRraZZ6PjuxxraYqOy
 4toEBT7irvQ3JnjgQkxQYo/YAV2TjaPzDAIx/21bKL0dABRplBR3qO/fbR5hBT9rkxq7 2A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2pybjsd6ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 01:07:12 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0H17BPp013313
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 01:07:11 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0H17ARW031844;
        Thu, 17 Jan 2019 01:07:10 GMT
Received: from [10.159.231.6] (/10.159.231.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Jan 2019 17:07:10 -0800
Subject: Re: [PATCH] mm: hwpoison: use do_send_sig_info() instead of
 force_sig() (Re: PMEM error-handling forces SIGKILL causes kernel panic)
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e3c4c0e0-1434-4353-b893-2973c04e7ff7@oracle.com>
 <CAPcyv4j67n6H7hD6haXJqysbaauci4usuuj5c+JQ7VQBGngO1Q@mail.gmail.com>
 <20190111081401.GA5080@hori1.linux.bs1.fc.nec.co.jp>
 <20190116093046.GA29835@hori1.linux.bs1.fc.nec.co.jp>
 <97e179e1-8a3a-5acb-78c1-a4b06b33db4c@oracle.com>
 <20190116233207.GA5868@hori1.linux.bs1.fc.nec.co.jp>
From:   Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <6fa27824-d86d-f642-db7c-a13faaac527d@oracle.com>
Date:   Wed, 16 Jan 2019 17:07:09 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190116233207.GA5868@hori1.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9138 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901170005
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/16/2019 3:32 PM, Naoya Horiguchi wrote:
> Hi Jane,
> 
> On Wed, Jan 16, 2019 at 09:56:02AM -0800, Jane Chu wrote:
>> Hi, Naoya,
>>
>> On 1/16/2019 1:30 AM, Naoya Horiguchi wrote:
>>
>>      diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>      index 7c72f2a95785..831be5ff5f4d 100644
>>      --- a/mm/memory-failure.c
>>      +++ b/mm/memory-failure.c
>>      @@ -372,7 +372,8 @@ static void kill_procs(struct list_head *to_kill, int forcekill, bool fail,
>>                              if (fail || tk->addr_valid == 0) {
>>                                      pr_err("Memory failure: %#lx: forcibly killing %s:%d because of failure to unmap corrupted page\n",
>>                                             pfn, tk->tsk->comm, tk->tsk->pid);
>>      -                               force_sig(SIGKILL, tk->tsk);
>>      +                               do_send_sig_info(SIGKILL, SEND_SIG_PRIV,
>>      +                                                tk->tsk, PIDTYPE_PID);
>>                              }
>>
>>
>> Since we don't care the return from do_send_sig_info(), would you mind to
>> prefix it with (void) ?
> 
> Sorry, I'm not sure about the benefit to do casting the return value
> just being ignored, so personally I'd like keeping the code simple.
> Do you have some in mind?

It's just coding style I'm used to, no big deal.
Up to you to decide. :)

thanks,
-jane

> 
> - Naoya
> 
