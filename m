Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C931EFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822DD20881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822DD20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeG3NYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:24:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727478AbeG3NYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:24:50 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 323387C6A9;
        Mon, 30 Jul 2018 11:50:13 +0000 (UTC)
Received: from ming.t460p (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 010A82026D68;
        Mon, 30 Jul 2018 11:50:08 +0000 (UTC)
Date:   Mon, 30 Jul 2018 19:50:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Tomas Janousek <tomi@nomi.cz>, Ming Lei <tom.leiming@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Message-ID: <20180730115002.GA6972@ming.t460p>
References: <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
 <CACVXFVPoO7kcEnUVmqGVWDgiTVYup2sD9puBZ8FzY+mDaMp-bQ@mail.gmail.com>
 <20180729094131.4kwuukzgfgtisgya@notes.lisk.in>
 <20180730075949.GA1755@xps.pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730075949.GA1755@xps.pks.im>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 30 Jul 2018 11:50:13 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Mon, 30 Jul 2018 11:50:13 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'ming.lei@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 09:59:49AM +0200, Patrick Steinhardt wrote:
> On Sun, Jul 29, 2018 at 11:41:31AM +0200, Tomas Janousek wrote:
> > Hi,
> > 
> > On Fri, Jul 13, 2018 at 09:41:41PM +0800, Ming Lei wrote:
> > > Now runtime PM is disabled for blk-mq/scsi_mq, not sure how this issue is
> > > triggered on your machine.
> > 
> > While Patrick did miss the following patch:
> > 
> > * 765e40b675a9 ("block: disable runtime-pm for blk-mq"; July 2017).
> > 
> > there is at least one other way to trigger it -- enable laptop-mode-tools
> > or tlp which enable runtime-pm for all devices.
> > 
> > The "disable runtime-pm for blk-mq" only disables it _by_default_, but doesn't
> > prevent it from being enabled again from user-space, which it is unless one
> > manually blacklists sd devices from runtime-pm enablement. It's bitten a few
> > people already: https://github.com/rickysarraf/laptop-mode-tools/issues/123
> > 
> > (I found this thread because I'm also getting the NULL pointer dereference at
> > 00000000000001a8 on resume from suspend.)
> 
> Huh, I did send out some more details on how I reproduce the
> issue, but it seems like my mail didn't get through. While I
> don't use laptop-mode-tools, I do have some custom hotplugging
> scripts which do in fact enable runtime-PM for most devices.

Now runtime PM is still enabled for sd/sr, and I believe the following
patch is needed until we figure out one perfect way for supporting it
well:

diff --git a/block/blk-core.c b/block/blk-core.c
index 03a4ea93a5f3..090b782df129 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3769,9 +3769,11 @@ EXPORT_SYMBOL(blk_finish_plug);
  */
 void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 {
-	/* not support for RQF_PM and ->rpm_status in blk-mq yet */
-	if (q->mq_ops)
+	/* Don't enable runtime PM for blk-mq until it is ready */
+	if (q->mq_ops) {
+		pm_runtime_disable(dev);
 		return;
+	}
 
 	q->dev = dev;
 	q->rpm_status = RPM_ACTIVE;

Thanks,
Ming
