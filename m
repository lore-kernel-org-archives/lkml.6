Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFE8ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936FB204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eEbUu64i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936FB204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeJRIr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:47:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50104 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeJRIr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:47:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9I0nVtj132213;
        Thu, 18 Oct 2018 00:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=/ifoaiLPddnu34zg2s9LEgudV3ZYIG6mnxrtqXZTiG0=;
 b=eEbUu64iclFMeJd98AyE2PU3IfBJHTIvfEoemijXwsS2mLbqrGugow/nizriim18XOEf
 eDdiQpsHkZ9wpUZW6tANlPCSER7iFMx+Bigd8ZUTxfCKMH6GmDfovYbwclMghogQHe2V
 5AuIR/4UfoUZ+DoYb7aJJy5FDnoOvce3/hDWzY+BIyu/ysLMfJNRS2tCxu4N96X921W2
 5EkRQQrRTc7p2gxbdJKqMuFOW7NWBQVZrPnXj4lN9z6kYH/EnJ/DbkV9KIy0eWYH8KPo
 j+BWoVcQYd0SddOSdY0udL/7Ag5gUnKNtg4AHmN1A3BLOQ+k+cugdDmyPwS3itAYMx51 sw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2n38nqa3b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 00:49:33 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9I0nW6Y031497
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Oct 2018 00:49:32 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9I0nWmb018787;
        Thu, 18 Oct 2018 00:49:32 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Oct 2018 17:49:32 -0700
To:     Evan Green <evgreen@chromium.org>
Cc:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        sayalil@codeaurora.org
Subject: Re: [PATCH] scsi: ufs: Schedule clk gating work on correct queue
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181005172732.203793-1-evgreen@chromium.org>
Date:   Wed, 17 Oct 2018 20:49:30 -0400
In-Reply-To: <20181005172732.203793-1-evgreen@chromium.org> (Evan Green's
        message of "Fri, 5 Oct 2018 10:27:32 -0700")
Message-ID: <yq1bm7sm63p.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9049 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=899
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810180007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Evan,

> With commit 10e5e37581fc ("scsi: ufs: Add clock ungating to a separate
> workqueue"), clock gating work was moved to a separate work queue with
> WQ_MEM_RECLAIM set, since clock gating could occur from a memory
> reclaim context. Unfortunately, clk_gating.gate_work was left queued
> via schedule_delayed_work, which is a system workqueue that does not
> have WQ_MEM_RECLAIM set.

Applied to 4.20/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
