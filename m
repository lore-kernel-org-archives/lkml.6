Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SORTED_RECIPS,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52951C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC18520C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 21:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k6pxkQKx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC18520C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbeGKVGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 17:06:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34438 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732939AbeGKVGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 17:06:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6BKwdtt064805;
        Wed, 11 Jul 2018 21:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=XTxBvsc0p4gSvfP15OY60Qe/rnfYsi/6eNL68xPz04o=;
 b=k6pxkQKxYAPqpHEyZaCQ74RFlrmy/hShuLCllSgzjFlvuGaQiLd91npIda+sQnG1ibUR
 0LpKpW2EqipftQMwOLgcCjIeXUCSe3eOxC028n8/pUhU3vHdVOEG871ks2RvmYLJHtf1
 6aAdNRAZhBhjh6BlVoB1JO5/B8ZI+UFHm+4IHs0KRuusZJLWWrfJNyhNu5MX/3pNU2FX
 I+V7cKYsmzxc4RymC7eQb5MTNH7XFG73MtJlsTGPYOtG4/KPbvMbL8H0g8kXhdoyavNQ
 DuQ9BBSAMvdQA2QTv/Mz11QR5PQ1g1WaRlBa4JtTMglsO6u0U/LwvCeG4tT/7Z4unQBK Ew== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2k2p7dyw71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 21:00:38 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6BL0b7t017603
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 21:00:37 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6BL0bp9025546;
        Wed, 11 Jul 2018 21:00:37 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 14:00:36 -0700
Subject: Re: KASAN: slab-out-of-bounds Read in rds_cong_queue_updates (2)
To:     syzbot <syzbot+0570fef57a5e020bdc87@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, syzkaller-bugs@googlegroups.com
References: <0000000000005274c40570be9f48@google.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <291f2ead-fdbe-f5bb-ebfa-aaa2583df9bb@oracle.com>
Date:   Wed, 11 Jul 2018 14:00:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <0000000000005274c40570be9f48@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=626
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110221
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/2018 12:55 PM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    0026129c8629 rhashtable: add restart routine in 
> rhashtable..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b7ced0400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b88de6eac8694da6
> dashboard link: 
> https://syzkaller.appspot.com/bug?extid=0570fef57a5e020bdc87
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0570fef57a5e020bdc87@syzkaller.appspotmail.com
> 
dup: syzbot+4c20b3866171ce8441d2@syzkaller.appspotmail.com
