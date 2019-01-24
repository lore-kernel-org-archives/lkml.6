Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B53DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E9321872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548351235;
	bh=qlZaXfaCi9wEE7QcfVCvztnFdKMsNxQIP4jzGg72sxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cKsEE+nraTHUuOra4BmSzvBej7twm4FIlKGTDt0X/6dNnEiJgxirThDtWL97mN7ll
	 LTtu/W1THBpWrjHl8aThg7lJ438I9tWVJodcJYnMCrT+1xClUVm8HDeiOB9qZ5MVpW
	 Mfy8tqkiAMus/O6CmnlYt1MtUPmcPJ4s17ZK98oQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbfAXRdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:33:52 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51334 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfAXRdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:33:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Aavs4DpFxrFSeZJ9Gy7B+7nTXknzrCUZh/kQHGogyII=; b=uRWlpH4EPWVCsFL54TDfOaCq2
        DZOstdV8+J0blo4siWD1M/3uVqtf/TUYSFHUOLsMSVASSRs6B7uA/R59erB/RoivxXnzx9wfMYTu0
        /aL8ibd2ewB46FelhbgsarnfNgws/+tya/pjtBeuTLby2jzphhv3ZVKYYHEzoo/runrEE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmisU-0006Wl-JO; Thu, 24 Jan 2019 17:33:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id E3F211121B6F; Thu, 24 Jan 2019 17:33:21 +0000 (GMT)
Date:   Thu, 24 Jan 2019 17:33:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Leo Yan <leo.yan@linaro.org>, Takashi Iwai <tiwai@suse.de>,
        alsa-devel@alsa-project.org, arnd@arndb.de, keescook@chromium.org,
        bgoswami@codeaurora.org, sr@denx.de, gustavo@embeddedor.com,
        philburk@google.com, willy@infradead.org,
        mchehab+samsung@kernel.org, sboyd@kernel.org, vkoul@kernel.org,
        Baolin Wang <baolin.wang@linaro.org>,
        daniel.thompson@linaro.org, mathieu.poirier@linaro.org,
        srinivas.kandagatla@linaro.org, anna-maria@linutronix.de,
        corbet@lwn.net, jmiller@neverware.com,
        ckeepax@opensource.wolfsonmicro.com, joe@perches.com,
        o-takashi@sakamocchi.jp, colyli@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ALSA: core: Add DMA share buffer support
Message-ID: <20190124173321.GE5641@sirena.org.uk>
References: <290f6d3a5fe288b87480cc5fa12c5139728daeca.1547787189.git.baolin.wang@linaro.org>
 <81e894ba-acad-2fd4-996d-8d35edd8825a@perex.cz>
 <20190118190805.GF6260@sirena.org.uk>
 <s5hzhrxzrez.wl-tiwai@suse.de>
 <20190121124053.GA12679@sirena.org.uk>
 <f278bb69-7df0-4d14-5e4f-9bcb57d7f2b6@perex.cz>
 <20190122202535.GK7579@sirena.org.uk>
 <s5h4l9z4mbo.wl-tiwai@suse.de>
 <20190123124658.GE15906@leoy-ThinkPad-X240s>
 <3962daba-f6ed-d706-c618-b791a1ba6b59@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
In-Reply-To: <3962daba-f6ed-d706-c618-b791a1ba6b59@perex.cz>
X-Cookie: Love America -- or give it back.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 24, 2019 at 02:43:02PM +0100, Jaroslav Kysela wrote:

> If I look to the dma_buf_fd() implementation:

>   fd = get_unused_fd_flags(flags);
>   fd_install(fd, dmabuf->file);

> .. what if we just add one new ioctl to the ALSA's PCM API which will
> return a new anonymous inode descriptor with the restricted access to
> the main PCM device to satisfy the SELinux requirements / security
> policies? It might be more nice and simple solution than to implement
> the full dma-buf interface for the ALSA's PCM devices.

That certainly works for me so long as the security people are happy.

> Question: The dma-buf also implements the fencing, but I am not able to
> determine, if this mechanism is used in android [1]. It may allow
> concurrent mmap and synchronize apps - but the sound server should
> manage the access to the DMA buffer anyway. In my opinion, it makes much
> sense for the video-pipes when the hardware does some accelerations
> (encoding/decoding).

We had the same discuission off list and couldn't think of a need for
that feature in the audio context but left it in as it's already there
with dma-buf so there's no real cost to implementing it and we weren't
sure we weren't missing something.

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxJ9uEACgkQJNaLcl1U
h9BHRwf9GMsmMNurfImygbIVYIiOSvt5nUSqwx8eQXILTHWza2Pumojxs0EqTQgU
Tt3s81HcYK7RkDUqdV9BvarzZfQfA8pPK9+s7TzIIv1eJzIrRu8h5CJKaZwNhdzz
sHQki9F7tBbUKQXNlDvTvU078HyoaMe1I/yZgWrz1WJl2u3+FCugB137wke6fpSD
NyMTbC7JrwAVcNZWVCZcQHAs3cbPDc30FbZ2OmpQUcWhFOR9Y5lUpp4jzg811+cR
PwTuU8EyUNjZwzoj6gcVP1whifDugAIx7rLziEOKPLPE708MitHkVI+1+j32Xfcw
2aXLRNhXODvEP3Ll2N5mAx4GCwZqnQ==
=XB4S
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
