Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88C3C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93942082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 17:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbfBDRfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:35:30 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45138 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbfBDRf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 12:35:29 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x14HYC54005426;
        Mon, 4 Feb 2019 11:35:25 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2qd8graet5-1;
        Mon, 04 Feb 2019 11:35:25 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id CAC686255C5C;
        Mon,  4 Feb 2019 11:35:32 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 4 Feb 2019
 17:35:24 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id x14HZNWw029893; Mon,
 4 Feb 2019 17:35:23 GMT
Date:   Mon, 4 Feb 2019 17:35:23 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Axel Lin <axel.lin@ingics.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: lochnagar: Fix n_voltages setting for VDDCORE
Message-ID: <20190204173523.GM3837@imbe.wolfsonmicro.main>
References: <20190129030156.2024-1-axel.lin@ingics.com>
 <20190129095438.GJ3837@imbe.wolfsonmicro.main>
 <20190129180547.GI10524@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190129180547.GI10524@sirena.org.uk>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902040136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 06:05:47PM +0000, Mark Brown wrote:
> On Tue, Jan 29, 2019 at 09:54:38AM +0000, Charles Keepax wrote:
> 
> > Hmm... I think this might need a little more investigation, it
> > does indeed fail at present (amazing that it works upto exactly 1.2V
> > which is common the usecase) but this feels more like a core
> > problem. There are indeed only 57 valid voltage settings as the
> > range is 0x8 - 0x41, but it seems that presently the core treats
> > this less as n_voltages and more like max_selector. Should we
> > perhaps be teaching the core to understand the min_selector
> > instead?
> 
> We've not had a need for this before but that seems like a reasonable
> addition.

Ok been looking at this last couple of days and I am not so sure
it was a good idea after all.

There are basically two options:

1) Update the usages of selector so it is consistently an index
into the available voltages.
2) Update the handling of n_voltages so that it is converted to
max_selector when used.

Both of these really seem to end up with code that is more
complex than the current system. You end up needing to always
specify or calculate and store the minimum selector and maybe
the maximum one. This needs handling across the various different
schemes for specifying the voltage ranges for the regulators.

So I am adding my ack to the patch, and think we should really
just apply Axel's fix.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

One thought that did cross my mind, would we be tempted to rename
n_voltages to max_selector? It would be more consistent with the
current usage, although its a horrible big change that doesn't
really make any functional difference.

Thanks,
Charles
