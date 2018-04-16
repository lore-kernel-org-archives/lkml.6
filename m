Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeDPVEd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 17:04:33 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46179 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbeDPVEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 17:04:31 -0400
X-Google-Smtp-Source: AIpwx4+kcJgB5Dxzs78GEWrzLfQZuvYBzVfvHvcSDUyXwCMJgr4jeb84jhrJzDwPsoxvpboPrYcYmQ==
Date: Mon, 16 Apr 2018 16:04:29 -0500
From: Rob Herring <robh@kernel.org>
To: Alban Bedel <albeu@free.fr>
Cc: linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3 1/3] nvmem: Update the OF binding to use a subnode for
 the cells list
Message-ID: <20180416210429.e3yo52f355qxnopb@rob-hp-laptop>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
 <1521933899-362-2-git-send-email-albeu@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521933899-362-2-git-send-email-albeu@free.fr>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 25, 2018 at 12:24:57AM +0100, Alban Bedel wrote:
> Having the cells as subnodes of the provider device without any
> compatible property might clash with other bindings. To avoid this
> problem update the binding to have all the cells in a 'nvmem-cells'
> subnode with a 'nvmem-cells' compatible string. This new binding
> guarantee that we can turn any kind of device in a nvmem provider.
> 
> While discouraged for new uses the old scheme is still supported for
> backward compatibility.
> 
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>  Documentation/devicetree/bindings/nvmem/nvmem.txt | 55 ++++++++++++++++-------
>  drivers/nvmem/core.c                              | 10 +++++
>  2 files changed, 48 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.txt b/Documentation/devicetree/bindings/nvmem/nvmem.txt
> index fd06c09..6b723e7 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.txt
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.txt
> @@ -11,14 +11,29 @@ these data from, and where they are stored on the storage device.
>  This document is here to document this.
>  
>  = Data providers =
> -Contains bindings specific to provider drivers and data cells as children
> -of this node.
> +A data provider should have a subnode named 'nvmem-cells' that contains
> +a subnodes for each data cells.
> +
> +For backward compatibility the nvmem data cells can be direct children
> +of the data provider. This use is discouraged as it can conflict with
> +other bindings.

I don't think we need to go this far. Whether this is necessary depends 
on the provider.

>  
>  Optional properties:
>   read-only: Mark the provider as read only.
>  
> += Data cells list =
> +The data cells list node should be named 'nvmem-cells' and have a
> +child node for each data cell.
> +
> +Required properties:
> + compatible: Must be "nvmem-cells"
> + #address-cells: <1> if the provider use 32 bit addressing,
> +                 <2> for 64 bits addressing
> + #size-cells: <1> if the provider use 32 bit sizes,
> +              <2> for 64 bits sizes
> +
>  = Data cells =
> -These are the child nodes of the provider which contain data cell
> +These are the child nodes of the nvmem-cells node which contain data cell
>  information like offset and size in nvmem provider.
