Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5B4C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32242084F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 05:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547963295;
	bh=ITe27/+0T+eU+ne2lJHm8YUJPa7N4RN1xKp5GksztqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IYbcfORaJNi2o+bEfAvD3eNeoOPgx+eq4L+qHXq6QL1Wmcdfash4vSYQqgrXnRnAr
	 x8MFWtq3K0yRbQigJuOxSio/o1elPpZaoIXo6zx9j5JazluH0TcLxLvzWFdnJrWB0Z
	 ccUlyXKDIcBbDnHXqYWbhWYmpeWHI7iKiRxqvq14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfATFsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 00:48:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfATFsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 00:48:14 -0500
Received: from localhost (unknown [122.178.235.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5150C2084F;
        Sun, 20 Jan 2019 05:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547963293;
        bh=ITe27/+0T+eU+ne2lJHm8YUJPa7N4RN1xKp5GksztqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDiSuHW0t0B/3N6VkrbcFW/Uh99iFB8EDrwL6+cSMuqdU7aG4x9lFMA/rxfLor0Bv
         T1weyKLmoVOsHtokZVpCW20JScJfe6cqhEzcziyb0gFEsSxZV9NaTZleSXcQwnz6+6
         /3XyVXP4hRjXnlqbDvfQc7k1HQp9sp6/C1IQ5wrE=
Date:   Sun, 20 Jan 2019 11:16:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma: ixm-dma: fix warning comparison of distinct pointer
 types
Message-ID: <20190120054639.GO4635@vkoul-mobl>
References: <20190110111535.11235-1-anders.roxell@linaro.org>
 <CAOMZO5DGxXBCFbLgqeophv_Jw2nO5wiPXJXuth6CPEfSr9f9=w@mail.gmail.com>
 <CADYN=9KOqZXiFYvxWED-f_sJS6G-CqY2pPUYohGuP9Pa6VGUZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADYN=9KOqZXiFYvxWED-f_sJS6G-CqY2pPUYohGuP9Pa6VGUZQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-01-19, 15:14, Anders Roxell wrote:
> On Mon, 14 Jan 2019 at 22:24, Fabio Estevam <festevam@gmail.com> wrote:
> >
> > Hi Anders,
> >
> > On Thu, Jan 10, 2019 at 9:15 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> > >
> > > The warning got introduced by commit 930507c18304 ("arm64: add basic
> > > Kconfig symbols for i.MX8"). Since it got enabled for arm64. The warning
> > > haven't been seen before since size_t was 'unsigned int' when built on
> > > arm32.
> > >
> > > ../drivers/dma/imx-dma.c: In function ‘imxdma_sg_next’:
> > > ../include/linux/kernel.h:846:29: warning: comparison of distinct pointer types lacks a cast
> > >    (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
> > >                              ^~
> > > ../include/linux/kernel.h:860:4: note: in expansion of macro ‘__typecheck’
> > >    (__typecheck(x, y) && __no_side_effects(x, y))
> > >     ^~~~~~~~~~~
> > > ../include/linux/kernel.h:870:24: note: in expansion of macro ‘__safe_cmp’
> > >   __builtin_choose_expr(__safe_cmp(x, y), \
> > >                         ^~~~~~~~~~
> > > ../include/linux/kernel.h:879:19: note: in expansion of macro ‘__careful_cmp’
> > >  #define min(x, y) __careful_cmp(x, y, <)
> > >                    ^~~~~~~~~~~~~
> > > ../drivers/dma/imx-dma.c:288:8: note: in expansion of macro ‘min’
> > >   now = min(d->len, sg_dma_len(sg));
> > >         ^~~
> > >
> > > Rework so that we use min_t and pass in the size_t that returns the
> > > minimum of two values, using the specified type.
> > >
> > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> >
> > There is a typo in the Subject: s/ixm/imx/ and the prefix should be
> > dmaengine instead:
> >
> > dmaengine: imx-dma: fix warning comparison of distinct pointer types
> >
> > With that fixed:
> >
> > Reviewed-by: Fabio Estevam <festevam@gmail.com>
> 
> OK, thanks Fabio.
> 
> Dan, do you want me to resend the patch with an updated shortlog or will
> you do that when you apply the patch?

applied after fixing subsystem name and driver name

-- 
~Vinod
