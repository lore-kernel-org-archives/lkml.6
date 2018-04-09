Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751721AbeDII1p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 04:27:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39454 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeDII1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 04:27:44 -0400
X-Google-Smtp-Source: AIpwx4/zSqznEVJhUDsewWTnOpDn/zsJLCjDHiVsNqigjVVG1xGEUvwZox/42hrQN6oQ1vuNBbvwww==
Date: Mon, 9 Apr 2018 10:27:40 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: Re: [PATCH 1/1] drm/xen-zcopy: Add Xen zero-copy helper DRM driver
Message-ID: <20180409082740.GI31310@phenom.ffwll.local>
Mail-Followup-To: Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org, gustavo@padovan.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180329131931.29957-1-andr2000@gmail.com>
 <20180329131931.29957-2-andr2000@gmail.com>
 <20180403094734.GT3881@phenom.ffwll.local>
 <1ef9290a-7564-007d-81c6-cf7db74252f3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ef9290a-7564-007d-81c6-cf7db74252f3@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 02:25:08PM +0300, Oleksandr Andrushchenko wrote:
> On 04/03/2018 12:47 PM, Daniel Vetter wrote:
> > On Thu, Mar 29, 2018 at 04:19:31PM +0300, Oleksandr Andrushchenko wrote:
> > > From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> > > +static int to_refs_grant_foreign_access(struct xen_gem_object *xen_obj)
> > > +{
> > > +	grant_ref_t priv_gref_head;
> > > +	int ret, j, cur_ref, num_pages;
> > > +	struct sg_page_iter sg_iter;
> > > +
> > > +	ret = gnttab_alloc_grant_references(xen_obj->num_pages,
> > > +			&priv_gref_head);
> > > +	if (ret < 0) {
> > > +		DRM_ERROR("Cannot allocate grant references\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	j = 0;
> > > +	num_pages = xen_obj->num_pages;
> > > +	for_each_sg_page(xen_obj->sgt->sgl, &sg_iter, xen_obj->sgt->nents, 0) {
> > > +		struct page *page;
> > > +
> > > +		page = sg_page_iter_page(&sg_iter);
> > Quick drive-by: You can't assume that an sgt is struct page backed.
> Do you mean that someone could give me sgt which never
> seen sg_assign_page for its entries?

Yes.

> What are the other use-cases for that to happen?

Sharing vram or other resources which are not backed by a struct page. See
Christian König's recent work to accomplish just that for admgpu.

> > And you probably want to check this at import/attach time.
> The check you mean is to make sure that when I call
> page = sg_page_iter_page(&sg_iter);
> I have to make sure that I get a valid page?

Yup.

> > -Daniel
> Thank you,
> Oleksandr

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
