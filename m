Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAEAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D4920837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 19:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pbdA8GP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D4920837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeH3Xef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 19:34:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33644 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbeH3Xee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 19:34:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UJSdLR182993;
        Thu, 30 Aug 2018 19:30:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=25JiRmqtNjc4VfMRwk5ZJQsnlBuT2mNXfLcn03go/ZE=;
 b=pbdA8GP9fqvyuXnQNg3IAI+Oh2uLuL0QqrWRilgj90N2+q793uFgEsBX7v21LpZcTrw6
 MLt+4Do06NfpDoy/RSxPG2P7mUDO+lnUY3ERFek8aLnL3b4LeFZfyaZiqCfnVgIFvRa5
 sD0+kGnnuvttNLed9Q5L7VGPG4eakG9ukk2jc6c9nDyYOT8Nox5PX8ZmWlz7PiH6Xi94
 nhswI1tSdNBOnY32E3hVmorc7DcvtmV9BUZMQnMPZ9wj8mqf1GgfYj/gwJ5lznuHjAC7
 ne3+oXcRS6ueHC4DvQIPDXMBWAAiZSgMAr1K/NuBc3gy+jGuXCtzo8mmYRN8CffaDBp+ SA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2m2yrqpkap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 19:30:47 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7UJUkS0030042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 19:30:46 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7UJUj7J010725;
        Thu, 30 Aug 2018 19:30:45 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 12:30:45 -0700
Subject: Re: KMSAN: uninit-value in rds_bind
To:     syzbot <syzbot+915c9f99f3dbc4bd6cd1@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, syzkaller-bugs@googlegroups.com
References: <000000000000010a4d0574ab4743@google.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <c8126a9a-9669-b758-039d-3e920d1dcff9@oracle.com>
Date:   Thu, 30 Aug 2018 12:30:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <000000000000010a4d0574ab4743@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9001 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=582
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2018 11:31 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    2dca2cbde67a kmsan: fix build warnings with CONFIG_KMSAN=n
> git tree:       https://github.com/google/kmsan.git/master
> console output: https://syzkaller.appspot.com/x/log.txt?x=16db895a400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=820d6393634b55e3
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=915c9f99f3dbc4bd6cd1
> compiler:       clang version 8.0.0 (trunk 339414)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1137bffe400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1521a7fe400000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+915c9f99f3dbc4bd6cd1@syzkaller.appspotmail.com
> 
OK. Will send the fix to address this.

Regards,
Santosh

