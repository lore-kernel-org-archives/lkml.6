Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6D7C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E7920672
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 06:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E7920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbeLMGMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:12:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:2617 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbeLMGMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 01:12:50 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 22:12:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,347,1539673200"; 
   d="scan'208";a="283206481"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 12 Dec 2018 22:12:49 -0800
Received: from tiger-server (unknown [10.239.48.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id B5640580380;
        Wed, 12 Dec 2018 22:12:47 -0800 (PST)
Date:   Thu, 13 Dec 2018 14:12:40 +0800
From:   Yi Zhang <yi.z.zhang@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, zwisler@kernel.org,
        Jan Kara <jack@suse.cz>, "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [PATCH V2 1/1] device-dax: check for vma range while dax_mmap.
Message-ID: <20181213061239.GA43404@tiger-server>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, zwisler@kernel.org,
        Jan Kara <jack@suse.cz>, "Zhang, Yi Z" <yi.z.zhang@intel.com>
References: <46441800c43f029757c70d8386e3112701081503.1534160958.git.yi.z.zhang@linux.intel.com>
 <1534787638.13739.52.camel@intel.com>
 <89e7bd54-4afa-614d-ec54-49af7928d6c7@intel.com>
 <20180821161657.GA22028@tiger-server>
 <CAPcyv4gZ8WBhUZkoUd1m6bCrtKW0EmfWfCtpGULvjfM=yJ9_sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4gZ8WBhUZkoUd1m6bCrtKW0EmfWfCtpGULvjfM=yJ9_sg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-10 at 16:10:31 -0800, Dan Williams wrote:
> On Tue, Aug 21, 2018 at 12:38 AM Yi Zhang <yi.z.zhang@linux.intel.com> wrote:
> >
> > On 2018-08-20 at 12:50:31 -0700, Dave Jiang wrote:
> > >
> > >
> > > On 08/20/2018 10:53 AM, Verma, Vishal L wrote:
> > > >
> > > > On Mon, 2018-08-13 at 20:02 +0800, Zhang Yi wrote:
> > > >> This patch prevents a user mapping an illegal vma range that is larger
> > > >> than a dax device physical resource.
> > > >>
> > > >> When qemu maps the dax device for virtual nvdimm's backend device, the
> > > >> v-nvdimm label area is defined at the end of mapped range. By using an
> > > >> illegal size that exceeds the range of the device dax, it will trigger a
> > > >> fault with qemu.
> > > >>
> > > >> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > > >> ---
> > > >>  drivers/dax/device.c | 29 +++++++++++++++++++++++++++++
> > > >>  1 file changed, 29 insertions(+)
> > > >>
> > > >
> > > > Looks good to me:
> > > > Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> > >
> > > Applied.
> > Thanks Dava and Vishal's kindly review. Thank you.
> 
> So, it turns out this patch did not get merged for 4.20. I fumbled it
> when returning from vacation. However, I'm not sure it is needed. As
> long as attempts to access the out-of-range capacity results in SIGBUS
> then the implementation is correct. This is similar to the case where
> a file is truncated after the vma is established. That size is
> validated at fault time.
The problem is that we didn't get the fault at we initial the mapping
until attempt to access it, then qemu will failed unexpect without any
output, I think is is better to mention user that we are starting at a 
illegal size, but not faulting at an uncertained time.
> 
> Could you be clearer about why this is a problem? The fault sounds
> like the correct result.
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
