Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2E0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389532087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AiZjI+1H";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IwzNnCZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbfBDUXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:23:53 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:53548 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfBDUXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:23:53 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9386960791; Mon,  4 Feb 2019 20:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549311832;
        bh=U7a/SiqVIx4/20isCf5fJ9ClastJ/q92E2QY0bv+KJA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AiZjI+1HMvKUXuSv3TJiT8mJV7yxIATGYPP/PN3WBKK/+gHPUTg2c6cNB4DGE0ebl
         /lfHcjm1810811I0LvkFXSYzHz6GGBpBLZtmAcVQIRuO4fiw6iZPthBw2G0N1ftpnT
         Zk7uZudlTFjdYFglCcQTphITmg21fpUlwxD2KJR0=
Received: from [10.226.60.81] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 543ED6043F;
        Mon,  4 Feb 2019 20:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549311831;
        bh=U7a/SiqVIx4/20isCf5fJ9ClastJ/q92E2QY0bv+KJA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IwzNnCZ6xWxy+J3R3dayt+t2xg+xLXpimOdmLD33dqEp4B7zIJCC8XZeZmAmPbzdz
         +wLD3ayyktdswOpEmwA9IFLW5XzHF4tGFy9jWU7CgFyqssfxY7bLAYfgP5nIFz5xN4
         uTvZM394//2GcrmY59e6V/FpG4QTQQvQF6QodGts=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 543ED6043F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 5/5] Revert "scsi: ufs: disable vccq if it's not needed
 by UFS device"
To:     Avri Altman <Avri.Altman@wdc.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        SCSI <linux-scsi@vger.kernel.org>
References: <e3c82a49-c601-effc-348f-f768656c659f@free.fr>
 <70618c25-83f0-b9db-51a3-c1d74b605a45@free.fr>
 <SN6PR04MB49255ADE41BBD35F894FD4CBFC6D0@SN6PR04MB4925.namprd04.prod.outlook.com>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <91e7f06c-7d13-d0bd-efee-4a62a429f727@codeaurora.org>
Date:   Mon, 4 Feb 2019 13:23:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <SN6PR04MB49255ADE41BBD35F894FD4CBFC6D0@SN6PR04MB4925.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/2019 12:51 PM, Avri Altman wrote:
> 
>> This reverts commit 60f0187031c05e04cbadffb62f557d0ff3564490.
>>
>> Calling ufshcd_set_vccq_rail_unused hangs my system.
>> It seems vccq is not *not* needed.
> This patch essentially implements the UFS_DEVICE_NO_VCCQ quirk,
> Which is needed for both Samsung and Hynix devices.

Needed, or optimal?
I'm rather sure Marc's device has a Samsung UFS chip, as do my devices 
and we've seen nothing but benefit from the proposed revert.

> Once acked by those vendors, can be removed from the quirk list as well.
> 
> Thanks,
> Avri
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>


-- 
Jeffrey Hugo
Qualcomm Datacenter Technologies as an affiliate of Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
