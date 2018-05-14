Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbeENPn2 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:43:28 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:14925 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752089AbeENPn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:43:26 -0400
From: Loic PALLARDY <loic.pallardy@st.com>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
CC: "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH v3 10/13] remoteproc: modify vring allocation to support
 pre-registered region
Thread-Topic: [PATCH v3 10/13] remoteproc: modify vring allocation to support
 pre-registered region
Thread-Index: AQHTsXm+ipVfNWWG40m907UTzmUTsqQob8QAgAdhtbA=
Date: Mon, 14 May 2018 15:43:23 +0000
Message-ID: <e2ef90c56046442baf33fef10bb347f6@SFHDAG7NODE2.st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
 <1519921440-21356-11-git-send-email-loic.pallardy@st.com>
 <20180510005918.GI29093@builder>
In-Reply-To: <20180510005918.GI29093@builder>
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
> Sent: Thursday, May 10, 2018 2:59 AM
> To: Loic PALLARDY <loic.pallardy@st.com>
> Cc: ohad@wizery.com; linux-remoteproc@vger.kernel.org; linux-
> kernel@vger.kernel.org; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> benjamin.gaignard@linaro.org
> Subject: Re: [PATCH v3 10/13] remoteproc: modify vring allocation to support
> pre-registered region
> 
> On Thu 01 Mar 08:23 PST 2018, Loic Pallardy wrote:
> [..]
> > @@ -265,23 +269,45 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev,
> int i)
> >  	struct device *dev = &rproc->dev;
> >  	struct rproc_vring *rvring = &rvdev->vring[i];
> >  	struct fw_rsc_vdev *rsc;
> > -	dma_addr_t dma;
> > -	void *va;
> >  	int ret, size, notifyid;
> > +	struct fw_rsc_carveout rsc_carveout;
> > +	struct rproc_mem_entry *mem;
> >
> >  	/* actual size of vring (in bytes) */
> >  	size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
> >
> > -	/*
> > -	 * Allocate non-cacheable memory for the vring. In the future
> > -	 * this call will also configure the IOMMU for us
> > -	 */
> > -	va = dma_alloc_coherent(dev->parent, size, &dma, GFP_KERNEL);
> > -	if (!va) {
> > -		dev_err(dev->parent, "dma_alloc_coherent failed\n");
> > +	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
> > +
> > +	/* Create virtual firmware carveout resource */
> > +	rsc_carveout.da = rsc->vring[i].da;
> > +	rsc_carveout.pa = FW_RSC_ADDR_ANY;
> > +	rsc_carveout.len = size;
> > +	rsc_carveout.flags = 0;
> > +	rsc_carveout.reserved = 0;
> > +	snprintf(rsc_carveout.name, sizeof(rsc_carveout.name),
> "vdev%dvring%d",
> > +		 rvdev->index, i);
> [..]
> > @@ -437,6 +460,7 @@ static int rproc_handle_vdev(struct rproc *rproc,
> struct fw_rsc_vdev *rsc,
> >
> >  	rvdev->id = rsc->id;
> >  	rvdev->rproc = rproc;
> > +	rvdev->index = index++;
> 
> This index isn't deterministic over multiple remoteproc instances and
> multiple restarts of the remoteproc. It probably needs to be based
> generated based on the ordering in the resource table.
Yes it was my intention, but static use make it wrong.
I'll revisit this point

Regards,
Loic
> 
> Regards,
> Bjorn
