Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F99C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEE0206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WWo1z+2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfAJIDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:03:11 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:57062 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfAJIDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:03:10 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0A7wiav117410;
        Thu, 10 Jan 2019 08:02:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : from :
 subject : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=kfdmoAhyWtoNrw/4cgQsOBYo7hQeJrbw9Et7QEngGYg=;
 b=WWo1z+2rYBmFBNviWCHk6CbHqPryirrKhrFRogKMshtiT07nbg04sCCdcFTPd3zMCFeG
 NxeNrzCTRhIz/DP+UxvdKDhDlUJpbfOlFJpXJOCJZuIp6XCT46B6w+UYgdeEJ2o+vxCe
 4gQUWUeQ1Ra0BtBo3xL84LONtSl5sB6hUi6xrphrRj/GoFcrX7IM5OGfKLlCm5ThJA24
 oQe/i9WFhUQw/w+AqABzgC0xbQn0kSIYL6Ay7A0BXcS2+h83hl6tXpODq/pl1Ajq+5UR
 rUshb7KKfO0vI/F1dB8ts3ErJ4BZalPjSkL3PP2lSCX1yEYhAjzYK52tydrcXX/AGyML wg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2ptj3e5v6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 08:02:58 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0A82vg7006708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 08:02:57 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0A82vnf004162;
        Thu, 10 Jan 2019 08:02:57 GMT
Received: from [10.191.19.190] (/10.191.19.190)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 00:02:57 -0800
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, longman@redhat.com,
        SRINIVAS <srinivas.eeda@oracle.com>
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
Subject: Question about qspinlock nest
Organization: Oracle Corporation
Message-ID: <e784a592-5dec-b0b3-6c70-d9ef775621d5@oracle.com>
Date:   Thu, 10 Jan 2019 16:02:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9131 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=743
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maintainer,


There is a question confused me for days. Appreciate an answer.

In below code, the comment says we never have more than 4 nested contexts.

What happen if debug and mce exceptions nest with the four, or we ensure 
it never happen?


/*
  * Per-CPU queue node structures; we can never have more than 4 nested
  * contexts: task, softirq, hardirq, nmi.
  *
  * Exactly fits one 64-byte cacheline on a 64-bit architecture.
  *
  * PV doubles the storage and uses the second cacheline for PV state.
  */
static DEFINE_PER_CPU_ALIGNED(struct qnode, qnodes[MAX_NODES]);

-- 
Thanks
Zhenzhong

