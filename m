Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_RHS_DOB,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A424C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F402082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18F402082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLFUib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:38:31 -0500
Received: from mail.bootlin.com ([62.4.15.54]:58281 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbeLFUib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:38:31 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AA47620734; Thu,  6 Dec 2018 21:38:28 +0100 (CET)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5AB7920510;
        Thu,  6 Dec 2018 21:38:28 +0100 (CET)
Date:   Thu, 6 Dec 2018 21:38:27 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     yuankuiz@codeaurora.org
Cc:     a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc-owner@vger.kernel.org
Subject: Re: [PATCH] rtc: proc: printf using alarm for alrm
Message-ID: <20181206203827.GE8952@piout.net>
References: <b44225b8e243a70c6ab63a40a3de630d@codeaurora.org>
 <acac27b279864ff8f938f79bcc49b238@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acac27b279864ff8f938f79bcc49b238@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 15:22:51+0800, yuankuiz@codeaurora.org wrote:
> Hi,
> 
>     Kindly, this format change formats the rtc dump from:
>         alrm_time	: 00:00:00
>         alrm_date	: 1970-01-01
>         alarm_IRQ	: no
>         alrm_pending	: no
> 
>     to:
>         alarm time	: 00:00:00
>         alarm date	: 1970-01-01
>         alarm IRQ	: no
>         alarm pending	: no
> 

Yes, and this would break the ABI as this file is in procfs. This is not
something I'm willing to do, especially since this file has been
deprecated since 2006.

>     Thanks,
> BR//John Zhao
> 
> On 2018-12-04 05:29 PM, yuankuiz@codeaurora.org wrote:
> > Hi,
> > 
> > From 549bae59445c5ec67dd6a46f3ea4f58966d40c9b
> > 
> > Current the struct rtc_wkalrm is dumped as
> > "alrm_" by printing converted from the struct
> > name of "alrm.*" directly. Shall we use the
> > "alarm *" to replace the "alrm_*" during this
> > dumping?
> > 
> > Signed-off-by: John Zhao <yuankuiz@codeaurora.org>
> > ---
> >  drivers/rtc/rtc-proc.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/rtc/rtc-proc.c b/drivers/rtc/rtc-proc.c
> > index a9dd921..d4a3c91 100644
> > --- a/drivers/rtc/rtc-proc.c
> > +++ b/drivers/rtc/rtc-proc.c
> > @@ -58,7 +58,7 @@ static int rtc_proc_show(struct seq_file *seq, void
> > *offset)
> > 
> >  	err = rtc_read_alarm(rtc, &alrm);
> >  	if (err == 0) {
> > -		seq_printf(seq, "alrm_time\t: ");
> > +		seq_printf(seq, "alarm time\t: ");
> >  		if ((unsigned int)alrm.time.tm_hour <= 24)
> >  			seq_printf(seq, "%02d:", alrm.time.tm_hour);
> >  		else
> > @@ -72,7 +72,7 @@ static int rtc_proc_show(struct seq_file *seq, void
> > *offset)
> >  		else
> >  			seq_printf(seq, "**\n");
> > 
> > -		seq_printf(seq, "alrm_date\t: ");
> > +		seq_printf(seq, "alarm date\t: ");
> >  		if ((unsigned int)alrm.time.tm_year <= 200)
> >  			seq_printf(seq, "%04d-", alrm.time.tm_year + 1900);
> >  		else
> > @@ -85,9 +85,9 @@ static int rtc_proc_show(struct seq_file *seq, void
> > *offset)
> >  			seq_printf(seq, "%02d\n", alrm.time.tm_mday);
> >  		else
> >  			seq_printf(seq, "**\n");
> > -		seq_printf(seq, "alarm_IRQ\t: %s\n",
> > +		seq_printf(seq, "alarm IRQ\t: %s\n",
> >  				alrm.enabled ? "yes" : "no");
> > -		seq_printf(seq, "alrm_pending\t: %s\n",
> > +		seq_printf(seq, "alarm pending\t: %s\n",
> >  				alrm.pending ? "yes" : "no");
> >  		seq_printf(seq, "update IRQ enabled\t: %s\n",
> >  			(rtc->uie_rtctimer.enabled) ? "yes" : "no");

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
