Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45472C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0342A208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 04:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="migyHbcs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0342A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeLDENE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 23:13:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36108 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeLDENE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 23:13:04 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB44Bd6f033481;
        Tue, 4 Dec 2018 04:12:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=cl1Qb8Ff2PKHbyKChMfPlXaB7oxxT5awaOgK/aWrWvQ=;
 b=migyHbcsEI8+MK3VPEg4JCmB09ELZvrSheKDJGHJLI42krobDURd7mxQIDWWknFDuYI9
 UvBd7pRYFM+nua5wA85r+sp6gZI/emtrINtc2fITGizMRHf7r6g0Hw7mBaDu4qA1lByq
 5TU1cVC50aEbY3kplAQtCyffyhIARSgWBYkrqlkDzeYGV9RL8yMXu4XJdu2+zVjdu31C
 /2lRKzkYJ50XYzJt4LpEIvtBkmt3T0qFdw31w4SCHNVn6LdOISoq/YoBtIH0UsR7PUJm
 /g4WwSIYTJA3qfuMGQKqclsKUSihfLyksFp7NbYeX+yhO2d7HT28pAnXhMgpT/PwqUqx qQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2p3jxr9yaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Dec 2018 04:12:49 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB44CisP022284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Dec 2018 04:12:44 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB44CgNh013114;
        Tue, 4 Dec 2018 04:12:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 Dec 2018 20:12:42 -0800
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.vnet.ibm.com>, <martin.petersen@oracle.com>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: Re: [PATCH v3 4/4] scsi: hisi_sas: Add support for DIF feature for v3 hw
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1543838994-30028-1-git-send-email-john.garry@huawei.com>
        <1543838994-30028-5-git-send-email-john.garry@huawei.com>
Date:   Mon, 03 Dec 2018 23:12:39 -0500
In-Reply-To: <1543838994-30028-5-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Mon, 3 Dec 2018 20:09:54 +0800")
Message-ID: <yq1ftveszew.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9096 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=364
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812040035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> +static int hisi_sas_dif_dma_map(struct hisi_hba *hisi_hba,
> +				int *n_elem_dif, struct sas_task *task)
> +{
> +	struct device *dev = hisi_hba->dev;
> +	struct sas_ssp_task *ssp_task;
> +	struct scsi_cmnd *scsi_cmnd;
> +	int rc;
> +
> +	if (task->num_scatter) {
> +		ssp_task = &task->ssp_task;
> +		scsi_cmnd = ssp_task->cmd;
> +
> +		if (scsi_prot_sg_count(scsi_cmnd)) {
> +			*n_elem_dif = dma_map_sg(dev,
> +						 scsi_prot_sglist(scsi_cmnd),
> +						 scsi_prot_sg_count(scsi_cmnd),
> +						 task->data_dir);
> +

If you're only supporting DIF there is no DMA mapping or unmapping since
the PI is generated by or verified by the HBA. No additional data is
transferred to/from host memory. The protection scatterlist will be
NULL.

> +	switch (prot_op) {
> +	case SCSI_PROT_READ_INSERT:
> +		prot->dw0 |= T10_INSRT_EN_MSK;
> +		prot->lbrtgv = lbrt_chk_val;
> +		break;
> +	case SCSI_PROT_READ_STRIP:
> +		prot->dw0 |= (T10_RMV_EN_MSK | T10_CHK_EN_MSK);
> +		prot->lbrtcv = lbrt_chk_val;
> +		if (prot_type == SCSI_PROT_DIF_TYPE1)
> +			prot->dw4 |= (0xc << 16);
> +		else if (prot_type == SCSI_PROT_DIF_TYPE3)
> +			prot->dw4 |= (0xfc << 16);
> +		break;
> +	case SCSI_PROT_READ_PASS:
> +		prot->dw0 |= T10_CHK_EN_MSK;
> +		prot->lbrtcv = lbrt_chk_val;
> +		if (prot_type == SCSI_PROT_DIF_TYPE1)
> +			prot->dw4 |= (0xc << 16);
> +		else if (prot_type == SCSI_PROT_DIF_TYPE3)
> +			prot->dw4 |= (0xfc << 16);
> +		break;
> +	case SCSI_PROT_WRITE_INSERT:
> +		prot->dw0 |= T10_INSRT_EN_MSK;
> +		prot->lbrtgv = lbrt_chk_val;
> +		break;
> +	case SCSI_PROT_WRITE_STRIP:
> +		prot->dw0 |= (T10_RMV_EN_MSK | T10_CHK_EN_MSK);
> +		prot->lbrtcv = lbrt_chk_val;
> +		break;
> +	case SCSI_PROT_WRITE_PASS:
> +		prot->dw0 |= T10_CHK_EN_MSK;
> +		prot->lbrtcv = lbrt_chk_val;
> +		if (prot_type == SCSI_PROT_DIF_TYPE1)
> +			prot->dw4 |= (0xc << 16);
> +		else if (prot_type == SCSI_PROT_DIF_TYPE3)
> +			prot->dw4 |= (0xfc << 16);
> +		break;
> +	default:
> +		WARN(1, "prot_op(0x%x) is not valid\n", prot_op);
> +		break;
> +	}

DIF is WRITE_INSERT/READ_STRIP operations only.

> +		if ((prot_op == SCSI_PROT_READ_INSERT) ||
> +		    (prot_op == SCSI_PROT_WRITE_INSERT) ||
> +		    (prot_op == SCSI_PROT_WRITE_PASS) ||
> +		    (prot_op == SCSI_PROT_READ_PASS)) {
> +			unsigned int interval = scsi_prot_interval(scsi_cmnd);
> +			unsigned int ilog2_interval = ilog2(interval);
> +
> +			len = (task->total_xfer_len >> ilog2_interval) * 8;
> +		}

if (scmd->prot_flags & SCSI_PROT_TRANSFER_PI) {

> +	.sg_prot_tablesize	= HISI_SAS_SGE_PAGE_CNT,

Also not required if you're only doing DIF. There is no protection
scatterlist.

Anyway. Instead of throwing the DIX stuff away, let's figure out what
the problem is.

-- 
Martin K. Petersen	Oracle Linux Engineering
