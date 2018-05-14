Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753925AbeENOwh convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:52:37 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:15579 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752349AbeENOwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:52:35 -0400
From: Loic PALLARDY <loic.pallardy@st.com>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
CC: "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH v3 09/13] remoteproc: modify rproc_handle_carveout to
 support pre-registered region
Thread-Topic: [PATCH v3 09/13] remoteproc: modify rproc_handle_carveout to
 support pre-registered region
Thread-Index: AQHTsXm+pn7t5hJUkUCVCvRavBQVeqQoayMAgAdVZGA=
Date: Mon, 14 May 2018 14:52:32 +0000
Message-ID: <35c35efde19e464285402786cba732ff@SFHDAG7NODE2.st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
 <1519921440-21356-10-git-send-email-loic.pallardy@st.com>
 <20180510004244.GE29093@builder>
In-Reply-To: <20180510004244.GE29093@builder>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Bjorn Andersson [mailto:bjorn.andersson@linaro.org]
> Sent: Thursday, May 10, 2018 2:43 AM
> To: Loic PALLARDY <loic.pallardy@st.com>
> Cc: ohad@wizery.com; linux-remoteproc@vger.kernel.org; linux-
> kernel@vger.kernel.org; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> benjamin.gaignard@linaro.org
> Subject: Re: [PATCH v3 09/13] remoteproc: modify rproc_handle_carveout to
> support pre-registered region
> 
> On Thu 01 Mar 08:23 PST 2018, Loic Pallardy wrote:
> 
> > In current version rproc_handle_carveout function support only dynamic
> > region allocation.
> > This patch extends rproc_handle_carveout function to support pre-
> registered
> > region. Match is done on region name, then requested device address and
> > length are checked.
> > If no name match found, original allocation is used.
> >
> > Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 49
> +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 48 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> > index 0ebbc4f..49b28a0 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -679,7 +679,7 @@ static int rproc_handle_carveout(struct rproc
> *rproc,
> >  				 struct fw_rsc_carveout *rsc,
> >  				 int offset, int avail)
> >  {
> > -	struct rproc_mem_entry *carveout, *mapping = NULL;
> > +	struct rproc_mem_entry *carveout, *mapping = NULL, *mem;
> >  	struct device *dev = &rproc->dev;
> >  	dma_addr_t dma;
> >  	void *va;
> > @@ -699,6 +699,51 @@ static int rproc_handle_carveout(struct rproc
> *rproc,
> >  	dev_dbg(dev, "carveout rsc: name: %s, da 0x%x, pa 0x%x, len 0x%x,
> flags 0x%x\n",
> >  		rsc->name, rsc->da, rsc->pa, rsc->len, rsc->flags);
> >
> > +	/* Check carveout rsc already part of a registered carveout */
> > +	/* Search by name */
> > +	mem = rproc_find_carveout_by_name(rproc, rsc->name);
> > +	if (mem) {
> 
> I don't fancy the concept of "check if there is another registered
> carveout and if so update this carveouts data based on that one and then
> skip the bottom half of this function but keep them both on the
> carveouts list".
> 
> It's unfortunately not very easy to follow and it doesn't allow us to
> reuse the carveout-handler for allocations in remoteprocs without a
> resource table.
> 
> How about splitting the handling of the resource table in two parts; one
> that creates or updates a carveout on the carvouts list and a second
> part that runs through all carveouts and "allocate" (similar to your
> specific release function) them.
> 
> 
> The first part of this function would then attempt to find a carveout
> entry matching the one we're trying to "handle";
> 
> * if one is found we check if it's compatible (as you do here), update a
>   rsc_offset (as we do with vrings) and return.
> 
> * if no match is found we create a new rproc_mem_entry, fill it out
>   based on the fw_rsc_carveout information and stash it at the end of
>   the carveouts list.
> 
> We do the same in the other resource handlers (just allocate entries
> onto the lists).
> 
> 
> As that is done the second step is to loop over all carveouts, devmem,
> trace and vdev resources and actually "allocate" the resources, by
> calling a "alloc" function pointer next to your proposed release one.
> 
> For memremap() memory this could be as simple as filling out the
> resource table at the associated rsc_offset or simply doing the
> memremap().
> 
> The default alloc (filled out in step 1, if not already specified) would
> be what's today found in rproc_handle_carveout().
> 
> 
> This allows carveout resources not specified in the resource table to be
> allocated as well. Which comes in handy for the handling of vdev
> resources:
> 
> In rproc_parse_vdev() we do a similar operation to the parser of a
> fw_rsc_carveout and try to find an existing carveout by name and if not
> create a new one on the list.
> 
> As the actual allocation of carveouts is done before the "allocation" of
> vrings there will be an allocated carveout ready when we hit
> rproc_alloc_vring() - and we don't care if it came from
> dma_alloc_coherent() or a driver defined region.
> 
> 
> Does this sound reasonable?
Yes, better to separate resource table parsing and memory carveout allocation.
I'll update series in that way

Regards,
Loic


> 
> Regards,
> Bjorn
