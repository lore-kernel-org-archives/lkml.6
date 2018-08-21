Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35030C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE44D214EE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 07:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE44D214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbeHUK5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 06:57:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:55769 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbeHUK5U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 06:57:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2018 00:38:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,268,1531810800"; 
   d="scan'208";a="83550667"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2018 00:38:05 -0700
Received: from tiger-server (unknown [10.239.48.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 063A05802C8;
        Tue, 21 Aug 2018 00:38:04 -0700 (PDT)
Date:   Wed, 22 Aug 2018 00:16:57 +0800
From:   Yi Zhang <yi.z.zhang@linux.intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>, "Zhang, Yi Z" <yi.z.zhang@intel.com>
Subject: Re: [PATCH V2 1/1] device-dax: check for vma range while dax_mmap.
Message-ID: <20180821161657.GA22028@tiger-server>
Mail-Followup-To: Dave Jiang <dave.jiang@intel.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>, "Zhang, Yi Z" <yi.z.zhang@intel.com>
References: <46441800c43f029757c70d8386e3112701081503.1534160958.git.yi.z.zhang@linux.intel.com>
 <1534787638.13739.52.camel@intel.com>
 <89e7bd54-4afa-614d-ec54-49af7928d6c7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89e7bd54-4afa-614d-ec54-49af7928d6c7@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-20 at 12:50:31 -0700, Dave Jiang wrote:
> 
> 
> On 08/20/2018 10:53 AM, Verma, Vishal L wrote:
> > 
> > On Mon, 2018-08-13 at 20:02 +0800, Zhang Yi wrote:
> >> This patch prevents a user mapping an illegal vma range that is larger
> >> than a dax device physical resource.
> >>
> >> When qemu maps the dax device for virtual nvdimm's backend device, the
> >> v-nvdimm label area is defined at the end of mapped range. By using an
> >> illegal size that exceeds the range of the device dax, it will trigger a
> >> fault with qemu.
> >>
> >> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> >> ---
> >>  drivers/dax/device.c | 29 +++++++++++++++++++++++++++++
> >>  1 file changed, 29 insertions(+)
> >>
> > 
> > Looks good to me:
> > Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> 
> Applied.
Thanks Dava and Vishal's kindly review. Thank you.
> 
> > 
> >> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> >> index 108c37f..6fe8c30 100644
> >> --- a/drivers/dax/device.c
> >> +++ b/drivers/dax/device.c
> >> @@ -177,6 +177,33 @@ static const struct attribute_group *dax_attribute_groups[] = {
> >>  	NULL,
> >>  };
> >>  
> >> +static int check_vma_range(struct dev_dax *dev_dax, struct vm_area_struct *vma,
> >> +		const char *func)
> >> +{
> >> +	struct device *dev = &dev_dax->dev;
> >> +	struct resource *res;
> >> +	unsigned long size;
> >> +	int ret, i;
> >> +
> >> +	if (!dax_alive(dev_dax->dax_dev))
> >> +		return -ENXIO;
> >> +
> >> +	size = vma->vm_end - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT);
> >> +	ret = -EINVAL;
> >> +	for (i = 0; i < dev_dax->num_resources; i++) {
> >> +		res = &dev_dax->res[i];
> >> +		if (size > resource_size(res)) {
> >> +			dev_info_ratelimited(dev,
> >> +				"%s: %s: fail, vma range overflow\n",
> >> +				current->comm, func);
> >> +			ret = -EINVAL;
> >> +			continue;
> >> +		} else
> >> +			return 0;
> >> +	}
> >> +	return ret;
> >> +}
> >> +
> >>  static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
> >>  		const char *func)
> >>  {
> >> @@ -469,6 +496,8 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
> >>  	 */
> >>  	id = dax_read_lock();
> >>  	rc = check_vma(dev_dax, vma, __func__);
> >> +	if (!rc)
> >> +		rc = check_vma_range(dev_dax, vma, __func__);
> >>  	dax_read_unlock(id);
> >>  	if (rc)
> >>  		return rc;
