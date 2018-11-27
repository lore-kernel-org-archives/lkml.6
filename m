Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95472C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C962086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 21:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mu9q7aG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C962086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeK1Io5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:44:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33276 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeK1Io5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 03:44:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so8350089pfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 13:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=wEOjbLOxIkjHyqa3SDWN3iRzvPOUlK/+shxFweLQHs8=;
        b=mu9q7aG5IDEbvCdyfiWwkvJ/PahNcqMqzBTOkQnlKn4dq69lfbxWPzdHvjyeC9BUVI
         4vVmow/Shz+gArI/VNBgSE1GzzB2lr5aSN+HJ0euqm+QV+VGNV5KsAGRiPJocJ/KXgOf
         YaOzxQuKGsAndwjXW/nkNQVWSRPJ2wEYmrcEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=wEOjbLOxIkjHyqa3SDWN3iRzvPOUlK/+shxFweLQHs8=;
        b=Z/fX8JsmwtW+w2bppsuXDdhuQKqGugEArhi6RxUpOCd+sZiTiIev+ESo5xrxXfXMdD
         jq5Sk/ObpHFLUPjL7rkmp1rxrAEl3JUic0cwSXGq0vN5sknLn2ajALNIQph1BfIlPg7z
         Q+0uqp32QC40ft8IGChWSS24uLZ/edg75FwN3G21q2WRWmFdhneE+KA3Tkx3Pgsu7I3V
         Gp2tR0gubWsuqqQd6CmxNnYuurgCTrujQXk+0wnJUKVJintmy4Q++PG+aSTlCi8FtgW/
         8wm5Oewqd2885GtFSW80mO3gH+l3siDQzuKEipBn49RmaSiWpUelTGUq14/GpZD14t48
         MmVg==
X-Gm-Message-State: AA+aEWYlaNWrYuQcOkADrIB50HyCIYJlaeNffmAdUEugqIlGqNqy6Vvz
        FGs3w6k6ZvEz8yEoPqptmEseKefHhd4=
X-Google-Smtp-Source: AFSGD/V/mlZEh5yjvUgv6ExLmof9wLpjgwhOXzlHoaxXTmPd4El+XjrAEz3aJgXAkB9cLgBXDWfmpg==
X-Received: by 2002:a63:1e17:: with SMTP id e23mr30584346pge.130.1543355140699;
        Tue, 27 Nov 2018 13:45:40 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id t5sm6688189pfb.60.2018.11.27.13.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 13:45:39 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Lina Iyer <ilina@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20181127182123.GC28236@codeaurora.org>
Cc:     evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        thierry.reding@gmail.com
References: <20181121000648.29262-1-ilina@codeaurora.org>
 <20181121000648.29262-3-ilina@codeaurora.org>
 <154283618199.88331.10217252750356423959@swboyd.mtv.corp.google.com>
 <20181126161455.GA28236@codeaurora.org>
 <154330994255.88331.11409511159882116164@swboyd.mtv.corp.google.com>
 <20181127182123.GC28236@codeaurora.org>
Message-ID: <154335513853.88331.9713562640538396853@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RFC v3 2/3] dt-bindings: sdm845-pinctrl: add wakeup interrupt parent
 for GPIO
Date:   Tue, 27 Nov 2018 13:45:38 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2018-11-27 10:21:23)
> On Tue, Nov 27 2018 at 02:12 -0700, Stephen Boyd wrote:
> >
> >Two reasons. First, simplicity. The TLMM driver just needs to pass the
> >gpio number up to the PDC gpio domain and then that domain can figure
> >out what hwirq it maps to within the PDC hw irq space. I don't see any
> >reason why we have to know the hwirq of PDC within the TLMM driver
> >besides "let's not be different".
> >
> >And second, it makes it easier for us to implement the MPM case in the
> >TLMM driver by letting the TLMM code just ask "should I mask the irq
> >here or not?" by passing that with a wrapper struct around the fwspec
> >and a dedicated domain in the PDC/MPM driver. Keeping less things in the
> >TLMM driver and not driving the decision from DT but from tables in the
> >PDC driver also keeps things simple and reduces DT parsing code/time.
> >
> Couldn't this be simply achieved by matching the compatible flags for
> PDC/MPM bindings for the wakeup-parent in the TLMM driver? =

> =


It could be, but then we would be making TLMM highly aware of the wakeup
parent and have to do compatible string matching in two places, instead
of making TLMM more abstractly aware that it needs to keep things masked
while irq parent deals with the interrupts.

