Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68C6ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4458A20883
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 06:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2trOTXmi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4458A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeIQMYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 08:24:47 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37992 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbeIQMYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 08:24:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8H6sK8n061415;
        Mon, 17 Sep 2018 06:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=eykuGvaTLMPdRKcJG+YdIc2gWfitaYYNzl877cH5jkU=;
 b=2trOTXmik+zjoksHuOg44nzZR3dKHuR60/kYvvwYng93+xY0/XfeoqN0OQ1s3MzYHu9i
 OJXCUcJRy7EAkEedV1X6xRY/Sae9jDZ3HvSxW9BToRjAMaUUbhpvOOyKpH1m82vaExvq
 1hdDjaQktc1t38unFE2z6bg6QTVykWXvzZS0sk2MkHEOZs26ZYOiDc7ebneN/RhngSmr
 bDZ4hjazv0azxvnf+IcOPgozLsMSlAfrLftJIe6JLVgo9tSockIaYKqVlirNtCkjvTBc
 r2FZ/pN9RyvTBKYhzXhWdeLPBkVhVx2tnzOb9LzcGekSRZhEamNzjIkpepQVI4ieOKWd BA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mgtqqm6wu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 06:58:27 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8H6wMGu024625
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Sep 2018 06:58:22 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8H6wJOE007517;
        Mon, 17 Sep 2018 06:58:19 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Sep 2018 23:58:19 -0700
To:     Xuewei Zhang <xueweiz@google.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Kali <adityakali@google.com>, tytso@mit.edu,
        Guenter Roeck <groeck@chromium.org>, maze@google.com
Subject: Re: [PATCH] scsi: sd: Contribute to randomness when running rotational device
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180906203719.209399-1-xueweiz@google.com>
Date:   Mon, 17 Sep 2018 02:58:16 -0400
In-Reply-To: <20180906203719.209399-1-xueweiz@google.com> (Xuewei Zhang's
        message of "Thu, 6 Sep 2018 13:37:19 -0700")
Message-ID: <yq1zhwgr4on.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9018 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=568
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809170074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Xuewei,

> Currently a scsi device won't contribute to kernel randomness when it
> uses blk-mq. Since we commonly use scsi on rotational device with
> blk-mq, it make sense to keep contributing to kernel randomness in these
> cases. This is especially important for virtual machines.

Applied to 4.19/scsi-fixes, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
