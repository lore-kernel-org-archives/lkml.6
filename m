Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7609CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270F9208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 270F9208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mev.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935407AbeFMRoa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:44:30 -0400
Received: from smtp81.ord1d.emailsrvr.com ([184.106.54.81]:50738 "EHLO
        smtp81.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751898AbeFMRo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:44:29 -0400
Received: from smtp11.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp11.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id 96BF16036E;
        Wed, 13 Jun 2018 13:44:28 -0400 (EDT)
X-Auth-ID: siepeng@mev.co.uk
Received: by smtp11.relay.ord1d.emailsrvr.com (Authenticated sender: siepeng-AT-mev.co.uk) with ESMTPSA id A2AB96042A;
        Wed, 13 Jun 2018 13:44:27 -0400 (EDT)
X-Sender-Id: siepeng@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 13 Jun 2018 13:44:28 -0400
Subject: Re: [PATCH v5] staging: comedi: Improved readability of function
 comedi_nsamples_left.
To:     Chris Opperman <eklikeroomys@gmail.com>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simo Koskinen <koskisoft@gmail.com>,
        Frank Mori Hess <fmh6jj@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1528910104-1360-1-git-send-email-eklikeroomys@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <4c33a400-f840-0a21-efad-2a9318dfdb09@mev.co.uk>
Date:   Wed, 13 Jun 2018 18:44:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528910104-1360-1-git-send-email-eklikeroomys@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/18 18:14, Chris Opperman wrote:
> Improve readability of comedi_nsamples_left:
> a) Reduce nesting by using more return statements.
> b) Declare variables scans_left and samples_left at start of function.
> c) Change type of scans_Left to unsigned long long to avoid cast.
> 
> Signed-off-by: Chris Opperman <eklikeroomys@gmail.com>
> ---
> 
> Changes v5:
> a) Moved additional text to below the cut-off line.
> 

The "Changes v5" text is a bit incomplete without the earlier change 
history, but let's forget that since the previous change history was a 
bit messed up anyway.

>   drivers/staging/comedi/drivers.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/comedi/drivers.c b/drivers/staging/comedi/drivers.c
> index 9d73347..57dd63d 100644
> --- a/drivers/staging/comedi/drivers.c
> +++ b/drivers/staging/comedi/drivers.c
> @@ -473,21 +473,21 @@ unsigned int comedi_nsamples_left(struct comedi_subdevice *s,
>   {
>   	struct comedi_async *async = s->async;
>   	struct comedi_cmd *cmd = &async->cmd;
> +	unsigned long long scans_left;
> +	unsigned long long samples_left;
> 
> -	if (cmd->stop_src == TRIG_COUNT) {
> -		unsigned int scans_left = __comedi_nscans_left(s, cmd->stop_arg);
> -		unsigned int scan_pos =
> -		    comedi_bytes_to_samples(s, async->scan_progress);
> -		unsigned long long samples_left = 0;
> -
> -		if (scans_left) {
> -			samples_left = ((unsigned long long)scans_left *
> -					cmd->scan_end_arg) - scan_pos;
> -		}
> +	if (cmd->stop_src != TRIG_COUNT)
> +		return nsamples;
> 
> -		if (samples_left < nsamples)
> -			nsamples = samples_left;
> -	}
> +	scans_left = __comedi_nscans_left(s, cmd->stop_arg);
> +	if (!scans_left)
> +		return 0;
> +
> +	samples_left = scans_left * cmd->scan_end_arg -
> +		comedi_bytes_to_samples(s, async->scan_progress);
> +
> +	if (samples_left < nsamples)
> +		return samples_left;
>   	return nsamples;
>   }
>   EXPORT_SYMBOL_GPL(comedi_nsamples_left);
> --
> 2.1.4
> 

The actual patch looks fine thanks!

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
