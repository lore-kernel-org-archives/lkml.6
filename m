Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932328AbeBGBcl (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:32:41 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55950 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932184AbeBGBck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:32:40 -0500
Date: Wed, 7 Feb 2018 09:24:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: wenxiong <wenxiong@linux.vnet.ibm.com>
Cc: Keith Busch <keith.busch@intel.com>, wenxiong@vmlinux.vnet.ibm.com,
        linux-nvme@lists.infradead.org, axboe@fb.com,
        linux-kernel@vger.kernel.org, wenxiong@us.ibm.com
Subject: Re: [PATCH]nvme-pci: Fixes EEH failure on ppc
Message-ID: <20180207012353.GD13470@ming.t460p>
References: <1517867380-18790-1-git-send-email-wenxiong@vmlinux.vnet.ibm.com>
 <20180206163347.GG31110@localhost.localdomain>
 <787e4960b62a03b3888c67e73d7e1ee2@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787e4960b62a03b3888c67e73d7e1ee2@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 06, 2018 at 02:01:05PM -0600, wenxiong wrote:
> On 2018-02-06 10:33, Keith Busch wrote:
> > On Mon, Feb 05, 2018 at 03:49:40PM -0600, wenxiong@vmlinux.vnet.ibm.com
> > wrote:
> > > @@ -1189,6 +1183,12 @@ static enum blk_eh_timer_return
> > > nvme_timeout(struct request *req, bool reserved)
> > >  	struct nvme_command cmd;
> > >  	u32 csts = readl(dev->bar + NVME_REG_CSTS);
> > > 
> > > +	/* If PCI error recovery process is happening, we cannot reset or
> > > +	 * the recovery mechanism will surely fail.
> > > +	 */
> > > +	if (pci_channel_offline(to_pci_dev(dev->dev)))
> > > +		return BLK_EH_HANDLED;
> > > +
> > 
> > This patch will tell the block layer to complete the request and
> > consider
> > it a success, but it doesn't look like the command actually completed at
> > all. You're going to get data corruption this way, right? Is returning
> > BLK_EH_HANDLED immediately really the right thing to do here?
> 
> Hi Ming,
> 
> Can you help checking if it is ok if returning BLK_EH_HANDLEDED in this
> case?

Hi Wenxiong,

Looks Keith is correct, and this timed out request will be completed by
block layer and NVMe driver if BLK_EH_HANDLED is returned, but this IO
isn't completed actually, so either data loss(write) or read failure is
caused.

Maybe BLK_EH_RESET_TIMER is fine under this situation.

Thanks,
Ming
