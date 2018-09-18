Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C55ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5B120C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T57v/jbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5B120C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbeIRGD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:03:57 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57334 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbeIRGD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:03:57 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8I0U1Us018813;
        Tue, 18 Sep 2018 00:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=on63DCus8rOUtOO9jKg8gWmyGWKE66OvvMADvWncgSw=;
 b=T57v/jbePs13nuyYGQT1mzbOMsUZI87edxT9c9ej5x/0tq8mlRKLVQjaolDXtQXklF+E
 c8hIdf+cyehpR+fnFKWtl6yqxXs12LhBEbGktA3E4GTT8JvZVStA3nQLGknoUau5uCc0
 ZP63L11hVTeldE9SuZ9uKwTw3Xm2Hbul2MgkTESHLffkw7ckY7ziFHUqSvmrERuY1vhY
 T7rI/QXQg75xIvZAtjS4Rb4O18Os14u34tR2cs/Z7vx+XXl/o9xDfYAbQ9/yPMyWjumN
 8ZJrBOHqRAFU0DqRjbxwcVZpKcUZKbC6zuqaFZZ2GnbbsujJZEg9uRWsnvO7eVSMUyon Vg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mgsgthd9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 00:33:47 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8I0XkeR028135
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Sep 2018 00:33:46 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8I0Xjtt023953;
        Tue, 18 Sep 2018 00:33:45 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Sep 2018 17:33:45 -0700
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <3336974a-38f7-41dd-25a7-df05e077444f@oracle.com>
Date:   Mon, 17 Sep 2018 17:33:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907214047.26914-1-jschoenh@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9019 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809180003
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/2018 02:39 PM, Jan H. Schönherr wrote:
> This patch series extends CFS with support for coscheduling. The
> implementation is versatile enough to cover many different coscheduling
> use-cases, while at the same time being non-intrusive, so that behavior of
> legacy workloads does not change.
>
> Peter Zijlstra once called coscheduling a "scalability nightmare waiting to
> happen". Well, with this patch series, coscheduling certainly happened.
> However, I disagree on the scalability nightmare. :)
>
> In the remainder of this email, you will find:
>
> A) Quickstart guide for the impatient.
> B) Why would I want this?
> C) How does it work?
> D) What can I *not* do with this?
> E) What's the overhead?
> F) High-level overview of the patches in this series.
>
> Regards
> Jan
>
>
> A) Quickstart guide for the impatient.
> --------------------------------------
>
> Here is a quickstart guide to set up coscheduling at core-level for
> selected tasks on an SMT-capable system:
>
> 1. Apply the patch series to v4.19-rc2.
> 2. Compile with "CONFIG_COSCHEDULING=y".
> 3. Boot into the newly built kernel with an additional kernel command line
>     argument "cosched_max_level=1" to enable coscheduling up to core-level.
> 4. Create one or more cgroups and set their "cpu.scheduled" to "1".
> 5. Put tasks into the created cgroups and set their affinity explicitly.
> 6. Enjoy tasks of the same group and on the same core executing
>     simultaneously, whenever they are executed.
>
> You are not restricted to coscheduling at core-level. Just select higher
> numbers in steps 3 and 4. See also further below for more information, esp.
> when you want to try higher numbers on larger systems.
>
> Setting affinity explicitly for tasks within coscheduled cgroups is
> currently necessary, as the load balancing portion is still missing in this
> series.
>
I don't get the affinity part. If I create two cgroups by giving them only
cpu shares (no cpuset) and set their cpu.scheduled=1, will this ensure
co-scheduling of each group on core level for all cores in the system?

Thanks,
Subhra
