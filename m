Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ECBECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F0A20869
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FHAF3WQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F0A20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeJRBxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:53:02 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36515 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbeJRBxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:53:02 -0400
Received: by mail-pg1-f194.google.com with SMTP id f18-v6so12904197pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 10:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GC+PC5EgQpOhcvBR3H+nITIUxiJoTB00jtxIMNkOx3Q=;
        b=FHAF3WQrbjEVzb7tsFeYEaciJpUzSszyRO569UDF/rT9EQ7dzTOcm4E3aPMHwGkrVH
         0VxwyN/xQR5TcRIRAVAdQaXVF71/k6vBx0ZTxKdez0L2abPkxnKb7dvnMozXyiMx49BW
         Mt64PsJeXgZa0MlEXOc8CdWG3ZCO5iK268Mqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GC+PC5EgQpOhcvBR3H+nITIUxiJoTB00jtxIMNkOx3Q=;
        b=NsNkQlL79u3TCStcIWGYbOG2B1Q+ej+mrZTqc8rIKeSQUF/vztYvthTZaSxSTh2E77
         gBm5iBMSCvyMrq9QCb0iKIJKGG8fwg0GfaR/FRFjurDUTeE6tLwf1A0Im96YTqGo84yy
         qb5V/tOZf9nAEzCNYCHFevaV6RnfAOT9r6gOftd+p7YfXFWVWF2DkrOcnOYLcRgL2kIN
         x/8RhtZzCyD2xoLBpQCsbttDoyDZgzrO2gTxTZy4Cb5QfcNEa4Vm0Wp68AnOjmYEWTnh
         z+MxZsuFqODFmhaolu73j4TW76TmeSxe/i0KIvDtDD09zNnGjzfsBknoEv5Co59N3KJ3
         Ciqg==
X-Gm-Message-State: ABuFfohiQga3R+sJJaadNc5iGKAlgW39wHiONQ3zrGSZjy6N1qOyFfJ9
        cmzVJXLSUwtc99losbwIse+rWA==
X-Google-Smtp-Source: ACcGV61qsG86irAquavuT3GGTc8m21d1jniVU31iOgalfdsTac+jr9N3ihExLjStdJ2VXLZHcvxqmw==
X-Received: by 2002:a63:3f07:: with SMTP id m7-v6mr25895803pga.115.1539798974018;
        Wed, 17 Oct 2018 10:56:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id n87-v6sm25096178pfb.62.2018.10.17.10.56.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 10:56:12 -0700 (PDT)
Date:   Wed, 17 Oct 2018 10:56:11 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        "Ivan T. Ivanov" <ivan.ivanov@linaro.org>,
        Geliang Tang <geliangtang@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pramod Gurav <gpramod@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
Message-ID: <20181017175611.GB107185@joelaf.mtv.corp.google.com>
References: <1cae8f10-55f5-20ce-9105-30af6f88bd6e@codeaurora.org>
 <20181016112928.4b52afb5@gandalf.local.home>
 <CAGXu5jLBtBU1eX7tGX1gOVKSFKeLMeoke3bGHUuqxk86dLSnng@mail.gmail.com>
 <20181017101355.GA230639@joelaf.mtv.corp.google.com>
 <2a23cd74-7364-0fb7-3c7b-7be79a881073@codeaurora.org>
 <69d2f43d-dc96-9348-7f70-5db88e8f5c39@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69d2f43d-dc96-9348-7f70-5db88e8f5c39@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 08:19:41PM +0530, Sai Prakash Ranjan wrote:
> On 10/17/2018 5:08 PM, Sai Prakash Ranjan wrote:
> > > 
> > > What do you think about the (untested) patch below? It seems to me
> > > that it
> > > should solve the issue of missing early crash dumps, but I have not
> > > tested it
> > > yet. Sai, would you mind trying it out and let me know if you can see the
> > > early crash dumps properly now?
> > > 
> > > ----8<---
> > > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > > Subject: [RFC] pstore: allocate compression during late_initcall
> > > 
> > > ramoop's pstore registration (using pstore_register) has to run during
> > > late_initcall because crypto backend may not be ready during
> > > postcore_initcall. This causes missing of dmesg crash dumps which could
> > > have been caught by pstore.
> > > 
> > > Instead, lets allow ramoops pstore registration earlier, and once crypto
> > > is ready we can initialize the compression.
> > > 
> > > Reported-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >   fs/pstore/platform.c | 13 +++++++++++++
> > >   fs/pstore/ram.c      |  2 +-
> > >   2 files changed, 14 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> > > index 15e99d5a681d..f09066db2d4d 100644
> > > --- a/fs/pstore/platform.c
> > > +++ b/fs/pstore/platform.c
> > > @@ -780,6 +780,19 @@ void __init pstore_choose_compression(void)
> > >       }
> > >   }
> > > +static int __init pstore_compression_late_init(void)
> > > +{
> > > +    /*
> > > +     * Check if any pstore backends registered earlier but did not
> > > allocate
> > > +     * for compression because crypto was not ready, if so then
> > > initialize
> > > +     * compression.
> > > +     */
> > > +    if (psinfo && !tfm)
> > > +        allocate_buf_for_compression();
> > > +    return 0;
> > > +}
> > > +late_initcall(pstore_compression_late_init);
> > > +
> > >   module_param(compress, charp, 0444);
> > >   MODULE_PARM_DESC(compress, "Pstore compression to use");
> > > diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> > > index bbd1e357c23d..98e48d1a9776 100644
> > > --- a/fs/pstore/ram.c
> > > +++ b/fs/pstore/ram.c
> > > @@ -940,7 +940,7 @@ static int __init ramoops_init(void)
> > >       ramoops_register_dummy();
> > >       return platform_driver_register(&ramoops_driver);
> > >   }
> > > -late_initcall(ramoops_init);
> > > +postcore_initcall(ramoops_init);
> > >   static void __exit ramoops_exit(void)
> > >   {
> > > 
> > 
> > Yes I could see the early crash dump. Also I tested with different
> > compression (LZO) instead of deflate just to be sure and it works fine,
> > thanks :)
> > 
> > Tested-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > 

Thanks.

> I just noticed that allocate_buf_for_compression() is also called from
> pstore_register(). Shouldn't that call be removed now that ramoops_init is
> moved to postcore_initcall and allocate_buf_for_compression() will just
> return doing nothing when called from pstore_register()?

Yes, that is the point. If crypto is not ready then my thought is
allocate_buf_for_compression() called from pstore_register() should do
nothing and pstore will work uncompressed and the kdump infrastructure will
only cause uncompressed writes. But say if the kdump triggered *after* crypto
was ready, then the dump write out would be compressed since pstore is ready
for compression.

The idea is if a future pstore backend calls pstore_register late, then it
may as well do the allocate_buf_for_compression as well at that time when it
runs. In that cause pstore_compression_late_init would do nothing.

So this approach is both dynamic and future proof.

- Joel

