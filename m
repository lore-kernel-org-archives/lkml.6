Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB25BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C53208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 07:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gqjsXNZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59C53208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeH0LYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 07:24:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbeH0LYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 07:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OLqmDYeCsfe9ahhCklYcW/5OQj+8jsLXbNsKnhu9DUY=; b=gqjsXNZ4Ez7spmrYqlRnTgFy+
        UDN1nKbEpw5k6CvBQ5bEoDGaD33bnsYDnU3D0DsuQCUlc9Q4+mvgqN3J9YsSM0KjOEFxBkJDYt7E6
        15YlRJ6J5nxFjtSoBGdRaSpHEfrtpzquZmGRf349ZC0HdsE71PWilsLk0NeHKtfUgVQ709D5M4VTT
        8i68W0Kk0B3DUri3Tc0UrFy7w6Ghd6lJR5SNQLqv/c38BtDFw28YqjYEcuFSR8FcCuD8n/uaX298h
        lKCbzGxEY9ooS5BW4iyRkEPH5jU2zGZ7ldRA2nzQSzHX2KQNlgZKJ4lC2MWMWn9VIgs5/tUMH7oX+
        1PlqfoEaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuC78-0006kx-BE; Mon, 27 Aug 2018 07:39:06 +0000
Date:   Mon, 27 Aug 2018 00:39:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Waiman Long <longman@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] xfs: Prevent multiple wakeups of the same log
 space waiter
Message-ID: <20180827073906.GA24831@infradead.org>
References: <1535316795-21560-1-git-send-email-longman@redhat.com>
 <1535316795-21560-3-git-send-email-longman@redhat.com>
 <20180827002134.GE2234@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827002134.GE2234@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:21:34AM +1000, Dave Chinner wrote:
> tl; dr: Once you pass a certain point, ramdisks can be *much* slower
> than SSDs on journal intensive workloads like AIM7. Hence it would be
> useful to see if you have the same problems on, say, high
> performance nvme SSDs.

Note that all these ramdisk issues you mentioned below will also apply
to using the pmem driver on nvdimms, which might be a more realistic
version.  Even worse at least for cases where the nvdimms aren't
actually powerfail dram of some sort with write through caching and
ADR the latency is going to be much higher than the ramdisk as well.
