Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87062C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5225B20855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5225B20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeLJJ2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:28:13 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:54502 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726802AbeLJJ2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:28:12 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBA9Ot5k028752;
        Mon, 10 Dec 2018 03:28:10 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2p8b8vt74r-1;
        Mon, 10 Dec 2018 03:28:10 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 956DD611C8B7;
        Mon, 10 Dec 2018 03:28:09 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 10 Dec 2018
 09:28:09 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wBA9S8VZ023996; Mon,
 10 Dec 2018 09:28:08 GMT
Date:   Mon, 10 Dec 2018 09:28:08 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 16/18] mfd: wm8350-i2c: Make it explicitly non-modular
Message-ID: <20181210092808.GN16508@imbe.wolfsonmicro.main>
References: <1544213465-16259-1-git-send-email-paul.gortmaker@windriver.com>
 <1544213465-16259-17-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1544213465-16259-17-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=968 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1812100087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 03:11:03PM -0500, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/mfd/Kconfig:config MFD_WM8350_I2C
> drivers/mfd/Kconfig:    bool "Wolfson Microelectronics WM8350 with I2C"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> We explicitly disallow a driver unbind, since that doesn't have a
> sensible use case anyway, and it allows us to drop the ".remove"
> code for non-modular drivers.
> 
> Since module_init was not in use by this code, the init ordering
> remains unchanged with this commit.
> 
> We don't replace module.h with init.h since the file already has that.
> But we do delete an unused moduleparam.h
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: patches@opensource.cirrus.com
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
> -static int wm8350_i2c_remove(struct i2c_client *i2c)
> -{
> -	struct wm8350 *wm8350 = i2c_get_clientdata(i2c);
> -
> -	wm8350_device_exit(wm8350);

This is the only caller of this function so you probably want to
remove it in the next patch as we did for the 831x stuff.

Thanks,
Charles
