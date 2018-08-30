Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF01C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD0120661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rzSmCob4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD0120661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeHaBAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:00:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45304 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbeHaBAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:00:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UKtvER072283;
        Thu, 30 Aug 2018 20:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=imZIYTuL+6od1DXxpgvec6AlHdg/mPfRFfDZwYLIU3k=;
 b=rzSmCob436O9O4NQ1Llw4zx9R2iWISU6mlu7rvx+GeBUAZOoKKX8R42Y40AF6bFq/xx1
 +J1E045dqnzfkZFwZDPJXpyQZT8Uyla+OlMQOgjH16yiXK2/Siz92iT9T+C+x7xMaSwf
 r3WIwNBmHl3FSP+d1h9VFOmVYrYzFq4KT6rCuEV6tqD/uArC46d2aDALocqCYjfHz3PV
 fHlz4+IeS8jibllJA7WnCt6v7U5LPdOBO9AnpqNJfzIk1AnIJeNA3qFZWt0zp4uEkOuM
 eyuVbU6E49FCKfp//tE88WLT4YmX7cfXHqdskGf2hwig9o1T3ku03aqo2UT8jSKqigFB fA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2m2xhu7315-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 20:56:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7UKuf6J025549
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 20:56:41 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7UKueKk016649;
        Thu, 30 Aug 2018 20:56:40 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 13:56:40 -0700
Subject: Re: KMSAN: uninit-value in rds_bind
To:     syzbot <syzbot+915c9f99f3dbc4bd6cd1@syzkaller.appspotmail.com>,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000010a4d0574ab4743@google.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <355351e8-71fa-6db9-ad2a-43115cc2e80e@oracle.com>
Date:   Thu, 30 Aug 2018 13:56:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <000000000000010a4d0574ab4743@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9001 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=742
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300210
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

BTW, can you please fix your git url since this one doesn't work.
This tree is not vanila kernel.org tree(4.19.0-rc1+ #36), so would be
good to get the line numbers correct for sources.

Regards,
Snatosh
