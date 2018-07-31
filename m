Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD747C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0CF20894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 20:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tn5h/ltJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0CF20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732812AbeGaVyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:54:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbeGaVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BB+vWAu21T8m2xYsLAfEoti/IEHlk1RJWuMpqprZ5A0=; b=tn5h/ltJDqSfLHWzBA63KSeX+
        51iA/4Aym05F2iZ/xxLYCYf4SgjzwsaerMgUZh74wwE+UYZm4fmFUuBejhoY6Q6i/XkLJb9/rR8fR
        tk1jsvvJv3EO5GzjtGWovv23srLtSiwPZ6D3GDyjCzIb+uqYq6XWc3W6NWAu5TbEA8HjdV3K6foDq
        wjGTpD8iAHdvgoHkMsgvXMuMb5uBKPLtFB7nL66NO8mQwc2CPCkOviVGuRa6wkCnI5W4KgeBf8SEK
        t9L5DjPPXmBeikwLV3YyjYyk70J56mJ86LUrpuWbEOK/L9bwsAUkten6TC5a2e7PLY74rZGFxxsA0
        tgYh1fOFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkb0L-0000aS-DU; Tue, 31 Jul 2018 20:12:25 +0000
Date:   Tue, 31 Jul 2018 13:12:25 -0700
From:   "hch@infradead.org" <hch@infradead.org>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "vinod.koul@intel.com" <vinod.koul@intel.com>,
        "david.kershner@unisys.com" <david.kershner@unisys.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "manoj@linux.vnet.ibm.com" <manoj@linux.vnet.ibm.com>,
        "sdharia@codeaurora.org" <sdharia@codeaurora.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "cyrille.pitchen@free-electrons.com" 
        <cyrille.pitchen@free-electrons.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "pombredanne@nexb.com" <pombredanne@nexb.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mrochs@linux.vnet.ibm.com" <mrochs@linux.vnet.ibm.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "sboyd@codeaurora.org" <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ukrishn@linux.vnet.ibm.com" <ukrishn@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/9] scsi: build scsi_common.o for all scsi
 passthrough request users
Message-ID: <20180731201225.GA1989@infradead.org>
References: <20180731195155.46664-1-keescook@chromium.org>
 <20180731195155.46664-4-keescook@chromium.org>
 <a5b545eade66f95c9a9ecf37676306a8d395187c.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b545eade66f95c9a9ecf37676306a8d395187c.camel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 08:01:16PM +0000, Bart Van Assche wrote:
> On Tue, 2018-07-31 at 12:51 -0700, Kees Cook wrote:
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index 24cd47014657..a6abd7a856c6 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -76,7 +76,7 @@ obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
> >  obj-$(CONFIG_NUBUS)		+= nubus/
> >  obj-y				+= macintosh/
> >  obj-$(CONFIG_IDE)		+= ide/
> > -obj-$(CONFIG_SCSI)		+= scsi/
> > +obj-y				+= scsi/
> >  obj-y				+= nvme/
> >  obj-$(CONFIG_ATA)		+= ata/
> >  obj-$(CONFIG_TARGET_CORE)	+= target/
> 
> The above change not only selects scsi_common.o but also the following object
> files: scsi.o hosts.o scsi_ioctl.o scsicam.o scsi_error.o scsi_lib.o scsi_scan.o
> scsi_sysfs.o scsi_devinfo.o scsi_trace.o scsi_logging.o. That is a change that
> has not been mentioned in the patch description.

It shouldn't.  All these are built into scsi_mod.o, which is only built
when CONFIG_SCSI is set.  Under what circumstances do you see them built?
