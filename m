Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 717AFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF44208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oZcKKumP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FF44208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965188AbeFOBl6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 21:41:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58926 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964986AbeFOBl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 21:41:56 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5F1eTvJ158129;
        Fri, 15 Jun 2018 01:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type : content-transfer-encoding; s=corp-2017-10-26;
 bh=KA1GKLcv1shouybnVBOti0n2P6plaNSDKgjoJdgw1CI=;
 b=oZcKKumPQjXu8RlzNyi+HvRVG8mj1TjTy8fNF/kFOt37BGRozkbuSOvv7x66xgj7XnUP
 v2pkI7dKc+RKglil8Wimh/oQD0+V9U+ky5NAUjMxjFO3GgK0B7mBoxESSrwflSYjLDxo
 TZSjbKFN1sgD1r+SkSqwXAY65Ibk1TgZt0ZxC/rxixrfj/wmJiBug+kKHFx4rFW5G5El
 HTgirNAKJtVEmZTJyg4b5M6eRG73uNF+ED6lSdWsKLgyET9D4uhgHTgscnjSefSFBM/P
 bGvD5O+cCP2O/zXv5nVmYFSzKYv+n16J40Pn8AH/nN+1gJY+DAZbGAKjub4YmonGTS0W 9g== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jk0xrf7pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 01:41:36 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5F1faxR010928
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 01:41:36 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5F1fZfW013334;
        Fri, 15 Jun 2018 01:41:35 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jun 2018 18:41:34 -0700
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Jeremy Cline <jeremy@jcline.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        stable@vger.kernel.org, Li Ning <lining916740672@icloud.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 128/268] scsi: sd: Keep disk read-only when re-reading partition
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180528100202.045206534@linuxfoundation.org>
        <20180528100216.627623125@linuxfoundation.org>
        <1528925110.2289.175.camel@codethink.co.uk>
Date:   Thu, 14 Jun 2018 21:41:30 -0400
In-Reply-To: <1528925110.2289.175.camel@codethink.co.uk> (Ben Hutchings's
        message of "Wed, 13 Jun 2018 22:25:10 +0100")
Message-ID: <yq1fu1oltbp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=532
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ben,

> (The log message about Write Protect status also reports the
> underlying SCSI device flag and not the combined ro flag, but maybe
> that was intentional.)

I'd prefer for the printk in question to reflect the device-reported
state, not the state of the block device.

> I think this commit should be reverted, both in stable and upstream.
> A proper fix would involve splitting the ro flag into two flags=E2=80=94o=
ne
> controlled by user-space and one read from the device=E2=80=94with the
> effective read-only status being the logical-or of those two.

I don't have a problem with distinguishing between current state and an
override flag in the block layer. However, I think an incremental patch
to fix that up is fine. SCSI devices don't typically switch write
protection state on a whim.

--=20
Martin K. Petersen	Oracle Linux Engineering
