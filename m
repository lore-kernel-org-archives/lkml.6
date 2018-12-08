Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C304FC07E85
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E15320857
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 02:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T8XYf5BQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E15320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbeLHC34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 21:29:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54142 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeLHC3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 21:29:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB82ToEp027460;
        Sat, 8 Dec 2018 02:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Wj2nqcELyxTj1j0DhbMvRWhgyT3uEjMjvZ+ioJ/pPD8=;
 b=T8XYf5BQmeKyMyysIw28iEJHqpFmFUWqwexn1EwV514tvkQjo6eAUo5QDlQaZSIHliXY
 ZoTqEeIHO+O8y/iMzgbEn5Uy+Ol+G7wQcf9UeNvD7udWaZSX4kUip/4Vk9LfjxPTfVOK
 PQO9xgOht7UGdDFx66r5nyJStSLoUFrtlf7suQ25vK84ufc1dxPLSxzw32pimi2OY5pb
 N33ahnDKiE1wluDxPoUlTDFw0Avy05OvsaZoiWGKsO9umBc44AGQUD6oUTXLhoq3Vsun
 LqW0KYsv4k4kbLuTZTHM+xBfSpAmjSymMRG8nzrgAT4G/6Tjnjkb2DSYoGmwKzIbnDOp hA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2p3jxs0fkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 08 Dec 2018 02:29:50 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wB82To3G015912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Dec 2018 02:29:50 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wB82Tn5d008473;
        Sat, 8 Dec 2018 02:29:49 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Dec 2018 18:29:49 -0800
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        jrdr.linux@gmail.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: Re: [PATCH v2] drivers/scsi/fnic/fnic_trace.c: Use vzalloc
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <5bec5342.1c69fb81.b02fa.ace9@mx.google.com>
Date:   Fri, 07 Dec 2018 21:29:46 -0500
In-Reply-To: <5bec5342.1c69fb81.b02fa.ace9@mx.google.com> (Sabyasachi Gupta's
        message of "Wed, 14 Nov 2018 22:24:21 +0530")
Message-ID: <yq17egkoin9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9100 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=382
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812080021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sabyasachi,

> Replaced vmalloc + memset with vzalloc

Applied to 4.21/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
