Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E919C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC635217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbeLSL7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:59:20 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55197 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbeLSL7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:59:20 -0500
Received: from 1.general.apw.uk.vpn ([10.172.192.78] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <apw@canonical.com>)
        id 1gZaVO-0006fe-JI; Wed, 19 Dec 2018 11:59:15 +0000
Date:   Wed, 19 Dec 2018 11:59:14 +0000
From:   Andy Whitcroft <apw@canonical.com>
To:     Joe Perches <joe@perches.com>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>, igor.stoppa@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch.pl: Improve WARNING on Kconfig help
Message-ID: <20181219115914.GA24359@brain>
References: <20181219083559.30985-1-igor.stoppa@huawei.com>
 <af04860002d4b0f4607bd4ce6d767f5705430ace.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af04860002d4b0f4607bd4ce6d767f5705430ace.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 02:44:36AM -0800, Joe Perches wrote:
> On Wed, 2018-12-19 at 10:35 +0200, Igor Stoppa wrote:
> > The checkpatch.pl script complains when the help section of a Kconfig
> > entry is too short, but it doesn't really explain what it is looking
> > for. Instead, it gives a generic warning that one should consider writing
> > a paragraph.
> > 
> > But what it *really* checks is that the help section is at least
> > .$min_conf_desc_length lines long.
> > 
> > Since the definition of what is a paragraph is not really carved in
> > stone (and actually the primary descriptions is "5 sentences"), make the
> > warning less ambiguous by expliciting the actual test condition, so that
> > one doesn't have to read checkpatch.pl sources, to figure out the actual
> > test.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -2931,7 +2931,8 @@ sub process {
> >  			}
> >  			if ($is_start && $is_end && $length < $min_conf_desc_length) {
> >  				WARN("CONFIG_DESCRIPTION",
> > -				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
> > +				     "please write a paragraph (" .$min_conf_desc_length . " lines)" .
> 
> could say "(at least $min_conf_desc_length lines)"

The original is better description in the semantic sense.  We want them
to describe it well.  We assume they haven't because it is short.  We
don't want them to make it long, we want them to confirm it is fully
described.

You arn't trying to make people make these warnings away, they should
just be checking they have met the criteria in the warning.  If they
have they can ignore the warning and be happy, they don't have to add
two more lines.

To cover both cases perhaps:

	"please ensure that this config symbols is described fully (less than
	 $min_conf_desc_length lines is quite brief)"

-apw
