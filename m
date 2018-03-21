Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752278AbeCUOeJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:34:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:55715 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751985AbeCUOeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:34:05 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,340,1517904000";
   d="scan'208";a="210142409"
Date: Wed, 21 Mar 2018 08:36:18 -0600
From: Keith Busch <keith.busch@intel.com>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>
Cc: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@cnexlabs.com>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 08/12] lightnvm: implement get log report chunk helpers
Message-ID: <20180321143617.GD12909@localhost.localdomain>
References: <1520004080-27760-1-git-send-email-javier@cnexlabs.com>
 <1520004080-27760-9-git-send-email-javier@cnexlabs.com>
 <8a0a3bad-26a4-ca2f-4bd8-5c71858f6d00@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a0a3bad-26a4-ca2f-4bd8-5c71858f6d00@lightnvm.io>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 03:06:05AM -0700, Matias Bjørling wrote:
> > outside of nvme core so that we can use it form lightnvm.
> > 
> > Signed-off-by: Javier González <javier@cnexlabs.com>
> > ---
> >   drivers/lightnvm/core.c      | 11 +++++++
> >   drivers/nvme/host/core.c     |  6 ++--
> >   drivers/nvme/host/lightnvm.c | 74 ++++++++++++++++++++++++++++++++++++++++++++
> >   drivers/nvme/host/nvme.h     |  3 ++
> >   include/linux/lightnvm.h     | 24 ++++++++++++++
> >   5 files changed, 115 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 2e9e9f973a75..af642ce6ba69 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -2127,9 +2127,9 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> >   	return ret;
> >   }
> >   
> > -static int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> > -			    u8 log_page, void *log,
> > -			    size_t size, size_t offset)
> > +int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> > +		     u8 log_page, void *log,
> > +		     size_t size, size_t offset)
> >   {
> >   	struct nvme_command c = { };
> >   	unsigned long dwlen = size / 4 - 1;
> > diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> > index 08f0f6b5bc06..ffd64a83c8c3 100644
> > --- a/drivers/nvme/host/lightnvm.c
> > +++ b/drivers/nvme/host/lightnvm.c
> > @@ -35,6 +35,10 @@ enum nvme_nvm_admin_opcode {
> >   	nvme_nvm_admin_set_bb_tbl	= 0xf1,
> >   };
> >   
> 
> <snip>
> 
> >   
> > diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> > index 1ca08f4993ba..505f797f8c6c 100644
> > --- a/drivers/nvme/host/nvme.h
> > +++ b/drivers/nvme/host/nvme.h
> > @@ -396,6 +396,9 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
> >   int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
> >   int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
> >   
> > +int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> > +		     u8 log_page, void *log, size_t size, size_t offset);
> > +
> >   extern const struct attribute_group nvme_ns_id_attr_group;
> >   extern const struct block_device_operations nvme_ns_head_ops;
> >   
> 
> 
> Keith, Christoph, Sagi, Is it okay that these two changes that exposes 
> the nvme_get_log_ext fn are carried through Jens' tree after the nvme 
> tree for 4.17 has been pulled?

That's okay with me. Alteratively, if you want to split the generic nvme
part out, I can apply that immediately and the API will be in the first
nvme-4.17 pull request.
