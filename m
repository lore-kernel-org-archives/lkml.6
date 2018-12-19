Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8239FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE20217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeLSJRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:17:46 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:38040 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726774AbeLSJRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:17:45 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBJ9ANXI026208;
        Wed, 19 Dec 2018 03:17:44 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2pcyw5qje2-1;
        Wed, 19 Dec 2018 03:17:44 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id A5916611C8AC;
        Wed, 19 Dec 2018 03:20:40 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 19 Dec 2018
 09:17:42 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wBJ9HgAS012169; Wed,
 19 Dec 2018 09:17:42 GMT
Date:   Wed, 19 Dec 2018 09:17:42 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 18/18] mfd: wm8400-core: Make it explicitly non-modular
Message-ID: <20181219091742.GA16508@imbe.wolfsonmicro.main>
References: <1545078688-21217-1-git-send-email-paul.gortmaker@windriver.com>
 <1545078688-21217-19-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1545078688-21217-19-git-send-email-paul.gortmaker@windriver.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1812190080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 03:31:28PM -0500, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/mfd/Kconfig:config MFD_WM8400
> drivers/mfd/Kconfig:    bool "Wolfson Microelectronics WM8400"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init was not in use by this code, the init ordering
> remains unchanged with this commit.
> 
> A trivial function rename from wm8400_module_init to the name
> wm8400_driver_init is also done to reduce possible confusion.
> 
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> is already contained at the top of the file in the comments.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: patches@opensource.cirrus.com
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> -MODULE_DEVICE_TABLE(i2c, wm8400_i2c_id);
>  
>  static struct i2c_driver wm8400_i2c_driver = {
>  	.driver = {
> @@ -161,7 +160,7 @@ static struct i2c_driver wm8400_i2c_driver = {
>  };
>  #endif

Do we not want to add suppress_bind_attrs into the i2c_driver
struct here?

Thanks,
Charles
