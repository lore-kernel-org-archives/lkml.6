Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD3DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B152626E59
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B152626E59
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933051AbeFZRTr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:19:47 -0400
Received: from smtprelay0160.hostedemail.com ([216.40.44.160]:50690 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752493AbeFZRTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:19:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6EF49181D3419;
        Tue, 26 Jun 2018 17:19:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sheep32_54cb1b6054103
X-Filterd-Recvd-Size: 3736
Received: from XPS-9350.home (unknown [47.151.150.235])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 26 Jun 2018 17:19:42 +0000 (UTC)
Message-ID: <cdc280594f84fda5a880bf3ce3b0931d50809e58.camel@perches.com>
Subject: Re: [PATCH v2 3/6] coresight: Introduce support for Coresight
 Address Translation Unit
From:   Joe Perches <joe@perches.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org
Date:   Tue, 26 Jun 2018 10:19:41 -0700
In-Reply-To: <20180626155954.GA27118@xps15>
References: <20180625112213.23492-1-suzuki.poulose@arm.com>
         <20180625112213.23492-4-suzuki.poulose@arm.com>
         <1dab29ef47d77c2456ee2500a4636f8793b53354.camel@perches.com>
         <20180626155954.GA27118@xps15>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 09:59 -0600, Mathieu Poirier wrote:
> On Mon, Jun 25, 2018 at 09:23:51AM -0700, Joe Perches wrote:
> > On Mon, 2018-06-25 at 12:22 +0100, Suzuki K Poulose wrote:
> > > Add the initial support for Coresight Address Translation Unit, which
> > > augments the TMC in Coresight SoC-600 by providing an improved Scatter
> > > Gather mechanism. CATU is always connected to a single TMC-ETR and
> > > converts the AXI address with a translated address (from a given SG
> > > table with specific format). The CATU should be programmed in pass
> > > through mode and enabled even if the ETR doesn't use the translation
> > > by CATU.
> > 
> > []
> > > diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
> > 
> > []
> > > +static inline bool coresight_is_catu_device(struct coresight_device *csdev)
> > > +{
> > > +	enum coresight_dev_subtype_helper subtype;
> > > +
> > > +	/* Make the checkpatch happy */
> > > +	subtype = csdev->subtype.helper_subtype;
> > > +
> > > +	return IS_ENABLED(CONFIG_CORESIGHT_CATU) &&
> > > +	       csdev->type == CORESIGHT_DEV_TYPE_HELPER &&
> > > +	       subtype == CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
> > > +}
> > 
> > I believe you should not make checkpatch happy here
> > by using a temporary but use the most readable form.
> > 
> > Probably the most readable form is:
> > 
> > 	return IS_ENABLED(CONFIG_CORESIGHT_CATU) &&
> > 	       csdev->type == CORESIGHT_DEV_TYPE_HELPER &&
> > 	       csdev->subtype.helper_subtype == CORESIGHT_DEV_SUBTYPE_HELPER_CATU;
> > 
> > where restricting line length to 80 columns is not useful
> > because the identifiers are very long.  The identifiers
> > are possibly longer than necessary.
> 
> I would prefer to avoid adding code that will trigger checkpatch warnings.  I
> suggest the following:
> 
> static inline bool coresight_is_catu_device(struct coresight_device *csdev)
> {
>         if (!IS_ENABLED(CONFIG_CORESIGHT_CATU))
>                 return false;
> 
>         if (csdev->type != CORESIGHT_DEV_TYPE_HELPER)
>                 return false;
> 
>         if (csdev->subtype.helper_subtype != CORESIGHT_DEV_SUBTYPE_HELPER_CATU)
>                 return false;
> 
>         return true;
> }
> 
> No temporary variable and all shorther than 80 columns.

Perhaps the most readable uses the positive
form instead of the negative, but your choice.
The compiler should emit equivalent or identical
code anyway.

Do remember that checkpatch is brainless and
everyone should always use theirs over fixing
any message that checkpatch emits.

cheers, Joe

