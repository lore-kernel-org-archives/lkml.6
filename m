Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A86EC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA69223A2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 23:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jaRHfAuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBA69223A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeHJB6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:58:07 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:43327 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbeHJB6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:58:07 -0400
Received: by mail-pf1-f173.google.com with SMTP id j26-v6so3566495pfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 16:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=2tcYp2nOhpAnnXMn3epCXDmtDxSozWvWBFV8l+R4iZU=;
        b=jaRHfAuStiLoSOWTQ+0B2TDa10XBEyCuktfqvHhGpHyiEn54RDj9dIeov/FgKS1I+e
         pMA76JD2HMqa0zVn49suYvtsJP7TT+D9hpRZ+QO34SQ9+a3i7mDvHZGUE2ThPDju4N2+
         KfVhUdxVIrEFbaimS2EcfocBPCJkR6qsAlLGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=2tcYp2nOhpAnnXMn3epCXDmtDxSozWvWBFV8l+R4iZU=;
        b=CfLsjo6HKB4h3rGLx5rCTpXvE70CML/8Ik1LDCijw9k7dwEpgaTP6KcdsKOtJWX5HV
         F6C94ZQ1cq0Jdv0rxBgmjR6xHEJ10X5AXzkgIkgryhgl2Hcy2fpkh3QAqgwFXJMqGHz6
         MevKIovqYvOmbvMvRANi0Z/A/vbINt+eN+ILKixZaf8Qz9Rmoumt1CI/5HC9zWQGBQPD
         uWqp+uMihTzEC99lIeoC8GfQ+EjUgfaNtL/nFuCVKJH//aOR6C1YxrT+t5vRyORS1Pjp
         F0OZ8JKG5kpv2dhWWXyJmjN0784gI5W1pAi2Ir1I68FHLIHMv5ICPTcBvFb9swwE6TSK
         Ppdw==
X-Gm-Message-State: AOUpUlEsKF4u5i6Srxhq5ug25yEwSVSbfMraZLiKAmbaGeGvkZqn7cXZ
        eLawi4sq/Yk4A2Crd7xLEgE6mg==
X-Google-Smtp-Source: AA+uWPxhBXMhrItQ5Qa2FhgzCILuR5E5OVTE8Q1FT0Hxn51KmROabUqVNoxvVkYTHhY2spu4s33+Mg==
X-Received: by 2002:a65:5c4b:: with SMTP id v11-v6mr3987505pgr.445.1533857459283;
        Thu, 09 Aug 2018 16:30:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id e82-v6sm13769957pfk.87.2018.08.09.16.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 16:30:58 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Julius Werner <jwerner@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <CAODwPW_ZiRMqUehq969UxiyrkNOfaevrE-G03M2z_C+6dNAxyQ@mail.gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Wei-Ning Huang <wnhuang@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>, samuel@sholland.org
References: <20180809171722.144325-1-swboyd@chromium.org>
 <20180809171722.144325-4-swboyd@chromium.org>
 <CAODwPW_ZiRMqUehq969UxiyrkNOfaevrE-G03M2z_C+6dNAxyQ@mail.gmail.com>
Message-ID: <153385745791.37448.8166542614146241338@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/7] firmware: coreboot: Make bus registration symmetric
Date:   Thu, 09 Aug 2018 16:30:57 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julius Werner (2018-08-09 11:10:42)
> > @@ -138,8 +136,10 @@ int coreboot_table_init(struct device *dev, void _=
_iomem *ptr)
> >                 ptr_entry +=3D entry.size;
> >         }
> >
> > -       if (ret)
> > +       if (ret) {
> > +               bus_unregister(&coreboot_bus_type);
> >                 iounmap(ptr);
> > +       }
> =

> nit: maybe cleaner to just do if (ret) coreboot_table_exit(); here?
> You're essentially writing the same code again.

Ok.

