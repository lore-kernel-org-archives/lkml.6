Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C08C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8A220936
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qs7/PCOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8A220936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbeGKCyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:54:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41868 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732389AbeGKCye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:54:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6B2iACk007554;
        Wed, 11 Jul 2018 02:52:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=iEkw6nbj4lNNSNtIp6hF8Qm5+SoqMiW1lgqR3d+h3qI=;
 b=Qs7/PCOE8mk9f4q2VNUmRmVLkAQd37uvNS9oFY66Z8cIMb7JYqB9kX/Iq0okZKKijhAw
 CmZ2maXA1Y8r4RsnBl5GjCUsMog/gwyEgxAIbF6QJW3LMRgOgvjs3OP6Vj/bKdLlVwaF
 xJ8D2B7u6nSPogWXn9y5KgD15K8rA0LXVIlFv8N5O6Q600XorWVp+IDl6yb0zYkLYLEK
 LZVMA+IHQH2vY+o2e/5C6sEzlbTfkVfaZWJn7FuJs1XlnGgTHOJnz7ByHM1ZL0iQ2tBG
 /hm4fGW1yr59S3Bl0r+KacQ/hIQ9B8vwYGLVoHcY7zqgk07ucDFaKd6MxbYgLWZsS9z8 ug== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2k2p764c1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 02:52:26 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6B2qP5v026047
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 02:52:25 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6B2qOOJ017749;
        Wed, 11 Jul 2018 02:52:24 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Jul 2018 19:52:24 -0700
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: switch to scsi-mq by default
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180704085356.10888-1-jthumshirn@suse.de>
Date:   Tue, 10 Jul 2018 22:52:21 -0400
In-Reply-To: <20180704085356.10888-1-jthumshirn@suse.de> (Johannes Thumshirn's
        message of "Wed, 4 Jul 2018 10:53:56 +0200")
Message-ID: <yq1d0vupjq2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8950 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=408
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Johannes,

> It has been more than one year since we tried to change the default
> from legacy to multi queue in SCSI with commit c279bd9e406 ("scsi:
> default to scsi-mq"). But due to issues with suspend/resume and
> performance problems it had been reverted again with commit
> cbe7dfa26eee ("Revert "scsi: default to scsi-mq"").
>
> In the meantime there have been a substantial amount of performance
> improvements and suspend/resume got fixed as well, thus we can
> re-enable scsi-mq without a significant performance penalty.

Applied to 4.19/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
