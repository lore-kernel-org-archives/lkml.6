Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145F6C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B3020839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cnDOAdn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B3020839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeILFsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:48:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34858 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbeILFsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:48:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8C0hbLS029359;
        Wed, 12 Sep 2018 00:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=cgMdj1GL9H89WSuRK5TA4RCmtpIB8WHECHAF7lDcS4s=;
 b=cnDOAdn07456l1YUhBdTbDfa9sOToDVVps1sQlpPnRtzfsJBdWiJktaH5HKDA1Xkjyz+
 MkWPKm1/rC6CV/dsQYhczIxW9JACm2Y0fmzD6Rd2sgNEJj3B5gzIKFa/bXJVQlz+TBxW
 zC8mUZH39/d1/BQ3GMT6Q7U0oc/8KNjBnHRZtpdW3ldWsr76hKjne4Ifdz9CHjp3jrQG
 nPT8AtjWcPqJLukHVHVK6Fx7yydLRuTEeOUNpMpJ7ISqByjN58khByh5nDv3v80EwwMf
 HGAraeU9KoUFuqYvnxk0L0fEfoBdnuJmVKSoeow6JdrmzQOnqug8/a8Yeggrv7p3a7ri wg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2mc72qq799-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 00:46:38 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8C0kbnp019987
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Sep 2018 00:46:37 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8C0kaf0019234;
        Wed, 12 Sep 2018 00:46:36 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Sep 2018 17:46:36 -0700
To:     Laura Abbott <labbott@redhat.com>
Cc:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Mike Christie <mchristi@redhat.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv3] iscsi-target: Don't use stack buffer for scatterlist
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180904184740.11102-1-labbott@redhat.com>
Date:   Tue, 11 Sep 2018 20:46:33 -0400
In-Reply-To: <20180904184740.11102-1-labbott@redhat.com> (Laura Abbott's
        message of "Tue, 4 Sep 2018 11:47:40 -0700")
Message-ID: <yq1efdzzgnq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9013 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=485
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809120007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Laura,

> There are two cases that trigger this bug. Switch to using a
> dynamically allocated buffer for one case and do not assign
> a NULL buffer in another case.

Applied to 4.20/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
