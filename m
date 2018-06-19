Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142C5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF520204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XKsB8Rlx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF520204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937206AbeFSCUu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:20:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36434 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937110AbeFSCUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:20:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5J2JB9n046335;
        Tue, 19 Jun 2018 02:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2017-10-26;
 bh=h717UtL0VBb4uoOdGtl34osENkyt+C2RJJr0YIOP6iw=;
 b=XKsB8Rlx7z89BdpFjzSFJlVtKe1stU8K7rLJF90FVuC76fz4YqI4p/QN8cX3VjVQTLda
 F+FMCDAze9Zk0YYZXwz4vbeu35YTGiOdi8OpsWH/2CYgaPjFmTXJIYF8/8EVbtcZwGtg
 ZiPWAnmI/C42yAmcq2vCNsl6NwN+Y6EXAykmvBbpnPHYuNLsDbv5JL/sPiNm4IXGhJ3D
 kXcHTzPIXulypRTOYOp2z+9PvCTufxumjoZzeJVMvgfZYdDxO4E7UTtGWsQ+rQ5faLgk
 uNm8l+homhCVwRmxNIzkXvuxwBC+Nr5MtKtPaCNY5B4A8pS+oK1YhYH+1uAFWiQbtkxl bw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2jmu6xp7eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 02:20:39 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5J2KclQ001148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 02:20:38 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5J2KaZU011256;
        Tue, 19 Jun 2018 02:20:36 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jun 2018 19:20:35 -0700
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Alex Lemberg <Alex.Lemberg@wdc.com>,
        Avri Altman <Avri.Altman@wdc.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] scsi: ufs: ufshcd_dump_regs to use memcpy_fromio
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180614081409.29780-1-tomas.winkler@intel.com>
Date:   Mon, 18 Jun 2018 22:20:33 -0400
In-Reply-To: <20180614081409.29780-1-tomas.winkler@intel.com> (Tomas Winkler's
        message of "Thu, 14 Jun 2018 11:14:09 +0300")
Message-ID: <yq1fu1jikjy.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=327
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tomas,

> ufshcd_dump_regs should use memcpy_fromio to read host registers
> instead of directly accessing using memcpy.  The same function is
> utilized in ufs-qcom.

Applied to 4.19/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
