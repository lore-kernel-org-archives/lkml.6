Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED21AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D932150F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 11:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D932150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbeHVOvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:51:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44820 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbeHVOvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:51:15 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D7694C83;
        Wed, 22 Aug 2018 11:26:43 +0000 (UTC)
Date:   Wed, 22 Aug 2018 13:26:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH v4 1/4] staging: mt7621-mmc: Fix debug macro N_MSG
Message-ID: <20180822112641.GA21716@kroah.com>
References: <cover.1534923403.git.nishadkamdar@gmail.com>
 <2313d873f9a940fcdd4f608ffe3c37ec6a5b6e35.1534923403.git.nishadkamdar@gmail.com>
 <20180822090935.eod5oyodo3xchaxw@mwanda>
 <20180822111052.GA2675@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180822111052.GA2675@nishad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 04:40:56PM +0530, Nishad Kamdar wrote:
> On Wed, Aug 22, 2018 at 12:09:36PM +0300, Dan Carpenter wrote:
> > On Wed, Aug 22, 2018 at 02:04:55PM +0530, Nishad Kamdar wrote:
> > > This patch fixes the debug macro N_MSG. Replaces printk with
> > > dev_<level> without __func__ or __LINE__ or current->comm and
> > > current->pid. Removes the do {} while(0) loop for the single
> > > statement macro. Issue found by checkpatch.
> > > 
> > > Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> > > ---
> > >  drivers/staging/mt7621-mmc/dbg.h | 11 ++++-------
> > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
> > > index 2f2c56b73987..c56fb896617a 100644
> > > --- a/drivers/staging/mt7621-mmc/dbg.h
> > > +++ b/drivers/staging/mt7621-mmc/dbg.h
> > > @@ -104,13 +104,10 @@ do { \
> > >  
> > >  #define N_MSG(evt, fmt, args...)
> > >  /*
> > > -do {    \
> > > -    if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> > > -        printk(KERN_ERR TAG"%d -> "fmt" <- %s() : L<%d> PID<%s><0x%x>\n", \
> > > -            host->id,  ##args , __FUNCTION__, __LINE__, current->comm, current->pid);	\
> > > -    } \
> > > -} while(0)
> > > -*/
> > > + *if ((DBG_EVT_##evt) & sd_debug_zone[host->id]) { \
> > > + *    dev_err(mmc_dev(host->mmc), "%d -> " fmt "\n", host->id, ##args) \
> > > + *}
> > > + */
> > 
> > I don't understand what you're trying to do here.  You just commented
> > out the macro and turned it into a no-op.  That's not what the patch
> > description says.
> > 
> > To me the original code seems fine.
> > 
> > regards,
> > dan carpenter
> >
> 
> Ok. But the macro definition was already commented.
> I just changed printk to dev_err and gave it a better
> block comment format.
> Should I leave the older version as it is ?

No, delete the whole thing if it is not being used, don't "convert" code
that is commented out.

thanks,

greg k-h
