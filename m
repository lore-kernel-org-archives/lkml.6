Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ED3C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA7320869
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jSiUQMYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA7320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeH1Vmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:42:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40253 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbeH1Vmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:42:31 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so1998514edq.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDHvISARzlXc6IUzVmxPNjn4u0Sjb5mi2PLIFKKEQhg=;
        b=jSiUQMYgJB6pJyT7156Aa2xyZJ3k7eqOsXgA/jAydBhftWlQkSlhAxD6g27RjvnJkC
         eIn5mqr1/zO2nCFSGPrQdIcUV5y2a9f0Um6hghAlIW7i8M2sT1nzr43AhhksmAtWG5Lt
         0hTyEXzbPX5KldogFXw+pfU7/928jbSnvthk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDHvISARzlXc6IUzVmxPNjn4u0Sjb5mi2PLIFKKEQhg=;
        b=VVrz22KRhXUG7hbVpJvdL7csdPNQtkc2eKTvCCttRK4Y4g38qyHLXI0MMbn7zLwQsq
         ZiuinxE1syVgaOUnD3PMaw4+qzW3updXEmWpUG0V3G010K26GN3rAadl/uPdaBdLr8kK
         v2LIOd6XM9HdBlDEJnyi7KJi/k+0Ad6W82xu7Z8Lv4p/Xvwz4yW8o5SKuTmiP0WTI3lA
         zE93V37BnZpc7033y/DjZIMbJ9zfmS3gMTLSB0CHMDiBh7JONbHzUItgPQo5FP+3d9ZT
         oBq4WROT3a/VJFYlvcTWI+K+ku8mgfDDcbhYMg2uAycolQiG93A4mB4lxo6CJFXtlNIM
         Qy/Q==
X-Gm-Message-State: APzg51Bfn/LhMychaBH6ttqz3j9YFVINW0OsbB0JDfbT4tOkHWKVcjKu
        TfkX0fwlsxj3zyK63EnpWLndo0AKn+Ogfg==
X-Google-Smtp-Source: ANB0VdZlUeZaM4YtKBmaUDPYYzJUTESkV3i75fmbg6vGmIXKiwe3zs0afFuz6ou6POq+Ud3pvX/heg==
X-Received: by 2002:a50:f10d:: with SMTP id w13-v6mr3891617edl.0.1535478585484;
        Tue, 28 Aug 2018 10:49:45 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id y7-v6sm816597edd.13.2018.08.28.10.49.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 10:49:44 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id u12-v6so2362292wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:49:44 -0700 (PDT)
X-Received: by 2002:adf:e505:: with SMTP id j5-v6mr1810402wrm.111.1535478583848;
 Tue, 28 Aug 2018 10:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180823183057.247630-1-hcutts@chromium.org> <20180823183057.247630-2-hcutts@chromium.org>
 <20180823185722.GA24777@bombadil.infradead.org> <20180823190124.GB53155@dtor-ws>
 <nycvar.YFH.7.76.1808281101500.25787@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1808281101500.25787@cbobk.fhfr.pm>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Tue, 28 Aug 2018 10:49:32 -0700
X-Gmail-Original-Message-ID: <CA+jURcua9vc_L0AJG5cDuPYY=LH3TcHB+QA_J1+74b97QXXkFw@mail.gmail.com>
Message-ID: <CA+jURcua9vc_L0AJG5cDuPYY=LH3TcHB+QA_J1+74b97QXXkFw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Add the `REL_WHEEL_HI_RES` event code
To:     jikos@kernel.org
Cc:     dmitry.torokhov@gmail.com, willy@infradead.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiri.kosina@suse.cz, benjamin.tissoires@redhat.com,
        linux-doc@vger.kernel.org, corbet@lwn.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin says he prefers micrometres, and I think I do to now that I
think about it (sticking with SI seems like a good idea), so I'll
update it in a V2.

Harry Cutts
Chrome OS Touch/Input team
Harry Cutts
Chrome OS Touch/Input team


On Tue, 28 Aug 2018 at 02:02, Jiri Kosina <jikos@kernel.org> wrote:
>
> On Thu, 23 Aug 2018, Dmitry Torokhov wrote:
>
> > > > +  - If a vertical scroll wheel supports high-resolution scrolling, this code
> > > > +    will be emitted in addition to REL_WHEEL. The value is the (approximate)
> > > > +    distance travelled by the user's finger, in 256ths of a millimeter.
> > >
> > > Is it too late to change this to an actual unit like micrometres?
> >
> > No love for imperial roots? Sure, micrometers would work too I think.
>
> I don't really care strongly :) Is either of you going to update the
> patch? Otherwise I'll just apply as-is.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
