Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B3FC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448EB21BC7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 01:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wRZU2Ix5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448EB21BC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbeHIDqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 23:46:43 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:47782 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbeHIDqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 23:46:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w791OQ2l034236;
        Thu, 9 Aug 2018 01:24:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ZZg4GrRXVCQFdPGxkd94HUqx6lv7QFogJn6j/7xWplI=;
 b=wRZU2Ix51PNqmUAdBbB2RqjtD4aV0VIElo1tYgz+cmWA3tcDirSS0oT2V7WMvVJnO/V6
 /DhHMuF7CjuZT/jRe+M08btRSd+nvtBnwjcDFMsIz5cKAK4x49MGJseaHVilAXuA/CDw
 LC22Oc0aE1Y1KQapLYWhHQ1niq0kh40I3foGEZ38GB6f1K4qwPIWCRHC4NStGJ8nlgi1
 T/He3B2MUnEiGkQbDOMhd8yiX7pxOGg232M0vdDAK4RxlH6JQ+3SxiDhmcV6u+RlUIGH
 h9p93Z8rpt6FgTLZtmrC6flaDupfMDNAgfkB/5ecl2TN4gPVeuy0VhhiUNPB4QJ9X82L bA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2kn1nd86w1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Aug 2018 01:24:26 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w791OPNb009542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Aug 2018 01:24:26 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w791OPj5012386;
        Thu, 9 Aug 2018 01:24:25 GMT
Received: from [10.182.69.179] (/10.182.69.179)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 08 Aug 2018 18:24:25 -0700
Subject: Re: [PATCH V2] blk-mq: count the hctx as active before allocate tag
To:     Jens Axboe <axboe@kernel.dk>
Cc:     tom.leiming@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1533722212-20327-1-git-send-email-jianchao.w.wang@oracle.com>
 <faf3e267-b6e6-7a44-2c14-91fd9bf63371@kernel.dk>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b0da11e4-d542-a4d0-545b-177ffedaabaa@oracle.com>
Date:   Thu, 9 Aug 2018 09:24:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <faf3e267-b6e6-7a44-2c14-91fd9bf63371@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8979 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=719
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808090014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens

On 08/08/2018 10:40 PM, Jens Axboe wrote:
> On 8/8/18 3:56 AM, Jianchao Wang wrote:
>> Currently, we count the hctx as active after allocate driver tag
>> successfully. The other shared-tags users could exhaust the driver
>> tags and starve a non-active and waiting-tag hctx. Count the hctx as
>> active before try to allocate driver tag to fix this.
> 
> Patch looks good, but please add some comments along the way.
> 

Yes, I will do that and post the V3.

Thanks
Jianchao
