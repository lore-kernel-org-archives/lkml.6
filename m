Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCC8ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FE9D20869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3VwpxBit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FE9D20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbeJSXgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:36:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45290 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbeJSXgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:36:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9JFO90v088225;
        Fri, 19 Oct 2018 15:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=xO6mOkvKjTumL7VUnexCh0alTTod+vkexKmilM7Pe7M=;
 b=3VwpxBitjvImWvgUcV2PLbI2hvVzTMaAUQj8FHE6mFpS9OTzEolJlrRU0YC9MQsZwskE
 VsyQSYdirNKLxEO5bvtTPRKQA/4uKtEU67z1Vd3DigUe6eeG6iaYU6RlQJBe78LjKh8e
 FMB3u4AfSjQIlytr1chJa/5De6zi2tXWW1dgfCyQq8lkRVQzH6o6GVg5LzH4X/1JTn6l
 jxYyKAhbprpzJzbylt9pi6NdUfaMfii/DF/Bere/NzHzQQzZ7iDGO/zyzHzdXmJRs7VG
 zwjHzGBxSQ7um1PY2qAqk7lESyphz672XcVgv0+RS2CSfCLQCcZyK5MVcMJk5ZfyQ+vE 6w== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2n384umw3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 15:28:57 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9JFSuJC014183
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 15:28:57 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9JFSr4U010459;
        Fri, 19 Oct 2018 15:28:53 GMT
Received: from [10.154.131.112] (/10.154.131.112)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Oct 2018 08:28:53 -0700
Subject: Re: [PATCH v14 03/12] cpuset: Simply allocation and freeing of
 cpumasks
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
References: <1539635377-22335-1-git-send-email-longman@redhat.com>
 <1539635377-22335-4-git-send-email-longman@redhat.com>
From:   Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <daecd3d4-0fb9-dd50-3282-affad1d21bf3@oracle.com>
Date:   Fri, 19 Oct 2018 09:28:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539635377-22335-4-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=989
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/2018 02:29 PM, Waiman Long wrote:
> The previous commit introduces a new subparts_cpus mask into the cpuset
> data structure and a new tmpmasks structure.  Managing the allocation
> and freeing of those cpumasks is becoming more complex.
>
> So a number of helper functions are added to simplify and streamline
> the management of those cpumasks. To make it simple, all the cpumasks
> are now pre-cleared on allocation.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Thanks!

Reviewed-by: Tom Hromatka <tom.hromatka@oracle.com>
