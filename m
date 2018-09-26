Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB731C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5B120843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5B120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeIZQxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:53:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:60940 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbeIZQxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:53:03 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Sep 2018 03:40:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,306,1534834800"; 
   d="scan'208";a="93847289"
Received: from jmoran2-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.26.29])
  by orsmga001.jf.intel.com with ESMTP; 26 Sep 2018 03:40:40 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 2FCF021E3F; Wed, 26 Sep 2018 13:40:39 +0300 (EEST)
Date:   Wed, 26 Sep 2018 13:40:39 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sebastian Reichel <sre@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/17] media: v4l2: async: Allow searching for asd of
 any type
Message-ID: <20180926104038.tc3u7vzojumcthen@kekkonen.localdomain>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
 <1531175957-1973-3-git-send-email-steve_longerbeam@mentor.com>
 <20180924140604.23e2b56f@coco.lan>
 <a8ea673c-a519-81e8-35b1-9d4a224dcbf5@mentor.com>
 <20180925192045.59c83e3d@coco.lan>
 <36fd43b2-695d-b990-bec2-c4d88ccb8e88@mentor.com>
 <20180926063335.3c3b863d@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926063335.3c3b863d@coco.lan>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro, Steve,

On Wed, Sep 26, 2018 at 06:33:35AM -0300, Mauro Carvalho Chehab wrote:
> Em Tue, 25 Sep 2018 18:05:36 -0700
> Steve Longerbeam <steve_longerbeam@mentor.com> escreveu:
> 
> > On 09/25/2018 03:20 PM, Mauro Carvalho Chehab wrote:
> > > Em Tue, 25 Sep 2018 14:04:21 -0700
> > > Steve Longerbeam <steve_longerbeam@mentor.com> escreveu:
> > >  
> > >>>     
> > >>>> @@ -392,12 +406,11 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
> > >>>>    		case V4L2_ASYNC_MATCH_CUSTOM:
> > >>>>    		case V4L2_ASYNC_MATCH_DEVNAME:
> > >>>>    		case V4L2_ASYNC_MATCH_I2C:
> > >>>> -			break;
> > >>>>    		case V4L2_ASYNC_MATCH_FWNODE:
> > >>>> -			if (v4l2_async_notifier_fwnode_has_async_subdev(
> > >>>> -				    notifier, asd->match.fwnode, i)) {
> > >>>> +			if (v4l2_async_notifier_has_async_subdev(
> > >>>> +				    notifier, asd, i)) {
> > >>>>    				dev_err(dev,
> > >>>> -					"fwnode has already been registered or in notifier's subdev list\n");
> > >>>> +					"asd has already been registered or in notifier's subdev list\n");  
> > >>> Please, never use "asd" on messages printed to the user. While someone
> > >>> may understand it while reading the source code, for a poor use,
> > >>> "asd" is just a random sequence of 3 characters.  
> > >> I will change the message to read:
> > >>
> > >> "subdev descriptor already listed in this or other notifiers".  
> > > Perfect!  
> > 
> > But the error message is removed in the subsequent patch
> > "[PATCH 03/17] media: v4l2: async: Add v4l2_async_notifier_add_subdev".
> > 
> > I could bring it back as a dev_dbg() in v4l2_async_notifier_asd_valid(), but
> > this shouldn't be a dev_err() anymore since it is up to the media platform
> > to decide whether an already existing subdev descriptor is an error.
> 
> Hmm... that's an interesting discussion... what cases do you think it
> would be fine to try to register twice an asd notifier?

Only the error message is removed; this case is still considered an error.
I think it'd be better to keep this error message; it helps debugging.

> 
> Haven't write myself any piece of code using async framework, on a first
> glance, trying to register twice sounds like an error to me.
> 
> Sakari, what do you think?

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
