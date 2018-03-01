Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161936AbeCAVNN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:13:13 -0500
Received: from galahad.ideasonboard.com ([185.26.127.97]:50029 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161269AbeCAVND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:13:03 -0500
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: frowand.list@gmail.com
Cc: Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, laurent.pinchart+renesas@ideasonboard.com
Subject: Re: [PATCH v4 1/4] of: change overlay apply input data from unflattened to FDT
Date: Thu, 01 Mar 2018 23:13:52 +0200
Message-ID: <6510001.NF9gEUFllG@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <18109035.ZrMSJvtVAx@avalon>
References: <1519927256-4868-1-git-send-email-frowand.list@gmail.com> <1519927256-4868-2-git-send-email-frowand.list@gmail.com> <18109035.ZrMSJvtVAx@avalon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Another comment, please see below.

On Thursday, 1 March 2018 22:59:08 EET Laurent Pinchart wrote:
> On Thursday, 1 March 2018 20:00:53 EET frowand.list@gmail.com wrote:
> > From: Frank Rowand <frank.rowand@sony.com>
> > 
> > Move duplicating and unflattening of an overlay flattened devicetree
> > (FDT) into the overlay application code.  To accomplish this,
> > of_overlay_apply() is replaced by of_overlay_fdt_apply().
> > 
> > The copy of the FDT (aka "duplicate FDT") now belongs to devicetree
> > code, which is thus responsible for freeing the duplicate FDT.  The
> > caller of of_overlay_fdt_apply() remains responsible for freeing the
> > original FDT.
> > 
> > The unflattened devicetree now belongs to devicetree code, which is
> > thus responsible for freeing the unflattened devicetree.
> > 
> > These ownership changes prevent early freeing of the duplicated FDT
> > or the unflattened devicetree, which could result in use after free
> > errors.
> > 
> > of_overlay_fdt_apply() is a private function for the anticipated
> > overlay loader.
> > 
> > Update unittest.c to use of_overlay_fdt_apply() instead of
> > of_overlay_apply().
> > 
> > Move overlay fragments from artificial locations in
> > drivers/of/unittest-data/tests-overlay.dtsi into one devicetree
> > source file per overlay.  This led to changes in
> > drivers/of/unitest-data/Makefile and drivers/of/unitest.c.
> > 
> >   - Add overlay directives to the overlay devicetree source files so
> >     that dtc will compile them as true overlays into one FDT data
> >     chunk per overlay.
> >   
> >   - Set CFLAGS for drivers/of/unittest-data/testcases.dts so that
> >     symbols will be generated for overlay resolution of overlays
> >     that are no longer artificially contained in testcases.dts
> >   
> >   - Unflatten and apply each unittest overlay FDT using
> >     of_overlay_fdt_apply().
> >   
> >   - Enable the of_resolve_phandles() check for whether the unflattened
> >     overlay is detached.  This check was previously disabled because the
> >     overlays from tests-overlay.dtsi were not unflattened into detached
> >     trees.
> >   
> >   - Other changes to unittest.c infrastructure to manage multiple test
> >     FDTs built into the kernel image (access by name instead of
> >     arbitrary number).
> >   
> >   - of_unittest_overlay_high_level(): previously unused code to add
> >     properties from the overlay_base devicetree to the live tree
> >     was triggered by the restructuring of tests-overlay.dtsi and thus
> >     testcases.dts.  This exposed two bugs: (1) the need to dup a
> >     property before adding it, and (2) property 'name' is
> >     auto-generated in the unflatten code and thus will be a duplicate
> >     in the __symbols__ node - do not treat this duplicate as an error.
> > 
> > Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> > ---
> > 
> > There are checkpatch warnings.  I have reviewed them and feel they
> > can be ignored.  They are "line over 80 characters" for either
> > pre-existing long lines, or lines in devicetree source files.
> > 
> > Changes from v3:
> >   - OF_OVERLAY: add select OF_FLATTREE
> > 
> > Changes from v1:
> >   - rebase on v4.16-rc1
> >  
> >  drivers/of/Kconfig                          |   1 +
> >  drivers/of/of_private.h                     |   1 +
> >  drivers/of/overlay.c                        | 107 +++++++++-
> >  drivers/of/resolver.c                       |   6 -
> >  drivers/of/unittest-data/Makefile           |  28 ++-
> >  drivers/of/unittest-data/overlay_0.dts      |  14 ++
> >  drivers/of/unittest-data/overlay_1.dts      |  14 ++
> >  drivers/of/unittest-data/overlay_10.dts     |  34 ++++
> >  drivers/of/unittest-data/overlay_11.dts     |  34 ++++
> >  drivers/of/unittest-data/overlay_12.dts     |  14 ++
> >  drivers/of/unittest-data/overlay_13.dts     |  14 ++
> >  drivers/of/unittest-data/overlay_15.dts     |  35 ++++
> >  drivers/of/unittest-data/overlay_2.dts      |  14 ++
> >  drivers/of/unittest-data/overlay_3.dts      |  14 ++
> >  drivers/of/unittest-data/overlay_4.dts      |  23 +++
> >  drivers/of/unittest-data/overlay_5.dts      |  14 ++
> >  drivers/of/unittest-data/overlay_6.dts      |  15 ++
> >  drivers/of/unittest-data/overlay_7.dts      |  15 ++
> >  drivers/of/unittest-data/overlay_8.dts      |  15 ++
> >  drivers/of/unittest-data/overlay_9.dts      |  15 ++
> >  drivers/of/unittest-data/tests-overlay.dtsi | 213 --------------------
> >  drivers/of/unittest.c                       | 294 +++++++++++------------
> >  include/linux/of.h                          |   7 -
> >  23 files changed, 552 insertions(+), 389 deletions(-)
> >  create mode 100644 drivers/of/unittest-data/overlay_0.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_1.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_10.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_11.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_12.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_13.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_15.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_2.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_3.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_4.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_5.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_6.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_7.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_8.dts
> >  create mode 100644 drivers/of/unittest-data/overlay_9.dts

[snip]

> > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > index 3397d7642958..5f6c5569e97d 100644
> > --- a/drivers/of/overlay.c
> > +++ b/drivers/of/overlay.c

[snip]

> > @@ -766,7 +803,59 @@ int of_overlay_apply(struct device_node *tree, int
> > *ovcs_id)
> > 
> >  	return ret;
> >  
> >  }
> > 
> > -EXPORT_SYMBOL_GPL(of_overlay_apply);
> > +
> > +int of_overlay_fdt_apply(void *overlay_fdt, int *ovcs_id)

