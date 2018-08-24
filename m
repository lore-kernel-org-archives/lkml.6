Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D94C0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5CE208B3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 22:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="04b2uNED"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5CE208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeHYBtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 21:49:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46814 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeHYBtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 21:49:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7OM8wQV172383;
        Fri, 24 Aug 2018 22:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=4hGWNp7Bsk69DpU8HQwCpjnaeh9B6rwD7duUx+24XQ8=;
 b=04b2uNEDYlvPrH4093Q+xNAVD2/JFN2rN1TRaV/jsHotkcnpABbfJ0uo0gap0YPvLIsw
 duzMev8xPeoYSl0Vk0Ylc/4sdRmNQkknVpRFcY2HrBbvt5X958b2vknvjSp/kQe98nUr
 8mn3q4HztUFsIA8MBVvH3vRKm5x0PG33U3Szf/IIjonXw5JhRK0Ccp65inYD0o1UvWBV
 AS8qTdz68+Ir7ewBJ7ho0DHiOIQMuycRuwaSyclKTiYPBMRNmGuo4Qy7qtdU6R5DK0Wz
 GD8SwLggliCyDhXXkhOcGjeTiBZJoEmFbiZMfaGR+D00nUNd0IQG1ukRw5t0HkM71Imf QQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kxc3raasv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 22:12:46 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w7OMCiFT032436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 22:12:44 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7OMCgTL024342;
        Fri, 24 Aug 2018 22:12:43 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Aug 2018 15:12:42 -0700
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jeffrey Lien <Jeff.Lien@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto\@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-block\@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "herbert\@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "tim.c.chen\@linux.intel.com" <tim.c.chen@linux.intel.com>,
        David Darrington <david.darrington@wdc.com>,
        Jeff Furlong <jeff.furlong@wdc.com>
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
        <yq1in4gq5jf.fsf@oracle.com> <yq1lg8zb2lp.fsf@oracle.com>
        <20180822062016.GA10356@infradead.org>
        <SN1PR04MB18241CBDC8E4CA5275EE4424EA360@SN1PR04MB1824.namprd04.prod.outlook.com>
        <CAKv+Gu-RwCrdgW69NVpyRLwGPGPCZx+ksTBM7NZk7v0-dzczGg@mail.gmail.com>
        <yq1a7pb9196.fsf@oracle.com>
        <CAKv+Gu8Y7YmyB5rmxaj-SGB7q03in7ijv2cOifwYnhP5CNastw@mail.gmail.com>
        <yq1tvnj780o.fsf@oracle.com>
        <CAKv+Gu8dMBUKmw+5rxWoiRKXngPeAsNyXzOY-nZwd3GPi1S5FA@mail.gmail.com>
Date:   Fri, 24 Aug 2018 18:12:39 -0400
In-Reply-To: <CAKv+Gu8dMBUKmw+5rxWoiRKXngPeAsNyXzOY-nZwd3GPi1S5FA@mail.gmail.com>
        (Ard Biesheuvel's message of "Fri, 24 Aug 2018 22:54:26 +0100")
Message-ID: <yq1pny776so.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8995 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=747
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808240222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ard,

> This looks like it should work, yes. It does rely on the module name
> to start with 'crct10dif' but I guess that is reasonable, and matches
> the current state on all architectures.

Yep, I verified the module names on ARM and Power. There really wasn't
much I could key off of other than the name string.

> Anyone care to boot test this? Jeffrey?

Did some quick tests on my end with both scsi_debug and FC hardware. I
verified that performance went up as I loaded crct10dif-pclmul while the
test was running:

[   23.488059] CRC T10 DIF calculated using crypto hash crct10dif-generic
[  156.922455] sd 0:0:0:0: [sda] Enabling DIX T10-DIF-TYPE1-CRC protection
[  221.577731] CRC T10 DIF calculated using crypto hash crct10dif-pclmul

R  63.60 MB/s, W  61.00 MB/s, IOPS  486 | Ops     4460, Rec  0, Err  0
R  61.80 MB/s, W  62.00 MB/s, IOPS  493 | Ops     6926, Rec  0, Err  0
R  62.60 MB/s, W  60.80 MB/s, IOPS  494 | Ops     9396, Rec  0, Err  0
R  59.40 MB/s, W  58.80 MB/s, IOPS  482 | Ops    11804, Rec  0, Err  0
R 151.40 MB/s, W 155.40 MB/s, IOPS 1216 | Ops    17883, Rec  0, Err  0
R 165.00 MB/s, W 166.40 MB/s, IOPS 1327 | Ops    24520, Rec  0, Err  0
R 175.00 MB/s, W 177.40 MB/s, IOPS 1417 | Ops    31604, Rec  0, Err  0
R 185.80 MB/s, W 188.60 MB/s, IOPS 1507 | Ops    39137, Rec  0, Err  0
R 200.60 MB/s, W 203.00 MB/s, IOPS 1629 | Ops    47284, Rec  0, Err  0

Note that in this case the CRC is calculated twice per I/O (block layer
and scsi_debug).

I'll do some more testing over the weekend...

-- 
Martin K. Petersen	Oracle Linux Engineering
