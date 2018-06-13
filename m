Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F0D19C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B67208D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jtzJ0G2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B67208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935367AbeFMROy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:14:54 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35208 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934817AbeFMROv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:14:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5DHDoFp175761;
        Wed, 13 Jun 2018 17:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=T8CBkINUMRhHcPPbFW8oss6DM5Rv12u3zAEvXWJRSmE=;
 b=jtzJ0G2AizVH5xtppsV7fYm429jZW4x0GrGbS8YvnQhVhf2EbRLi8oF1uvHEnl/JEhbp
 bZQzcqwOrdfUjUkNdgx41+HEUXfsT1HhOi3yIJnOjBsiXVhXRbimuh9YnLYp4eQrnI6w
 eXFoilnIoW/goLUXxC+SiiCJZnhHw7bxg6TvSTpb5eh8yzgsOLPwHIWpSdLkTYhPiw/r
 TPhMZbTaTSNtV1T4sz1Lh/ZWKujeuuYjdSsDC1dQvZtFGBu3/7mvmCKBahTpwlhBm5Sr
 d/AhNNU/patrawgWNaYZQNw0BRwByyGmV194zl6g6WYtt5s/oZaTBbYwXO9D9ekDHFrr OA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jk0xqsphs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 17:14:43 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5DHEguC016248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 17:14:42 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5DHEe1k029346;
        Wed, 13 Jun 2018 17:14:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jun 2018 10:14:40 -0700
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Hannes Reinecke <hare@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Wen Xiong <wenxiong@linux.vnet.ibm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ipr: fix build on 32-bit architectures
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180608144617.2900894-1-arnd@arndb.de>
Date:   Wed, 13 Jun 2018 13:14:36 -0400
In-Reply-To: <20180608144617.2900894-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Fri, 8 Jun 2018 16:46:00 +0200")
Message-ID: <yq18t7itxqb.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8923 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=254
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> the conclusion was that drivers should generally assume that the
> barrier implied by writel() is sufficient for ordering DMA, so this
> reverts his change and instead removes the extraneous wmb() before it,
> which is no longer needed on any architecture now.

Applied to 4.18/scsi-fixes and squashed with Sinan's patch.

-- 
Martin K. Petersen	Oracle Linux Engineering
