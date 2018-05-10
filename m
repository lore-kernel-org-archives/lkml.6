Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966029AbeEJAmt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 20:42:49 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:38049 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934395AbeEJAmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 20:42:47 -0400
X-Google-Smtp-Source: AB8JxZqOouR1e08YqNR76WuK0nWCsFM3v4FMuw9gxjDIYhafKQxtarfaomAVsa4hoz83Ld6pbCPpbA==
Date: Wed, 9 May 2018 17:42:44 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Loic Pallardy <loic.pallardy@st.com>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com,
        benjamin.gaignard@linaro.org
Subject: Re: [PATCH v3 09/13] remoteproc: modify rproc_handle_carveout to
 support pre-registered region
Message-ID: <20180510004244.GE29093@builder>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
 <1519921440-21356-10-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519921440-21356-10-git-send-email-loic.pallardy@st.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01 Mar 08:23 PST 2018, Loic Pallardy wrote:

> In current version rproc_handle_carveout function support only dynamic
> region allocation.
> This patch extends rproc_handle_carveout function to support pre-registered
> region. Match is done on region name, then requested device address and
> length are checked.
> If no name match found, original allocation is used.
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 49 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 0ebbc4f..49b28a0 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -679,7 +679,7 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  				 struct fw_rsc_carveout *rsc,
>  				 int offset, int avail)
>  {
> -	struct rproc_mem_entry *carveout, *mapping = NULL;
> +	struct rproc_mem_entry *carveout, *mapping = NULL, *mem;
>  	struct device *dev = &rproc->dev;
>  	dma_addr_t dma;
>  	void *va;
> @@ -699,6 +699,51 @@ static int rproc_handle_carveout(struct rproc *rproc,
>  	dev_dbg(dev, "carveout rsc: name: %s, da 0x%x, pa 0x%x, len 0x%x, flags 0x%x\n",
>  		rsc->name, rsc->da, rsc->pa, rsc->len, rsc->flags);
>  
> +	/* Check carveout rsc already part of a registered carveout */
> +	/* Search by name */
> +	mem = rproc_find_carveout_by_name(rproc, rsc->name);
> +	if (mem) {

I don't fancy the concept of "check if there is another registered
carveout and if so update this carveouts data based on that one and then
skip the bottom half of this function but keep them both on the
carveouts list".

It's unfortunately not very easy to follow and it doesn't allow us to
reuse the carveout-handler for allocations in remoteprocs without a
resource table.

How about splitting the handling of the resource table in two parts; one
that creates or updates a carveout on the carvouts list and a second
part that runs through all carveouts and "allocate" (similar to your
specific release function) them.


The first part of this function would then attempt to find a carveout
entry matching the one we're trying to "handle";

* if one is found we check if it's compatible (as you do here), update a
  rsc_offset (as we do with vrings) and return.

* if no match is found we create a new rproc_mem_entry, fill it out
  based on the fw_rsc_carveout information and stash it at the end of
  the carveouts list.

We do the same in the other resource handlers (just allocate entries
onto the lists).


As that is done the second step is to loop over all carveouts, devmem,
trace and vdev resources and actually "allocate" the resources, by
calling a "alloc" function pointer next to your proposed release one.

For memremap() memory this could be as simple as filling out the
resource table at the associated rsc_offset or simply doing the
memremap().

The default alloc (filled out in step 1, if not already specified) would
be what's today found in rproc_handle_carveout().


This allows carveout resources not specified in the resource table to be
allocated as well. Which comes in handy for the handling of vdev
resources:

In rproc_parse_vdev() we do a similar operation to the parser of a
fw_rsc_carveout and try to find an existing carveout by name and if not
create a new one on the list.

As the actual allocation of carveouts is done before the "allocation" of
vrings there will be an allocated carveout ready when we hit
rproc_alloc_vring() - and we don't care if it came from
dma_alloc_coherent() or a driver defined region.


Does this sound reasonable?

Regards,
Bjorn
