Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB39EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694DE21871
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 04:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5mSiH0+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbeLSEZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 23:25:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:57866 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeLSEZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 23:25:15 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBJ4OQYM069438;
        Wed, 19 Dec 2018 04:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=AKyXuUYRO59kW8etP2eZC8G9FPELazOkNcN3PNNUgrE=;
 b=5mSiH0+fQPMKw8MfwSiG8qoKPECXHYwJTBaFcVoFHm1eyzRgcegr5dlsnA7lKgnnpekv
 baL/D2Bp5oNCi10Bguw88SYXJGyfD3pkr2NXQhEytphuyBnuRrk9ifrH/wMP7HnyxRw+
 mu6ukLSqt/t17OdljKsZqG1lO3y2Nzc7yhMUTALjDMDkifk7vVLzCFjIunFPmaPPgBca
 l6aXTbxl/vBf8VJg6xZkfhd5jY33OEgMDKwF5Nx5P27YXLWzUEHos03KJJNnw/vMH5v3
 kKr/ddV6KzUntfaWFvfMAIN/7MPUUHhFEiHQawdW3wxUzrZASMZHpYFvI2IPX9ht3/jj RQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2pcs1tq2c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Dec 2018 04:24:56 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBJ4OsTr020382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Dec 2018 04:24:55 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wBJ4OrRn006532;
        Wed, 19 Dec 2018 04:24:54 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Dec 2018 20:24:53 -0800
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        thenzl@redhat.com, hch@lst.de, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] megaraid: fix out-of-bound array accesses
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181206212252.36732-1-cai@lca.pw>
        <20181213132727.57058-1-cai@lca.pw>
Date:   Tue, 18 Dec 2018 23:24:50 -0500
In-Reply-To: <20181213132727.57058-1-cai@lca.pw> (Qian Cai's message of "Thu,
        13 Dec 2018 08:27:27 -0500")
Message-ID: <yq1y38mgn3h.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9111 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=27 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=808
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812190036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/drivers/scsi/megaraid/megaraid_sas_fp.c b/drivers/scsi/megaraid/megaraid_sas_fp.c
> index 59ecbb3b53b5..a33628550425 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fp.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fp.c
> @@ -1266,7 +1266,7 @@ void mr_update_load_balance_params(struct MR_DRV_RAID_MAP_ALL *drv_map,
>  
>  	for (ldCount = 0; ldCount < MAX_LOGICAL_DRIVES_EXT; ldCount++) {
>  		ld = MR_TargetIdToLdGet(ldCount, drv_map);
> -		if (ld >= MAX_LOGICAL_DRIVES_EXT) {
> +		if (ld >= MAX_LOGICAL_DRIVES_EXT - 1) {
>  			lbInfo[ldCount].loadBalanceFlag = 0;
>  			continue;
>  		}
> diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> index f74b5ea24f0f..49eaa87608f6 100644
> --- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
> +++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
> @@ -2832,7 +2832,7 @@ static void megasas_build_ld_nonrw_fusion(struct megasas_instance *instance,
>  		device_id < instance->fw_supported_vd_count)) {
>  
>  		ld = MR_TargetIdToLdGet(device_id, local_map_ptr);
> -		if (ld >= instance->fw_supported_vd_count)
> +		if (ld >= instance->fw_supported_vd_count - 1)
>  			fp_possible = 0;
>  		else {
>  			raid = MR_LdRaidGet(ld, local_map_ptr);

Kashyap, Sumit, Shivasharan: Please review!

-- 
Martin K. Petersen	Oracle Linux Engineering
