Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 993EEC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCFF208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="es47VBvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCFF208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933528AbeFLLDU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:03:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37662 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933308AbeFLLCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:02:52 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CB19bs036618;
        Tue, 12 Jun 2018 11:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=UeSv2U84AUAYThVZf28vmDow2HKXUVFBSN9B9dNQ/qE=;
 b=es47VBvprEeybrTgjWefC0GL3uI+HGhHqWS8Ma0hFavRjBvUP93fIp2OKFt3rVnh3n6L
 BdxGyYXFP3Z4CHY0SL6z6XDQHGjDBkrpXTIk5LGkbV/3ICscfFFWJziUM4J1xT5VVG8y
 9FsGrFuXgJTxQCE7OwczMILFiEugZt1frVqB/Mt5E0MilLtjdwJuPP/yYr6Yx3lkvw+2
 HJyYL+AuUNo7M8XLBJAlsmrt8/ni0TQgQUkNeG9AxIb7f/9UWcrOEJPYRLzHSCtn0rOD
 GCRLYEK2DHuBbhgrB3kVs+U+b1nXSBoJGJmKqk10N1Vdo1oBoAdeRtwMAfeBQqBumg0u xg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jgecxgqdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 11:02:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5CB2fZS019986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 11:02:41 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5CB2cPP008921;
        Tue, 12 Jun 2018 11:02:38 GMT
Received: from mwanda (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 04:02:38 -0700
Date:   Tue, 12 Jun 2018 14:02:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH] staging: pi433: add mutex fixing race condition when
 accessing tx_cfg
Message-ID: <20180612110230.dvqmcyisdwaynixj@mwanda>
References: <20180612011200.GB1794@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612011200.GB1794@hle-laptop.local>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8921 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=770
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 09:12:00PM -0400, Hugo Lefeuvre wrote:
> In the PI433_IOC_WR_TX_CFG case in pi433_ioctl, instance->tx_cfg is
> modified using
> 
> copy_from_user(&instance->tx_cfg, argp, sizeof(struct pi433_tx_cfg)))
> 
> without any kind of synchronization. In the case where two threads
> would execute this same command concurrently the tx_cfg field might
> enter in an inconsistent state.
> 
> Add a mutex making sure that the PI433_IOC_WR_TX_CFG case will never
> be run by several threads concurrently.
> 
> Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>

We read the data from the user here and then we write it to the fifo
in pi433_write().  We should be using the device->tx_fifo_lock so that
we don't copy over the data at the same time we're writing it to the
fifo.

This bug could cause a user space program to fail.

regards,
dan carpenter



