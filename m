Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936378AbeBUQjc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:39:32 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:55417 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932674AbeBUQja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:39:30 -0500
Date: Wed, 21 Feb 2018 17:39:25 +0100
From: Simon Horman <horms@verge.net.au>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
        Matt Porter <mporter@konsulko.com>,
        Koen Kooi <koen@dominion.thruhere.net>,
        Guenter Roeck <linux@roeck-us.net>, Marek Vasut <marex@denx.de>,
        Wolfram Sang <wsa@the-dreams.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Subject: Re: [PATCH v4 00/16] R-Car DU: Convert LVDS code to bridge driver
Message-ID: <20180221163924.cikog34sqr6aggyk@verge.net.au>
References: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180220231046.32638-1-laurent.pinchart+renesas@ideasonboard.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 01:10:30AM +0200, Laurent Pinchart wrote:
> Hello,
> 
> This patch series addresses a design mistake that dates back from the initial
> DU support. Support for the LVDS encoders, which are IP cores separate from
> the DU, was bundled in the DU driver. Worse, both the DU and LVDS were
> described through a single DT node.
> 
> To fix the, patches 01/16 and 02/16 define new DT bindings for the LVDS
> encoders, and deprecate their description inside the DU bindings. To retain
> backward compatibility with existing DT, patches 03/16 to 08/16 then patch the
> device tree at runtime to convert the legacy bindings to the new ones.
> 
> With the DT side addressed, patch 09/16 converts the LVDS support code to a
> separate bridge driver. Patches 11/16 to 16/16 then update all the device tree
> sources to the new DU and LVDS encoders bindings.
> 
> I decided to go for live DT patching in patch 08/16 because implementing
> support for both the legacy and new bindings in the driver would have been
> very intrusive, and prevented further cleanups. This version relies more
> heavily on overlays to avoid touching the internals of the OF core compared to
> v2, even if manual fixes to the device tree are still needed.
> 
> Compared to v3, this series uses the OF changeset API to update properties
> instead of accessing the internals of the property structure. This removes the
> local implementation of functions to look up nodes by path and update
> properties. In order to do this, I pulled in Pantelis' patch series titled
> "[PATCH v2 0/5] of: dynamic: Changesets helpers & fixes" at Rob's request, and
> rebased it while taking two small review comments into account.
> 
> Rob, I'd like this series to be merged in v4.17. As the changeset helpers are
> now a dependency, I'd need you to merge them early (ideally on top of
> v4.16-rc1) and provide a stable branch, or get your ack to merge them through
> Dave's tree if they don't conflict with what you have and will queue for
> v4.17.
> 
> This version also drops the small fix to the Porter board device tree that has
> been queued for v4.17 already.
> 
> Compared to v2, the biggest change is in patch 03/16. Following Rob's and
> Frank's reviews it was clear that modifying the unflattened DT structure of
> the overlay before applying it wasn't popular. I have thus decided to use one
> overlay source per SoC to move as much of the DT changes to the overlay as
> possible, and only perform manual modifications (that are still needed as some
> of the information is board-specific) on the system DT after applying the
> overlay. As a result the overlay is parsed and applied without being modified.
> 
> Compared to v1, this series update the r8a7792 and r8a7794 device tree sources
> and incorporate review feedback as described by the changelogs of individual
> patches.
> 
> 
> Laurent Pinchart (11):
>   dt-bindings: display: renesas: Add R-Car LVDS encoder DT bindings
>   dt-bindings: display: renesas: Deprecate LVDS support in the DU
>     bindings
>   drm: rcar-du: Fix legacy DT to create LVDS encoder nodes
>   drm: rcar-du: Convert LVDS encoder code to bridge driver
>   ARM: dts: r8a7790: Convert to new LVDS DT bindings
>   ARM: dts: r8a7791: Convert to new LVDS DT bindings
>   ARM: dts: r8a7792: Convert to new DU DT bindings
>   ARM: dts: r8a7793: Convert to new LVDS DT bindings
>   ARM: dts: r8a7794: Convert to new DU DT bindings
>   arm64: dts: renesas: r8a7795: Convert to new LVDS DT bindings
>   arm64: dts: renesas: r8a7796: Convert to new LVDS DT bindings

I have marked the dts patches above as deferred as they depend
on the driver changes not to cause a regression. Please repost them
or otherwise ping me once the driver dependencies are present in an rc
release.

I am assuming that the other patches in this series are not targeted
at the renesas tree.

> 
> Pantelis Antoniou (5):
>   of: dynamic: Add __of_node_dupv()
>   of: changesets: Introduce changeset helper methods
>   of: changeset: Add of_changeset_node_move method
>   of: unittest: changeset helpers
>   i2c: demux: Use changeset helpers for clarity

...
