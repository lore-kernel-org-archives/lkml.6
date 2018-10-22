Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0001DC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA0120652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 19:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BnyYXnaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA0120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeJWDnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:43:12 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38568 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbeJWDnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:43:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MJIaWt138075;
        Mon, 22 Oct 2018 19:21:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=xadglORLiZqzm+SyQ1ZZS++6VS1vZZiJyP98IzvLdpU=;
 b=BnyYXnaDNhwq+THxdWhM3kCa7kkKisQYJxa0jtYYscA9L3ZnkL4l4Wa9TcGGeIYQqFOv
 qZxfM/KF9es+tqBEqY4o5YG17kxlTFQusc+dT1ae1zcbfWHClkIY5QXFov52mZ3neE37
 kQP39ux1FbincOZy+i9C+Y13f8ZitijXCLzuIJ5iTXPlzWj5ZKDRPGYXfwc7cCtd97U9
 FwHs9d1kBz8JIPl/p2B5a0A5/BIuQlZLZlHcOkY/LaMhqN3CnWbUI8tchs3jPt9yoC3u
 45lhbfAjTbX6iH3hFEGER1eNh9cvVePOfRh1U2eF/BFzjPFkZl2QD0x3Uwi8FGHDZ3x4 tQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2n7w0qgksm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 19:21:40 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9MJLcfG022290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 19:21:39 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9MJLbxZ006142;
        Mon, 22 Oct 2018 19:21:37 GMT
Received: from [10.39.206.107] (/10.39.206.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 12:21:37 -0700
Subject: Re: [PATCH 09/10] sched/fair: disable stealing if too many NUMA nodes
From:   Steven Sistare <steven.sistare@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, subhra.mazumdar@oracle.com,
        dhaval.giani@oracle.com, rohit.k.jain@oracle.com,
        daniel.m.jordan@oracle.com, pavel.tatashin@microsoft.com,
        matt@codeblueprint.co.uk, umgwanakikbuti@gmail.com,
        riel@redhat.com, jbacik@fb.com, juri.lelli@redhat.com,
        linux-kernel@vger.kernel.org
References: <1540220381-424433-1-git-send-email-steven.sistare@oracle.com>
 <1540220381-424433-10-git-send-email-steven.sistare@oracle.com>
 <20181022170604.GG3117@worktop.programming.kicks-ass.net>
 <1356a3cc-a9f2-6593-4737-1b20fc5daa75@oracle.com>
Organization: Oracle Corporation
Message-ID: <274b79fd-b001-3d30-3773-7f01940ca8a6@oracle.com>
Date:   Mon, 22 Oct 2018 15:21:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1356a3cc-a9f2-6593-4737-1b20fc5daa75@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/2018 2:47 PM, Steven Sistare wrote:
> On 10/22/2018 1:06 PM, Peter Zijlstra wrote:
>> On Mon, Oct 22, 2018 at 07:59:40AM -0700, Steve Sistare wrote:
>>> The STEAL feature causes regressions on hackbench on larger NUMA systems,
>>> so disable it on systems with more than sched_steal_node_limit nodes
>>> (default 2).
>>
>> How come? From a quick read the stealing is per LLC, where do we steal
>> across nodes?
> 
> See the complete explanation in this patch.  It is deeper than can be gleaned
> from a quick read.

I should have said a bit more.  Your quick take on stealing is correct, we do
not steal across nodes.  However, stealing reduces average run queue length which 
influences wake_affine migrations.  Now see the complete explanation.

- Steve


