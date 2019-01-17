Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE64C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F08120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nYGS+/Tq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfAQIAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:00:48 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52886 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbfAQIAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:00:48 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0H7rmsf024693;
        Thu, 17 Jan 2019 08:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=BDM0Pqg3+g5RUeFfvlcXyYh6lh1jjjEGwMhySrdQMfQ=;
 b=nYGS+/Tq26EfePiWdrp9dQtOMvMQp5FdSlTgbL9xb/EVUwaMHpbDuVCF5S2EOgcjjg/7
 8DE+HAs7e7h2nyqEHi5GU6b2h0tBYUptuO4kzjZfmerqzHNlDmxr8Cqy3Qg2IYsuY2wg
 /DtRfjyfKzhIzCG0RUI8oULglKNd1xg+V/h+wwVVxEavDHwir+DoULV4A39KEFQ7bs3w
 3gN/pTYfo9sBcLcI9ZZWUcpw9dbOX0HsayGPpz1D85fP7c2rgCP7jipd68rAa5aWCW3r
 n567KaMGdSWmq55ZgGeBV9EUUk8tcaPHI7veD0xLi0S76VXav+OApn4pqlgnrUU8slp4 3Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2pybjsec4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 08:00:28 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0H80MTP006153
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Jan 2019 08:00:22 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0H80Gfi018697;
        Thu, 17 Jan 2019 08:00:16 GMT
Received: from kadam (/41.202.241.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Jan 2019 00:00:15 -0800
Date:   Thu, 17 Jan 2019 10:59:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ching Huang <ching2048@areca.com.tw>
Cc:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, colin.king@canonical.com
Subject: Re: [PATCH 2/3] scsi: arcmsr: Fix suspend/resume of
 ACB_ADAPTER_TYPE_B part 2
Message-ID: <20190117070227.GM4504@kadam>
References: <1547696703.4339.21.camel@Centos6.3-64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547696703.4339.21.camel@Centos6.3-64>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9138 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=940
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901170059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:45:03AM +0800, Ching Huang wrote:
> >From Ching Huang <ching2048@areca.com.tw>
> 
> Fix suspend/resume of ACB_ADAPTER_TYPE_B part 2.
> 

What does this look like from a user perspective?  Does it fail every
time or does it only fail sometimes?

What's the bug exactly?

There is no Fixes tag...

> Signed-off-by: Ching Huang <ching2048@areca.com.tw>
> ---
> 
> diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
> index a94c513..b98c632 100755
> --- a/drivers/scsi/arcmsr/arcmsr.h
> +++ b/drivers/scsi/arcmsr/arcmsr.h
> @@ -508,9 +508,9 @@ struct MessageUnit_A
>  struct MessageUnit_B
>  {
>  	uint32_t	post_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> -	uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];
> +	volatile uint32_t	done_qbuffer[ARCMSR_MAX_HBB_POSTQUEUE];

There is a well known rule of thumb that when someone uses "volatile"
in the kernel it means there is a locking problem...  Is this __iomem or
something?

>  	uint32_t	postq_index;
> -	uint32_t	doneq_index;
> +	volatile uint32_t	doneq_index;
>  	uint32_t	__iomem *drv2iop_doorbell;
>  	uint32_t	__iomem *drv2iop_doorbell_mask;
>  	uint32_t	__iomem *iop2drv_doorbell;
> diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
> index 5736434..88053b1 100755
> --- a/drivers/scsi/arcmsr/arcmsr_hba.c
> +++ b/drivers/scsi/arcmsr/arcmsr_hba.c
> @@ -1113,7 +1113,11 @@ static int arcmsr_resume(struct pci_dev *pdev)
>  	switch (acb->adapter_type) {
>  	case ACB_ADAPTER_TYPE_B: {
>  		struct MessageUnit_B *reg = acb->pmuB;
> -		reg->post_qbuffer[0] = 0;
> +		uint32_t i;
> +		for (i = 0; i < ARCMSR_MAX_HBB_POSTQUEUE; i++) {
> +			reg->post_qbuffer[i] = 0;
> +			reg->done_qbuffer[i] = 0;
> +		}

Is this cause by patch 1 changing the zalloc to regular alloc??  If so
then it should be folded into that patch instead of sent separately.

regards,
dan carpenter


