Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758000AbeD0SkV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 14:40:21 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43960 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753079AbeD0SkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 14:40:19 -0400
X-Google-Smtp-Source: AB8JxZpm+eR/5R13fdQvh+n3V2KQNhWm1T6OwaNatxB8LweGkb7x2uZrX2t5zUhHGIRwuSB5CZgdHA==
Date: Fri, 27 Apr 2018 11:40:17 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Lina Iyer <ilina@codeaurora.org>
Cc: andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        rnayak@codeaurora.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org,
        dianders@chromium.org
Subject: Re: [PATCH v6 05/10] drivers: qcom: rpmh-rsc: write sleep/wake
 requests to TCS
Message-ID: <20180427184017.GI243180@google.com>
References: <20180419221635.17849-1-ilina@codeaurora.org>
 <20180419221635.17849-6-ilina@codeaurora.org>
 <20180425214111.GC243180@google.com>
 <20180427173943.GD6380@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180427173943.GD6380@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 11:39:43AM -0600, Lina Iyer wrote:
> On Wed, Apr 25 2018 at 15:41 -0600, Matthias Kaehlcke wrote:
> > On Thu, Apr 19, 2018 at 04:16:30PM -0600, Lina Iyer wrote:
> > > Sleep and wake requests are sent when the application processor
> > > subsystem of the SoC is entering deep sleep states like in suspend.
> > > These requests help lower the system power requirements when the
> > > resources are not in use.
> > > 
> > > Sleep and wake requests are written to the TCS slots but are not
> > > triggered at the time of writing. The TCS are triggered by the firmware
> > > after the last of the CPUs has executed its WFI. Since these requests
> > > may come in different batches of requests, it is the job of this
> > > controller driver to find and arrange the requests into the available
> > > TCSes.
> > > 
> > > Signed-off-by: Lina Iyer <ilina@codeaurora.org>
> > > Reviewed-by: Evan Green <evgreen@chromium.org>
> > > ---
> > >  drivers/soc/qcom/rpmh-internal.h |   8 +++
> > >  drivers/soc/qcom/rpmh-rsc.c      | 120 +++++++++++++++++++++++++++++++
> > >  2 files changed, 128 insertions(+)
> > > 
> > > diff --git a/drivers/soc/qcom/rpmh-internal.h b/drivers/soc/qcom/rpmh-internal.h
> > > index d9a21726e568..6e19fe458c31 100644
> > > --- a/drivers/soc/qcom/rpmh-internal.h
> > > +++ b/drivers/soc/qcom/rpmh-internal.h
> > 
> > <snip>
> > 
> > > +static int find_match(const struct tcs_group *tcs, const struct tcs_cmd *cmd,
> > > +		      int len)
> > > +{
> > > +	int i, j;
> > > +
> > > +	/* Check for already cached commands */
> > > +	for_each_set_bit(i, tcs->slots, MAX_TCS_SLOTS) {
> > > +		for (j = 0; j < len; j++) {
> > > +			if (tcs->cmd_cache[i] != cmd[0].addr) {
> > 
> > Shouldn't the condition be 'tcs->cmd_cache[i + j] != cmd[j].addr'?
> > 
> Here, we are trying to find the first address from the request and its
> position 'i' in the cmd_cache.
> 
> > Otherwise the code below the following if branch will never be
> > executed. Either the 'tcs->cmd_cache[i] != cmd[0].addr' branch isn't
> > entered because the addresses match, or the addresses don't match
> > and the inner loop is aborted after the first iteration.
> > 
> > > +				if (j == 0)
> > > +					break;
> > > +				WARN(tcs->cmd_cache[i + j] != cmd[j].addr,
> > > +				     "Message does not match previous sequence.\n");
> We now check for the sequence using the iterator 'j' only after we have
> found 'i' (the beginning of our request).
> 
> I hope that helps clear the concern.

It doesn't, maybe I'm just confused, the driver has a certain
complexity and I don't claim to have a comprehensive understanding :)

If I understand correctly find_match() is used to find a sequence of
commands of length 'len' in the command cache. If that is correct I
would expect it to do the following:

1. iterate through the commands in the command cache and find a
command that matches the first command in the sequence

2. verify that the (len - 1) subsequent commands match those in the
sequence, otherwise bail out

If I'm not mistaken the current version of find_match() only checks
that the first command exists. After that it happily increases the
command index, but doesn't perform any checks (after finding the first
command 'tcs->cmd_cache[i] != cmd[0].addr' remains false for the
subsequent values of j). When j reaches (len - 1) the function
returns the index of the first command in the cache, regardless of
whether the other commands match or not.

Please correct me if I'm just confused, I think the negative logic of
'tcs->cmd_cache[i] != cmd[0].addr' doesn't help the readability of the
code.
