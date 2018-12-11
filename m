Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402EDC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034FC20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VeM35Ykd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034FC20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbeLKNBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:01:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53204 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbeLKNBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:01:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBBCt7eK122711;
        Tue, 11 Dec 2018 13:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=5sB+7yK4V2ZLdr6eMRKGor5tcQDc9e0qsluthOpRXdw=;
 b=VeM35Ykd4OK9FQ4YwuhO814LNFbXffhL7hYj3jOcoH2DS+NxzePS9/izkkt0mnqt8fd+
 W2wDIrIRwh9nsloJuAyGpxu30rosFa947v8MIQemgXGJ/o6KaAhEbbzBjV6FH1C6JVlv
 iGz4C0aLDraU8zZ+C94+qNnGuYte9K/OVJsc+o1VsOcYgkBWMQlTTWc9aVLcEHKbCUW/
 LxoWcweOu54p++mw2iz9z6icfHvjeUPW0eabenG2gGJdph4xQDdFLgYkZVyJb2gDXkJj
 uLycBQRUCgDSCj8D0wTag+6uuE6R6fRCuKyifw/WN5Vv2Q/DZDINkKxRZG6H1qdJ6CW/ xA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2p86kqumga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 13:00:59 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBBD0wLD001518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Dec 2018 13:00:58 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBBD0ugC026053;
        Tue, 11 Dec 2018 13:00:56 GMT
Received: from kadam (/10.175.36.120)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 11 Dec 2018 05:00:55 -0800
Date:   Tue, 11 Dec 2018 16:00:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Aaron Strahlberger <aaron.strahlberger@posteo.de>
Cc:     Gao Xiang <gaoxiang25@huawei.com>, devel@driverdev.osuosl.org,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        linux-kernel@i4.cs.fau.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org,
        Dominik Huber <domi250@gmx.de>, linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 1/5] drivers: staging: erofs: Fix alignment.
Message-ID: <20181211130039.GE3116@kadam>
References: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
 <20181211105443.21826-1-aaron.strahlberger@posteo.de>
 <20181211105443.21826-2-aaron.strahlberger@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211105443.21826-2-aaron.strahlberger@posteo.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=660
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812110118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:54:39AM +0100, Aaron Strahlberger wrote:
> Fix of 17 `CHECK: Alignment should match open parenthesis` checkpatch.pl
> issues.
> 
> Signed-off-by: Aaron Strahlberger <aaron.strahlberger@posteo.de>
> Signed-off-by: Julius Wiedmann <julius.wiedmann@fau.de>
> Signed-off-by: Dominik Huber <domi250@gmx.de>
> 
> LocalWords:  Alighnment
  ^^^^^^^^^^^^^^^^^^^^^^^

Remove this.

Please wait at least a day before resending a patch.

regards,
dan carpenter

