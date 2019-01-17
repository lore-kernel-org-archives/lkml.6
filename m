Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC91C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF712054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="Z+YAU/lY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfAQL1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:27:32 -0500
Received: from onstation.org ([52.200.56.107]:55756 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbfAQL1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:27:32 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id DED1617F;
        Thu, 17 Jan 2019 11:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547724451;
        bh=fYkbefJ+qXthGu5ibucFnH4X+A77wMucqnhEdZHrBAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+YAU/lYSKbHMVxho3dOOtEqr9FG8mV1siUGrjYqfsLEW+FsJBgn9VzJvpVZUGyUw
         kqeuHH085rO+JcOj/QnXRtd0rMPpImvxeYCiQxdpf410Du4QgzkYFTMtTwibmn+PUA
         c1nEtODaBhAX0n8lcuwKnmLfwEX5F8qhdfiAJTCU=
Date:   Thu, 17 Jan 2019 06:27:30 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] watchdog: qcom: Add suspend/resume support
Message-ID: <20190117112730.GA25198@basecamp>
References: <20190117091555.2018-1-saiprakash.ranjan@codeaurora.org>
 <20190117093113.GA23389@basecamp>
 <91108b9b-fe05-1068-b07e-872cb4cd4012@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91108b9b-fe05-1068-b07e-872cb4cd4012@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 04:08:52PM +0530, Sai Prakash Ranjan wrote:
> On 1/17/2019 3:01 PM, Brian Masney wrote:
> > 
> > You can use the __maybe_unused attribute to remove the #ifdef:
> > 
> > static int __maybe_unused qcom_wdt_suspend(struct device *dev)
> > 
> 
> Thanks for looking into this.
> 
> As for __maybe_unused, I think it's better to keep #ifdef rather than
> this attribute which seems to be meaning unused when actually its possible
> that it's used often(PM_SLEEP is def y). It's like saying unused when you
> are actually using it. The attribute seems like a
> hack to avoid compilation error. Please correct me if I am wrong.

That attribute suppresses a warning from the compiler if the function is
unused when PM_SLEEP is disabled.  I don't consider it hackish since the
function name no longer appears outside the #ifdef. For example:

	#ifdef CONFIG_PM_SLEEP
	static int qcom_wdt_suspend(struct device *dev)
	{
		...
	}
	#endif /* CONFIG_PM_SLEEP */

	static SIMPLE_DEV_PM_OPS(..., qcom_wdt_suspend, ...);

SIMPLE_DEV_PM_OPS (actually SET_SYSTEM_SLEEP_PM_OP) includes the check
for PM_SLEEP and its a noop if PM_SLEEP is disabled so this works.

Now here's the code with __maybe_unused:

	static int __maybe_unused qcom_wdt_suspend(struct device *dev)
	{
		...
	}

	static SIMPLE_DEV_PM_OPS(..., qcom_wdt_suspend, ...);

This will still be a NOOP when power management is disabled, but have
the benefit of increased compile-time test coverage in that situation.
The symbols won't be included in the final executable. I personally
think the code a is cleaner with __maybe_unused.

This pattern is already in use across various subsystems in the kernel
for suspend and resume functions:

$ git grep __maybe_unused | egrep "_suspend|_resume"  | wc -l
767

Brian
