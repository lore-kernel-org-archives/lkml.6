Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6A3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D6E2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 22:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DO1oIM6e";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DO1oIM6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfB0W3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 17:29:16 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46056 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728397AbfB0W3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 17:29:16 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 98539608CE; Wed, 27 Feb 2019 22:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551306554;
        bh=ZVdH6yRS+A5FF1Iv5uXWvbZf/P3M/KvUibQBOF5OhCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DO1oIM6ezAbu+32Pwb3AqFS8hZRjMIR+tpaTIEKsxsGfze+QXfaLf/Dd3ueT1wmKV
         pkSS9cCIMADLHoTlA0XsHw8omqUVGXpmgIgJa36Jk+WCJ1khGnZkn8G2IMnrt8E/2i
         zEPO2Xwed3q+HaYOj0jFr/3np+q0czv0g3oARnGA=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CEABE608CE;
        Wed, 27 Feb 2019 22:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1551306554;
        bh=ZVdH6yRS+A5FF1Iv5uXWvbZf/P3M/KvUibQBOF5OhCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DO1oIM6ezAbu+32Pwb3AqFS8hZRjMIR+tpaTIEKsxsGfze+QXfaLf/Dd3ueT1wmKV
         pkSS9cCIMADLHoTlA0XsHw8omqUVGXpmgIgJa36Jk+WCJ1khGnZkn8G2IMnrt8E/2i
         zEPO2Xwed3q+HaYOj0jFr/3np+q0czv0g3oARnGA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CEABE608CE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 27 Feb 2019 15:29:13 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, evgreen@chromium.org,
        dianders@chromium.org, mka@chromium.org
Subject: Re: [PATCH RESEND v3 2/3] drivers: qcom: rpmh-rsc: return if the
 controller is idle
Message-ID: <20190227222913.GA10971@codeaurora.org>
References: <20190221121827.32427-1-rplsssn@codeaurora.org>
 <20190221121827.32427-3-rplsssn@codeaurora.org>
 <155122856693.260864.16771523196413005158@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <155122856693.260864.16771523196413005158@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Tue, Feb 26 2019 at 17:49 -0700, Stephen Boyd wrote:
>Quoting Raju P.L.S.S.S.N (2019-02-21 04:18:26)
>> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
>> index d6b834eeeb37..9cc303e88a06 100644
>> --- a/drivers/soc/qcom/rpmh-rsc.c
>> +++ b/drivers/soc/qcom/rpmh-rsc.c
>> @@ -524,6 +524,30 @@ static int tcs_ctrl_write(struct rsc_drv *drv, const struct tcs_request *msg)
>>         return ret;
>>  }
>>
>> +/**
>> + *  rpmh_rsc_ctrlr_is_idle: Check if any of the AMCs are busy.
>> + *
>> + *  @drv: The controller
>> + *
>> + *  Returns true if the TCSes are engaged in handling requests.
>> + */
>> +bool rpmh_rsc_ctrlr_is_idle(struct rsc_drv *drv)
>> +{
>
>This API seems inherently racy. How do we know that nothing else is
>going to be inserted into the TCS after this function returns true? Do
>you have a user of this API? It would be good to know how it is used
>instead of adding some code that never gets called.
>
This API is called from the last CPU that is powering down in an
interrupt locked context (say during suspend). If we are waiting on a
request, we would bail out of the suspend process. There can be no issue
requested during the last step in suspend. The PM driver itself does not
make any TCS request. Currently, this API is used by the downstream code
in its last man activities. The usage by platform coordinated mode is
still under discussion.

-- Lina
>> +       int m;
>> +       struct tcs_group *tcs = get_tcs_of_type(drv, ACTIVE_TCS);
>> +
>> +       spin_lock(&drv->lock);
>> +       for (m = tcs->offset; m < tcs->offset + tcs->num_tcs; m++) {
>> +               if (!tcs_is_free(drv, m)) {
>> +                       spin_unlock(&drv->lock);
>> +                       return false;
>> +               }
>> +       }
>> +       spin_unlock(&drv->lock);
>> +
>> +       return true;
>> +}
>> +
>>  /**
>>   * rpmh_rsc_write_ctrl_data: Write request to the controller
>>   *
>
