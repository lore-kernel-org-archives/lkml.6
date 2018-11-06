Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03698C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A1F20830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XdC+5074"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0A1F20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbeKGDl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:41:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53430 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387745AbeKGDl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:41:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA6IEFVu154821;
        Tue, 6 Nov 2018 18:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=miOfMHUh8ogQ61eQGJ07YWpYEDhS/I0/q6CKu+pXRWo=;
 b=XdC+5074bdapcOsHXkrcJzU1StuZ1UvBvAEFV7Maqybc1fpTPSlNBF2wDPnYjMdtuZdd
 qlsp9KLSdTwE5OVNg0/cqGlYacytyHH8nSGx+yedLK8v1SzHrXKW32AgvLmwfFChmm/3
 kbpYUMmRRW035N+t25CJ60PEkNviKGhqiVz8EoVprbBk+g5NrGCLCsXOp3iieGl+k7nb
 8h1sEfDdpVe02xS9QRdh0YgSZ8KjJpi2DUlCZQ5xjloJkRoLXufhCuY7Q03r7PORlgqa
 5S5LAAcMHY7IUKXjuhPzRKRgjg20KOS9aFBv4Dfc3Qe+ViBYehGNO5adXF4zwugEn6Ne Vw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2nh3mpq09b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Nov 2018 18:14:35 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wA6IETn9021509
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Nov 2018 18:14:29 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wA6IESxA001477;
        Tue, 6 Nov 2018 18:14:28 GMT
Received: from [10.39.220.171] (/10.39.220.171)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Nov 2018 10:14:28 -0800
Subject: Re: [PATCH v2 00/10] steal tasks to improve CPU utilization
To:     Valentin Schneider <valentin.schneider@arm.com>, mingo@redhat.com,
        peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        linux-kernel@vger.kernel.org
References: <1541448489-19692-1-git-send-email-steven.sistare@oracle.com>
 <ed3d1b90-8473-0f81-9f78-2652adb047df@arm.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <7fd88831-2745-5697-e9a0-fa30e3de02b0@oracle.com>
Date:   Tue, 6 Nov 2018 13:14:24 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ed3d1b90-8473-0f81-9f78-2652adb047df@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9069 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=984
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811060158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/2018 12:52 PM, Valentin Schneider wrote:
> Hi Steve,
> 
> On 05/11/2018 20:07, Steve Sistare wrote:
> [...]
>> The patch series is based on kernel 4.19.0-rc7.  It compiles, boots, and
>> runs with/without each of CONFIG_SCHED_SMT, CONFIG_SMP, CONFIG_SCHED_DEBUG,
>> and CONFIG_PREEMPT.  It runs without error with CONFIG_DEBUG_PREEMPT +
>> CONFIG_SLUB_DEBUG + CONFIG_DEBUG_PAGEALLOC + CONFIG_DEBUG_MUTEXES +
>> CONFIG_DEBUG_SPINLOCK + CONFIG_DEBUG_ATOMIC_SLEEP.  CPU hot plug and CPU
>> bandwidth control were tested.
>>
> 
> There are some conflicts with misfit on 4.20-rc1 (nothing major, just that
> misfit logic appeared where the stealing logic wants to land), and git
> gets lost after a few conflict resolutions.
> 
> It's fine for testing on 4.19 - I just apply the misfit series then merge
> a branch with the steal patches to fix it all at once - but it makes
> playing around with 4.20-rc* more tedious.
> 

Thanks for powering through the merge.  I will update the patch for 4.20.

- Steve

