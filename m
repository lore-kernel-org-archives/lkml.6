Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C8CC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DB52083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jNs0B7Tn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DB52083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754147AbeFTBfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:35:44 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33074 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752861AbeFTBfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:35:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5K1XNdN191386;
        Wed, 20 Jun 2018 01:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=uxIGDBF/PlWU/qFFt5WG/G9WBN8gk1IntEyfXhGocis=;
 b=jNs0B7Tn7K50+A0xCuAKg8HIlnpZodJ5Gn2JDUJf1aLF9QfjNFYRuOEIoKeDAFWt8bAO
 VIOornz0IxjTNoUMq9EFhANOgZ28PB09k5daRfDUq3cESWV1oX4077MYMERxcBRmIagE
 rwK1XUS7HNyfd3+8gVLH/v8w94o4zwP8g4BdUFYxooUSnGYECGDjb0W2un5IYLq4l4dQ
 v3ssQMfJ2cdMsFn0X+3tQnyZwwpMdyC38WdtJEF9bDDFJtrZc7NUJKGezNE7UTdmunUu
 4cRBfHlXRgxHoAV8utrWHMgmsSYq3+n5c2L9dzQx5SvCcLLMUY6FlzjjZwM6Um6MeCGU PA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jmu6xtdgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 01:35:24 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5K1ZNix003318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 01:35:24 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5K1ZMkY019819;
        Wed, 20 Jun 2018 01:35:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 18:35:22 -0700
To:     "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        brajeswar.linux@gmail.com
Subject: Re: [PATCH] scsi: cxlflash: Change return type for fault handler
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180611194204.GA18687@jordon-HP-15-Notebook-PC>
        <20180613232347.GA3851@p8tul1-build.aus.stglabs.ibm.com>
        <CAFqt6zb-fDRdH1_k7QwW_YEErKYPYFNpJFrK7N82P0PLiKnRtA@mail.gmail.com>
        <1E0C8AFA-5168-4916-932E-8E1C3F0EADE6@linux.vnet.ibm.com>
        <CAFqt6zbgaqVxAVcX+ryzP5-qDDZs+Z1rNrY4mHhwr=THO++5Vg@mail.gmail.com>
        <20180619232930.GB10658@p8tul1-build.aus.stglabs.ibm.com>
Date:   Tue, 19 Jun 2018 21:35:19 -0400
In-Reply-To: <20180619232930.GB10658@p8tul1-build.aus.stglabs.ibm.com>
        (Matthew R. Ochs's message of "Tue, 19 Jun 2018 18:29:30 -0500")
Message-ID: <yq1h8lyfdew.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=562
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200015
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew,

> Since this has not yet been queued for 4.19, please submit a v2 with
> the modifications to also update the return type for
> ocxlflash_mmap_fault().

Yes, please. I have been waiting for an amended patch.

-- 
Martin K. Petersen	Oracle Linux Engineering
