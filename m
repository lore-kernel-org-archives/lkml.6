Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932212AbeENOkJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:40:09 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23687 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752343AbeENOkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:40:06 -0400
From: Loic PALLARDY <loic.pallardy@st.com>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
CC: "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>
Subject: RE: [PATCH v3 07/13] remoteproc: introduce
 rproc_find_carveout_by_name function
Thread-Topic: [PATCH v3 07/13] remoteproc: introduce
 rproc_find_carveout_by_name function
Thread-Index: AQHTsXm9BXRJDS4JpEaHD/3IhHRU+KQoZIWAgAdaddA=
Date: Mon, 14 May 2018 14:40:03 +0000
Message-ID: <3fd160a950374b71a5e1db03b7c55d66@SFHDAG7NODE2.st.com>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
 <1519921440-21356-8-git-send-email-loic.pallardy@st.com>
 <20180510001903.GD29093@builder>
In-Reply-To: <20180510001903.GD29093@builder>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thanks for the review

> -----Original Message-----
> From: Bjorn Andersson [mailto:bjorn.andersson@linaro.org]
> Sent: Thursday, May 10, 2018 2:19 AM
> To: Loic PALLARDY <loic.pallardy@st.com>
> Cc: ohad@wizery.com; linux-remoteproc@vger.kernel.org; linux-
> kernel@vger.kernel.org; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> benjamin.gaignard@linaro.org
> Subject: Re: [PATCH v3 07/13] remoteproc: introduce
> rproc_find_carveout_by_name function
> 
> On Thu 01 Mar 08:23 PST 2018, Loic Pallardy wrote:
> 
> > This patch provides a new function to find a carveout according
> > to a name.
> > If match found, this function returns a pointer on the corresponding
> > carveout (rproc_mem_entry structure).
> >
> > Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 43
> ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/drivers/remoteproc/remoteproc_core.c
> b/drivers/remoteproc/remoteproc_core.c
> > index 91aa22b..7a500cb 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -216,6 +216,49 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da,
> int len)
> >  }
> >  EXPORT_SYMBOL(rproc_da_to_va);
> >
> > +/**
> > + * rproc_find_carveout_by_name() - lookup the carveout region by a
> name
> > + * @rproc: handle of a remote processor
> > + * @name,..: carveout name to find (standard printf format)
> > + *
> > + * Platform driver has the capability to register some pre-allacoted
> carveout
> > + * (physically contiguous memory regions) before rproc firmware loading
> and
> > + * associated resource table analysis. These regions may be dedicated
> memory
> > + * regions internal to the coprocessor or specified DDR region with specific
> > + * attributes
> > + *
> > + * This function is a helper function with which we can go over the
> > + * allocated carveouts and return associated region characteristics like
> > + * coprocessor address, length or processor virtual address.
> > + *
> > + * The function returns a valid pointer on carveout entry on success
> > + * or NULL on failure.
> 
> The kerneldoc format for describing the return value is
> 
>  * Return: description
Yes I'll update

> 
> > + */
> > +struct rproc_mem_entry *
> > +rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...)
> > +{
> > +	va_list args;
> > +	char _name[32];
> > +	struct rproc_mem_entry *carveout, *mem = NULL;
> > +
> > +	va_start(args, name);
> > +	snprintf(_name, sizeof(_name), name, args);
> > +	va_end(args);
> > +
> > +	if (!name)
> > +		return NULL;
> 
> If you would like for it to actually be valid to pass NULL for name,
> then I think you should move this check to the top of the function.
> 
> But I suspect that you're looking for (name[0] == '\0'), to check if we
> where passed an empty string, e.g. from a resource table without
> resource names.

Good catch, I updated function prototype without changing associated test
 
> 
> > +
> > +	list_for_each_entry(carveout, &rproc->carveouts, node) {
> > +		/* Compare carveout and requested names */
> > +		if (!strcmp(carveout->name, name)) {
> > +			mem = carveout;
> > +			break;
> 
> Just return carveout when you find it.
Sure

> 
> > +		}
> > +	}
> > +
> > +	return mem;
> > +}
> > +
> 
> Regards,
> Bjorn
