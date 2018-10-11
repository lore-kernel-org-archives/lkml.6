Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B957C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9CB12082B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WGdDmbdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CB12082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeJKKN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 06:13:58 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55882 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeJKKN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 06:13:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9B2drZa004867;
        Thu, 11 Oct 2018 02:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=FdrwLWBVHg8GNj3FmRwEBr8/ImK9Wfo/8GCvJ+vhAvs=;
 b=WGdDmbdS55vnXhOkifZ1u8wcQgraJFujWKk19LdCcVv3yrUFHdfewht1RrlbNpH7o6Qa
 s4WRA4IuAK8A8R6b4OnhKL0MX5yFO0O5QlmWVmuHNCJuIOHFfNYFEnjvr900kKIhXC2Z
 7X/KAU3rtnfmxMtn82g+SBKWYyTawWcFSOdQkWna2vvQHqmbbmZF5ldhW2GRaPJBBIEq
 wXqANjPomq6hdRXE1wa2OsbybO/7VADk/j1k2gbLrb/BezP9Pdr5JgZKmUE6aGlupSeX
 k+dEMDc9dBpMuej3RyY4GIzKdP+I2J0Wfwv3IsurLEoBN8dExTSw4BVVJ4jJbmrYqZMk yg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2mxnpr7gbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 02:48:15 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9B2m7sC010814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Oct 2018 02:48:08 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9B2m6Vj027007;
        Thu, 11 Oct 2018 02:48:06 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Oct 2018 02:47:58 +0000
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Willem Riede <osst@riede.org>,
        Kai =?utf-8?Q?M?= =?utf-8?Q?=C3=A4kisara?= 
        <Kai.Makisara@kolumbus.fi>, esc.storagedev@microsemi.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        osst-users@lists.sourceforge.net
Subject: Re: [PATCH] scsi: mark expected switch fall-throughs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181003145535.GA24941@embeddedor.com>
Date:   Wed, 10 Oct 2018 22:47:02 -0400
In-Reply-To: <20181003145535.GA24941@embeddedor.com> (Gustavo A. R. Silva's
        message of "Wed, 3 Oct 2018 16:55:35 +0200")
Message-ID: <yq18t352o9l.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9042 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=451
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810110024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Gustavo,

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.

I'm not entirely convinced that all these identified fall through cases
are intentional. From a quick glance, some of them look like bugs...

> diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
> index bd6ac6b..8e1c45d 100644
> --- a/drivers/scsi/ips.c
> +++ b/drivers/scsi/ips.c
> @@ -3485,6 +3485,7 @@ ips_send_cmd(ips_ha_t * ha, ips_scb_t * scb)
>  
>  		case START_STOP:
>  			scb->scsi_cmd->result = DID_OK << 16;
> +			/* fall through */
>  
>  		case TEST_UNIT_READY:
>  		case INQUIRY:

-- 
Martin K. Petersen	Oracle Linux Engineering
