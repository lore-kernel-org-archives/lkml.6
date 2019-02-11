Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB52C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E75AD21B69
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549904007;
	bh=213rxQAYnDGWBawD/lOaoEHzhESJIIJ6RpLMiiXeL0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eztxxyknsLHlPb4Th3GL/45mRckAb/hbXEB2tJHxmiXvVZauWNz1le4WEmMWVA6WB
	 sGFLJqsDVslVY/KR6LnaXInekWZ1B550sjqj14Ga4jiOTUQNWCGHX5g5CfoNumaUSD
	 ZGVQ3sw4F2OBm083Hl2L9VCvFv2NLa/aa8ixd/DY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfBKQxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:53:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfBKQxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 11:53:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBB39218DE;
        Mon, 11 Feb 2019 16:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549904004;
        bh=213rxQAYnDGWBawD/lOaoEHzhESJIIJ6RpLMiiXeL0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/pYj6b90XgdYmiAscOPUdq57/bngaAyJzoykvEjiXaBeMXOz0fghKOID9qPXM6pu
         GtpW0OwXDtLAK8ShqxQ68MU0YFy/7EUaGaxbcaloE3aflfarHNlc8WE/K4xvlXeJtG
         GsGgv4e2UCcszkAM5Vhsxy5aOE4HcuAcKr5dQlg4=
Date:   Mon, 11 Feb 2019 17:53:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Michael Mueller <mimu@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.20 193/352] KVM: s390: unregister debug feature on
 failing arch init
Message-ID: <20190211165321.GC21634@kroah.com>
References: <20190211141846.543045703@linuxfoundation.org>
 <20190211141859.386277295@linuxfoundation.org>
 <2de995f3-bb44-4f01-e6d9-05b785371a82@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de995f3-bb44-4f01-e6d9-05b785371a82@de.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 03:34:20PM +0100, Christian Borntraeger wrote:
> 
> On 11.02.2019 15:17, Greg Kroah-Hartman wrote:
> > 4.20-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > [ Upstream commit 308c3e6673b012beecb96ef04cc65f4a0e7cdd99 ]
> > 
> > Make sure the debug feature and its allocated resources get
> > released upon unsuccessful architecture initialization.
> > 
> > A related indication of the issue will be reported as kernel
> > message.
> > 
> > Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> > Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> > Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Message-Id: <20181130143215.69496-2-mimu@linux.ibm.com>
> > Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> It does not hurt, but I explicitly did not cc stable for this patch as 
> kvm_register_device_ops only fails in case of a code error.

Fair enough, I've dropped it from all trees now, thanks.

greg k-h
