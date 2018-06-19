Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99868C5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BF0204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="uNeozLZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BF0204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937183AbeFSCRl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:17:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55854 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937044AbeFSCRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:17:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5J2EC64021136;
        Tue, 19 Jun 2018 02:17:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=BBpLfvjRyuZFPGmfanq4TGIEVAfAJgcJujm/ggv6SaA=;
 b=uNeozLZTsrVCLQ+Vq2QlO2g8oCS7BMI5Ll2XDlVHhhnvBFVcm83T5YyBflLWAYBFZqZy
 UcZ/gMKVJ4RfIn3wNDVfX8iRv43IuUP7sRImGhxXSIQqsQc48CX0SNtKX6/i9018pUtg
 aY7QOuziZ8SiQrnN1qSye+huJVua4eiOSNEisWGM4ybCQMBMELJClK5m3TDA0qOSceiy
 tckIUXex/QW0mVFDLHnUfQspQ+bHSjtRDiWGKPDStudHf1RvVAfLiOlUGDz2iv4SyL35
 JAe0g/MY1h+FeYY+fOKC4hl6MhteadukCNzoQu5LH5N1K5ZZHcQ96QyWgIix05tvR7mE +A== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jmt01e9y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 02:17:33 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5J2HXVP031229
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 02:17:33 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5J2HW9Q003475;
        Tue, 19 Jun 2018 02:17:32 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jun 2018 19:17:32 -0700
To:     Luis Henriques <lhenriques@suse.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] scsi: scsi_debug: Fix memory leak on module unload
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180618160803.11674-1-lhenriques@suse.com>
Date:   Mon, 18 Jun 2018 22:17:29 -0400
In-Reply-To: <20180618160803.11674-1-lhenriques@suse.com> (Luis Henriques's
        message of "Mon, 18 Jun 2018 17:08:03 +0100")
Message-ID: <yq1k1qvikp2.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=677
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Luis,

> Since commit 80c49563e250 ("scsi: scsi_debug: implement IMMED bit")
> there are long delays in F_SYNC_DELAY and F_SSU_DELAY.  This can cause
> a memory leak in schedule_resp(), which can be invoked while unloading
> the scsi_debug module: free_all_queued() had already freed all sd_dp
> and schedule_resp will alloc a new one, which will never get freed.
> Here's the kmemleak report while running xfstests generic/350:

Applied to 4.18/scsi-fixes. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
