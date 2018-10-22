Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CC7C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AA6920663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eL2Wf8Mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA6920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbeJWDHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 23:07:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49846 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727748AbeJWDHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 23:07:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9MIiIrJ157874;
        Mon, 22 Oct 2018 18:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XFwxmK7iDoxHdWyToLU4Am7OJ7HnxcXSQILb4j0RfgY=;
 b=eL2Wf8MtlP4brC4E19V8dPAQJ3cIxSBOjTjuii99Xk74rxCHMNGIy4B9GOLBlRi/vWbV
 S1zBxPZxYFShC93B0oyTMKtJvFii/7v1IQ3vdJcfImoXEBhbk9FMQuaoVMklzg8ZItQZ
 A2vSstfz8Kj7FuBgsxbfJl/rY2eYx8k/c9h8AWf2ySftOgEoonT8wWP6mZLxCoJFLAp/
 oYcf1El7DC5Ylpl1WL3YVScr7Esa4S0A+Uyv7xM6+0bbNwogvKm7w/0yz8vkS7Ed/Tbp
 hEe1zJc8chqJo+VzxpSK72V+DHPFRajHGLLIvWD7nIbgIuKvqS6O2xNO71RlJXW44Wj+ jA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2n7vaprfk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 18:47:20 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9MIlIwp017732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Oct 2018 18:47:19 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9MIlI21017594;
        Mon, 22 Oct 2018 18:47:18 GMT
Received: from [10.39.206.107] (/10.39.206.107)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 11:47:18 -0700
Subject: Re: [PATCH 09/10] sched/fair: disable stealing if too many NUMA nodes
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
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <1356a3cc-a9f2-6593-4737-1b20fc5daa75@oracle.com>
Date:   Mon, 22 Oct 2018 14:47:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181022170604.GG3117@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=739
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810220160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/2018 1:06 PM, Peter Zijlstra wrote:
> On Mon, Oct 22, 2018 at 07:59:40AM -0700, Steve Sistare wrote:
>> The STEAL feature causes regressions on hackbench on larger NUMA systems,
>> so disable it on systems with more than sched_steal_node_limit nodes
>> (default 2).
> 
> How come? From a quick read the stealing is per LLC, where do we steal
> across nodes?

See the complete explanation in this patch.  It is deeper than can be gleaned
from a quick read.

- Steve
