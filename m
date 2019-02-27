Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF656C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD113213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551259872;
	bh=0IPyUIuuc2n1pwFv7O4IAtJH03UoAoOkPJzMleOid2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zvAJvmZkKLGRBxERgnv0Ixg9UbWkBHB7ptufsB1M+3HUDxvs2ERi7tY8dBPneyjoA
	 Xyx5cvP5OCoUlf0oqt5l1dJiQXHzKLno7cZO+sqskYHVXI9ESMesv10uBxq9hiPP6e
	 cH0MhDmcjSCswMg/Rfn2pWYRIPc0HOZ1jq9Pm0T8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbfB0JbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:31:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfB0JbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:31:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6725213A2;
        Wed, 27 Feb 2019 09:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551259868;
        bh=0IPyUIuuc2n1pwFv7O4IAtJH03UoAoOkPJzMleOid2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aj5xRR1+3YqyRaBvfHkHtDUmPsu12F+eGt/QswEtMYV71qQGFNJSWwc4khqzqgS7K
         jNhMYydlkIl1SWzooAeqvz9fn2vIvuYOy2SGR6qjyCyCstdvWsylN3vVdiUvYTT0dU
         7WSrbUn8cn0RUXPs25ASc4UDeDcoTb0ebm7lF3w8=
Date:   Wed, 27 Feb 2019 10:31:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] device.h: pack struct dev_links_info
Message-ID: <20190227093104.GA5354@kroah.com>
References: <20190226144108.25891-1-gregkh@linuxfoundation.org>
 <20190227092318.GK4747@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227092318.GK4747@localhost>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 10:23:18AM +0100, Johan Hovold wrote:
> On Tue, Feb 26, 2019 at 03:41:07PM +0100, Greg Kroah-Hartman wrote:
> > The dev_links_info structure has 4 bytes of padding at the end of it
> > when embedded in struct device (which is the only place it lives).  To
> > help reduce the size of struct device pack this structure so we can take
> > advantage of the hole with later structure reorganizations.
> > 
> > Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  include/linux/device.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 6cb4640b6160..b63165276a09 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -884,7 +884,7 @@ struct dev_links_info {
> >  	struct list_head suppliers;
> >  	struct list_head consumers;
> >  	enum dl_dev_state status;
> > -};
> > +} __packed;
> 
> This seems like a bad idea. You're changing the alignment of these
> fields to one byte, something which may cause the compiler to generate
> less efficient code to deal with unaligned accesses (even if they happen
> to currently be naturally aligned in struct device).

No, all this changes is the trailing "space" is gone.  The alignment of
the fields did not change at all as they are all naturally aligned
(list_head is just 2 pointers).

Here's the pahole output before and after this patch:

Before:
struct dev_links_info {
        struct list_head           suppliers;            /*     0    16 */
        struct list_head           consumers;            /*    16    16 */
        enum dl_dev_state          status;               /*    32     4 */

        /* size: 40, cachelines: 1, members: 3 */
        /* padding: 4 */
        /* last cacheline: 40 bytes */
};

After:
struct dev_links_info {
        struct list_head           suppliers;            /*     0    16 */
        struct list_head           consumers;            /*    16    16 */
        enum dl_dev_state          status;               /*    32     4 */

        /* size: 36, cachelines: 1, members: 3 */
        /* last cacheline: 36 bytes */
};


So this allows us to save 4 bytes in struct device by putting something in that
trailing "hole" that can be aligned with it better (i.e. an integer or
something else).

thanks,

greg k-h
