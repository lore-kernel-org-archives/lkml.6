Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB2CC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DF421533
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PPNUR5/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DF421533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbeHGTZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:25:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48038 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeHGTZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:25:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w77H4UQO012760;
        Tue, 7 Aug 2018 17:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=9hsiQhkFiuv9WHw8UXh7YXQEk7pre1hBwCz5ybxxGNQ=;
 b=PPNUR5/5E6LMFrvvHVGJCWWU3js0QVphaV0UbTN075wahfO4tpLjXlIsHzs/ayELNq6E
 sQL0OSaGjyFliJlZr+T6PMLqmqiq9plNI2O184sMLkah/YPdT4ojUWWnJ/da7JbKptCB
 WZG06OgLf5ZjePjeAGw6adVzCSnwkqAiFHIdJ5PE/4eKGhDXM0rvOcr1RQXzFSruzmv4
 TDTz1lZnO0TWX5POmMYKNSKkMsBlfO5uajzCxAvQBA0QCovvPE3Q3hLDDoBs8AYv1N3j
 jzDSRTwtmMvOGbyHC9P/jR5mQDaYDSHEX4fRs8LmGt2VNBk1JvXXdIRlsuFEQbP8eGwp 4g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kn4sptbd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Aug 2018 17:09:53 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w77H9qLe028544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Aug 2018 17:09:52 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w77H9qnj027293;
        Tue, 7 Aug 2018 17:09:52 GMT
Received: from [10.209.243.127] (/10.209.243.127)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Aug 2018 10:09:51 -0700
Subject: Re: [PATCH net-next] RDS: IB: fix 'passing zero to ERR_PTR()' warning
To:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com
References: <20180807113416.12680-1-yuehaibing@huawei.com>
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <62d6f34a-3bdc-8c32-bcae-cd55cf27a911@oracle.com>
Date:   Tue, 7 Aug 2018 10:09:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180807113416.12680-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8978 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=669
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808070171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/2018 4:34 AM, YueHaibing wrote:
> Fix a static code checker warning:
>   net/rds/ib_frmr.c:82 rds_ib_alloc_frmr() warn: passing zero to 'ERR_PTR'
> 
> The error path for ib_alloc_mr failure should set err to PTR_ERR.
> 
> Fixes: 1659185fb4d0 ("RDS: IB: Support Fastreg MR (FRMR) memory registration mode")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
Looks good. Thanks !!

Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
