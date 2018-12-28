Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63047C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393B42084A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 09:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731925AbeL1Jml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 04:42:41 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:50408 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727225AbeL1Jmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 04:42:40 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBS9ccHh011624;
        Fri, 28 Dec 2018 03:42:39 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2phkj7f2ht-1;
        Fri, 28 Dec 2018 03:42:38 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id B3B8A611B6D0;
        Fri, 28 Dec 2018 03:46:36 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 28 Dec 2018
 09:42:37 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wBS9gakZ027318; Fri,
 28 Dec 2018 09:42:37 GMT
Date:   Fri, 28 Dec 2018 09:42:36 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        <patches@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 18/18] mfd: wm8400-core: Make it explicitly non-modular
Message-ID: <20181228094236.GL16508@imbe.wolfsonmicro.main>
References: <1545078688-21217-1-git-send-email-paul.gortmaker@windriver.com>
 <1545078688-21217-19-git-send-email-paul.gortmaker@windriver.com>
 <20181219091742.GA16508@imbe.wolfsonmicro.main>
 <20181221155516.GP4292@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181221155516.GP4292@windriver.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=926 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1812280087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 10:55:16AM -0500, Paul Gortmaker wrote:
> [Re: [PATCH 18/18] mfd: wm8400-core: Make it explicitly non-modular] On 19/12/2018 (Wed 09:17) Charles Keepax wrote:
> 
> > On Mon, Dec 17, 2018 at 03:31:28PM -0500, Paul Gortmaker wrote:
> > > -MODULE_DEVICE_TABLE(i2c, wm8400_i2c_id);
> > >  
> > >  static struct i2c_driver wm8400_i2c_driver = {
> > >  	.driver = {
> > > @@ -161,7 +160,7 @@ static struct i2c_driver wm8400_i2c_driver = {
> > >  };
> > >  #endif
> > 
> > Do we not want to add suppress_bind_attrs into the i2c_driver
> > struct here?
> 
> We can add one if you/maintainers want one, but if you look at the
> original patch, this driver was using the more classic/legacy case of
> subsys_init() vs. platform_driver_register() used in other drivers.
> 
> Not adding a suppress_bind_attrs here was intentional, since I'd decided
> to put in the unbind entries for code that used platform_driver_register()
> where the author had created the .remove code, on the assumption that they
> had put some thought into the process of unbind/remove - to make it
> explicit that unbind is now disabled.
> 
> To be clear, using the subsys_init() doesn't implicitly disable unbind.
> However, there are lots of non-modular drivers out there; ones I've not
> even touched, and to start a project to add an unbind disable to them
> all is beyond the scope of the goals I've listed in the 00/18 preamble.
> 
> I'd hope maybe we can revisit the global default setting for non-modular
> code someday - to make non-modules opt-in instead of opt-out, and
> achieve better consistency from one driver to the next, without having
> to add a new .driver sub-struct to each file for the suppress entry.
> 
> I think LinusW hinted at in an earlier email in this ongoing review,
> that the default setting didn't quite make sense to him either.  But in
> any case, that is a separate discussion for another time and place.
> 
> Let me know if you explicitly want one added, otherwise I'll just leave
> the .remove + .suppress_bind_attrs pairing as described above.
> 

Nah its ok, if you are specifically not doing this one I think I
am ok with it. Just seemed out of place compared to the the
others:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
