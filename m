Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77FFC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1B1208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 06:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1B1208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbeHQKBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:01:25 -0400
Received: from verein.lst.de ([213.95.11.211]:34111 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeHQKBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:01:24 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5032568EEE; Fri, 17 Aug 2018 09:00:13 +0200 (CEST)
Date:   Fri, 17 Aug 2018 09:00:13 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@lst.de" <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.com" <hare@suse.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
        groups
Message-ID: <20180817070013.GD11170@lst.de>
References: <20180814073305.87255-1-hare@suse.de> <20180814073305.87255-3-hare@suse.de> <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com> <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de> <f9ad4ed4685e51a7b0378f11d3ce9d0a76235095.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ad4ed4685e51a7b0378f11d3ce9d0a76235095.camel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 03:44:57PM +0000, Bart Van Assche wrote:
> On Tue, 2018-08-14 at 17:39 +0200, Hannes Reinecke wrote:
> > While I have considered having nvme_nvm_register_sysfs() returning a
> > pointer I would then have to remove the 'static' declaration from the
> > nvm_dev_attr_group_12/20.
> > Which I didn't really like, either.
> 
> Hmm ... I don't see why the static declaration would have to be removed from
> nvm_dev_attr_group_12/20 if nvme_nvm_register_sysfs() would return a pointer?
> Am I perhaps missing something?

No, I think that would be the preferable approach IFF patching the global
table of groups would be viable.  I don't think it is, though - we can
have both normal NVMe and LightNVM devices in the same system, so we
can't just patch it over.

So we'll need three different attribut group arrays:

const struct attribute_group *nvme_ns_id_attr_groups[] = {
	&nvme_ns_id_attr_group,
	NULL,
};

const struct attribute_group *lightnvm12_ns_id_attr_groups[] = {
	&nvme_ns_id_attr_group,
	&nvm_dev_attr_group_12,
	NULL,
};

const struct attribute_group *lightnvm20_ns_id_attr_groups[] = {
	&nvme_ns_id_attr_group,
	&nvm_dev_attr_group_20,
	NULL,
};

and a function to select which one to use.
