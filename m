Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710FFC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BB3206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 09:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BB3206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeIENpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:45:34 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:59686 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725862AbeIENpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:45:34 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w859EHgt030856;
        Wed, 5 Sep 2018 04:16:11 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2m7r62n6ec-1;
        Wed, 05 Sep 2018 04:16:11 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 0B20A611C8B4;
        Wed,  5 Sep 2018 04:17:56 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 5 Sep 2018
 10:16:10 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w859G9q8018868; Wed,
 5 Sep 2018 10:16:09 +0100
Date:   Wed, 5 Sep 2018 10:16:09 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Colin King <colin.king@canonical.com>
CC:     Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-input@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: wm97xx: only unregister wm97xx_driver if it has
 been registered
Message-ID: <20180905091609.GC1653@imbe.wolfsonmicro.main>
References: <20180904183505.10693-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180904183505.10693-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=846 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1809050099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 07:35:05PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where IS_BUILTIN(CONFIG_AC97_BUS)) is not true, the
> wm97xx_driver driver is being unregistered even it has not been
> previously registered.  Fix this by only unregistering it if
> IS_BUILTIN(CONFIG_AC97_BUS)) is true.  This fixes the warning
> message:
> 
> [  834.111248] ------------[ cut here ]------------
> [  834.111248] Unexpected driver unregister!
> [  834.111319] WARNING: CPU: 2 PID: 11749 at drivers/base/driver.c:193 driver_unregister+0x3b/0x40
> [  834.111319] Modules linked in: wm97xx_ts(-) ....
> 
> ..and a stack trace.
> 
> To easily reproduce this, load and unload the module on a system where
> the hardware is not supported.
> 
> Fixes: ae9d1b5fbd7b ("Input: wm97xx: add new AC97 bus support")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
