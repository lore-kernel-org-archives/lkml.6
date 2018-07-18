Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF761ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB9520693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sOuMu2mF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB9520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbeGRDMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:12:32 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36756 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbeGRDMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:12:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2YvU7175002;
        Wed, 18 Jul 2018 02:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=mpn0FBerLmxLPSmluCa5MQNY5jh7SNzhigyM5FVz7Kc=;
 b=sOuMu2mFh2hciCRSymq0vvxvIiXeV7KWyYliI0VItX2FS37522e+P/vo1vtPvHBSzK2C
 0Vfg3H1Sju/2O7fUJqB18IsE96F7Y4d254r2xOsJSQL/h8FIszUQ/37nWo946lBKFz1a
 lL5fpaR4inbSM6Uz51h9rl+CELw6cxSfYWYHo0WwHHcwEUKkPLqlRUoHq8sA/6pu/r2r
 d7BfrvX68jPMLizuuNouueCnoy1vZ5seIO2PfdGduQ2FpKHHxuaBMl1JiKJr1g/UdRex
 2p9iOaYhMXy42WSt+WkF3FoTWsxBBFoWyKLwLtztbzsza+ig+MKrfUeKQEQdJfJOs06K EQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2k7a3ju450-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:36:51 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2aodT023220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:36:50 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2amr8025377;
        Wed, 18 Jul 2018 02:36:49 GMT
Received: from [192.168.1.164] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:36:48 -0700
Subject: Re: [PATCH v2 1/2] mm: fix race on soft-offlining free huge pages
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "xishi.qiuxishi@alibaba-inc.com" <xishi.qiuxishi@alibaba-inc.com>,
        "zy.zhengyi@alibaba-inc.com" <zy.zhengyi@alibaba-inc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1531805552-19547-1-git-send-email-n-horiguchi@ah.jp.nec.com>
 <1531805552-19547-2-git-send-email-n-horiguchi@ah.jp.nec.com>
 <20180717142743.GJ7193@dhcp22.suse.cz>
 <773a2f4e-c420-e973-cadd-4144730d28e8@oracle.com>
 <20180718012817.GB12184@hori1.linux.bs1.fc.nec.co.jp>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <161a4a4c-4311-9d68-fe05-b22d7e33dd61@oracle.com>
Date:   Tue, 17 Jul 2018 19:36:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180718012817.GB12184@hori1.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17/2018 06:28 PM, Naoya Horiguchi wrote:
> On Tue, Jul 17, 2018 at 01:10:39PM -0700, Mike Kravetz wrote:
>> It seems that soft_offline_free_page can be called for in use pages.
>> Certainly, that is the case in the first workflow above.  With the
>> suggested changes, I think this is OK for huge pages.  However, it seems
>> that setting HWPoison on a in use non-huge page could cause issues?
> 
> Just after dissolve_free_huge_page() returns, the target page is just a
> free buddy page without PageHWPoison set. If this page is allocated
> immediately, that's "migration succeeded, but soft offline failed" case,
> so no problem.
> Certainly, there also is a race between cheking TestSetPageHWPoison and
> page allocation, so this issue is handled in patch 2/2.

Yes, the issue of calling soft_offline_free_page() for an 'in use' page
is handled in the new routine set_hwpoison_free_buddy_page() of patch 2/2.

Thanks,
-- 
Mike Kravetz
