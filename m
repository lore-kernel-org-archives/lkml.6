Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C52C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1121208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bvrutSXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1121208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbeGaDmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 23:42:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:50906 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbeGaDmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 23:42:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6V1xK8k134094;
        Tue, 31 Jul 2018 02:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=PEnD66L2aVzM6XcugfKbhRGXdKIihMhUsAr6ks6yBwc=;
 b=bvrutSXEdcIHKDnIJ7gHbMuZNUC2ARp7rgxpzGoPKvYMDs4cohDkIhPg9/JaB3yM9A3c
 RXgrPHyRipiGNIfmlU+b1HH+ZrbyiVvPZ5ts74b28QgRBW/lszAH3NUyKdZ/yqbT+rXF
 sMGadbVH6cOHjk7KoqgTOeI6HmaQCd3H1VLevQd+XqUlRagKvu0tSyzWop9dPmZUNm02
 gVob495C7WLBSL/jlQGR2XTls69SzBXVB4fDohjyEY1SDCoagePqFWJulIO+F/8/3id7
 zQRbgSbtM9Ya7L96A6ykFa77AkjWS9OVk4J4DtQN/YSWu+ep7d7r8ku2keNxE0tRcRDH Dg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2kge0cy1b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 02:03:30 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6V23RND012191
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jul 2018 02:03:28 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6V23PKV007882;
        Tue, 31 Jul 2018 02:03:25 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 19:03:24 -0700
To:     Mike Christie <mchristi@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Varun Prakash <varun@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 18/26] target/iscsi: Allocate session IDs from an IDA
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180621212835.5636-1-willy@infradead.org>
        <20180621212835.5636-19-willy@infradead.org>
        <5B59FB56.9090901@redhat.com> <5B5A014D.9060901@redhat.com>
        <20180727193814.GB3825@bombadil.infradead.org>
        <5B5B892D.1000305@redhat.com>
Date:   Mon, 30 Jul 2018 22:03:21 -0400
In-Reply-To: <5B5B892D.1000305@redhat.com> (Mike Christie's message of "Fri,
        27 Jul 2018 16:05:49 -0500")
Message-ID: <yq1wotcw49i.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=667
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mike,

>> How about I take it through my tree to minimise the amount of rebasing
>> I'll need to do?  I'm already dependent on the nvdimm tree and I'd rather
>> not depend on the scsi tree as well.  I'll queue it up in front of my
>> IDA change to maximise its backportability.
>
> Ccing Martin, because he has been handling target patches.

That's fine with me.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
