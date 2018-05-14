Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754448AbeENPDF convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 11:03:05 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48538 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752937AbeENPDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 11:03:03 -0400
From: Loic PALLARDY <loic.pallardy@st.com>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
CC: "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH v3 08/13] remoteproc: add prepare and unprepare ops
Thread-Topic: [PATCH v3 08/13] remoteproc: add prepare and unprepare ops
Thread-Index: AQHTsXm9dYPIVY3zHU+69HELf8b3rKQobfSAgAdYTlA=
Date: Mon, 14 May 2018 15:03:00 +0000
Message-ID: <b4d9dfbdc6684e59bec149f80897bd42@SFHDAG7NODE2.st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
 <1519921440-21356-9-git-send-email-loic.pallardy@st.com>
 <20180510005249.GF29093@builder>
In-Reply-To: <20180510005249.GF29093@builder>
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
> Sent: Thursday, May 10, 2018 2:53 AM
> To: Loic PALLARDY <loic.pallardy@st.com>
> Cc: ohad@wizery.com; linux-remoteproc@vger.kernel.org; linux-
> kernel@vger.kernel.org; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> benjamin.gaignard@linaro.org
> Subject: Re: [PATCH v3 08/13] remoteproc: add prepare and unprepare ops
> 
> On Thu 01 Mar 08:23 PST 2018, Loic Pallardy wrote:
> 
> > On some SoC architecture, it is needed to enable HW like
> > clock, bus, regulator, memory region... before loading
> > co-processor firmware.
> >
> > This patch introduces prepare and unprepare ops to execute
> > platform specific function before firmware loading and after
> > stop execution.
> >
> > Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 20 +++++++++++++++++++-
> >  include/linux/remoteproc.h           |  4 ++++
> >  2 files changed, 23 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> > index 7a500cb..0ebbc4f 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1058,12 +1058,22 @@ static int rproc_fw_boot(struct rproc *rproc,
> const struct firmware *fw)
> >  		return ret;
> >  	}
> >
> > +	/* Prepare rproc for firmware loading if needed */
> > +	if (rproc->ops->prepare) {
> > +		ret = rproc->ops->prepare(rproc);
> > +		if (ret) {
> > +			dev_err(dev, "can't prepare rproc %s: %d\n",
> > +				rproc->name, ret);
> > +			goto disable_iommu;
> > +		}
> > +	}
> 
> We do allow drivers to implement custom versions of parse_fw() - and
> they can call the resource-table-parse-fw from the custom function.
> 
> So with the proposed refactoring in patch 9 I would like for parse_fw()
> to call back into the core to fill out the resource lists and then
> before jumping to rproc_start() we loop over the allocator functions.

Agree
Regards,
Loic
> 
> > +
> >  	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
> >
> >  	/* load resource table */
> >  	ret = rproc_load_rsc_table(rproc, fw);
> >  	if (ret)
> > -		goto disable_iommu;
> > +		goto unprepare_rproc;
> >
> >  	/* reset max_notifyid */
> >  	rproc->max_notifyid = -1;
> > @@ -1086,6 +1096,10 @@ static int rproc_fw_boot(struct rproc *rproc,
> const struct firmware *fw)
> >  	kfree(rproc->cached_table);
> >  	rproc->cached_table = NULL;
> >  	rproc->table_ptr = NULL;
> > +unprepare_rproc:
> > +	/* release HW resources if needed */
> > +	if (rproc->ops->unprepare)
> > +		rproc->ops->unprepare(rproc);
> >  disable_iommu:
> >  	rproc_disable_iommu(rproc);
> >  	return ret;
> > @@ -1331,6 +1345,10 @@ void rproc_shutdown(struct rproc *rproc)
> >  	/* clean up all acquired resources */
> >  	rproc_resource_cleanup(rproc);
> >
> > +	/* release HW resources if needed */
> > +	if (rproc->ops->unprepare)
> > +		rproc->ops->unprepare(rproc);
> 
> And this would then be handled by the rproc_resource_cleanup() function,
> looping over all resources and calling release().
> 
> Regards,
> Bjorn
