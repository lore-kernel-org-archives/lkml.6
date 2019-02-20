Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D81C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41E52086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfBTMev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:34:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:44506 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726805AbfBTMev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:34:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A13F6AE65;
        Wed, 20 Feb 2019 12:34:47 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 08709E00A5; Wed, 20 Feb 2019 13:34:46 +0100 (CET)
Date:   Wed, 20 Feb 2019 13:34:46 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>, Jiri Pirko <jiri@resnulli.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next v3 10/21] ethtool: provide string sets with
 GET_STRSET request
Message-ID: <20190220123445.GH23151@unicorn.suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
 <abfb63ea613f295a68a77f8ffba202d198c38fe1.1550513384.git.mkubecek@suse.cz>
 <20190219185610.4c6aa82a@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190219185610.4c6aa82a@cakuba.netronome.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 06:56:10PM -0800, Jakub Kicinski wrote:
> On Mon, 18 Feb 2019 19:22:14 +0100 (CET), Michal Kubecek wrote:
> > Requests a contents of one or more string sets, i.e. indexed arrays of
> > strings; this information is provided by ETHTOOL_GSSET_INFO and
> > ETHTOOL_GSTRINGS commands of ioctl interface. There are three types of
> > requests:
> > 
> >   - no NLM_F_DUMP, no device: get "global" stringsets
> >   - no NLM_F_DUMP, with device: get string sets related to the device
> >   - NLM_F_DUMP, no device: get device related string sets for all devices
> > 
> > It's possible to request all string sets of given type or only specific
> > sets. With ETHA_STRSET_COUNTS flag, only set sizes (number of strings) are
> > returned.
> 
> > +GET_STRSET
> > +----------
> > +
> > +Requests contents of a string set as provided by ioctl commands
> > +ETHTOOL_GSSET_INFO and ETHTOOL_GSTRINGS. String sets are not user writeable so
> > +that the corresponding SET_STRSET message is only used in kernel replies.
> > +There are two types of string sets: global (independent of a device, e.g.
> > +device feature names) and device specific (e.g. device private flags).
> > +
> > +Request contents:
> > +
> > +    ETHA_STRSET_DEV		(nested)	device identification
> > +    ETHA_STRSET_COUNTS		(flag)		request only string counts
> > +    ETHA_STRSET_STRINGSET	(nested)	string set to request
> > +        ETHA_STRINGSET_ID		(u32)		set id
> > +
> > +Kernel response contents:
> > +
> > +    ETHA_STRSET_DEV		(nested)	device identification
> > +    ETHA_STRSET_STRINGSET	(nested)	string set to request
> 
> Is it common to put the device information outside of the main
> attribute nest?

There may be multiple string sets (ETHA_STRSET_STIRNGSET nests) in one
message but they would be either all global or all related to the same
device. If string sets for multiple devices are sent, it would be in
response to a dump request and there would be one message per device.

> 
> > +        ETHA_STRINGSET_ID		(u32)		set id
> > +        ETHA_STRINGSET_COUNT		(u32)		number of strings
> > +        ETHA_STRINGSET_STRINGS		(nested)	array of strings
> > +            ETHA_STRING_INDEX			(u32)		string index
> > +            ETHA_STRING_VALUE			(string)	string value
> > +
> > +ETHA_STRSET_DEV, if present, identifies the device to request device specific
> > +string sets for. Depending on its presence a and NLM_F_DUMP flag, there are
> > +three type of GET_STRSET requests:
> > +
> > + - no NLM_F_DUMP, no device: get "global" stringsets
> > + - no NLM_F_DUMP, with device: get string sets related to the device
> > + - NLM_F_DUMP, no device: get device related string sets for all devices
> > +
> > +If there is no ETHA_STRSET_STRINGSET attribute, all string sets of requested
> > +type are returned, otherwise only those specified in the request. Flag
> > +ETHA_STRSET_COUNTS tells kernel to only return string counts of the sets, not
> > +the actual strings.
> > +
> > +
> 
> > +static int get_strset_id(const struct nlattr *nest, u32 *val,
> > +			 struct genl_info *info)
> > +{
> > +	struct nlattr *tb[ETHA_STRINGSET_MAX + 1];
> > +	int ret;
> > +
> > +	ret = nla_parse_nested(tb, ETHA_STRINGSET_MAX, nest, stringset_policy,
> > +			       info ? info->extack : NULL);
> 
> Would it make sense to use strict parsing everywhere from the start?
> You seem to add REJECTS, but won't attributes > max get ignored?

Good point, I forgot about this when the strict checking helpers were
added. I'll change the uses of nlmsg_parse() and nla_parse_nested() to
their strict variants (and add nla_parse_nested_strict()).

Michal
