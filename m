Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC84C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C289120854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AuyVNe2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C289120854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeIKOtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:49:21 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34374 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:49:21 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D54E857;
        Tue, 11 Sep 2018 11:50:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536659446;
        bh=YxmogvtaUd7WCtiePQepeH/K4t2uX7oCGYhcGAYiITs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AuyVNe2RH7V8Bkc74c9QULTAMNJlB0dbCTxgh5cs9gT7J+Z3JSIqJAU/FuutpIQF9
         Dz8EcWmq2SJidgDu/LgJTLRRCP3LDMv8U0YMlmLVhQDh9ymk4IzQ8cKrW+dDNWDDUT
         IC9DcitFC3cb9iLE2BoypzgWEIoyWGk8foNwM2KI=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH v7] Add udmabuf misc device
Date:   Tue, 11 Sep 2018 12:50:58 +0300
Message-ID: <18750721.r4B5nx0M26@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20180911065014.vo6qp6hkb7cjftdc@sirius.home.kraxel.org>
References: <20180827093444.23623-1-kraxel@redhat.com> <21053714.0Xa7F2u2PE@avalon> <20180911065014.vo6qp6hkb7cjftdc@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

On Tuesday, 11 September 2018 09:50:14 EEST Gerd Hoffmann wrote:
>   Hi,
> 
> >> +#define UDMABUF_CREATE       _IOW('u', 0x42, struct udmabuf_create)
> > 
> > Why do you start at 0x42 if you reserve the 0x40-0x4f range ?
> 
> No particular strong reason, just that using 42 was less boring than
> starting with 0x40.
> 
> >> +#define UDMABUF_CREATE_LIST  _IOW('u', 0x43, struct
> >> udmabuf_create_list)
> > 
> > Where's the documentation ? :-)
> 
> Isn't it simple enough?

No kernel UAPI is simple enough to get away without documenting it.

> But, well, yes, I guess I can add some kerneldoc comments.
> 
> >> +static int udmabuf_vm_fault(struct vm_fault *vmf)
> >> +{
> >> +	struct vm_area_struct *vma = vmf->vma;
> >> +	struct udmabuf *ubuf = vma->vm_private_data;
> >> +
> >> +	if (WARN_ON(vmf->pgoff >= ubuf->pagecount))
> >> +		return VM_FAULT_SIGBUS;
> > 
> > Just curious, when do you expect this to happen ?
> 
> It should not.  If it actually happens it would be a bug somewhere,
> thats why the WARN_ON.

But you seem to consider that this condition that should never happen still 
has a high enough chance of happening that it's worth a WARN_ON(). I was 
wondering why this one in particular, and not other conditions that also can't 
happen and are not checked through the code. 

> >> +	struct udmabuf *ubuf;
> >> 
> >> +	ubuf = kzalloc(sizeof(struct udmabuf), GFP_KERNEL);
> > 
> > sizeof(*ubuf)
> 
> Why?  Should not make a difference ...

Because the day we replace

	struct udmabuf *ubuf;

with

	struct udmabuf_ext *ubuf;

and forget to change the next line, we'll introduce a bug. That's why 
sizeof(variable) is preferred over sizeof(type). Another reason is that I can 
easily see that

	ubuf = kzalloc(sizeof(*ubuf), GFP_KERNEL);

is correct, while using sizeof(type) requires me to go and look up the 
declaration of the variable.

> >> +		memfd = fget(list[i].memfd);
> >> +		if (!memfd)
> >> +			goto err_put_pages;
> >> +		if (!shmem_mapping(file_inode(memfd)->i_mapping))
> >> +			goto err_put_pages;
> >> +		seals = memfd_fcntl(memfd, F_GET_SEALS, 0);
> >> +		if (seals == -EINVAL ||
> >> +		    (seals & SEALS_WANTED) != SEALS_WANTED ||
> >> +		    (seals & SEALS_DENIED) != 0)
> >> +			goto err_put_pages;
> > 
> > All these conditions will return -EINVAL. I'm not familiar with the memfd
> > API, should some error conditions return a different error code to make
> > them distinguishable by userspace ?
> 
> Hmm, I guess EBADFD would be reasonable in case the file handle isn't a
> memfd.  Other suggestions?

I'll let others comment on this as I don't feel qualified to pick proper error 
codes, not being familiar with the memfd API.

> I'll prepare a fixup patch series addressing most of the other
> review comments.

-- 
Regards,

Laurent Pinchart



