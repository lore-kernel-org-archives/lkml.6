Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469B7C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 01:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3455217B4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 01:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Jv0venbz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3455217B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeHVFD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 01:03:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40834 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbeHVFD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 01:03:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7M1eEGr030350;
        Wed, 22 Aug 2018 01:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=1BXj+iGG6JrPfuliedGsb0oZivCyaDi2jmgf9bSaol8=;
 b=Jv0venbzCx9ZBg6rD9jO5ewWpLGUTD1HCFSHSBzyme7WUo5JZ2VpMyyKb8zC8VAxm6Rm
 CNVRvuPoQ7E62zLaVjO+5DM1EkMRImv4E1VybAyh37eNKf/km9Q4zVfDZuMh/PBqLbLf
 d9z/EOS+x6GeiqOVB5qZIVSk/9IbT3UNt+9Hcz3nIFLow7DCUUAthhZ6flY/v73/C//p
 pawT6OO8Oc3PS8vl5+Dw1FjITfwAHUNapz0gAlWTgvLl/3iSGJwUYm4Fi3dKP9vuMfJc
 gHAnsCfDwVfWozY27ih6qUc1rof6xdHrdr0fdqaw4hTIlZvEPDy7tk5NHmRa/ZQTYMVW 4Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2kxavtqwmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 01:40:43 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7M1eb5O026222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Aug 2018 01:40:38 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7M1eb0k001995;
        Wed, 22 Aug 2018 01:40:37 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Aug 2018 18:40:37 -0700
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jeff Lien <jeff.lien@wdc.com>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, herbert@gondor.apana.org.au,
        tim.c.chen@linux.intel.com, david.darrington@wdc.com,
        jeff.furlong@wdc.com
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
        <yq1in4gq5jf.fsf@oracle.com>
Date:   Tue, 21 Aug 2018 21:40:34 -0400
In-Reply-To: <yq1in4gq5jf.fsf@oracle.com> (Martin K. Petersen's message of
        "Sat, 11 Aug 2018 11:36:20 -0400")
Message-ID: <yq1lg8zb2lp.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8992 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808220016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> These days we obviously use the hardware-accelerated CRC calculation
> so the software table approach mostly serves as a reference
> implementation.

I was puzzled as to why WDC's tests did not seem to use the hardware-
accelerated CRC calculation whereas tests on my end worked fine. Turns
out this is due to an unfortunate side effect of how the crypto
subsystem works.

When crc-t10dif is initialized, the crypto infrastructure will pick the
algorithm with the highest priority currently registered. Both block and
SCSI will cause crc-t10dif to be compiled as a built-in so this
selection happens very early.

If crct10dif-pclmul is compiled as a module it will not be available at
the time the T10 CRC library is initialized. And thus the block layer
integrity code will be stuck with the sluggish table CRC. The workaround
is to build with CONFIG_CRYPTO_CRCT10DIF_PCLMUL=y.

However, it seems like a bit of a deficiency in crypto that there is no
way to upgrade existing transformations if higher priority algorithms
become available. btrfs and a few others work around this issue by not
using the generic lib/ CRC functions (which defeats the purpose of
having these in the first place). Instead they are registering their own
transformation at a later time where any accelerator modules are more
likely to be loaded.

Anyway. Just a heads up to people that wonder why the table algorithm is
being exercised despite their hardware supporting CRC acceleration.

-- 
Martin K. Petersen	Oracle Linux Engineering
