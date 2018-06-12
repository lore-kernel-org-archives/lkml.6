Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1E3B6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FC92086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MzXU9w+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FC92086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934526AbeFLQPa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:15:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:40818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933439AbeFLQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SCg+YZboiHyYnUqwflD4bmV682boIitd/rXFaQYaF3M=; b=MzXU9w+qw2HMXb5iavRh3Vsb+
        f4vvu7aUvldoDoOfKjirquoUIonCKP8ztC6LT94RhZWwePc0ga7P15vVBlfgy9sbWSKI8slWYUsOq
        4f8+bxhu6Cetk08I30/li7R2+VBYx8KQOt9NBLgglnbAzE5AKb4e/ZNJuIVNBgBDAtmbXw3HcWbZj
        BThlN2o+O64xuKt4gqNNViI9XIKyiy751gJZwD7L3Xit/4AxLeh93Ccf42DUsHreL5qZwt7qr8h31
        MUpjk2Pqk3ovE7Xo1bFpXuqZ0Ne5+MZg3K8HT2juZrZReQtlrag36rcjBnDvEMN2rURl4icYrEMRc
        JnT+azgig==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSlx8-0003O3-Ky; Tue, 12 Jun 2018 16:15:26 +0000
Date:   Tue, 12 Jun 2018 09:15:26 -0700
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
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>
Subject: Re: [PATCH 1/2] Convert target drivers to use sbitmap
Message-ID: <20180612161526.GE19433@bombadil.infradead.org>
References: <20180515160043.27044-1-willy@infradead.org>
 <20180515160043.27044-2-willy@infradead.org>
 <da5220a5ed4bed210c31a7517389e787a3b1a01f.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da5220a5ed4bed210c31a7517389e787a3b1a01f.camel@wdc.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 03:22:42PM +0000, Bart Van Assche wrote:
> On Tue, 2018-05-15 at 09:00 -0700, Matthew Wilcox wrote:
> > diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
> > index 025dc2d3f3de..cdf671c2af61 100644
> > --- a/drivers/scsi/qla2xxx/qla_target.c
> > +++ b/drivers/scsi/qla2xxx/qla_target.c
> > @@ -3719,7 +3719,8 @@ void qlt_free_cmd(struct qla_tgt_cmd *cmd)
> >  		return;
> >  	}
> >  	cmd->jiffies_at_free = get_jiffies_64();
> > -	percpu_ida_free(&sess->se_sess->sess_tag_pool, cmd->se_cmd.map_tag);
> > +	sbitmap_queue_clear(&sess->se_sess->sess_tag_pool, cmd->se_cmd.map_tag,
> > +			cmd->se_cmd.map_cpu);
> >  }
> >  EXPORT_SYMBOL(qlt_free_cmd);
> 
> Please introduce functions in the target core for allocating and freeing a tag
> instead of spreading the knowledge of how to allocate and free tags over all
> target drivers.

I can't without doing an unreasonably large amount of work on drivers that
I have no way to test.  Some of the drivers have the se_cmd already; some
of them don't.  I'd be happy to introduce a common function for freeing
a tag.

> > +int iscsit_wait_for_tag(struct se_session *se_sess, int state, int *cpup)
> > +{
> > +	int tag = -1;
> > +	DEFINE_WAIT(wait);
> > +	struct sbq_wait_state *ws;
> > +
> > +	if (state == TASK_RUNNING)
> > +		return tag;
> > +
> > +	ws = &se_sess->sess_tag_pool.ws[0];
> > +	for (;;) {
> > +		prepare_to_wait_exclusive(&ws->wait, &wait, state);
> > +		if (signal_pending_state(state, current))
> > +			break;
> 
> This looks weird to me. Shouldn't target code ignore signals instead of causing
> tag allocation to fail if a signal is received?

It's what the current code did:

-               if (signal_pending_state(state, current)) {
-                       tag = -ERESTARTSYS;
-                       break;
-               }

and the current callers literally indicate that they want signals:

drivers/infiniband/ulp/isert/ib_isert.c:        cmd = iscsit_allocate_cmd(conn, TASK_INTERRUPTIBLE);
drivers/target/iscsi/iscsi_target.c:    cmd = iscsit_allocate_cmd(conn, TASK_INTERRUPTIBLE);

(etc)
