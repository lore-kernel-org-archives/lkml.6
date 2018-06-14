Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 04B5CC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD977208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bj25A3ep";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B/mVQ8v3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD977208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755246AbeFNRSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 13:18:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45856 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754635AbeFNRSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 13:18:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EF86F602B8; Thu, 14 Jun 2018 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528996688;
        bh=SKYHID8KcqtQU3YdWn7T35a3r7SAYBC2Me8gzIpokDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bj25A3ep5ZAzQNMzBhpCsGrAEEe0+OF6vOh0rH6jLxPj+x5EEpvsC5MmK6Sn65dNY
         tFO9+AqdQ8EWtPdZbcDCfkv/Qro1a3faQdZvesXTeQUi9wPB5j+ZA7KUNoAqH4MjNI
         Lmec2U5w39LTYg5IdGj8oRvoOTE+JQkQTgoB34Ic=
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ilina@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 189D1602B8;
        Thu, 14 Jun 2018 17:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528996687;
        bh=SKYHID8KcqtQU3YdWn7T35a3r7SAYBC2Me8gzIpokDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/mVQ8v3ekVwcrrmKWvgAhYwA2mtIuTyCm8QLLk5rHZSqDePcQc3WftMiyLER3hrb
         CFSN8tlBo5Azy26rdT+sqIPw3ee7r7x6IHKPBkvnx5NDfbGJEkVcovtyIPA+N2YElJ
         Q+AUNVTGk31HTx5F88HXljyWE3LGtUF3z0dGjWfQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 189D1602B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Thu, 14 Jun 2018 11:18:06 -0600
From:   Lina Iyer <ilina@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Raju P L S S S N <rplsssn@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v10 10/10] drivers: qcom: rpmh-rsc: allow active requests
 from wake TCS
Message-ID: <20180614171806.GB21724@codeaurora.org>
References: <1528737949-17495-1-git-send-email-rplsssn@codeaurora.org>
 <1528737949-17495-11-git-send-email-rplsssn@codeaurora.org>
 <CAD=FV=Vc_wtLTxM8A9T-RZ8h5XpkSLLUVJzmCQSytXFwOPRkOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAD=FV=Vc_wtLTxM8A9T-RZ8h5XpkSLLUVJzmCQSytXFwOPRkOw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13 2018 at 15:09 -0600, Doug Anderson wrote:
>Hi,
>
>On Mon, Jun 11, 2018 at 10:25 AM, Raju P L S S S N
><rplsssn@codeaurora.org> wrote:
>> @@ -148,7 +148,8 @@ int rpmh_rsc_invalidate(struct rsc_drv *drv)
>>  static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
>>                                          const struct tcs_request *msg)
>>  {
>> -       int type;
>> +       int type, ret;
>> +       struct tcs_group *tcs;
>>
>>         switch (msg->state) {
>>         case RPMH_ACTIVE_ONLY_STATE:
>> @@ -164,7 +165,25 @@ static struct tcs_group *get_tcs_for_msg(struct rsc_drv *drv,
>>                 return ERR_PTR(-EINVAL);
>>         }
>>
>> -       return get_tcs_of_type(drv, type);
>> +       /*
>> +        * If we are making an active request on a RSC that does not have a
>> +        * dedicated TCS for active state use, then re-purpose a wake TCS to
>> +        * send active votes.
>> +        * NOTE: The driver must be aware that this RSC does not have a
>> +        * dedicated AMC, and therefore would invalidate the sleep and wake
>> +        * TCSes before making an active state request.
>> +        */
>> +       tcs = get_tcs_of_type(drv, type);
>> +       if (msg->state == RPMH_ACTIVE_ONLY_STATE && IS_ERR(tcs)) {
>> +               tcs = get_tcs_of_type(drv, WAKE_TCS);
>> +               if (!IS_ERR(tcs)) {
>> +                       ret = rpmh_rsc_invalidate(drv);
>> +                       if (ret)
>> +                               return ERR_PTR(ret);
>
>In v9 you looped as long as the "ret" was -EAGAIN.  Now you're not.
>Are all the callers setup to handle -EAGAIN or should you keep the
>loop in for -EAGAIN?  I don't think callers handle this well.
>
>...or is there some reason that EAGAIN can't happen in this call to
>rpmh_rsc_invalidate()?
>
>
Returning an error back to the caller is the right approach here. If the
invalidate fails, its mostly because, the TCS is busy or in use by an
external entity. Only the caller would be able to resolve the condition
and take corrective action.

-- Lina

