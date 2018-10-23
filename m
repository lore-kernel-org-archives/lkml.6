Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC5C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3117920652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 13:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h5DjHWdk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3117920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeJWVms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 17:42:48 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36850 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWVmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 17:42:47 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9NDId3k059339;
        Tue, 23 Oct 2018 13:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=124ptN+JUR+plZzz6Z8tK2CBPA5dj0g8J8c7U27weCM=;
 b=h5DjHWdkknqE3K/pHYCpt6TnHC14ml45LE6gjOQvssVEDoBo4PM7sjQFjeZXkCiuOD6A
 OHqFaWxepNvM7U8ehRHTg7QgS/1Yf3ZW7VnVDC0DjYJriBC0NfzTvi8icbAml6D3XexW
 aeMkQMUiIrlYbBwLHRv7ywFVWbecyDM/yvr4aKCyLY00UzuqnA7OY4fKopRyq0yh1Vyn
 Eo8RaBXwl575wXXRLuZR4zk5occWepzuHJDt4RyO87u5v8IaADX+WGo9IWk1bgE8CAb3
 A/mKiKsyf68H8Klbufg262cY7nKOR3Z+XyabWiC7FYsbWvCz2t9Osi/VaxehExuPtCjv pw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2n7usu56dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 13:19:01 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9NDJ15k006274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 13:19:01 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9NDJ0kL011098;
        Tue, 23 Oct 2018 13:19:00 GMT
Received: from [10.152.33.198] (/10.152.33.198)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 23 Oct 2018 06:19:00 -0700
Subject: Re: [PATCH 09/10] sched/fair: disable stealing if too many NUMA nodes
To:     mingo@redhat.com, peterz@infradead.org
Cc:     subhra.mazumdar@oracle.com, dhaval.giani@oracle.com,
        rohit.k.jain@oracle.com, daniel.m.jordan@oracle.com,
        pavel.tatashin@microsoft.com, matt@codeblueprint.co.uk,
        umgwanakikbuti@gmail.com, riel@redhat.com, jbacik@fb.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-10-git-send-email-steven.sistare@oracle.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <629c5dc5-cde4-76de-4680-9fb5ecfd26cd@oracle.com>
Date:   Tue, 23 Oct 2018 09:18:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1540220381-424433-10-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810230111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/2018 10:59 AM, Steve Sistare wrote:
[...]
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index f18c416..b7d2070 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1337,6 +1337,30 @@ static void init_numa_topology_type(void)
>  	}
>  }
>  
> +DEFINE_STATIC_KEY_TRUE(sched_steal_allow);
> +static int sched_steal_node_limit;
> +#define SCHED_STEAL_NODE_LIMIT_DEFAULT 1

This is an oversight; I meant to suggest a value of 2.  All my 2-socket 
testing was done with stealing enabled.

- Steve
