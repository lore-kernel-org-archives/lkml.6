Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4466AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3E220875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PHqEcM2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3E220875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757270AbeFSOI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:08:58 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52792 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755376AbeFSOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:08:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5JE4JRp032375;
        Tue, 19 Jun 2018 14:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=stxPTpc/02UwYOqTT9a5jOsxFQ5YLZcFcfW3Va4NG6c=;
 b=PHqEcM2srMMKF9N5X3g/j4JOkUI208Hp3iRrFep2TqB9bVqtfa3ZLYUYwg09dkYoY1uA
 S7YUeEuaNYtKKsjODzVMNxxiffkEC12qftuvxoF6xOtr5WznDLK5AaNoAwjunuPckYaE
 a1M/MaPun9OwfJbjQlJcys1NhrtYvUwgHAc3hDssVBffJ1qMuV/3z8OWO5LoISKck3W/
 tQTQ2MeofCVrOqQg5H2U9ztQanbOusWwFXz506iII7hD3PzqQxt656Sb3bAStloyx6w0
 tKEkAxCmjSX55vh5ehaOa6We8UDtLIpShbO76Y2/p8nFejHupk7Hfwhnsi6L9Skgdgo2 Ig== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2jmr2mgex7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 14:08:25 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5JE8NbV002440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 14:08:23 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5JE8LZq016065;
        Tue, 19 Jun 2018 14:08:21 GMT
Received: from mwanda (/197.157.34.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 07:08:20 -0700
Date:   Tue, 19 Jun 2018 17:08:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hugo Lefeuvre <hle@owl.eu.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Marcus Wolf <linux@wolf-entwicklungen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: fix race condition in pi433_open
Message-ID: <20180619140804.rly7oey6jsbznfg3@mwanda>
References: <20180618022400.GA1893@hle-laptop.local>
 <20180618101838.gzbrxabilnqyilsi@mwanda>
 <20180619030850.GA1876@hle-laptop.local>
 <20180619104248.z5nbbakwhjgscufb@mwanda>
 <20180619134220.GA2396@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619134220.GA2396@hle-laptop.local>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=565
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 09:42:20AM -0400, Hugo Lefeuvre wrote:
> This TODO seems to be related to this misunderstanding too:
> 
>  890         /* TODO? guard against device removal before, or while,
>  891          * we issue this ioctl. --> device_get()
>  892          */
> 
> Device removal can't happen before or during the ioctl execution.

Correct.  Just delete the comment.

regards,
dan carpenter


