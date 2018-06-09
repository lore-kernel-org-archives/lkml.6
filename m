Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jePbJaafG1toWwAAmS7hNA
	; Sat, 09 Jun 2018 09:36:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8B4A56074D; Sat,  9 Jun 2018 09:36:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DCF73605A5;
	Sat,  9 Jun 2018 09:36:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DCF73605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbeFIJgf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 05:36:35 -0400
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:35743 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751344AbeFIJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 05:36:34 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C37F4100E86C4;
        Sat,  9 Jun 2018 09:36:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: oven06_906c2b5d0745d
X-Filterd-Recvd-Size: 3346
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sat,  9 Jun 2018 09:36:32 +0000 (UTC)
Message-ID: <86ccd1d2471b4541c2242d71173734cdbb99f247.camel@perches.com>
Subject: Re: [PATCH] staging: comedi: shortened a long line
From: Joe Perches <joe@perches.com>
To: Chris Opperman <eklikeroomys@gmail.com>
Cc: Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Mori Hess <fmh6jj@gmail.com>,
        Simo Koskinen <koskisoft@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date: Sat, 09 Jun 2018 02:36:31 -0700
In-Reply-To: <1528541720-1853-1-git-send-email-eklikeroomys@gmail.com>
References: <1528541720-1853-1-git-send-email-eklikeroomys@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-06-09 at 12:54 +0200, Chris Opperman wrote:
> Shortened a long line to improve readability in 
> drivers/staging/comedi/drivers.c

Hi Chris.

Look at the whole function and see if you can
find a better way to write it instead of merely
doing what a brainless tool like checkpatch asks.

> diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
[]
> @@ -475,7 +475,8 @@ unsigned int comedi_nsamples_left(struct comedi_subdevice *s,
>  	struct comedi_cmd *cmd = &async->cmd;
>  
>  	if (cmd->stop_src == TRIG_COUNT) {
> -		unsigned int scans_left = __comedi_nscans_left(s, cmd->stop_arg);
> +		unsigned int scans_left =
> +		    __comedi_nscans_left(s, cmd->stop_arg);
>  		unsigned int scan_pos =
>  		    comedi_bytes_to_samples(s, async->scan_progress);
>  		unsigned long long samples_left = 0;

For instance, this is the existing function:

unsigned int comedi_nsamples_left(struct comedi_subdevice *s,
				  unsigned int nsamples)
{
	struct comedi_async *async = s->async;
	struct comedi_cmd *cmd = &async->cmd;

	if (cmd->stop_src == TRIG_COUNT) {
		unsigned int scans_left = __comedi_nscans_left(s, cmd->stop_arg);
		unsigned int scan_pos =
		    comedi_bytes_to_samples(s, async->scan_progress);
		unsigned long long samples_left = 0;

		if (scans_left) {
			samples_left = ((unsigned long long)scans_left *
					cmd->scan_end_arg) - scan_pos;
		}

		if (samples_left < nsamples)
			nsamples = samples_left;
	}
	return nsamples;
}
EXPORT_SYMBOL_GPL(comedi_nsamples_left);

By using multiple returns and removing indentation,
this could become something that doesn't fits
neatly on 80 columns.
It's the same number of vertical lines too.

unsigned int comedi_nsamples_left(struct comedi_subdevice *s,
				  unsigned int nsamples)
{
	struct comedi_async *async = s->async;
	struct comedi_cmd *cmd = &async->cmd;
	unsigned int scans_left;
	u64 samples_left;

	if (cmd->stop_src != TRIG_COUNT)
		return nsamples;

	scans_left = __comedi_nscans_left(s, cmd->stop_arg);
	if (scans_left == 0)
		return 0;

	samples_left = (u64)scans_left * cmd->scan_end_arg -
			comedi_bytes_to_samples(s, s->async->scan_progress);
	if (samples_left < nsamples)
		return samples_left;

	return nsamples;
}
EXPORT_SYMBOL_GPL(comedi_nsamples_left);
