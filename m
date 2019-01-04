Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814BBC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A01820874
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfADLcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:32:19 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:34350 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726981AbfADLcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:32:18 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x04BTK3B031141;
        Fri, 4 Jan 2019 05:32:09 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2pp67uq1u7-1;
        Fri, 04 Jan 2019 05:32:09 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id B2633611C8B0;
        Fri,  4 Jan 2019 05:32:08 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 4 Jan 2019
 11:32:08 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id x04BW7Jc023384; Fri,
 4 Jan 2019 11:32:07 GMT
Date:   Fri, 4 Jan 2019 11:32:07 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
CC:     <mazziesaccount@gmail.com>, <mikko.mutanen@fi.rohmeurope.com>,
        <heikki.haikola@fi.rohmeurope.com>, <broonie@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <geert@linux-m68k.org>
Subject: Re: [PATCH] regmap: regmap-irq: Make irq-type callbak optional
Message-ID: <20190104113207.GT16508@imbe.wolfsonmicro.main>
References: <20190104103115.GA10043@localhost.localdomain>
 <20190104111443.GS16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190104111443.GS16508@imbe.wolfsonmicro.main>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=572 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901040103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 11:14:43AM +0000, Charles Keepax wrote:
> On Fri, Jan 04, 2019 at 12:31:15PM +0200, Matti Vaittinen wrote:
> > +	if (num_type_reg)
> > +		d->irq_chip.irq_set_type = regmap_irq_set_type;
> > +
> 
> Afraid this also causes regressions at my end, still having a bit
> of a look but it looks like some how this prevents properties of the
> IRQ getting passed along which causes my system to not probe
> properly with:
> 
> genirq: Flags mismatch irq 58. 00002088 (cs35l35) vs. 00002088 (cs35l35)
> cs35l35 0-0041: Failed to request IRQ: -16
> 

My case is a shared IRQ with 2 amps (cs35l35) connected to a CODEC
(wm8280).

So looks like the issue is if you don't have a set_type callback
then the IRQ ends up as IRQF_TRIGGER_NONE, which causes the
second IRQ to fail the middle check here in __setup_irq:

		if (!((old->flags & new->flags) & IRQF_SHARED) ||
		    (oldtype != (new->flags & IRQF_TRIGGER_MASK)) ||
		    ((old->flags ^ new->flags) & IRQF_ONESHOT)) {

Kinda inclined to just leave the fix as currently submitted and
just drop this patch? But I can do more testing etc. if we want
to push further down this road.

Thanks,
Charles
