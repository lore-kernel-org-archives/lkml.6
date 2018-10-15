Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B4EC71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EA420881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gioilvQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0EA420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJPCSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:18:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34720 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeJPCSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:18:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9FIOSeP010280;
        Mon, 15 Oct 2018 18:31:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=lP3s8su0hYbbuQqJ17aoW8Pq6QaJdWfCtPAiwg6se4k=;
 b=gioilvQ+vzOiH5rqVOLOIyJNbEM5Mv7pD3bq4h+39Rggr91GnepZA61Ynb//5aDmbYUI
 youfGluYpd4B7Wpy7rf4IakZCRoaJVPnM3D8kmM5RIDICuuQfs7bFkU6VI8HuYgrNDRD
 vNmk7GPGYlNB8nEWFEVrTdZkwb9dXb1BtWuzv+AIoZ4G4LcG/z4hcqqmXOKsq9ZeEy2/
 kPacCZoPMQ43BI1eLjMKsAAF8MoGHo8n+3cekP7wg/gfN+mYwjmcO09h2fP10Q7QYRrK
 oYv3uNo4eLNP3zzz84QZjsVvkU8uAShG3q9bpVaDymKbSS/Ew4/pE9D4pd70exvnw+U6 NQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2n39br42mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 18:31:48 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9FIVgKc008363
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Oct 2018 18:31:42 GMT
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9FIVdgK003714;
        Mon, 15 Oct 2018 18:31:39 GMT
Received: from [10.154.131.235] (/10.154.131.235)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 11:31:39 -0700
Subject: Re: [PATCH v13 01/11] cpuset: Enable cpuset controller in default
 hierarchy
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
References: <1539366951-8498-1-git-send-email-longman@redhat.com>
 <1539366951-8498-2-git-send-email-longman@redhat.com>
From:   Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <bfa8d0a2-ce78-8a0b-2a2e-45b02d6a8239@oracle.com>
Date:   Mon, 15 Oct 2018 12:31:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539366951-8498-2-git-send-email-longman@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=883
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810150160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2018 11:55 AM, Waiman Long wrote:
> Given the fact that thread mode had been merged into 4.14, it is now
> time to enable cpuset to be used in the default hierarchy (cgroup v2)
> as it is clearly threaded.
>
> The cpuset controller had experienced feature creep since its
> introduction more than a decade ago. Besides the core cpus and mems
> control files to limit cpus and memory nodes, there are a bunch of
> additional features that can be controlled from the userspace. Some of
> the features are of doubtful usefulness and may not be actively used.
>
> This patch enables cpuset controller in the default hierarchy with
> a minimal set of features, namely just the cpus and mems and their
> effective_* counterparts.  We can certainly add more features to the
> default hierarchy in the future if there is a real user need for them
> later on.

I really appreciate this simplification of the cpuset controller.

I currently have an in-house customer that is unhappy with the
way cgroups cpuset v1 handles offlined CPUs.  This patchset makes two
significant improvements over current cpuset v1 behavior.  1) It allows
for offlined CPUs to be added to a cpuset (even though the CPU is
offline) and 2) it restores CPUs back to the requested cpuset when they
come back online.  This is more intuitive and secure for my customers.
Thank you!

In part because of this patchset, I plan on proposing similar behavior
for offlined CPUs to cpuset v1.

Thanks.

Tom
