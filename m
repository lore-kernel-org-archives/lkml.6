Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AB5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E0820864
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mZiSSduP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E0820864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731141AbeGQKpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:45:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57092 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbeGQKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:45:38 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6HADN3C083519;
        Tue, 17 Jul 2018 10:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=s+4uEpG7up2znegEzvrEKaBqcaxSEsIE/0yPI6SQtzA=;
 b=mZiSSduPmJED/IflDJ2ydJYWIf/LUzsAal35VDXhNDUNLX9IxydX/WHFgSZqKJ+KpG0g
 lLLSWqxmB9aFwBEpyAhBn4iZhAQf/HguebXjrOoDgYeiePipNi7+7qRpqT+Ddd3K6W7K
 y31rHiQyaJpdtXaP63GOw5iQJy+2sKs6x31xYp2idI1bXxHyrCRgMDJ3d29Crc5HpKW2
 AhLk28vgHTt+2HnplDVDI6zoKfpun4AQSk/FmFp5epyesE54JjopgxySDdXQhZ4LmJWe
 XFZe7BomXTrlQZhJNmDuDSD+OvAy24YjhDN8s9c96rNGaW1kArE/pTdCIg8mACc4mjF9 lg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2k7a3t0245-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 10:13:40 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6HADdW5022641
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jul 2018 10:13:39 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6HADcaN008827;
        Tue, 17 Jul 2018 10:13:38 GMT
Received: from mwanda (/197.179.115.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 03:13:38 -0700
Date:   Tue, 17 Jul 2018 13:13:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, Zhongze Hu <frankhu@chromium.org>,
        linux-kernel@vger.kernel.org, Simon Que <sque@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 12/32] staging: gasket: gasket_wait_with_reschedule
 return when condition hit
Message-ID: <20180717101329.yl4hwob2jbjlp2uh@mwanda>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
 <20180717020926.176408-13-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717020926.176408-13-toddpoynor@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8956 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=470
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807170106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 07:09:06PM -0700, Todd Poynor wrote:
> From: Todd Poynor <toddpoynor@google.com>
> 
> Return right away instead of break out of while and then return.
> 

You could remove the (retries == max_retries) condition since that's
always true now and pull that code in one tab.  You could do it in one
patch because they're closely related so it's One Thing [tm].

regads,
dan carpenter

