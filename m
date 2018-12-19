Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FFDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C36D204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeLSM3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 07:29:37 -0500
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:35708 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727960AbeLSM3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 07:29:37 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 5EA8E181D341A;
        Wed, 19 Dec 2018 12:29:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pan05_5397f3b32c511
X-Filterd-Recvd-Size: 4034
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Dec 2018 12:29:34 +0000 (UTC)
Message-ID: <0fcf870749cae85490aa17cd637e2c933a792c90.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Improve WARNING on Kconfig help
From:   Joe Perches <joe@perches.com>
To:     Andy Whitcroft <apw@canonical.com>
Cc:     Igor Stoppa <igor.stoppa@gmail.com>, igor.stoppa@huawei.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 19 Dec 2018 04:29:33 -0800
In-Reply-To: <20181219115914.GA24359@brain>
References: <20181219083559.30985-1-igor.stoppa@huawei.com>
         <af04860002d4b0f4607bd4ce6d767f5705430ace.camel@perches.com>
         <20181219115914.GA24359@brain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-12-19 at 11:59 +0000, Andy Whitcroft wrote:
> On Wed, Dec 19, 2018 at 02:44:36AM -0800, Joe Perches wrote:
> > On Wed, 2018-12-19 at 10:35 +0200, Igor Stoppa wrote:
> > > The checkpatch.pl script complains when the help section of a Kconfig
> > > entry is too short, but it doesn't really explain what it is looking
> > > for. Instead, it gives a generic warning that one should consider writing
> > > a paragraph.
> > > 
> > > But what it *really* checks is that the help section is at least
> > > .$min_conf_desc_length lines long.
> > > 
> > > Since the definition of what is a paragraph is not really carved in
> > > stone (and actually the primary descriptions is "5 sentences"), make the
> > > warning less ambiguous by expliciting the actual test condition, so that
> > > one doesn't have to read checkpatch.pl sources, to figure out the actual
> > > test.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -2931,7 +2931,8 @@ sub process {
> > >  			}
> > >  			if ($is_start && $is_end && $length < $min_conf_desc_length) {
> > >  				WARN("CONFIG_DESCRIPTION",
> > > -				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
> > > +				     "please write a paragraph (" .$min_conf_desc_length . " lines)" .
> > 
> > could say "(at least $min_conf_desc_length lines)"
> 
> The original is better description in the semantic sense.  We want them
> to describe it well.  We assume they haven't because it is short.  We
> don't want them to make it long, we want them to confirm it is fully
> described.
> 
> You arn't trying to make people make these warnings away, they should
> just be checking they have met the criteria in the warning.  If they
> have they can ignore the warning and be happy, they don't have to add
> two more lines.
> 
> To cover both cases perhaps:
> 
> 	"please ensure that this config symbols is described fully (less than
> 	 $min_conf_desc_length lines is quite brief)"

This is one of those checkpatch bleats I never
really thought was appropriate as some or many
Kconfig symbols are fully descriptive in even
with only a single line.

Also, it seems you are arguing for a checkpatch
--verbose-help output style rather than the
intentionally terse single line output that the
script produces today.

That is something Al Viro once suggested in this thread:
https://lore.kernel.org/patchwork/patch/775901/

On Sat, 2017-04-01 at 05:08 +0100, Al Viro wrote:
> On Fri, Mar 31, 2017 at 08:52:50PM -0700, Joe Perches wrote:
> > checkpatch messages are single line.
> 
> Too bad... Incidentally, being able to get more detailed explanation of
> a warning might be a serious improvement, especially if it contains
> the rationale.  Hell, something like TeX handling of errors might be
> a good idea - warning printed, offered actions include 'give more help',
> 'continue', 'exit', 'from now on suppress this kind of warning', 'from
> now on just dump this kind of warning into log and keep going', 'from
> now on dump all warnings into log and keep going'.



