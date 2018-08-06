Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C611BC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D43021990
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ky/rpyEI";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ky/rpyEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D43021990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbeHFPr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:47:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33304 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbeHFPr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:47:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CD07B60B11; Mon,  6 Aug 2018 13:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533562697;
        bh=UOk/g3lJ/0LOvtfcOeOGdfIE3y2uKG4fzuJwcuVSUGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ky/rpyEInhi+khcbt2O7FiBq1R6X1T2RaUQ9ZAPkHsF8XzKdDlh0ErDF1KKAffeQd
         f/ryk+gyoOCQnudJQOTc5TT2L9opUB5IFI1ZUd+rhUOu7l7XVYNtI9VzxdK7MeImZ9
         7e8NehQGHiKHHkEG3HbFcZd7o8Uc9KV47iXyaYB8=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3C05860769;
        Mon,  6 Aug 2018 13:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533562697;
        bh=UOk/g3lJ/0LOvtfcOeOGdfIE3y2uKG4fzuJwcuVSUGo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ky/rpyEInhi+khcbt2O7FiBq1R6X1T2RaUQ9ZAPkHsF8XzKdDlh0ErDF1KKAffeQd
         f/ryk+gyoOCQnudJQOTc5TT2L9opUB5IFI1ZUd+rhUOu7l7XVYNtI9VzxdK7MeImZ9
         7e8NehQGHiKHHkEG3HbFcZd7o8Uc9KV47iXyaYB8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 06 Aug 2018 19:08:17 +0530
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
Message-ID: <9960617f02a0df8935175651408ce2d3@codeaurora.org>
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
>> Separate firmware loading part into a new function.
> 
> I cannot apply this patch in order to test the series.
Sorry about the inconvenience. Most probably this PIL patch series
was based on previous version of the venus update series from you.
I have posted a new series which is based on the latest venus driver.

>> 
>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
>> ---
<snip>