I find it a bit dangerous that this function doesn't take the size of the FDT 
blob. I don't think we will always be able to trust the FDT blob. I'm fine 
fixing this in follow-up patches, I don't think it's a blocker as the only 
user we have today passes an FDT compiled in the kernel sources.

> > +{
> > +	const void *new_fdt;
> > +	int ret;
> > +	u32 size;
> > +	struct device_node *overlay_root;
> > +
> > +	*ovcs_id = 0;
> > +	ret = 0;
> > +
> > +	if (fdt_check_header(overlay_fdt)) {
> > +		pr_err("Invalid overlay_fdt header\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	size = fdt_totalsize(overlay_fdt);
> > +
> > +	/*
> > +	 * Must create permanent copy of FDT because of_fdt_unflatten_tree()
> > +	 * will create pointers to the passed in FDT in the unflattened tree.
> > +	 */
> > +	new_fdt = kmemdup(overlay_fdt, size, GFP_KERNEL);
> > +	if (!new_fdt)
> > +		return -ENOMEM;
> > +
> > +	of_fdt_unflatten_tree(new_fdt, NULL, &overlay_root);
> > +	if (!overlay_root) {
> > +		pr_err("unable to unflatten overlay_fdt\n");
> > +		ret = -EINVAL;
> > +		goto out_free_new_fdt;
> > +	}
> > +
> > +	ret = of_overlay_apply(new_fdt, overlay_root, ovcs_id);
> > +	if (ret < 0) {
> > +		/*
> > +		 * new_fdt and overlay_root now belong to the overlay
> > +		 * changeset.
> > +		 * overlay changeset code is responsible for freeing them.
> > +		 */
> > +		goto out;
> > +	}
> > +
> > +	return 0;
> > +
> > +
> > +out_free_new_fdt:
> > +	kfree(new_fdt);
> > +
> > +out:
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(of_overlay_fdt_apply);
> > 
> >  /*
> >   * Find @np in @tree.

-- 
Regards,

Laurent Pinchart
