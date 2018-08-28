Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA33C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7AE20878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7AE20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbeH1Oac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:30:32 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:53602 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727172AbeH1Oab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:30:31 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7SAcfaN020001;
        Tue, 28 Aug 2018 05:39:14 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2m34h1ukwp-1;
        Tue, 28 Aug 2018 05:39:14 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 055E9611C8B3;
        Tue, 28 Aug 2018 05:41:15 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 28 Aug 2018
 11:39:13 +0100
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id w7SAdBfw012289; Tue,
 28 Aug 2018 11:39:11 +0100
Date:   Tue, 28 Aug 2018 11:39:11 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Jon Hunter <jonathanh@nvidia.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <linux-tegra@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: core: Don't schedule DAPM work if
 already in target state
Message-ID: <20180828103911.GX32322@imbe.wolfsonmicro.main>
References: <1534520143-29266-1-git-send-email-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1534520143-29266-1-git-send-email-jonathanh@nvidia.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808280110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 04:35:43PM +0100, Jon Hunter wrote:
> When dapm_power_widgets() is called, the dapm_pre_sequence_async() and
> dapm_post_sequence_async() functions are scheduled for all DAPM contexts
> (apart from the card DAPM context) regardless of whether the DAPM
> context is already in the desired state. The overhead of this is not
> insignificant and the more DAPM contexts there are the more overhead
> there is.
> 
> For example, on the Tegra124 Jetson TK1, when profiling the time taken
> to execute the dapm_power_widgets() the following times were observed.
> 
>   Times for function dapm_power_widgets() are (us):
>      Min 23, Ave 190, Max 434, Count 39
> 
> Here 'Count' is the number of times that dapm_power_widgets() has been
> called. Please note that the above time were measured using ktime_get()
> to log the time on entry and exit from dapm_power_widgets(). So it
> should be noted that these times may not be purely the time take to
> execute this function if it is preempted. However, after applying this
> patch and measuring the time taken to execute dapm_power_widgets() again
> a significant improvement is seen as shown below.
> 
>   Times for function dapm_power_widgets() are (us):
>      Min 4, Ave 16, Max 82, Count 39
> 
> Therefore, optimise the dapm_power_widgets() function by only scheduling
> the dapm_pre/post_sequence_async() work if the DAPM context is not in
> the desired state.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---

Looks ok to me:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Although that said the performance increase is pretty hard to
measure on my systems.

Thanks,
Charles
