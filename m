Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA8EC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1382086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1382086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxdriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeLLMAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:00:53 -0500
Received: from charlotte.tuxdriver.com ([70.61.120.58]:57571 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeLLMAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:00:52 -0500
Received: from cpe-2606-a000-111b-405a-a193-cb97-58ba-1c15.dyn6.twc.com ([2606:a000:111b:405a:a193:cb97:58ba:1c15] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1gX3C0-0007Rp-Fc; Wed, 12 Dec 2018 07:00:47 -0500
Date:   Wed, 12 Dec 2018 07:00:15 -0500
From:   Neil Horman <nhorman@tuxdriver.com>
To:     David Miller <davem@davemloft.net>
Cc:     lucien.xin@gmail.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
        marcelo.leitner@gmail.com, dave.hansen@linux.intel.com,
        rientjes@google.com, eparis@redhat.com, khorenko@virtuozzo.com
Subject: Re: [PATCHv2 net 0/3] net: add support for flex_array_resize in
 flex_array
Message-ID: <20181212120015.GA7637@hmswarspite.think-freely.org>
References: <cover.1544163962.git.lucien.xin@gmail.com>
 <20181211.225000.726755542677275663.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211.225000.726755542677275663.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 10:50:00PM -0800, David Miller wrote:
> From: Xin Long <lucien.xin@gmail.com>
> Date: Fri,  7 Dec 2018 14:30:32 +0800
> 
> > Without the support for the total_nr_elements's growing or shrinking
> > dynamically, flex_array is not that 'flexible'. Like when users want
> > to change the size, they have to redo flex_array_alloc and copy all
> > the elements from the old to the new one.  The worse thing is every
> > element's memory gets changed.
> > 
> > To implement flex_array_resize based on current code, the difficult
> > thing is to process the size border of FLEX_ARRAY_BASE_BYTES_LEFT,
> > where the base data memory may change to an array for the 2nd level
> > data memory for growing, likewise for shrinking.
> > 
> > To make this part easier, we separate the base data memory and define
> > FLEX_ARRAY_BASE_SIZE as a same value of FLEX_ARRAY_PART_SIZE, as Neil
> > suggested.  When new size is crossing the border, the base memory is
> > allocated as the array for the 2nd level data memory and its part[0]
> > is pointed to the old base memory, and do the opposite for shrinking.
> > 
> > But it doesn't do any memory allocation or shrinking for elements in
> > flex_array_resize, as which should be done by flex_array_prealloc or
> > flex_array_shrink called by users.  No memory leaks can be caused by
> > that.
> > 
> > SCTP has benefited a lot from flex_array_resize() for managing its
> > stream memory so far.
> > 
> > v1->v2:
> >   Cc LKML and more developers.
> 
> So I don't know what to do about this series.
> 
> One of the responses stated that it has been proposed to remove flex_array
> and I don't know what to make of that, nor can I tell if that makes this
> series inappropriate or not.
> 


I suggest xin respond to messageid 20180523011821.12165-6-kent.overstreet@gmail.com>
and send a NAK, indicating that his patch seems like it will break the build,
as, looking through it, it never removes flex_array calls from the sctp code.
If kent reposts with a conversion of the sctp code to radix trees, we're done.
If not, you can move forward with this commit.

Neil

