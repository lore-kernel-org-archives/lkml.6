Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeFDLLt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:11:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:12115 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752628AbeFDLLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:11:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="234446126"
From: "Dziegielewski, Marcin" <marcin.dziegielewski@intel.com>
To: Javier Gonzalez <javier@cnexlabs.com>
CC: Matias Bjorling <mb@lightnvm.io>, Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
Subject: RE: [GIT PULL 18/20] lightnvm: pblk: handle case when mw_cunits
 equals to 0
Thread-Topic: [GIT PULL 18/20] lightnvm: pblk: handle case when mw_cunits
 equals to 0
Thread-Index: AQHT9mJJ9Oeppdx29kSrRWdMkH84gaRE6UWAgArugQCAAAZRAIAAExfA
Date: Mon, 4 Jun 2018 11:11:45 +0000
Message-ID: <9FC4315EA6BEAA449828D92CF173A10D3E3833ED@IRSMSX109.ger.corp.intel.com>
References: <20180528085841.26684-1-mb@lightnvm.io>
 <20180528085841.26684-19-mb@lightnvm.io>
 <54B2CCDB-B869-4087-8AE2-2AC73381B1FF@cnexlabs.com>
 <9FC4315EA6BEAA449828D92CF173A10D3E382351@IRSMSX109.ger.corp.intel.com>
 <3B216FC2-D5EB-4A36-8946-27307DA3D1B1@cnexlabs.com>
In-Reply-To: <3B216FC2-D5EB-4A36-8946-27307DA3D1B1@cnexlabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTczYjhkNWMtMjY1Yy00NTNkLWEzMDctODM0ZjFiNmYyZmEyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZ2hpWTI1amVqekthVmU4Mnh1a0UyKzFqNVgrYlJQRnNCWnFnajdQNGNlVjJkVzI2alNXUHFuNWpBXC9oTm52N08ifQ==
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w54BBskL007873


