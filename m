Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0C03DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65DA208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 12:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65DA208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mev.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935395AbeFMMGr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 08:06:47 -0400
Received: from smtp73.ord1d.emailsrvr.com ([184.106.54.73]:52046 "EHLO
        smtp73.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935273AbeFMMGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 08:06:46 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jun 2018 08:06:46 EDT
Received: from smtp18.relay.ord1d.emailsrvr.com (localhost [127.0.0.1])
        by smtp18.relay.ord1d.emailsrvr.com (SMTP Server) with ESMTP id 7E591A0384;
        Wed, 13 Jun 2018 08:01:37 -0400 (EDT)
X-Auth-ID: siepeng@mev.co.uk
Received: by smtp18.relay.ord1d.emailsrvr.com (Authenticated sender: siepeng-AT-mev.co.uk) with ESMTPSA id 88348A0382;
        Wed, 13 Jun 2018 08:01:36 -0400 (EDT)
X-Sender-Id: siepeng@mev.co.uk
Received: from [10.0.0.185] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Wed, 13 Jun 2018 08:01:37 -0400
Subject: Re: [PATCH v4] staging: comedi: Improved readability of function
 comedi_nsamples_left.
To:     Chris Opperman <eklikeroomys@gmail.com>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simo Koskinen <koskisoft@gmail.com>,
        Frank Mori Hess <fmh6jj@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1528837793-11765-1-git-send-email-eklikeroomys@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <202d1efe-fcd4-1155-ad80-f44a2345dc97@mev.co.uk>
Date:   Wed, 13 Jun 2018 13:01:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528837793-11765-1-git-send-email-eklikeroomys@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/18 22:09, Chris Opperman wrote:
> Changes since v3:
> a) Reverted u64 to unsigned long long and u32 to unsigned int.
> b) Added patch versioning.
> c) Changed type of scans_left to unsigned long long to avoid cast.
> d) Clarified and updated changelog.
> 
>> 8-----------------------------------------------------------------------8<
> 
> Improve readability of comedi_nsamples_left:
> a) Reduce nesting by using more return statements.
> b) Declare variables scans_left and samples_left at start of function.
> c) Change type of scans_Left to unsigned long long to avoid cast.
> 
> Signed-off-by: Chris Opperman <eklikeroomys@gmail.com>
> ---
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

The code changes look fine.  You just need to correct the commit 
message, as pointed out by Dan Carpenter.

For reference, everything below the "---" cut-off line gets stripped out 
of the commit message in the git repository, so that is a good place to 
add comments about the patch itself (such as change logs) that do not 
belong in the commit message.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
