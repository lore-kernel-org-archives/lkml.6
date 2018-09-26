Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360D6C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDE32089D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 00:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nuaHsEVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDE32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbeIZHDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 03:03:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54618 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeIZHDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 03:03:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8Q0jMTn029769;
        Wed, 26 Sep 2018 00:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Jk4O/MacvM9YCb/DJt2sX3d5C4wDUaJw8b7DcHqJBjA=;
 b=nuaHsEVONuufguJs5onQOxzS3BkA61cT2xszn8crH5d/qc8/m3HCLH9DwzcBQ+pN6vyp
 UJSXcUwBgtTJwaWfHPL8DQlDPSOyyb2zYjuDztXgaQYqge8+MJKQrVtk3UKCGHKunhSZ
 uJKbrwgm9pHUhTvIdlxYt4si4frU+SeeML0rN9gD4ROt3rckWu3ZHZ4DQ5bp9Nw708qS
 SiadbBecoJ8RGJ6aqjN5tnYV1BvA8/m+PV8gJ0cOJ9hqqZ7X13d2obITA1HrcLgcbXg2
 zaNMqaJ/K++2dbpshLLSHfhMZFYNVSs3V5yrrTRM6dklsCElRN7x5Qo0zxcubD5Esmx0 xA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2mnd5tffr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 00:53:02 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8Q0r2km030899
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Sep 2018 00:53:02 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8Q0r1BN022908;
        Wed, 26 Sep 2018 00:53:01 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 25 Sep 2018 17:53:01 -0700
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] scsi: sd: don't crash the host on invalid commands
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20180921070101.9260-1-jthumshirn@suse.de>
Date:   Tue, 25 Sep 2018 20:52:58 -0400
In-Reply-To: <20180921070101.9260-1-jthumshirn@suse.de> (Johannes Thumshirn's
        message of "Fri, 21 Sep 2018 09:01:01 +0200")
Message-ID: <yq1tvmdgjv9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9027 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=569
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809260006
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Johannes,

> When sd_init_command() get's a with a unknown req_op() it crashes the
> system via BUG().
>
> This makes debugging the actual reason for the broken request
> cmd_flags pretty hard as the system is down before it's able to write
> out debugging data on the serial console or the trace buffer.
>
> Change the BUG() to a WARN_ON() and return BLKPREP_KILL to fail
> gracefully and return an I/O error to the producer of the request.

Looks like a bunch of my merge mails didn't make it out last week.

For the record, I did merge this into 4.19/scsi-fixes and it has made
its way upstream.

-- 
Martin K. Petersen	Oracle Linux Engineering
