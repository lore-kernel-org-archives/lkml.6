Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A74BFC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E013208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="twVVupp1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E013208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934989AbeFMHyp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:54:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57378 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934250AbeFMHyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:54:23 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5D7p7Ve044598;
        Wed, 13 Jun 2018 07:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=WBAZo9Sul9vuDX9ErGsd6XEQSeGdiQiobQmAa+DwAPo=;
 b=twVVupp1KlRhJmWrwSfUuHjAuUPF/kE1N/eKb9aBLyTGPywOsuzTXIEtfT3bhB1/4zhD
 CK3VxP0hi8fiYjAxLi7fHW3kqQl1u8poSiJCrZgz/YgZK5TMnZVICTbw0C4rEkDMcCHL
 s6TCsjIJY4OsLDGiN4mcg/RpViJyTsdgRV1w096FlGoy0Yt+xaEYo7PhCH+SlSIWNdl9
 F5J1HIEWMxQNwHsBt+Lo3vgNUvKq64bKRWBjuHmmh01jB+aBS/fLaED9OqTaQf/wBgKL
 2Pctowx969Y8jUiqErzYzUeI9UQx37o8lWO8QYjlEsWeT5AZNQ3a37A52UwZoeUH3lZe vQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2jjp6bs8c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 07:54:17 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5D7sGnq006803
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 07:54:16 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5D7sFmG022090;
        Wed, 13 Jun 2018 07:54:15 GMT
Received: from santoshs-mbp.lan (/69.181.241.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jun 2018 00:54:15 -0700
Subject: Re: KASAN: use-after-free Read in rds_cong_queue_updates
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+4c20b3866171ce8441d2@syzkaller.appspotmail.com>
Cc:     Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, rds-devel@oss.oracle.com,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <089e08e548431cd0f90565c9f4e5@google.com>
 <000000000000a643e4056e7d0db4@google.com>
 <CACT4Y+b+DFpa34E3UWzSYn6qy-BMmxN80ikdmU_xMe9x9JF2+Q@mail.gmail.com>
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <c1078f20-b8ea-7efe-8b39-0c75fd598e1d@oracle.com>
Date:   Wed, 13 Jun 2018 00:54:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+b+DFpa34E3UWzSYn6qy-BMmxN80ikdmU_xMe9x9JF2+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=391
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/18 12:51 AM, Dmitry Vyukov wrote:
> On Wed, Jun 13, 2018 at 4:51 AM, syzbot
> <syzbot+4c20b3866171ce8441d2@syzkaller.appspotmail.com> wrote:
>> syzbot has found a reproducer for the following crash on:
> 
> Woohoo! Please take a look, this is a top crasher.
> 
Will have a look Dmitry !!
