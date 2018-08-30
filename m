Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8864DC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACD22084E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r/jYC+/1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACD22084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeH3Ppo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:45:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52866 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbeH3Ppn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:45:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UBdCUn196269;
        Thu, 30 Aug 2018 11:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=V9qZ81JocbnutLjbmnknLp4leCHUqHldqUW2grvQ9L8=;
 b=r/jYC+/1AfUg1gOufCFEeCVeYWT+v+Xyh9D22uy+hA1KqYIvWTnlwH+AHlGwILW2Jelm
 Y5YLHbmYXHFUFvEHrg1o/2s8GMKDIuYIOLnl/+9XxBXI71fSMJaKq7/9ec9JBed7WDxV
 NUKqOrVRBi0YT1AXFoKDE1nv41urZhb7L561nRuEmdVVWuJiFnxhNOU1BRiTrl9GY85s
 vhXrMqDtgcsDC3j7AQzKccneQU7vYOfXB9ni65z82MddRfonxSS0z9A2rlGYj+P47Lsg
 qXFiuwBnVcplNPArFnq66/tjAg45tt1DkrS+7PfHTi7gb3bYC7YuJITeWMvoLV3c1SDa Lw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2m2y2ps18r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 11:42:08 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7UBg3kM008132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 11:42:03 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7UBg1h0013493;
        Thu, 30 Aug 2018 11:42:02 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 04:42:01 -0700
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        codalist@telemann.coda.cs.cmu.edu, coda@cs.cmu.edu,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Paul Sokolovsky <paul.sokolovsky@linaro.org>,
        Miklos Szeredi <mszeredi@suse.cz>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 2/2] scsi: aic7xxx: Fix build using bare-metal toolchain
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180829170015.7729-1-semen.protsenko@linaro.org>
        <20180829170015.7729-3-semen.protsenko@linaro.org>
Date:   Thu, 30 Aug 2018 07:41:58 -0400
In-Reply-To: <20180829170015.7729-3-semen.protsenko@linaro.org> (Sam
        Protsenko's message of "Wed, 29 Aug 2018 20:00:15 +0300")
Message-ID: <yq1efeg3wu1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=842
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sam,

> Bare-metal toolchains don't define __linux__, so aic7xxx build with
> bare-metal toolchain is broken. This driver codebase used to be
> partially shared with FreeBSD, but these days there is no point in
> keeping the compatibility around. So let's just drop FreeBSD related
> code and get rid of __linux__ checking in order to fix the build using
> bare-metal toolchains.

Applied to 4.20/scsi-queue, thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
