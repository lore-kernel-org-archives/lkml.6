Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318F0C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08E221523
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 16:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fwxF4ozu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08E221523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeHXUFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 16:05:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:58296 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbeHXUFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 16:05:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7OGSbcD129769;
        Fri, 24 Aug 2018 16:29:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=rDbmFACZmgGCM5RRK69FiY0qV+b20mV3qUrCjnwJ/EM=;
 b=fwxF4ozupR05NpC3msyrKt6fZQM6DMelodTtTKDw+OYPBCTBRG6hT9IKdFr/EgZJFtDC
 k1IHE5e2V2UW95WMji5Pck8fR/wxDE7r0gGttMNwv7qxzQ94QUF+Biviv/2/6WHBC9q8
 znKlHxP1Cr9/RFOf0ESRre9CInl0WL/idTGiT+dl9ozs9atsgwLGHnn618i0e5ZImwDK
 VoaVxlbeanQ2GG9AJDKHoNsRbRcsNPEWWIc3DNKDkjbsQVmyYQABM8QeMxIL5ZbmWWib
 GoN3umBIvx0LK/uCpM/IJe5pWYOaHA5P+tplWrfdCcJGZP9GR0sKO0IufAjLJ2C3fIZ9 BA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2kxavu987p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 16:29:30 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7OGTTvq018552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Aug 2018 16:29:30 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7OGTSUH001749;
        Fri, 24 Aug 2018 16:29:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Aug 2018 09:29:28 -0700
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Jeffrey Lien <Jeff.Lien@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
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
Date:   Fri, 24 Aug 2018 12:29:25 -0400
In-Reply-To: <CAKv+Gu-RwCrdgW69NVpyRLwGPGPCZx+ksTBM7NZk7v0-dzczGg@mail.gmail.com>
        (Ard Biesheuvel's message of "Fri, 24 Aug 2018 16:39:47 +0100")
Message-ID: <yq1a7pb9196.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8995 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1808240173
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ard,

> Would it be possible to allocate the crypto transform upon first use
> instead of from an initcall? If crc_t10dif() is mostly called from
> non-process context, that would not really work, but otherwise, we
> could simply defer it (and occasional calls from non-process context
> that do occur would use the generic code until the point where another
> call from process context allocates the transform)

The function is always called from user context. However, postponing the
crypto transform registration doesn't solve the common scenario of the
user booting off of a Fibre Channel/SAS/NVMe device with the desired
crct10dif-pclmul.ko module located on the boot drive.

If there is no good way to teach crypto to update existing registrations
when a higher priority transformation becomes available, then we
probably need to explore tweaking dracut to unconditionally load
crct10dif-pclmul (and your ARM equivalent). Looks like there are already
hacks in place in dracut to preload crc32c for btrfs and XFS.

Anyway. Just seems like the kernel is violating the principle of least
surprise here. The kernel should always pick the best available tool for
the job...

-- 
Martin K. Petersen	Oracle Linux Engineering
