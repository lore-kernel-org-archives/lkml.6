Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD98C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A6922084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 08:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vnDGY9RS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6922084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbeJ2Ra0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 13:30:26 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49004 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbeJ2RaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 13:30:25 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9T8cb9b022333;
        Mon, 29 Oct 2018 08:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=D7NLud37n9ffGvg4g7MNVxLGBKFByEwVLNH/OyBT4B8=;
 b=vnDGY9RSEAjd4yY1NHYNeA0xaf1mGQULuYhShBbrJYrBANmDruEVitAW5ozKns0ZFHcm
 N16tipD3IVq9afyxaczwGEcMJhBwLBv9CT7TexpvefhynSuWzLt4LogshR36234+HcEP
 gl0HF/SNBVl0TQgyej2wYC67U6e3PCxWwu9AsC7D5QDcsJwonvIZU6CLrul3KGj4qVOx
 VD76G7VgxSdb/E4NEaPBcCiGcwjhyyxBQ+8gyMR7Z75ZWMJcRfeeY2+SwIm39xyAjtM4
 MEgevXzUYE/daOJOOopW3G/LRO5voTVJsdfxlWzl+jyBfdLwxcOktbTiipiCarr+9lw8 Ow== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2ncfypm8pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 08:42:42 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9T8gfft006483
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Oct 2018 08:42:41 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9T8gePj024343;
        Mon, 29 Oct 2018 08:42:40 GMT
Received: from [10.182.70.180] (/10.182.70.180)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Oct 2018 01:42:40 -0700
Subject: Re: [PATCH V3 1/4] blk-mq: refactor the code of issue request
 directly
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1540802013-2921-1-git-send-email-jianchao.w.wang@oracle.com>
 <1540802013-2921-2-git-send-email-jianchao.w.wang@oracle.com>
From:   "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <82b8ea32-2227-ca1b-5dbb-23e072148715@oracle.com>
Date:   Mon, 29 Oct 2018 16:42:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540802013-2921-2-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9060 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=645
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810290083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, please ignore this patchset.
I will re-send a new one.

Thanks
Jianchao
