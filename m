Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971DEC46460
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F0121A5D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 15:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bk5qVcjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F0121A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeHKSLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 14:11:14 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40200 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbeHKSLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 14:11:14 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7BFYugI110729;
        Sat, 11 Aug 2018 15:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Yjx6BCgF4V2ikSGioclu6J65exxcWC5O7s1gXzLUavo=;
 b=bk5qVcjxD1XpZh0jl96wfJA1zJpVVbf8J2Ocub58QyKTH1tPOPgP/GXldQV4iT5mDesk
 dE3Wk3rMOc5Dsjfkjutfzjm5cMAn36RtVeKMqP6L29frylATMxdzG1al8lLbH4WAbiNI
 zY8awSoTz+xPAUa4MHbRw6FPCe/bs/ncs/2mTUuNUFzzRXhZvuGevA7n2ShZ/neQf6H2
 ECZAUogxD+NAEetVT0A774/4QSrNh/to1ZuPY42DtW7xDWaM66+roMZOMBkdavJDbcVI
 lhoqt59HQ3KSFDyrjLeD2fz7Iy1OxDOBH9DPsaULuqXCQDuTV227k0yTMVQL5S/6A7mP Xg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2ksqrp0qaa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Aug 2018 15:36:24 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7BFaNl8026988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Aug 2018 15:36:23 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7BFaNnc029886;
        Sat, 11 Aug 2018 15:36:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 11 Aug 2018 08:36:22 -0700
To:     Jeff Lien <jeff.lien@wdc.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        herbert@gondor.apana.org.au, tim.c.chen@linux.intel.com,
        martin.petersen@oracle.com, david.darrington@wdc.com,
        jeff.furlong@wdc.com
Subject: Re: [PATCH] Performance Improvement in CRC16 Calculations.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com>
Date:   Sat, 11 Aug 2018 11:36:20 -0400
In-Reply-To: <1533928331-21303-1-git-send-email-jeff.lien@wdc.com> (Jeff
        Lien's message of "Fri, 10 Aug 2018 14:12:11 -0500")
Message-ID: <yq1in4gq5jf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8981 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=634
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808110174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff,

> This patch provides a performance improvement for the CRC16
> calculations done in read/write workloads using the T10 Type 1/2/3
> guard field.  For example, today with sequential write workloads (one
> thread/CPU of IO) we consume 100% of the CPU because of the CRC16
> computation bottleneck.  Today's block devices are considerably
> faster, but the CRC16 calculation prevents folks from utilizing the
> throughput of such devices.  To speed up this calculation and expose
> the block device throughput, we slice the old single byte for loop
> into a 16 byte for loop, with a larger CRC table to match.  The result
> has shown 5x performance improvements on various big endian and little
> endian systems running the 4.18.0 kernel version.

The reason I went with a simple slice-by-one approach was that the
larger tables had a negative impact on the CPU caches. So while
slice-by-N numbers looked better in synthetic benchmarks, actual
application performance started getting affected as the tables grew
larger.

These days we obviously use the hardware-accelerated CRC calculation so
the software table approach mostly serves as a reference
implementation. But given your big vs. little endian performance
metrics, I'm assuming you guys are focused on embedded processors
without support for CRC acceleration?

I have no problem providing a choice for bigger tables. My only concern
is that the selection heuristics need to be more than one-dimensional.
Latency and cache side effects are often more important than throughput.
At least on the initiator side.

Also, I'd like to keep the original slice-by-one implementation for
reference purposes.

-- 
Martin K. Petersen	Oracle Linux Engineering
