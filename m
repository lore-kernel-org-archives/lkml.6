Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161143AbeEXTBs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 15:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032740AbeEXTBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 15:01:45 -0400
Date: Thu, 24 May 2018 21:01:26 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>, Mark Brown <broonie@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, boot-architecture@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/8] driver core: add a deferred probe timeout
Message-ID: <20180524190126.GC31019@kroah.com>
References: <20180524175024.19874-1-robh@kernel.org>
 <20180524175024.19874-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524175024.19874-3-robh@kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 12:50:18PM -0500, Rob Herring wrote:
> Deferring probe can wait forever on dependencies that may never appear
> for a variety of reasons. This can be difficult to debug especially if
> the console has dependencies or userspace fails to boot to a shell. Add
> a timeout to retry probing without possibly optional dependencies and to
> dump out the deferred probe pending list after retrying.
> 
> This mechanism is intended for debug purposes. It won't work for the
> console which needs to be enabled before userspace starts. However, if
> the console's dependencies are resolved, then the kernel log will be
> printed (as opposed to no output).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |  7 +++++
>  drivers/base/dd.c                             | 28 ++++++++++++++++++-
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 11fc28ecdb6d..dd3f40b34a24 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -809,6 +809,13 @@
>  			Defaults to the default architecture's huge page size
>  			if not specified.
>  
> +	deferred_probe_timeout=
> +			[KNL] Set a timeout in seconds for deferred probe to
> +			give up waiting on dependencies to probe. Only specific
> +			dependencies (subsystems or drivers) that have opted in
> +			will be ignored. This option also dumps out devices
> +			still on the deferred probe list after retrying.

Doesn't sound like a debugging-only option.  I can see devices enabling
this when they figure out that's the only way their platform can boot :)

thanks,

greg k-h
