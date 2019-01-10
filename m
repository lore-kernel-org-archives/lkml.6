Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8A9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD79214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="FpR6PtNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfAJPA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:00:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41604 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfAJPA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:00:56 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so10437751edc.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 07:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IsZ5luVbqBio/AhP+gw7d2oCQ0PvNsFIQhvK4QKiM4c=;
        b=FpR6PtNE04gCPL68UxyHY+dK/Lz2h0txcCuVtuZzoAf4A5iIXCc4fK1oWqb1BUnUPk
         nfRmqk6nVPxEkktLheiil+RQNCtAZVB3vLxVgQV6l+U3txFcf3JnyIOs5r4vj2DQqQkr
         Eqq9eGIuS3oBx3arvi0BR1tRBBefeB/rfdX/JcDhMJ8Guvjn7yI+TR7OCuxeZJbfjj8p
         NL5B5+mn10RuaUoGCtVxTJwk2YAftNEqam/y1aG6laARl7A8WHv1k9YSCIXY6QpK/Pl6
         ODAMQfNCW7VTQ4/Nfff/ZP4DgQJzp8M9ecME24XgnIeewrf43+oqoE9giw3lZuKneR3H
         Gyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IsZ5luVbqBio/AhP+gw7d2oCQ0PvNsFIQhvK4QKiM4c=;
        b=l5jJ9jSgj97bferK+RZvVJrAD/32EO4riPA0nzjGPiMexUP5Q9TgPmD4U4Eg22Hx4n
         S2o9ctOdJPTxksUGMjgd229QKeRTxRS3jTwDbfJZacM9owAcdI5uqBULBCygtCiULZE7
         7viNsoI0he3G54OY1HeI9IhWtvODadiBqvi9fcfrema7BxaNGrzxuCuXRIUwdaggjm/c
         JeHT2yFDKlfuy8vgRGO4krhAv86BKJ63zBS57C01xoICwJEyjqnyoqxBkhy/ERsCdRn/
         yPnwLfCGpgHwcoKV+uPKAQ+ixeTYw23A6DW3tXJWF7XnH4XxbmOJt8fdAV6/aw+Q5HVc
         yylw==
X-Gm-Message-State: AJcUukc6Yd4ZTYMiFYphTBM+en8K8BZXZHgujfOiptJ+XRk7oYqo1cyr
        wg0uzeYRFWlu7iroow9YCHK+eg==
X-Google-Smtp-Source: ALg8bN62qRFv+qbI6IrHiXvWpMJIhUUD0jIoFTetZAjSDtshPb+lMUSQbrWFtaKeivWpKz8+371Uzw==
X-Received: by 2002:a17:906:27c6:: with SMTP id k6-v6mr8932563ejc.112.1547132454276;
        Thu, 10 Jan 2019 07:00:54 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:d6c:c571:88:8aee:976c])
        by smtp.gmail.com with ESMTPSA id b14sm1635857edt.6.2019.01.10.07.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 07:00:53 -0800 (PST)
Date:   Thu, 10 Jan 2019 16:00:52 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        mcgrof@kernel.org, joe.lawrence@redhat.com, longman@redhat.com,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org
Subject: Re: [RESEND PATCH v3 2/2] sysctl: handle overflow for file-max
Message-ID: <20190110150051.ah7srm4wcmumlxff@brauner.io>
References: <20190107222700.15954-1-christian@brauner.io>
 <20190107222700.15954-3-christian@brauner.io>
 <20190108070110.GA7998@light.dominikbrodowski.net>
 <20190110145004.zhc2t42aasni7wnq@brauner.io>
 <20190110145559.relfx37ocq5xu4by@isilmar-4.linta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110145559.relfx37ocq5xu4by@isilmar-4.linta.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 03:55:59PM +0100, Dominik Brodowski wrote:
> On Thu, Jan 10, 2019 at 03:50:05PM +0100, Christian Brauner wrote:
> > On Tue, Jan 08, 2019 at 08:01:10AM +0100, Dominik Brodowski wrote:
> > > On Mon, Jan 07, 2019 at 11:27:00PM +0100, Christian Brauner wrote:
> > > > @@ -2833,6 +2836,10 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table, int
> > > >  				break;
> > > >  			if (neg)
> > > >  				continue;
> > > > +			if ((max && val > *max) || (min && val < *min)) {
> > > > +				err = -EINVAL;
> > > > +				break;
> > > > +			}
> > > >  			val = convmul * val / convdiv;
> > > >  			if ((min && val < *min) || (max && val > *max))
> > > >  				continue;
> > > 
> > > This is a generic change which affects all users of
> > > do_proc_doulongvec_minmax() that have extra1 or extra2 set. In sysctl.c, I
> > > do not see another user of proc_doulongvec_minmax() that has extra1 or
> > > extra2 set. However, have you verified whether your patch changes the
> > > behaviour for other files that make use of proc_doulongvec_minmax() or
> > > proc_doulongvec_ms_jiffies_minmax(), and not only of the file-max sysctl?
> > 
> > Sorry for the delayed reply. I did look at the callers. The functions
> > that are of interest afaict are:
> > 
> > proc_doulongvec_ms_jiffies_minmax
> > proc_doulongvec_minmax
> > 
> > So this could be visible when users write values that would overflow the
> > type used in the kernel.
> >
> > I guess your point is whether we are venturing into userspace break
> > territory. Hm... We should probably make sure that we're not regressing
> > anyone else! What do you think if instead of the above patch we did:
> 
> Hm, I prefer the original patch -- as the same (valid) reasons which apply
> for the file-max sysctl might also apply to other users of this function
> where extra1 and/or2 extra2 are set.

In that case we should erorr out on:

val = convmul * val / convdiv;
if ((min && val < *min) || (max && val > *max)) {
        err = -EINVAL;
        break;
}

I fear that erroring out before might break *_jiffies since they are the
only caller that request a convmul/convdiv value that is not 1l.

Christian
