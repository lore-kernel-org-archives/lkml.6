Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF84FC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A8A20869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LCgwtmKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69A8A20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJPKg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:36:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57890 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeJPKg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:36:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9G2ia5v178069;
        Tue, 16 Oct 2018 02:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=SLo9LGrIGQBXCm7ajdtz/OkgIttDcccQCDe1AJJNBpU=;
 b=LCgwtmKlLcjDjqAwqYX5OSk+8k4w0SgvUxNlU2nP/y3Bx4ZUntAw4VrQ0oUJCQ/X+KMD
 NrKxTP9UZJSBGlNUx2GoHmJJ/Ty/wwuAIZq0xMdpGATA6v7X8/j/whyuqjwarFnzfpjo
 9wsjwDh/JHGUfw4ZVpihYHS1+unnVfK2sD60q2RJwYdahlkFoLlOdW4ycEpyfU7M/RAD
 RAMur48cHMlWiwmLS/Z8IJ0l+RGQD881Up1sDz3LgYK6BpJR3th69OvdmZt6AsjPJ05u
 VwuVjzRMxjeWzZzBfSwWN8EN3xFdMBXfpNNA+/qis5PLWXZESjQ0w+Oz6+enZq13n1Vu Iw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2n39br5pha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 02:47:52 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9G2ljKx023602
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Oct 2018 02:47:46 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9G2lhpR025650;
        Tue, 16 Oct 2018 02:47:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Oct 2018 19:47:42 -0700
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
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
        <yq18t352o9l.fsf@oracle.com>
        <84512689-d898-e670-075d-509bbff20423@embeddedor.com>
Date:   Mon, 15 Oct 2018 22:47:40 -0400
In-Reply-To: <84512689-d898-e670-075d-509bbff20423@embeddedor.com> (Gustavo
        A. R. Silva's message of "Fri, 12 Oct 2018 14:26:58 +0200")
Message-ID: <yq1murewqsz.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9047 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=509
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810160021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

>> I'm not entirely convinced that all these identified fall through cases
>> are intentional. From a quick glance, some of them look like bugs...
>
> I took a second look at this and, certainly, the one below looks more like a
> bug. The rest seem to be false positives.

Yep.

>>> diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
>>> index bd6ac6b..8e1c45d 100644
>>> --- a/drivers/scsi/ips.c
>>> +++ b/drivers/scsi/ips.c
>>> @@ -3485,6 +3485,7 @@ ips_send_cmd(ips_ha_t * ha, ips_scb_t * scb)
>>>  
>>>  		case START_STOP:
>>>  			scb->scsi_cmd->result = DID_OK << 16;
>>> +			/* fall through */
>
> If you confirm this is an actual bug, I can send a separate fix.

I believe it is. So please do.

-- 
Martin K. Petersen	Oracle Linux Engineering