> -----Original Message-----
> From: Javier Gonzalez [mailto:javier@cnexlabs.com]
> Sent: Monday, June 4, 2018 12:22 PM
> To: Dziegielewski, Marcin <marcin.dziegielewski@intel.com>
> Cc: Matias Bjørling <mb@lightnvm.io>; Jens Axboe <axboe@fb.com>; linux-
> block@vger.kernel.org; linux-kernel@vger.kernel.org; Konopko, Igor J
> <igor.j.konopko@intel.com>
> Subject: Re: [GIT PULL 18/20] lightnvm: pblk: handle case when mw_cunits
> equals to 0
> 
> > On 4 Jun 2018, at 12.09, Dziegielewski, Marcin
> <marcin.dziegielewski@intel.com> wrote:
> >
> >
> > Frist of all I want to say sorry for late response - I was on holiday.
> >
> >> From: Javier Gonzalez [mailto:javier@cnexlabs.com]
> >> Sent: Monday, May 28, 2018 1:03 PM
> >> To: Matias Bjørling <mb@lightnvm.io>
> >> Cc: Jens Axboe <axboe@fb.com>; linux-block@vger.kernel.org; linux-
> >> kernel@vger.kernel.org; Dziegielewski, Marcin
> >> <marcin.dziegielewski@intel.com>; Konopko, Igor J
> >> <igor.j.konopko@intel.com>
> >> Subject: Re: [GIT PULL 18/20] lightnvm: pblk: handle case when
> >> mw_cunits equals to 0
> >>
> >>> On 28 May 2018, at 10.58, Matias Bjørling <mb@lightnvm.io> wrote:
> >>>
> >>> From: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> >>>
> >>> Some devices can expose mw_cunits equal to 0, it can cause creation
> >>> of too small write buffer and cause performance to drop on write
> >>> workloads.
> >>>
> >>> To handle that, we use the default value for MLC and beacause it
> >>> covers both 1.2 and 2.0 OC specification, setting up mw_cunits in
> >>> nvme_nvm_setup_12 function isn't longer necessary.
> >>>
> >>> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> >>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> >>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
> >>> ---
> >>> drivers/lightnvm/pblk-init.c | 10 +++++++++-
> >>> drivers/nvme/host/lightnvm.c |  1 -
> >>> 2 files changed, 9 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/lightnvm/pblk-init.c
> >>> b/drivers/lightnvm/pblk-init.c index d65d2f972ccf..0f277744266b
> >>> 100644
> >>> --- a/drivers/lightnvm/pblk-init.c
> >>> +++ b/drivers/lightnvm/pblk-init.c
> >>> @@ -356,7 +356,15 @@ static int pblk_core_init(struct pblk *pblk)
> >>> 	atomic64_set(&pblk->nr_flush, 0);
> >>> 	pblk->nr_flush_rst = 0;
> >>>
> >>> -	pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
> >>> +	if (geo->mw_cunits) {
> >>> +		pblk->pgs_in_buffer = geo->mw_cunits * geo->all_luns;
> >>> +	} else {
> >>> +		pblk->pgs_in_buffer = (geo->ws_opt << 3) * geo->all_luns;
> >>> +		/*
> >>> +		 * Some devices can expose mw_cunits equal to 0, so let's
> >> use
> >>> +		 * here default safe value for MLC.
> >>> +		 */
> >>> +	}
> >>>
> >>> 	pblk->min_write_pgs = geo->ws_opt * (geo->csecs / PAGE_SIZE);
> >>> 	max_write_ppas = pblk->min_write_pgs * geo->all_luns; diff --git
> >>> a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c index
> >>> 41279da799ed..c747792da915 100644
> >>> --- a/drivers/nvme/host/lightnvm.c
> >>> +++ b/drivers/nvme/host/lightnvm.c
> >>> @@ -338,7 +338,6 @@ static int nvme_nvm_setup_12(struct
> >> nvme_nvm_id12
> >>> *id,
> >>>
> >>> 	geo->ws_min = sec_per_pg;
> >>> 	geo->ws_opt = sec_per_pg;
> >>> -	geo->mw_cunits = geo->ws_opt << 3;	/* default to MLC safe values
> >> */
> >>> /* Do not impose values for maximum number of open blocks as it is
> >>> 	 * unspecified in 1.2. Users of 1.2 must be aware of this and
> >>> eventually
> >>> --
> >>> 2.11.0
> >>
> >> By doing this, 1.2 future users (beyond pblk), will fail to have a
> >> valid mw_cunits value. It's ok to deal with the 0 case in pblk, but I
> >> believe that we should have the default value for 1.2 either way.
> >
> > I'm not sure. From my understanding, setting of default value was
> > workaround for pblk case, am I right ?.
> 
> The default value covers the MLC case directly at the lightnvm layer, as
> opposed to doing it directly in pblk. Since pblk is the only user now, you can
> argue that all changes in the lightnvm layer are to solve pblk issues, but the
> idea is that the geometry should be generic.
> 
> > In my opinion any user of 1.2
> > spec should be aware that there is not mw_cunit value. From my point
> > of view, leaving here 0 (and decision what do with it to lightnvm
> > user) is more safer way, but maybe I'm wrong. I believe that it is
> > topic to wider discussion with maintainers.
> >
> 
> 1.2 and 2.0 have different geometries, but when we designed the common
> nvm_geo structure, the idea was to abstract both specs and allow the upper
> layers to use the geometry transparently.
> 
> Specifically in pblk, I would prefer to keep it in such a way that we don't need
> to media specific policies (e.g., set default values for MLC memories), as a
> general design principle. We already do some geometry version checks to
> avoid dereferencing unnecessary pointers on the fast path, which I would
> eventually like to remove.
> 

Ok, now I understand your point of view and agree with that, I will prepare second version of this patch without this change. Thanks for the clarification.

> >> A more generic way of doing this would be to have a default value for
> >> 2.0 too, in case mw_cunits is reported as 0.
> >
> > Since 0 is correct value and users can make different decisions based
> > on it, I think we shouldn't overwrite it by default value. Is it make
> > sense?
> 
> Here I meant at a pblk level - I should have specified it. At the geometry
> level, we should not change it.
> 
> The case I am thinking is if mw_cuints repoints 0, but ws_min > 0. In this case,
> we still need a host side buffer to serve < ws_min I/Os, even though the
> device does not require the buffer to guarantee reads.

Oh, ok now we are on the same page. In this patch I was trying to address such case. Do you have other idea how to do it or here are you thinking only on value of default variable?

> 
> >> Javier
> >
> > Thanks,
> > Marcin
> 
> Javier
Thanks,
Marcin
