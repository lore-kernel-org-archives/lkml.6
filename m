Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55D4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E822170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VXSmsTdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50E822170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeI1Acx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:32:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37160 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeI1Acx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:32:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8RHx3P2146854;
        Thu, 27 Sep 2018 18:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=mjT2C6lHzgGUiU0fI0OkORjd+PtI20uVj1BfMezw4nY=;
 b=VXSmsTdnM5swEuIG8IC3n9v1L137RmFvzXAvvtAIxrYurA1ohsPQvfvtQ9E1e02dyZfW
 NOgbV5CE2N1h4aZtPXuqvPjSq5f2D8Jbv9uvd5AQjECTWMKCuuLJSDVTWsLJm8Nt6nYg
 kwTON7SJDvF57Qs7JsCblro/02beXKtS2f01AXBF+MW1SMrII4y7i2WGwpWcVfxZAinA
 lgYb2yL7CVkwkEj1k7U+4h5c7rlJTgtyximqR9v47ccTtDU2NpmLNmGr+amEVb7xnQ40
 p0nYa9HOOPGT0SzIw8e2EkzK5ZVzal9Jgd4GliK83gqbgAEzAAsZDITTqCvsXDGdfoAr Rw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mnvtv2hwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 18:12:42 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8RICf3q017513
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Sep 2018 18:12:41 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8RICeB1031756;
        Thu, 27 Sep 2018 18:12:41 GMT
Received: from [10.132.91.175] (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Sep 2018 11:12:40 -0700
Subject: Re: [RFC 00/60] Coscheduling for Linux
To:     "=?UTF-8?Q?Jan_H._Sch=c3=b6nherr?=" <jschoenh@amazon.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
References: <20180907214047.26914-1-jschoenh@amazon.de>
 <3336974a-38f7-41dd-25a7-df05e077444f@oracle.com>
 <90282ce3-dd14-73dc-fb9f-e78bb4042221@amazon.de>
 <a68891ae-468b-da35-61ee-a3136c6e64c1@oracle.com>
 <b95ff65d-04fe-642f-4878-a31db8875b0d@amazon.de>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <cb7ce9a8-2274-913a-62ff-7a84de9505f1@oracle.com>
Date:   Thu, 27 Sep 2018 11:12:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b95ff65d-04fe-642f-4878-a31db8875b0d@amazon.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9029 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=727
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809270167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/24/2018 08:43 AM, Jan H. Schönherr wrote:
> On 09/19/2018 11:53 PM, Subhra Mazumdar wrote:
>> Can we have a more generic interface, like specifying a set of task ids
>> to be co-scheduled with a particular level rather than tying this with
>> cgroups? KVMs may not always run with cgroups and there might be other
>> use cases where we might want co-scheduling that doesn't relate to
>> cgroups.
> Currently: no.
>
> At this point the implementation is tightly coupled to the cpu cgroup
> controller. This *might* change, if the task group optimizations mentioned
> in other parts of this e-mail thread are done, as I think, that it would
> decouple the various mechanisms.
>
> That said, what if you were able to disable the "group-based fairness"
> aspect of the cpu cgroup controller? Then you would be able to control
> just the coscheduling aspects on their own. Would that satisfy the use
> case you have in mind?
>
> Regards
> Jan
Yes that will suffice the use case. We wish to experiment at some point
with co-scheduling of certain workers threads in DB parallel query and see
if there is any benefit

Thanks,
Subhra
