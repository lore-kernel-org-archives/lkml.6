Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F431C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2B4217BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 08:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LErI2EkP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bgpxtg49"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A2B4217BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbeHFKcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 06:32:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41558 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeHFKct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 06:32:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 81BF860B72; Mon,  6 Aug 2018 08:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533543893;
        bh=X6NsWbxOmbuIisG12zzTg1v0jQgGBBKkNb7MlFz4ruE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LErI2EkPgy2gtYMfQsi0VakwR18MT0FKhI+2+C/dZPJrWoF1nDs/r6RGrm7vjz53S
         pQI9YqLtxBFFa0Zxhr8G0WLV0ue+2qw9AXY0WxxKII/cKXUXv9iKBbgLJeGixs2ARs
         QKsbN2+MyfGkZLIKqLh8qW62MZRxByxrJH8gVDas=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D564B6037C;
        Mon,  6 Aug 2018 08:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533543892;
        bh=X6NsWbxOmbuIisG12zzTg1v0jQgGBBKkNb7MlFz4ruE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bgpxtg49eRJBujVJx7Uxa+5cqeh2rrd98Ld5TryadbXch8x4nVNt4WobLvTea+E04
         8CzfrTdttF4CA+hqQ2v2HlBaCsa5kgW8/TwVRP408YfkfcURR3POtDutWS9poXyhyg
         pgoJoHTjFhLRTUqCgoUsXAKI9yVsdvKjCZwPAT0M=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Aug 2018 13:54:52 +0530
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     hverkuil@xs4all.nl, mchehab@kernel.org, robh@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org, arnd@arndb.de,
        bjorn.andersson@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        acourbot@chromium.org, linux-media-owner@vger.kernel.org
Subject: Re: [PATCH v3 2/4] venus: firmware: move load firmware in a separate
 function
In-Reply-To: <b5ecaa26-2f3b-9a2e-d496-7f9b35e3f761@linaro.org>
References: <1530731212-30474-1-git-send-email-vgarodia@codeaurora.org>
 <1530731212-30474-3-git-send-email-vgarodia@codeaurora.org>
 <b5ecaa26-2f3b-9a2e-d496-7f9b35e3f761@linaro.org>
Message-ID: <6c8c4e7b27000903073ac85a867b0454@codeaurora.org>
X-Sender: vgarodia@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

On 2018-07-25 15:05, Stanimir Varbanov wrote:
> Hi Vikash,
> 
> On 07/04/2018 10:06 PM, Vikash Garodia wrote:

<snip>

>> +
>> +	if (!IS_ENABLED(CONFIG_QCOM_MDT_LOADER))
>> +		return -EPROBE_DEFER;
> 
> the original venus_boot was checking for || !qcom_scm_is_available() 
> why
> is that removed? It was done on purpose.

For booting venus without tz, scm calls are not needed. Does it look 
good to
keep the check for "!core->no_tz" case alone ?

if (!core->no_tz && !qcom_scm_is_available())
     return -EPROBE_DEFER;

Thanks,
Vikash
