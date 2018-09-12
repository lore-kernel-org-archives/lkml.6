Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42401C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C815620839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mcEGkcrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C815620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeILFuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:50:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55294 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeILFuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:50:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8C0hgZN073291;
        Wed, 12 Sep 2018 00:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=vG6mbgvlOh6z84z7ZlYsCejpPd3kGcOIh/PDuzAIDxA=;
 b=mcEGkcrbGtFTWEw9qDzjXc/EFcH3VaB9/Q84pWehwqNOVFiVcBs8/OoF/ivth0k3JbWg
 zGd9PAnSrahTKC/tofng5cjx0+jhHaqyS+bq7SaYATNOIiNMtcHk1fVihNw817x/Sg77
 k0m0kUdWLEvx/0zVLi5EJBnRvMunFLG4owthP56ouyJj9St1oUUOcOgl819ZmO8VVcNa
 Mm3B3BDZFGrFRE0LG9ieJKdyoV0/l8az7fBSFoutl6G8rlSG2la4E0UitR1NpRhp+n6Z
 QD0YET0hcGUnyNE7nU+twj94MjQNQDqv0EUmHLXAuDCr+BEpk2yAKs014pB0G6EG+wRG 5Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2mc6cpq8sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 00:48:26 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8C0mPQ0005389
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 00:48:25 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8C0mPGA020000;
        Wed, 12 Sep 2018 00:48:25 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Sep 2018 17:48:25 -0700
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Laura Abbott <labbott@redhat.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Mike Christie <mchristi@redhat.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCHv3] iscsi-target: Don't use stack buffer for scatterlist
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180904184740.11102-1-labbott@redhat.com>
        <yq1efdzzgnq.fsf@oracle.com>
Date:   Tue, 11 Sep 2018 20:48:17 -0400
In-Reply-To: <yq1efdzzgnq.fsf@oracle.com> (Martin K. Petersen's message of
        "Tue, 11 Sep 2018 20:46:33 -0400")
Message-ID: <yq1a7onzgku.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9013 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=372
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809120007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Applied to 4.20/scsi-queue, thank you!

4.19/scsi-fixes, that is...

-- 
Martin K. Petersen	Oracle Linux Engineering
