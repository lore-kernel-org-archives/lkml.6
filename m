Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2BAC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C29E2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 04:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EXQysMYJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfADE6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 23:58:03 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40618 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfADE6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 23:58:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x044sRDu077447;
        Fri, 4 Jan 2019 04:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=0mQERALhTrEsrDYr9dcg0ectth3nEciBiWRbWNi54Fc=;
 b=EXQysMYJhQ48JjOnNMZl73p5NTdhOydgjRzoafRktdtPNm2blbW4VDp2lmw0zhTWY5nx
 xvHIq4QlJELIltBF+20OGhaHxpcFCR1WjD06K6VJf/vWxWmSttvFO8W16lj7QOsfJ3XK
 d5ZEL6kx5vSjiLAIKfobhJTD3wTF0Dhcc8nXVfdT8XvUqLcvJ1C4YwiBjfRxagqGuFrq
 VUIG6klEnumxvPg5ale8+itIM3gZJdVSn19Vb07RnctdFOkgpgWsUJTwSFHBAVmFT1E2
 Vvu3S4OWeBWRpm6T6+vsy993TYG0aaXH8OSBT7X8ykasdjMJ1TnpE2axQu6+ePX5VmvE AQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2pp1jra9wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jan 2019 04:57:46 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x044vjl6032351
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Jan 2019 04:57:45 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x044vf8i030947;
        Fri, 4 Jan 2019 04:57:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 03 Jan 2019 20:57:41 -0800
To:     "Ewan D. Milne" <emilne@redhat.com>
Cc:     dgilbert@interlog.com, Randall Huang <ihhuang@abmail.org>,
        Christoph Hellwig <hch@infradead.org>, huangrandall@google.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: associate bio write hint with WRITE CDB
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181226041504.66283-1-huangrandall@google.com>
        <20190103075133.GA5141@infradead.org>
        <20190103094755.GA96532@google.com>
        <e5bc96cd-1b48-3b7e-706f-4cbbd1a040a4@interlog.com>
        <6152b478ea77dacf57eef6f758ba795f756cd3da.camel@redhat.com>
Date:   Thu, 03 Jan 2019 23:57:38 -0500
In-Reply-To: <6152b478ea77dacf57eef6f758ba795f756cd3da.camel@redhat.com> (Ewan
        D. Milne's message of "Thu, 03 Jan 2019 16:40:41 -0500")
Message-ID: <yq1ef9t81fh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9125 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=677
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901040043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ewan,

> SBC-5 says that support for the grouping function is indicated by the
> GROUP_SUP bit in the Extended Inquiry VPD page (86h).  I'm not sure
> how many devices actually support that page though.  Probably most
> don't.

Several devices support it, albeit for various different purposes. It's
one of these wonderful features whose interpretation was left outside
the scope of the spec for a long time.

So even though we absolutely and positively need to make setting GROUP
NUMBER conditional on GROUP_SUP being reported, we also need additional
information from the storage about how the field should be interpreted.

The official way to report hinting is for the device to implement the IO
Advice Hints Grouping mode page. I wrote some code to support that but
no vendors that I know of ended up actually shipping an implementation.
A few implemented my older I/O class proposal but didn't ship that
either despite really convincing performance results.

If Randall has access to a device which implements hinting, I'd love to
know more.

-- 
Martin K. Petersen	Oracle Linux Engineering
