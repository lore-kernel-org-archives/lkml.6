Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD752C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866962073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KqjTCmyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866962073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbeH3TAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:00:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:32960 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728220AbeH3TAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:00:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7UEro00148239;
        Thu, 30 Aug 2018 14:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=9nr21xP85t89sz8n2W12rp2sSW3sVPNrLKZRIhijjLM=;
 b=KqjTCmyv7W+T4WdpBodl00oVVUjOTG3UI0ygjzeCF7kx+9b7yVy1DYgftvTLutHzZnqs
 eVYjg7bj/rfpNjidFS39w5cqMMxwIHqyWu5LRwhw4DMrsls/wSZ7P2A14MFYF7ksDnEa
 wXk7BxcVoX/4dEGqHBKRqJzIBDUrmjwWI8ynlFTjs29cpW1On9e/czr7zYj+ikAChvAU
 AXyQgOqJ7yUBDk/WsJ3QANLsSmaK1kcCmqDwWJY0hDcg6n2dEYBmHuz2eh28h70/gnxP
 eJBqajvJWzXtPhpVvbIiEPFdQuNNP6K3mN96ePO4RUg8HUZa9V9p9VGJWYqTCNrq5bwc 7A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2m2y2pvwmg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 14:57:52 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7UEvp8Z023663
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Aug 2018 14:57:51 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7UEvnUY014144;
        Thu, 30 Aug 2018 14:57:49 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 30 Aug 2018 07:57:49 -0700
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jeff.Lien@wdc.com, ard.biesheuvel@linaro.org,
        david.darrington@wdc.com, hch@infradead.org, jeff.furlong@wdc.com,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 1/4] crypto: Introduce notifier for new crypto algorithms
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180825061205.ygrjjazkooqghrqy@gondor.apana.org.au>
        <20180826024006.13800-1-martin.petersen@oracle.com>
        <20180827060918.tfz7ljufqhlej4kq@gondor.apana.org.au>
Date:   Thu, 30 Aug 2018 10:57:46 -0400
In-Reply-To: <20180827060918.tfz7ljufqhlej4kq@gondor.apana.org.au> (Herbert
        Xu's message of "Mon, 27 Aug 2018 14:09:19 +0800")
Message-ID: <yq15zzr52c5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9000 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=578
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808300154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Herbert,

Sorry about the delay. Been on the road with surprisingly spotty
internet.

I addressed your two comments in the patch series that will follow.

-- 
Martin K. Petersen	Oracle Linux Engineering
