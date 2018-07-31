Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3A2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A878320844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PQe/8+Ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A878320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbeGaT4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 15:56:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38954 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbeGaT4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 15:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YpI10Uogb87ABkln8vuCI7eyH7v3bXpzrZFA0sm1uKs=; b=PQe/8+Ri9DwrbsAwBSEfzg7ny
        7vBaLjttjdEptr3aOpsi7fVpNH+TFNHYq547fcmB5RqMP28/DUr/rDUhPK7Ck6T5M4y8EQWVL4WNB
        PMwSUOy/AzYjddbjKwUvBV6UvWnhczgnTfat8dQvQNj4SW7CvT0dfWSEviK1HyRoUR9Q6BJ55qutv
        Cu2Poxn4fu1qxs3+0ChQhIDYcJuEEeRf7NvvNemqCv2K7QaZQjp4HCZ+/yG9dz3jwxluMGMZZWbw+
        kIVRrKIrQhD5CI5WhW6m13VG2ix9+4Av5AhbOLHBX2BlBwXJVjCG025GXs17JsP5uaBPWHrtclL5J
        dlubSZoRg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkZAs-0007T9-Os; Tue, 31 Jul 2018 18:15:10 +0000
Date:   Tue, 31 Jul 2018 11:15:10 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Mike Christie <mchristi@redhat.com>, linux-kernel@vger.kernel.org,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Varun Prakash <varun@chelsio.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH 18/26] target/iscsi: Allocate session IDs from an IDA
Message-ID: <20180731181510.GA16794@bombadil.infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
 <20180621212835.5636-19-willy@infradead.org>
 <5B59FB56.9090901@redhat.com>
 <5B5A014D.9060901@redhat.com>
 <20180727193814.GB3825@bombadil.infradead.org>
 <5B5B892D.1000305@redhat.com>
 <yq1wotcw49i.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1wotcw49i.fsf@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:03:21PM -0400, Martin K. Petersen wrote:
> 
> Mike,
> 
> >> How about I take it through my tree to minimise the amount of rebasing
> >> I'll need to do?  I'm already dependent on the nvdimm tree and I'd rather
> >> not depend on the scsi tree as well.  I'll queue it up in front of my
> >> IDA change to maximise its backportability.
> >
> > Ccing Martin, because he has been handling target patches.
> 
> That's fine with me.
> 
> Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

Thanks, Martin.  Mike, can I have your Signed-off-by: on the original patch?
What Fixes: line should this have?  As far as I can tell, the bug is present
all the way back to its introduction, so:

Fixes: e48354ce078c ("iscsi-target: Add iSCSI fabric support for target v4.1")

yes?
