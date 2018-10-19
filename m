Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A707ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E24A220869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4mkCWFxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24A220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeJTAEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:04:05 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48412 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbeJTAEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:04:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9JFs0mI120653;
        Fri, 19 Oct 2018 15:57:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=woKs13d20C6/wsVlBqfLWm8nwMiYVwwEaqCRWryk7HQ=;
 b=4mkCWFxqMxofpp4gwCm4erVCG1R7IU5eaDnDbd4Jiqv2T+UNZf+OT/2iT2AJtvqgF25J
 17yt48xlXDWrzkkrCzcXQfYCfX6U1RiNwG1IUOCajmxxAryfZf71yCDizfNXfBIy9WHi
 r+B+z/7G7Z4kX18n3dERyhMphCyC9U6oCyVZd2BrAbhFckFSqcVhUZQek5g8oeX5HrLH
 rC3oQN1+/fOmzALMJ9oigJlgfvdbV22U0LLoizTKEA4fmfMbETR7NXh/1NjzCmC1fgU9
 Smv+QhEeQRtYJahnd1BSBAFP2Io6bwqMf1uwsZbAm28t3Bam1LblIEjdpk8ENeeYfoKi sw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2n38nqmuh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 15:57:21 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9JFvK7q001067
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Oct 2018 15:57:20 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9JFvKn2027668;
        Fri, 19 Oct 2018 15:57:20 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Oct 2018 08:57:20 -0700
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: don't check position contiguity for DISCARD in attempt_merge
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1539941093-32058-1-git-send-email-jianchao.w.wang@oracle.com>
Date:   Fri, 19 Oct 2018 11:57:18 -0400
In-Reply-To: <1539941093-32058-1-git-send-email-jianchao.w.wang@oracle.com>
        (Jianchao Wang's message of "Fri, 19 Oct 2018 17:24:53 +0800")
Message-ID: <yq15zxyj5ep.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9050 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=908
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810190141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jianchao,

> Discard command supports multiple ranges of blocks, so needn't
> checking position contiguity when merging. Let's do the same thing
> in attempt_merge as the blk_try_merge.

Discards need to be contiguous unless queue->limits.max_discard_segments
is bigger than 1. So if you remove this I think you need to add a
contiguity check in req_attempt_discard_merge().

-- 
Martin K. Petersen	Oracle Linux Engineering
