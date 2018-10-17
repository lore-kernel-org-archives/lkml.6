Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C698C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49D5214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KPQtLTK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49D5214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeJQJMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:12:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33320 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeJQJMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:12:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9H1J38W174316;
        Wed, 17 Oct 2018 01:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=fdeARUy+1iJZiDiV3PLavO/26WqPf1w5KvXeVB50ZtQ=;
 b=KPQtLTK/e23Y5iA+ipgR6k8XVUgMKmAliLjuwpm8hM+dF1VHL1BeCqpn7sKe9RHYTCIZ
 jMMqyV8dekJbzxcbEtmWOF4g3p0r4LyfucKHTGBA6aJGseNPtaM6sSrWSw3z++mfwEIE
 Hu77O/RrmXIkpCYxG0KM5XIKq1Hoj9GcT40zPK4AGgDAGhRpKkZ6MXEHTfHGJVTeNZU5
 bVGKfAuKqjBGJIsZLPJu4DCLzk5DdVF50e2DBXAeVy4IGBNwHu6fUQgmvW959Itlfyuw
 c7fZLdDjMGMKrkZJyclAZyq6EOfoFOpT643s8e25JYUrifli+9xKBSlPXoXSyvmDHMe7 Sw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2n38nq41kv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 01:19:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9H1JNjY023191
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Oct 2018 01:19:24 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9H1JNeB007527;
        Wed, 17 Oct 2018 01:19:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Oct 2018 18:19:23 -0700
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ips: fix missing break in switch
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20181016091223.GA19765@embeddedor.com>
        <yq1ftx5sgw1.fsf@oracle.com>
        <alpine.LNX.2.21.1810170922480.130@nippy.intranet>
Date:   Tue, 16 Oct 2018 21:19:20 -0400
In-Reply-To: <alpine.LNX.2.21.1810170922480.130@nippy.intranet> (Finn Thain's
        message of "Wed, 17 Oct 2018 09:27:45 +1100 (AEDT)")
Message-ID: <yq1r2gppdyf.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9048 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=765
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810170009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Finn,

> This looks wrong to me. I think you've just prevented all START STOP
> commands sent to logical volumes from reaching
>
>         return ((*ha->func.issue) (ha, scb));
>
> I think a better patch is to add a "fall though" comment not a "break"
> statement. (I no longer have access to a ServeRAID board so I can't
> test.)

When I looked at this a few days ago, it seemed that the fallthrough to
the TUR/INQUIRY case statement was accidental and that the intent was to
quickly complete START_STOP unit (which probably doesn't make much sense
for a RAID device anyway).

See the case statements above for another fast exit scenario.

Sadly I have no way to test this. It just stuck out like a false
positive in Gustavo's fallthrough markup patch.

-- 
Martin K. Petersen	Oracle Linux Engineering
