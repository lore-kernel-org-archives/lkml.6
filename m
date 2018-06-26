Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F15C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5884D26D70
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 16:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ERl/dQCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5884D26D70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeFZQAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 12:00:02 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34210 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbeFZP76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:59:58 -0400
Received: by mail-pf0-f193.google.com with SMTP id g3-v6so3546390pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 08:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ym87OEdCXc8tOfnuY/5sHeTCav33jxRL0IFo1LuF/ts=;
        b=ERl/dQCkmPjfcP5/xquDK8xQ7FKsqdcA9+yRXAPbeZM2Sp53cmiw8o6L7ZZVxZwRmP
         FuAwPsFqSVOnX8zdKJuY/nhNZZRhD8trGmt+QY5FAHPtv901gq1QBcoGT2dP+Gy1F2tF
         DGTVarmxH84arm7PTkNbfhL2Jgb0YessnjSbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ym87OEdCXc8tOfnuY/5sHeTCav33jxRL0IFo1LuF/ts=;
        b=iyuvmmliY6ntb2tFdxyaaBT6ywudHDRPw1vjp3jJGPr3JobxgMbd0JhINjpMMSG5bp
         ifMjIZSKe6VK2cgUBPSy8vXOBOdZu75DqU0w5NFkpk/Z+Qa8ycrbfnTFDpCdaelY2ot6
         iP5HVZR4EUMk9arnEvZ6bx1HTQg0rB3+fuuVPy+HUzzxzMs1KWtXA64BmqBZVR6XLTFh
         a6mXsYnq4STDF4d3iHf0Lje5RqcxdEw9woD+htwL3vs+Y9+z19JdZFY2BjwQx49oH91E
         e4eHGZAXqgNq+NP9KtrTDD6vgLqXYxUejnPtdVIMUB7ajPeT5nFAZfLUPaUuhZ3LSDOH
         TOvA==
X-Gm-Message-State: APt69E3bz6b+zYO6VcJYfR1KhtOpMFZ4lZYEl7pmTqus1bahZCMtPXWX
        h+yasg2bbBoBQDwIYWf8fBxQrQ==
X-Google-Smtp-Source: ADUXVKI5v5VrgKuEv2Ps+k2EhNozz32J3qGPM85i59V16+SFaf8SPCfmD7Dy+BU4mkx0TGxF6WUzVw==
X-Received: by 2002:a65:4005:: with SMTP id f5-v6mr1844515pgp.302.1530028798262;
        Tue, 26 Jun 2018 08:59:58 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id g75-v6sm2892465pfg.145.2018.06.26.08.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 08:59:56 -0700 (PDT)
Date:   Tue, 26 Jun 2018 09:59:54 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/6] coresight: Introduce support for Coresight
 Address Translation Unit
Message-ID: <20180626155954.GA27118@xps15>
References: <20180625112213.23492-1-suzuki.poulose@arm.com>
 <20180625112213.23492-4-suzuki.poulose@arm.com>
 <1dab29ef47d77c2456ee2500a4636f8793b53354.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dab29ef47d77c2456ee2500a4636f8793b53354.camel@perches.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 09:23:51AM -0700, Joe Perches wrote:
> On Mon, 2018-06-25 at 12:22 +0100, Suzuki K Poulose wrote:
> > Add the initial support for Coresight Address Translation Unit, which
> > augments the TMC in Coresight SoC-600 by providing an improved Scatter
> > Gather mechanism. CATU is always connected to a single TMC-ETR and
> > converts the AXI address with a translated address (from a given SG
> > table with specific format). The CATU should be programmed in pass
> > through mode and enabled even if the ETR doesn't use the translation
> > by CATU.
> []
> > diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
> []
> > +static inline bool coresight_is_catu_device(struct coresight_device *csdev)
> > +{
> > +	enum coresight_dev_subtype_helper subtype;
> > +
> > +	/* Make the checkpatch happy */
> > +	subtype = csdev->subtype.helper_subtype;
> > +
> > +	return IS_ENABLED(CONFIG_CORESIGHT_CATU) &&
> > +	       csdev->type == CORESIGHT_DEV_TYPE_HELPER &&
> > +	       subtype == CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
> > +}
> 
> I believe you should not make checkpatch happy here
> by using a temporary but use the most readable form.
> 
> Probably the most readable form is:
> 
> 	return IS_ENABLED(CONFIG_CORESIGHT_CATU) &&
> 	       csdev->type == CORESIGHT_DEV_TYPE_HELPER &&
> 	       csdev->subtype.helper_subtype == CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
> 
> where restricting line length to 80 columns is not useful
> because the identifiers are very long.  The identifiers
> are possibly longer than necessary.

I would prefer to avoid adding code that will trigger checkpatch warnings.  I
suggest the following:

static inline bool coresight_is_catu_device(struct coresight_device *csdev)
{
        if (!IS_ENABLED(CONFIG_CORESIGHT_CATU))
                return false;

        if (csdev->type != CORESIGHT_DEV_TYPE_HELPER)
                return false;

        if (csdev->subtype.helper_subtype != CORESIGHT_DEV_SUBTYPE_HELPER_CATU)
                return false;

        return true;
}

No temporary variable and all shorther than 80 columns.

Thanks,
Mathieu

> 
