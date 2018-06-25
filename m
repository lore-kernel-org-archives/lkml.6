Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650C3C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F1E25BA8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 14:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27F1E25BA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934516AbeFYOpK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 10:45:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:9214 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934378AbeFYOpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 10:45:09 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 07:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,270,1526367600"; 
   d="scan'208";a="67083418"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 25 Jun 2018 07:44:13 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 25 Jun 2018 17:44:12 +0300
Date:   Mon, 25 Jun 2018 17:44:12 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tps6598x: Remove VLA usage
Message-ID: <20180625144412.GB16601@kuha.fi.intel.com>
References: <20180620182840.GA24775@beast>
 <20180621100003.GF2847@kuha.fi.intel.com>
 <CAGXu5jJ8ROmGh0HorCZhbodhxcCBjze-9TwLEX=iO3D4MqtwTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJ8ROmGh0HorCZhbodhxcCBjze-9TwLEX=iO3D4MqtwTQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 01:31:23PM -0700, Kees Cook wrote:
> On Thu, Jun 21, 2018 at 3:00 AM, Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> > On Wed, Jun 20, 2018 at 11:28:40AM -0700, Kees Cook wrote:
> >> In the quest to remove all stack VLA usage from the kernel[1], this
> >> uses the maximum buffer size and adds a sanity check.
> >>
> >> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> ---
> >>  drivers/usb/typec/tps6598x.c | 7 ++++++-
> >>  1 file changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> >> index 4b4c8d271b27..396193f85e6d 100644
> >> --- a/drivers/usb/typec/tps6598x.c
> >> +++ b/drivers/usb/typec/tps6598x.c
> >> @@ -81,12 +81,17 @@ struct tps6598x {
> >>       struct typec_capability typec_cap;
> >>  };
> >>
> >> +#define TPS_MAX_LEN  sizeof(u64)
> >
> > That is not big enough. The registers of this chip can be as big as 64
> > bytes. The identity register alone is 25 bytes, so the above would
> > make the driver fail quite fast. Can you set the maximum to 64?
> >
> > #define TPS_MAX_LEN     64
> 
> Oops! Yes, thanks, I missed this usage:
> 
>         struct tps6598x_rx_identity_reg id;
> ...
>         ret = tps6598x_block_read(tps, TPS_REG_RX_IDENTITY_SOP,
>                                   &id, sizeof(id));
> 
> struct tps6598x_rx_identity_reg {
>         u8                         status;               /*     0     1 */
>         struct usb_pd_identity     identity;             /*     1    12 */
>         u32                        vdo[3];               /*    13    12 */
> 
>         /* size: 25, cachelines: 1, members: 3 */
>         /* last cacheline: 25 bytes */
> };
> 
> But that's still only 25 bytes. Where is the 64? I see these:
> 
>    return tps6598x_block_read(tps, reg, val, sizeof(u16));
>    return tps6598x_block_read(tps, reg, val, sizeof(u32));
>    return tps6598x_block_read(tps, reg, val, sizeof(u64));
>    ret = tps6598x_block_read(tps, TPS_REG_RX_IDENTITY_SOP,
>                              &id, sizeof(id));
>            ret = tps6598x_block_read(tps, TPS_REG_DATA1,
>                                      out_data, out_len);
>            ret = tps6598x_block_read(tps, TPS_REG_DATA1, &val, sizeof(u8));
> 
> 1, 2, 4, 8, 25, and "out_len" in tps6598x_exec_cmd(), which is always zero:
> 
>    ret = tps6598x_exec_cmd(tps, cmd, 0, NULL, 0, NULL);
>    ret = tps6598x_exec_cmd(tps, cmd, 0, NULL, 0, NULL);
> 
> I clearly need a v2 of this patch, but I just want to make sure I get
> the right value. :)

64 is the max No. Data Bytes at least for the Data1 and Data2
registers, and it seems for few other registers as well [1] (ch.
1.3.2). But I don't mind if you still prefer to use 25 as the value.
I'm happy as long as we don't break the driver :-)

[1] http://www.ti.com/lit/ug/slvuan1a/slvuan1a.pdf


Thanks,

-- 
heikki
