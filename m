Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08766ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEF82087B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 11:43:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEF82087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeIPRFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 13:05:51 -0400
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:58154 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbeIPRFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 13:05:51 -0400
Received: from ydin.reaktio.net (reaktio.net [85.76.255.15])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 3432DB01AE;
        Sun, 16 Sep 2018 14:43:07 +0300 (EEST)
Received: by ydin.reaktio.net (Postfix, from userid 1001)
        id EF30036C0F6; Sun, 16 Sep 2018 14:43:06 +0300 (EEST)
Date:   Sun, 16 Sep 2018 14:43:06 +0300
From:   Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Jan Beulich <JBeulich@suse.com>,
        Govinda Tatti <Govinda.Tatti@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        xen-devel@lists.xenproject.org, roger.pau@citrix.com,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] [PATCH V3 2/2] Xen/PCIback: Implement PCI
 flr/slot/bus reset with 'reset' SysFS attribute
Message-ID: <20180916114306.GF18222@reaktio.net>
References: <20171207222145.9769-1-Govinda.Tatti@Oracle.COM>
 <20171207222145.9769-3-Govinda.Tatti@Oracle.COM>
 <5A2A6AB10200007800195D4F@prv-mh.provo.novell.com>
 <8a3bc517-1255-4547-d244-5c400e44cc77@Oracle.COM>
 <f19dbb09-ef22-2cf4-fb38-2a7c42b5dc48@Oracle.COM>
 <5A377E020200007800197FFA@prv-mh.provo.novell.com>
 <559ffd12-b541-8a69-60bd-fbe10e3dc159@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <559ffd12-b541-8a69-60bd-fbe10e3dc159@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 18, 2017 at 12:32:11PM -0500, Boris Ostrovsky wrote:
> On 12/18/2017 02:36 AM, Jan Beulich wrote:
> >>>> On 15.12.17 at 20:52, <Govinda.Tatti@Oracle.COM> wrote:
> >>>>> +static int pcistub_device_reset(struct pci_dev *dev)
> >>>>> +{
> >>>>> +	struct xen_pcibk_dev_data *dev_data;
> >>>>> +	bool slot = false, bus = false;
> >>>>> +	struct pcistub_args arg = {};
> >>>>> +
> >>>>> +	if (!dev)
> >>>>> +		return -EINVAL;
> >>>>> +
> >>>>> +	dev_dbg(&dev->dev, "[%s]\n", __func__);
> >>>>> +
> >>>>> +	/* First check and try FLR */
> >>>>> +	if (pcie_has_flr(dev)) {
> >>>>> +		dev_dbg(&dev->dev, "resetting %s device using FLR\n",
> >>>>> +			pci_name(dev));
> >>>>> +		pcie_flr(dev);
> >>>> The lack of error check here puzzled me, but I see the function
> >>>> indeed returns void right now. I think the prereq patch should
> >>>> change this along with exporting the function - you really don't
> >>>> want the device to be handed to a guest when the FLR timed
> >>>> out.
> >>> We will change pcie_flr() to return error code. I will make this change
> >>> in the next version of this patch.
> >> I exchanged some emails with Bjorn/Christoph and it looks like Christoph
> >> as some planto restructure pcie flr specific functions but I don't know
> >> the exact time-frame. For now,I am planning to use existing pcie_flr()
> >> after checking FLR capability. We will switchto revised pcie_flr() once
> >> it is available.
> >>
> >> I hope you are fine with this approach. Please let me know. Thanks.
> > I've seen that other discussion. I don't think the change here
> > should be done prior to the error reporting being put in place,
> > for security reasons. But in the end it'll be Konrad as the
> > maintainer to judge.
> >
> > Or wait, looks like there's some confusion in ./MAINTAINERS:
> > Konrad is listed as maintainer for "XEN PCI SUBSYSTEM", but the
> > list of files doesn't include pciback. So it would instead be Boris
> > or Jürgen to give you a final word.
> 
> 
> This is now 4.16 material so we can at least wait until closer to
> opening of the merge window when we may have the PCI updates. (And I
> just noticed that you responded to Christoph.)
> 
> Besides, we don't want to make kernel changes until the interface is
> settled (i.e the toolstack changes are accepted).
> 

It seems Govinda's email address is giving an error, so I assume someone else needs to pick up this pciback 'reset' feature.
Is it likely someone else from Oracle can/will pick up and refresh this patch, with the review comments addressed?


Meanwhile the pcie_has_flr() has been exported in upstream Linux kernel, so that's already available for use now.

"PCI: Export pcie_has_flr()":
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d2917f7747805a1f4188672f308d82a8ba01700


> -boris
>


Thanks,

-- Pasi

