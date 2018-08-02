Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150D1C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1792208DA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZMNPrncs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1792208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeHBICM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:02:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44012 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeHBICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:02:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w7264539122915;
        Thu, 2 Aug 2018 06:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=kS4foqt/6bOC8QY3RGD+ah6CP+9XssfnGY2zOFQUmgw=;
 b=ZMNPrncsQfVmzGl3/iKzss4RPlJg1Z6HzqJ58p/Rp8r4NpXtO76Dyw7qsKQcZKmpw5ib
 OhWS4X7jLg0m/B31+SczAXvKc35PK8aEVf0T+9ax961vyyMQYWdAgiUmedeN65UawDML
 vW6SkJ/7jHJ/JdGfHM5cwial0GAv4AcmMFIAkmdkJ7cKJTkQD6yIsg6gkD7Ti8jtECWT
 vT2Kd3Ermzfph2t8INelVfxofCb3cJy1K+2sFVCZK5y/Ifo+DVidG+3PVYG49QgpenGC
 ksXjJ27Px7dTgH7wUFcQJVmAzjx20cjxDaT6QISRhwn67VWpaT2J+tkAjOLo0u4fqE+9 Rw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2kggep9qbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Aug 2018 06:12:38 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w726Cbvh011902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Aug 2018 06:12:37 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w726CaFq023232;
        Thu, 2 Aug 2018 06:12:36 GMT
Received: from mwanda (/197.232.248.111)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 01 Aug 2018 23:12:36 -0700
Date:   Thu, 2 Aug 2018 09:12:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jheng-Jhong Wu <goodwater.wu@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: mt29f_spinand: fix memory leak while
 programming pages
Message-ID: <20180802061229.vg4zefomfxek4vvi@mwanda>
References: <1533116658-14924-1-git-send-email-goodwater.wu@gmail.com>
 <20180801114518.ajkgsx7exjny63mt@mwanda>
 <CALtPoQCyoe5V0m5=3K1XeZm41aDCaJ0rmYU-a=qkm=Yb8jgMxg@mail.gmail.com>
 <CALtPoQA7EdUDmN26Z406J6gFFx4XLUy1zTb65x8MgTVpoG57tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALtPoQA7EdUDmN26Z406J6gFFx4XLUy1zTb65x8MgTVpoG57tg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8972 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=828
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1808020066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 02, 2018 at 11:42:30AM +0800, Jheng-Jhong Wu wrote:
> Dear Dan,
> 
> I know what you wrote, but before the spinand device is removed and
> freed memory automatically, programming pages may do many many times.
> Assume we erase and rewrite a large part of the flash, then
> spinand_program_page() might exhaust memory if memory is not large
> enough.
> In fact, OOM indeed occured when I tested programming multi-pages by
> mtd_debug tool.
> If OOM was not caused by devm_kzalloc() in spinand_program_page(),
> what may exhaust memory?
> 

Ok.  That makes sense.  I didn't look at it in context.  You should say
that sort of thing in your changelog.  Looking at it now, the devm_
model isn't right for this function so we should change it to use normal
kzalloc().

We should fix all the error paths as well.  It looks like if this
function starts returning errors, we are probably toasted, but it's
still good practice to avoid slow leaks.

regards,
dan carpenter


