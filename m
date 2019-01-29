Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D697C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A4720869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfA2Jyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:54:43 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:35454 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbfA2Jyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:54:43 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0T9sA9D030677;
        Tue, 29 Jan 2019 03:54:39 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2q8nu7uh9q-1;
        Tue, 29 Jan 2019 03:54:39 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id B924E611C8B3;
        Tue, 29 Jan 2019 03:54:38 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 29 Jan 2019
 09:54:38 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id x0T9sc6s015547; Tue,
 29 Jan 2019 09:54:38 GMT
Date:   Tue, 29 Jan 2019 09:54:38 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Axel Lin <axel.lin@ingics.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: lochnagar: Fix n_voltages setting for VDDCORE
Message-ID: <20190129095438.GJ3837@imbe.wolfsonmicro.main>
References: <20190129030156.2024-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190129030156.2024-1-axel.lin@ingics.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901290076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 11:01:56AM +0800, Axel Lin wrote:
> With current n_voltages setting, regulator_list_voltage will return
> -EINVAL when selector >=57. The highest selector is 0x41, so the
> n_voltages should be 0x41+1, i.e. 66.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/lochnagar-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
> index 4962d13659aa..ff97cc50f2eb 100644
> --- a/drivers/regulator/lochnagar-regulator.c
> +++ b/drivers/regulator/lochnagar-regulator.c
> @@ -194,7 +194,7 @@ static const struct regulator_desc lochnagar_regulators[] = {
>  		.name = "VDDCORE",
>  		.supply_name = "SYSVDD",
>  		.type = REGULATOR_VOLTAGE,
> -		.n_voltages = 57,
> +		.n_voltages = 66,
>  		.ops = &lochnagar_vddcore_ops,
>  
>  		.id = LOCHNAGAR_VDDCORE,
> -- 
> 2.17.1

Hmm... I think this might need a little more investigation, it
does indeed fail at present (amazing that it works upto exactly 1.2V
which is common the usecase) but this feels more like a core
problem. There are indeed only 57 valid voltage settings as the
range is 0x8 - 0x41, but it seems that presently the core treats
this less as n_voltages and more like max_selector. Should we
perhaps be teaching the core to understand the min_selector
instead?

Thanks,
Charles
