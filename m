Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5BF49C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 074612086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 12:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pAz6Et3A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074612086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933370AbeFLMLm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 08:11:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54838 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932555AbeFLMLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 08:11:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5CC5lMQ012518;
        Tue, 12 Jun 2018 12:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=2CYl8EN03bUQqU6Fqtz7Tnjmy3CvBGmrELPnpshJiQY=;
 b=pAz6Et3ABO7yYEAP9EuegCrXHzH9NZkg/zJ8p1UzVku2QbrPE1mm9CDflNxzZJfbwLHh
 rnrxNA0CSvT/Rpv4gaj2qwonnbn6yvG3gtsfVlLGnszNmXEwzrm/gUkGNsaIB1XPtlte
 pjHiXi33iL2CYN6dGF/rx/QK6xvUDM41irozGDDHePtH1wumVLglaySM9wzLMyeWHips
 y68ikbkm6SsgeZNblXB9JSCPvu6vq+Z1FQ0w+5QKsFy2ozA8XljDf5S7IGJgYyXiJRS8
 xs2jc00Raj0IHV+/YEu80zkAO2hwQ8ixp9MZoMbKiTo6etZ89FnP3YfBgVHU8A/68mO5 /g== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2jg6b1hqn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 12:11:25 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5CCBOjI019030
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jun 2018 12:11:24 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5CCBLDt007377;
        Tue, 12 Jun 2018 12:11:21 GMT
Received: from mwanda (/197.157.0.30)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Jun 2018 05:11:21 -0700
Date:   Tue, 12 Jun 2018 15:11:07 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Valentin Vidic <Valentin.Vidic@CARNet.hr>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Subject: Re: [PATCH v2] staging: pi433: add mutex fixing concurrency issues.
Message-ID: <20180612121107.xgxdqda5bzhqeizr@mwanda>
References: <20180602175649.GA2816@hle-laptop.local>
 <20180607124216.GA2329@hle-laptop.local>
 <20180609081244.GP14048@gavran.carpriv.carnet.hr>
 <20180609154842.GB1826@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180609154842.GB1826@hle-laptop.local>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8921 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=819
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806120142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 09, 2018 at 11:48:42AM -0400, Hugo Lefeuvre wrote:
> case PI433_IOC_WR_TX_CFG:
>         if (copy_from_user(&instance->tx_cfg, argp,
>                    sizeof(struct pi433_tx_cfg)))
>             return -EFAULT;
>         break;

Btw, it looks so wrong to me that we copy partial data to
&instance->tx_cfg...  I'd really prefer copying it to a tmp buffer and
then verifying it's corrent then memcpy()ing it to &instance->tx_cfg.

regards,
dan carpenter

