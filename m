Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FC9C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86F732083E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 08:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A+8HbMGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F732083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbeHAKKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 06:10:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51004 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387699AbeHAKKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 06:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=neN0si3P3XtX51EGBePl4xBgtIZoVqiGLlomZ2W6+60=; b=A+8HbMGjSuD5v28TbQgkw10cc
        T5MxFWxNj5bELxKq4Iauh51HFXuSpSriM9to6NAhUxQqoLdyo5Eu/fW4k8SdMV1IbixgGbHG88lKB
        s+cZR94qigEzLzcYgCvESbAcy19DT10tDbEaxcIOZAC2Ef5tXSPenHWrf5LdYXuhD8TAr7iQtX9LN
        icL0abPz1wR3ho/xIDQZGpqv2XP1g3sUJVVEF5ORpOeSDXQl/kBclhBNJvBhCJBwd08/JapIS7Cvk
        UwKqlIitzmwAuH7Z8zAoKBpBTEYyQlMy97f+55d3X1BZcVYWx5eNalc41QQztfJMnO7zzhkJXeOXW
        fxJvK5fPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkmRY-00024A-OK; Wed, 01 Aug 2018 08:25:16 +0000
Date:   Wed, 1 Aug 2018 01:25:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Cyrille Pitchen <cyrille.pitchen@free-electrons.com>,
        Juergen Gross <jgross@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vinod Koul <vinod.koul@intel.com>,
        David Kershner <david.kershner@unisys.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 9/9] scsi: Check sense buffer size at build time
Message-ID: <20180801082516.GE26378@infradead.org>
References: <20180731195155.46664-1-keescook@chromium.org>
 <20180731195155.46664-10-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731195155.46664-10-keescook@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 12:51:54PM -0700, Kees Cook wrote:
> To avoid introducing problems like those fixed in commit f7068114d45e
> ("sr: pass down correctly sized SCSI sense buffer"), this creates a macro
> wrapper for scsi_execute() that verifies the size of the sense buffer
> similar to what was done for command string sizes in commit 3756f6401c30
> ("exec: avoid gcc-8 warning for get_task_comm").
> 
> Another solution could be to add a length argument to scsi_execute(),
> but this function already takes a lot of arguments and Jens was not fond
> of that approach.
> 
> Additionally, this moves the SCSI_SENSE_BUFFERSIZE definition into
> scsi_device.h, and removes a redundant include for scsi_device.h from
> scsi_cmnd.h.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
