Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B945BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1562086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jt4MSR0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F1562086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934537AbeFLSJe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:09:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52076 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934283AbeFLSIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EZmC6MgZPZnws5XA9fObuBumORt6Ugb7WdqStyrevaw=; b=Jt4MSR0sd9alITyAZAQN4+OTJ
        xl9l3pwvPcDT7o3Cw8UYHBYit8iKTWwXINfpKByhtyoiak5TfMJOxPtKRG0Nu7WFWb6JWhl/5BESl
        daYBMSHdXqFvMOTvJ+R8fliyb5v7z0gtA8x3jN4WpWboa9MLsjK7Rw923UJJuoCogDRsSJDfFK+hy
        AbBScdhK2G+gCzZzPMf+n/LCLfFyC5jEiPX8KT9Gta/+f6CD21AlgAFZl7ziapUO675vIkGs7jItV
        e70yZXwTvIJ9TDm464Fvb5n4LpsgAtE7L5dfcUB293Gaffv+5xdpQwzqzY1FzEWAfUZ9+2xypYycz
        9U1MxdQAg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSnim-0001Sg-46; Tue, 12 Jun 2018 18:08:44 +0000
Date:   Tue, 12 Jun 2018 11:08:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>,
        "linux1394-devel@lists.sourceforge.net" 
        <linux1394-devel@lists.sourceforge.net>,
        "jgross@suse.com" <jgross@suse.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "qla2xxx-upstream@qlogic.com" <qla2xxx-upstream@qlogic.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] Convert target drivers to use sbitmap
Message-ID: <20180612180843.GF19433@bombadil.infradead.org>
References: <20180515160043.27044-1-willy@infradead.org>
 <20180515160043.27044-2-willy@infradead.org>
 <da5220a5ed4bed210c31a7517389e787a3b1a01f.camel@wdc.com>
 <20180612161526.GE19433@bombadil.infradead.org>
 <0c93c72a3a339f3479f82de04223315671e07863.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c93c72a3a339f3479f82de04223315671e07863.camel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 04:32:03PM +0000, Bart Van Assche wrote:
> On Tue, 2018-06-12 at 09:15 -0700, Matthew Wilcox wrote:
> > On Tue, Jun 12, 2018 at 03:22:42PM +0000, Bart Van Assche wrote:
> > > Please introduce functions in the target core for allocating and freeing a tag
> > > instead of spreading the knowledge of how to allocate and free tags over all
> > > target drivers.
> > 
> > I can't without doing an unreasonably large amount of work on drivers that
> > I have no way to test.  Some of the drivers have the se_cmd already; some
> > of them don't.  I'd be happy to introduce a common function for freeing
> > a tag.
> 
> Which target drivers are you referring to? If you are referring to the sbp driver:
> I think that driver is dead and can be removed from the kernel tree. I even don't
> know whether that driver ever has had any users other than the developer of that
> driver.

For example tcm_fc:

        tag = sbitmap_queue_get(&se_sess->sess_tag_pool, &cpu);
        if (tag < 0)
                goto busy;

        cmd = &((struct ft_cmd *)se_sess->sess_cmd_map)[tag];

or qla2xxx:

        tag = sbitmap_queue_get(&se_sess->sess_tag_pool, &cpu);
        if (tag < 0)
                return NULL;

        cmd = &((struct qla_tgt_cmd *)se_sess->sess_cmd_map)[tag];

The core doesn't know at what offset from the pointer to store the tag
& cpu.  Only the individual drivers know their cmd layout.

