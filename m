Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87B1C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E795217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550506599;
	bh=9JmnPrZ50hdAOW8UXqjf28MDlx26RzMdqnblmO6f7vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=swiZw4WWtuuLZoriOGT6y2jmE5LKN6cP6vGOv0vd2KrYB6ge0OmIFJBM3RCpCTQeY
	 gmVFKGx84PKdbsTmSM1S3+XSqiI6ZUbDNuCUHDZ3NWC4k4hrWUfmUUlBTNJSImRn0G
	 nVWZqLdZxiVgjt+2PUGnDqb0zSY7q1vV8HZBD+eY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbfBRQQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:16:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730659AbfBRQQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:16:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B5C208E4;
        Mon, 18 Feb 2019 16:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550506597;
        bh=9JmnPrZ50hdAOW8UXqjf28MDlx26RzMdqnblmO6f7vY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s900sfsRBcUDVflf/yU/5n4YsRKk1POfUeOKZxj0vbZmbbfmIWaURa2nbzDesoVyY
         DDU+MUaSnyEsIpMP+qM78ITatso8Wkfzhd2IICFRSF3wONuLUBF0/ImWHFMN71Kr3x
         Eq4O4ENif287aRP7l2kxPK6F3bV82BFwu4aIlVeQ=
Date:   Mon, 18 Feb 2019 17:16:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>,
        Wolfgang Walter <linux@stwm.de>, Roman Gushchin <guro@fb.com>,
        Spock <dairinin@gmail.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.20 71/92] Revert "mm: slowly shrink slabs with a
 relatively small number of objects"
Message-ID: <20190218161634.GA30873@kroah.com>
References: <20190218133454.668268457@linuxfoundation.org>
 <20190218133501.533140116@linuxfoundation.org>
 <a998a5028aa3bb17a5a60fffd3db558223b84cd5.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a998a5028aa3bb17a5a60fffd3db558223b84cd5.camel@surriel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 10:30:44AM -0500, Rik van Riel wrote:
> On Mon, 2019-02-18 at 14:43 +0100, Greg Kroah-Hartman wrote:
> > 4.20-stable review patch.  If anyone has any objections, please let
> > me know.
> > 
> > ------------------
> > 
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > commit a9a238e83fbb0df31c3b9b67003f8f9d1d1b6c96 upstream.
> > 
> > This reverts commit 172b06c32b9497 ("mm: slowly shrink slabs with a
> > relatively small number of objects").
> 
> This revert will result in the slab caches of dead
> cgroups with a small number of remaining objects never
> getting reclaimed, which can be a memory leak in some
> configurations.
> 
> But hey, that's your tradeoff to make.

That's what is in Linus's tree.  Should we somehow diverge from that?

thanks,

greg k-h
