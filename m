Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E17BC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30D6205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="48e264x2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30D6205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeHaAwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:52:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37984 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeHaAwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:52:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UKiUZB063112;
        Thu, 30 Aug 2018 20:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=raxuU5+0NgX6UYLzNJ9CScyRlgdVTDbu8V2Fnp3kY6g=;
 b=48e264x2frAc1unP4we9kar8lk/RwCSqhw+8NC0n5zo1oY4RxJcCO0bPUyxqh9ULHTgH
 Dn5UKfeDD3C6bCKKYlCWCY3OnmduEGLn25u7d1AenuSD0xUOOTPmvicxeyuLubqoIFIJ
 RRFuS3AbsMPEou6nVfp5MWmULahhU/GdWRQ1AGnYNqrKWqbMYqas6XKj50WK5xlKsJXB
 Kjirsni4gjedb6fiGJj053zSArmciTYS9a+KsCNSAXksKY9kkJqQcWqgmZL702twcovb
 4HoR3mDhFn3FBUjwVCXf89cYN6X7UOI7JxcNk5jwl3XyS8KqbwixnvlFHvdn2zKZY93Z 3Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2m2xhu71p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 20:48:10 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7UKmAcP008692
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 20:48:10 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7UKm9JH017126;
        Thu, 30 Aug 2018 20:48:09 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 13:48:08 -0700
Subject: Re: [RFC PATCH 0/2] Pipe busy wait
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, dhaval.giani@oracle.com,
        steven.sistare@oracle.com
References: <20180830202458.32579-1-subhra.mazumdar@oracle.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <dc4f324f-3c14-6cc1-deb2-5ca2022db804@oracle.com>
Date:   Thu, 30 Aug 2018 13:48:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830202458.32579-1-subhra.mazumdar@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9001 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=676
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/30/2018 01:24 PM, subhra mazumdar wrote:
> This patch introduces busy waiting for pipes similar to network sockets.
> When pipe is full or empty a thread busy waits for some microseconds before
> sleeping. This avoids the sleep and wakeup overhead and improves
> performance in case wakeup happens very fast. It uses new fields in
> pipe_inode_info to decide how much to spin and if data has been written or
> read during spin. As different workloads on different systems can have
> different optimum spin time, it is configurable via a tunable that can be
> set via /proc. The default value is 0 which indicates no spin.
Hi,

Looking for comments on how useful you think this is. Network sockets does
similar. Some workloads other than hackbench didn't show any improvement.
Also for some it may regress. I initially tried to find the optimum spin
time for all workloads and systems but realized that is extremely
challenging. Given all these it is best to have a tunable and can be set if
beneficial. Also looking for more workloads suggestions that can benefit.

Thanks,
Subhra
>
> Following are the hackbench process run times using pipe for different
> sized systems with baseline and suitable spin time.
>
> Hackbench on 2 socket, 36 core and 72 threads Intel x86 machine
> (lower is better):
> groups  baseline     patch(spin=10us)
> 1       0.603        0.614 (-1.82%)
> 2       0.673        0.527 (21.7%)
> 4       0.765        0.638 (16.6%)
> 8       1.935        1.114 (42.43%)
> 16      7.314        2.007 (72.56%)
> 32      6.215        3.585 (42.32%)
>
> Hackbench on 1 socket, 16 core and 32 threads Intel x86 VM
> (lower is better):
> groups  baseline     patch(spin=10us)
> 1       1.314        0.747 (43.15%)
> 2       1.454        0.754 (48.14%)
> 4       3.409        1.343 (60.6%)
> 8       6.879        2.559 (62.8%)
> 16      9.82         4.951 (49.58%)
>
> Hackbench on 1 socket, 4 core and 8 threads Intel x86 VM
> (lower is better):
> groups  baseline     patch(spin=5us)
> 1       2.827        1.455 (48.53%)
> 2       6.201        2.805 (54.77%)
> 4       9.514        5.008 (47.36%)
> 8       14.571       8.422 (42.2%)
>
> Hackbench on 1 socket, 1 core and 2 threads Intel x86 VM
> (lower is better):
> groups  baseline     patch(spin=5us)
> 1       3.365        2.948 (12.39%)
> 2       6.82         6.535 (4.18%)
> 4       13.18        13.025 (1.18%)
>
> subhra mazumdar (2):
>    pipe: introduce busy wait for pipe
>    pipe: use pipe busy wait
>
>   fs/pipe.c                 | 58 +++++++++++++++++++++++++++++++++++++++++++++--
>   include/linux/pipe_fs_i.h | 20 ++++++++++++++++
>   kernel/sysctl.c           |  7 ++++++
>   3 files changed, 83 insertions(+), 2 deletions(-)
>

