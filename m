Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DA0C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544C921531
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 13:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bpuxgzAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544C921531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeJTWI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:08:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50770 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeJTWI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:08:29 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9KDs40q195987;
        Sat, 20 Oct 2018 13:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=50IKw/Hhogwq9S/6fB91SMx9jTvj0OjthHRSj8EhAzA=;
 b=bpuxgzArr611xldRvSHVMLIZjfgdW1uHt95zbrAzf8CZbxE5HEJ9YcAVR2X4UOrYgUU9
 6hlS2pLl/pJVt6IUTqE0MulNvWr+MqIf66cenGG+wQjXDHSyY7TktcWF48KbpGqKhP8q
 48co9j/OgUZgoXB7lro60XICVbZ0mry5pVjvs1deqlzlOdTA03WGnDK/zolAyL8MktN7
 UqzEKzina+T3yzlYMxHovWTQEli2dgwQKl4EkyQKprlKMaSBxI2PrAGSyiPYvB2nmOi1
 w85ivtTFE+5bfOcC4pUvB7o80uaj3n7hijy5XPP4gXngQNp232gOFEYxPQabYZ1p2X8a 3A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2n7vapgw4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Oct 2018 13:57:52 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9KDvltq019815
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Oct 2018 13:57:47 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9KDvk2Z016373;
        Sat, 20 Oct 2018 13:57:47 GMT
Received: from [10.191.20.190] (/10.191.20.190)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 20 Oct 2018 06:57:46 -0700
Subject: Re: [PATCH] block: don't check position contiguity for DISCARD in
 attempt_merge
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1539941093-32058-1-git-send-email-jianchao.w.wang@oracle.com>
 <yq15zxyj5ep.fsf@oracle.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <09103f89-35af-e4e5-fd7c-e3f48e6fda75@oracle.com>
Date:   Sat, 20 Oct 2018 21:57:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <yq15zxyj5ep.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9051 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810200131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin

On 10/19/18 11:57 PM, Martin K. Petersen wrote:
> 
> Jianchao,
> 
>> Discard command supports multiple ranges of blocks, so needn't
>> checking position contiguity when merging. Let's do the same thing
>> in attempt_merge as the blk_try_merge.
> 
> Discards need to be contiguous unless queue->limits.max_discard_segments
> is bigger than 1. So if you remove this I think you need to add a
> contiguity check in req_attempt_discard_merge().
> 
Yes.

I will send the V2 version next.

Thanks
Jianchao
