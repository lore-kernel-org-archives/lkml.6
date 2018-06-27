Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAB5C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF43267E2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF43267E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeF0HfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:35:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:39858 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752244AbeF0HfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:35:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C6346ABFC;
        Wed, 27 Jun 2018 07:35:11 +0000 (UTC)
Date:   Wed, 27 Jun 2018 09:35:11 +0200
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Keith Busch <keith.busch@linux.intel.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v4 1/2] nvme: cache struct nvme_ctrl reference to struct
 nvme_request
Message-ID: <20180627073511.og4xsmt2o2pqagit@linux-x5ow.site>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-2-jthumshirn@suse.de>
 <20180626145532.GA6628@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180626145532.GA6628@localhost.localdomain>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 08:55:32AM -0600, Keith Busch wrote:
> On Tue, Jun 26, 2018 at 03:51:40PM +0200, Johannes Thumshirn wrote:
> > @@ -652,6 +653,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
> >  	}
> >  
> >  	cmd->common.command_id = req->tag;
> > +	nvme_req(req)->ctrl = ctrl;
> >  	if (ns)
> >  		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
> >  	else
> 
> I don't think we need to do this per-io. The request coming from the
> controller's tagset, so we can do this just once at .init_request time,
> right?

Agreed, but as it's Sagi's patch I'd like to hear his opinion on this
before changing it.

Byte,
       Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
