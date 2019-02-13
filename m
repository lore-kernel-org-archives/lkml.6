Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0423C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6562147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 10:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbfBMKGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 05:06:21 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:42805 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfBMKGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 05:06:21 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 9169513F8F1;
        Wed, 13 Feb 2019 11:05:28 +0100 (CET)
Subject: Re: [PATCH v5 1/2] scsi: ufs: Do not disable vccq in UFSHC driver
To:     Mark Brown <broonie@kernel.org>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Ohad Sharabi <ohad.sharabi@wdc.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Yaniv Gardi <ygardi@codeaurora.org>,
        Raviv Shvili <rshvili@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, Kyuho Choi <kyuho.choi@sk.com>,
        Martin Petersen <martin.petersen@oracle.com>
References: <494cd639-89a7-8868-b63a-ea7cdcba9777@free.fr>
 <be3ef9bf-438b-4e8a-62c4-f75458e8ecc0@free.fr>
 <20190211172340.GG22391@sirena.org.uk>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <cc915cc2-722b-5cae-6c8b-b0d50d90c56d@free.fr>
Date:   Wed, 13 Feb 2019 11:05:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211172340.GG22391@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2019 18:23, Mark Brown wrote:

> On Mon, Feb 11, 2019 at 02:32:15PM +0100, Marc Gonzalez wrote:
> 
>> Unfortunately, this optimization breaks UFS on systems where vccq
>> powers not only the Flash chip, but the host controller as well,
>> such as APQ8098 MEDIABOX or MTP8998.
>> 
>> In my opinion, the rationale for the original patch is questionable.
>> If neither the UFSHC, nor the Flash chip, require any load from vccq,
>> then that power rail should simply not be specified at all in the DT.
> 
> If the supply is physically connected it should be valid to represent
> this in DT regardless of how or if the supply gets used at runtime.
> However it does sound like this support needs to be better thought
> through to make sure we have represented the supplies to the flash chip
> and the controller separately - it seems like right now there's no
> tracking of the supplies needed for the controller and the assumption is
> that only the flash chip needs managing which is breaking things.

As far as I'm aware, the conflation of host controller with their respective
storage medium occurs across several techs: UFS, NAND, SDHC, EMMC.

There might be room for improvement, but I don't think these considerations
should hold up this series, which fixes something that is broken *today*.

UFS reviewers (Alim, Avri, Pedro), can I get at least one Acked-by to remove
this small power optimization that breaks UFS on my system?

Regards.
