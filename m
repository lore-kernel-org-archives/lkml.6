Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0B5C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E3E2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Okw1lxEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E3E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeJSDmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:42:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38778 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbeJSDmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:42:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id f8-v6so14655301pgq.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KmlPXodtEEbQmRptkxxzZvv1Wlj1GyycFew+5+SLaSM=;
        b=Okw1lxEkUFyLrpJqpfLqV9whlEtcZVV82E9BCCMXeIYVD18Qq2yL2UdlI+QBcPUhjy
         zmuBXz0ghlaSD4sme+3q4RL+N4Ya4Mz5Ll0kSDtQiU60qp136S3uR8x/K9FhKTev6P6j
         /6h8oLueosR9oLKHRFxRdHCRire+mjLfv9Meo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KmlPXodtEEbQmRptkxxzZvv1Wlj1GyycFew+5+SLaSM=;
        b=NIAsWt8WoI6rw8lZQd9stC0MyQidEAKekzF9kCRi0mfTFlIwUm5Q7NHFLRf2JsBzXI
         7yoy38iEp/6n5wfkKHjiioj5uNPOPnHyWyoMHqYB0J0qLRYYlTUIksT09Tu/pLz/Ox/e
         do+Cbg5tc/KtnEdlukDDVQLDy+qnpauzL53JsyvLMRo6qQr/51qFlLBdFnyV27KOh/8F
         TLZiii4M+jRd4KwxKjcLiWjFTnGxUiwv1Gmbuc7o/SEdUAmbjmIpgo/IQAq4obfA2Qa9
         ORjoEvF8GeVq1qL4GnDUUBYezg4XuZKQpiUwbMr5fBBUwkkSF//qKg56B75cYVX5YlUc
         tiQg==
X-Gm-Message-State: ABuFfoicO6u39D2vt+hNIQof+rflp0lgWV6S3Yv1dWRRWBQ8Yt53BbDm
        ZyK0TbsbuJt5JJshZB3NW8gNDw==
X-Google-Smtp-Source: ACcGV62psRnjK2PObO+U2YNehxCABi/IlR2a4piP4Bh2kQz+zD7OXe2A7ev+EEFN3+5xnXwtAXb2Cg==
X-Received: by 2002:a63:4f20:: with SMTP id d32-v6mr27908718pgb.231.1539891612053;
        Thu, 18 Oct 2018 12:40:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id t184-v6sm22621900pfd.14.2018.10.18.12.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 12:40:11 -0700 (PDT)
Date:   Thu, 18 Oct 2018 12:40:10 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: vadc: Update example to include
 unit address for node 'usb-id-nopull'
Message-ID: <20181018194010.GV22824@google.com>
References: <20181004001432.21218-1-mka@chromium.org>
 <20181004001432.21218-2-mka@chromium.org>
 <20181005204743.GA17135@bogus>
 <20181012171523.GQ22824@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181012171523.GQ22824@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:15:23AM -0700, Matthias Kaehlcke wrote:
> On Fri, Oct 05, 2018 at 03:47:43PM -0500, Rob Herring wrote:
> > On Wed, Oct 03, 2018 at 05:14:31PM -0700, Matthias Kaehlcke wrote:
> > > The node has a reg property, therefore its name should include a unit
> > > address.
> > > 
> > > Also change the name from 'usb_id_nopull' to 'usb-id-nopull' to follow
> > > DT conventions.
> > 
> > This is ADC channels? If so, then DT convention would really be 
> > "adc@...". 
> 
> Is it really? A grep for 'adc@' in arch/${ARCH}/boot/dts yields
> mostly ADC controller not channel nodes.
> 
> I'm totally fine with changing the name to 'adc@...' if that's the
> preference/convention, just want to reconfirm since the actual use is
> a bit ambiguous.

Could we please reach a conclusion on this?

Summarizing the options on the table so far are:

1. usb-id-nopull@VADC_LR_MUX10_USB_ID
2. usb-id-nopull@57
3. adc@VADC_LR_MUX10_USB_ID
4. adc@57

My personal preference goes to something <node name>@<define>
since the unit address doesn't just resolve to an ADC channel number
but also includes configuation information. A literal like '57'
conveys less information than the define, it's easier to introduce
errors and these errors are harder to spot.

If 'adc@...' really was the convention (or should be) I'd be clearly
in favor of following it. As mentioned above, in practice the use of
the 'adc@...' node name seems to be more prevalent for ADC controllers
than channels, so I'm more inclined towards 'usb-id-nopull@...' or
similar.

All that said, these are just my preferences for the reasons outlined
above, if DT maintainers really want it to be 'adc@57' or some
variation of that, I'm fine with that too. Please let me know and we
can move forward with this trivial series.

Thanks

Matthias
