Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE97C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADD221557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LmW/eQ8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADD221557
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeHYDOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 23:14:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42772 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeHYDOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 23:14:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7ONYC0s072657;
        Fri, 24 Aug 2018 23:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=bxydiVmJvEpPkDM/iVLhTMRTL1MRu+kYnyejNNvHrZU=;
 b=LmW/eQ8WvgSKKQ7NsbVvjaMzI0pYtUaQA5mPce1Nw9xqKKmlwR5cYguIvFpIjaJd48jx
 v94Usb0QuGD/aVJ1ZTvNqND/nPdrJD5vdikvDDZXGeeUZfIbijDyFBPEOzHVxGYSzQuz
 o7x9A5BXyZI6DMJ2EtsmrU3EkkhEG01KzIZKeA8JJSHKnvZKDPA7gaZ/yrDpcnEzN0GA
 Q4FkOm9ojrduYNaPorrzhySaeYmjJgTuCL5X2ug8eC2ba+G02+SZqaEF4WX4DgsiJ6HF
 ztmNl7HA3gwo9tVSACh861+Tz0CL03EsCQEyW6PNx5nIrlmU46ePIRxl3nbYBqyTl6XJ 3w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2kxbdqjhha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 23:37:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7ONb2OK000333
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 23:37:02 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7ONb1Nn010794;
        Fri, 24 Aug 2018 23:37:01 GMT
Received: from oracle.com (/10.154.122.223)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Aug 2018 16:37:01 -0700
Date:   Fri, 24 Aug 2018 19:37:00 -0400
From:   Sowmini Varadhan <sowmini.varadhan@oracle.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+8967084bcac563795dc6@syzkaller.appspotmail.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, rds-devel@oss.oracle.com,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: KASAN: use-after-free Read in __rhashtable_lookup (2)
Message-ID: <20180824233700.GC31961@oracle.com>
References: <20180824230446.GA16891@oracle.com>
 <000000000000d8879a05743667a2@google.com>
 <CACT4Y+a6P+q8jtRrd=cAf5hWbqQO4CQdWUaCCX-ygRbGsWHnGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a6P+q8jtRrd=cAf5hWbqQO4CQdWUaCCX-ygRbGsWHnGQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8995 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=829
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808240235
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/24/18 16:10), Dmitry Vyukov wrote:
> You need a colon after dup.

I see.

> But this can't possibly be a dup of that bug. That bug was fixed in February:

Apologies, I unknowingly made a mistake in my 
syzbot-tiquette in that case,

I did not intend to *close* the bug as a dup, I was
merely trying to indicate that this is yet another 
manifestation of the original report with subject
"KASAN: use-after-free Read in rds_find_bound"

All of these problems are happening because we are missing
a synchronize_net() in rds_release.

A full description of the race conditon can be found in
https://www.spinics.net/lists/netdev/msg475074.html

If rds_release is going to nuke the rds_socket
it needs to sychronize_net() with other threads that may be
looking up the bind_hash_table. If we dont do that,
all of these "use-after-free" races can happen.
As long as we dont have the synchronize_net() we are
missing a big (and standard) bit of RCU synchronization.

--Sowmini



