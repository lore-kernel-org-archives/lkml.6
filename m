Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521C4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143AF20866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mQAioU7b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143AF20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeKKXUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 18:20:55 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:38688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeKKXUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 18:20:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vsR1LbCE/RUd/KRcPIj31tEqsN7XDRQ2dR5N7Py6MxM=; b=mQAioU7bamMuJiFf26O9lY17w
        BjO0+inFXvHsaWZ/RP846QaqLfsywnQ342ignem50nbqliadnMfvkuDZGFchp0HBQEHISo4BgwaJ4
        94mNdb7Y/DDx8LvV+NfevP51g8n9lrUO0Bo8E+Kor+Y5653ryYGWSXxD2iLzSSMtl0zgYttkNGCR5
        W3oH3zf/zRIOQk6pHAVGnrRm+RbbM5R+nMTI/f3/161gXE8PdkrN6qwNWAHXXpKgXtiyN2h9ZfFOZ
        gEwoV/0sYfNQEpEKblUG+Mia/QLqJBF0RLn1D8Mz297J6uPQwW7DJqfXYoTcGRsRUsABSV4bv/gz7
        KzfgfCoxQ==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gLpqY-0007Xq-4O; Sun, 11 Nov 2018 13:32:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, martin.petersen@oracle.com, ooo@electrozaur.com
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Benjamin Block <bblock@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: remove exofs, the T10 OSD code and block/scsi bidi support V3
Date:   Sun, 11 Nov 2018 14:32:03 +0100
Message-Id: <20181111133211.13926-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only real user of the T10 OSD protocol, the pNFS object layout
driver never went to the point of having shipping products, and we
removed it 1.5 years ago.  Exofs is just a simple example without
real life users.

The code has been mostly unmaintained for years and is getting in the
way of block / SCSI changes, so I think it's finally time to drop it.

Quote from Boaz:

"As I said then. It is used in Universities for studies and experiments.
Every once in a while. I get an email with questions and reports.

But yes feel free to remove the all thing!!

I guess I can put it up on github. In a public tree.

Just that I will need to forward port it myself, til now you guys
been doing this for me ;-)"

Now the last time this caused a bit of a stir, but still no actual users,
not even for SG_IO passthrough commands.  So here we go again, this time
including removing everything in the scsi and block layer supporting it,
and thus shrinking struct request.
