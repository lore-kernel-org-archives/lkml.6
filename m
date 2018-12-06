Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31D0C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E6C20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 06:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SemlZ3Zz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E6C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeLFGF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 01:05:29 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:48928 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbeLFGF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 01:05:28 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB65xi1C188185;
        Thu, 6 Dec 2018 06:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=sAO1Ecf1GQRWJWCXxLPVrvSWhqwMK08Ka3qMtMGlL5U=;
 b=SemlZ3ZzyqWXgNISwi7zubRuwGc7vjN+oM6aTRLxyF1fcYuo6LJ7R269AAJVOYxNY7vx
 LeFNbiGYwNSN0V0njKBurs6YJclTsupzLEnz04Cy5xr1DJg26FymXjVIaelHegvM3gkO
 DboZ/Zp9Wzxsr51m900pJCFp/8gQjMxt/CZ2YoCg3OIeXiCQtaByUhe441Ac88/RtAGS
 d7x7vzJURRremHFb/vnZMRhoc8DiYLZQFUt9JyV6vIsVTOvmSCOqCjPnIlgeCNmgHeUc
 mYZhoA37HetyyvWgBy0S/q37pSd4z69ZchXixvv5E/2fWuok49oleynbxnw8LWBWY7gV mQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2p3ftfa8y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Dec 2018 06:04:48 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB664ki6018055
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Dec 2018 06:04:46 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB664hHJ006278;
        Thu, 6 Dec 2018 06:04:43 GMT
Received: from [10.39.220.54] (/10.39.220.54)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 05 Dec 2018 22:04:43 -0800
Subject: Re: [PATCH] /proc/kpagecount: return 0 for special pages that are
 never mapped
To:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        adobriyan@gmail.com, vbabka@suse.cz, sfr@canb.auug.org.au,
        kirill.shutemov@linux.intel.com, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, alexander.h.duyck@linux.intel.com,
        hannes@cmpxchg.org, miles.chen@mediatek.com,
        n-horiguchi@ah.jp.nec.com
References: <1543963526-27917-1-git-send-email-anthony.yznaga@oracle.com>
 <20181205004836.GU10377@bombadil.infradead.org>
 <fa5b667d-ccfb-b11a-2aeb-b1007651f9ec@oracle.com>
 <20181205012534.GW10377@bombadil.infradead.org>
 <540f7690-5fcd-04d6-edb3-a44ebd09e70c@oracle.com>
 <20181205194409.GB11646@bombadil.infradead.org>
 <d9fa0325-690d-47cc-fc49-2606855f6a4f@oracle.com>
 <20181206042631.GA24603@bombadil.infradead.org>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
Organization: Oracle Corporation
Message-ID: <2f3606d3-ab1f-1d3e-4514-28db69a47eb2@oracle.com>
Date:   Wed, 5 Dec 2018 22:07:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181206042631.GA24603@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9098 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812060055
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/05/2018 08:26 PM, Matthew Wilcox wrote:
> On Wed, Dec 05, 2018 at 04:44:15PM -0800, Anthony Yznaga wrote:
>> On 12/05/2018 11:44 AM, Matthew Wilcox wrote:
>>> Nobody seems terribly interested in mapcount overflows.  I got no response
>>> to https://lkml.org/lkml/2018/3/2/991
>> Okay.  Thanks for the background.
>>
>> How about this, then:
> Acked-by: Matthew Wilcox <willy@infradead.org>

Thanks for all of the feedback, Matthew.

Andrew,
Would you like me to submit a revised patch?  An -mm tree diff?

Thanks,
Anthony
