Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05A5C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3AB218A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 07:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546933088;
	bh=CexS1eDyLIYgXDnDaCYXWivEUxxAI51EJN1rCFfeMf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lGmZfiaitXxX/boqpcEcD1/fNwzJ/F6RlvNoxNp5qGaes2yeZxJE1ngN4NaPbCnIi
	 gzNqdNEvmT5jzVsNWDnwybFx1P+F9VM+fFRQ8JEDsP7EmaiXkvMfUKwwF046JhywMz
	 iU6W4uGaP4J/GYubilaPg+qR+mMzftFqwVl+ll9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfAHHiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 02:38:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfAHHiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 02:38:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F7EC21855;
        Tue,  8 Jan 2019 07:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546933087;
        bh=CexS1eDyLIYgXDnDaCYXWivEUxxAI51EJN1rCFfeMf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1pRtnyoOzt5Kqmt919XckWgvbvkvGX+8oBwqJuNDMWPn0yOQpgpv06noJ3DeeaEt/
         coCdt0cx4HIdsY3kogYSglT76KeDY7I43hZSI+/iy2PyuqX1lYF4At69lYv5ad5NMB
         wDKdQrlObN6BRTxu1YVtvzsyUqAofTsSyp+1LffQ=
Date:   Tue, 8 Jan 2019 08:38:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 4.14 090/101] MIPS: c-r4k: Add r4k_blast_scache_node for
 Loongson-3
Message-ID: <20190108073804.GC2102@kroah.com>
References: <20190107105330.372621917@linuxfoundation.org>
 <20190107105337.790421457@linuxfoundation.org>
 <CADVatmNw3X2WuUXSY9hP_n7ar2Hi8xUCh+BovQz2=c8RGRnwkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmNw3X2WuUXSY9hP_n7ar2Hi8xUCh+BovQz2=c8RGRnwkQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 09:17:22PM +0000, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Mon, Jan 7, 2019 at 1:14 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Huacai Chen <chenhc@lemote.com>
> >
> > commit bb53fdf395eed103f85061bfff3b116cee123895 upstream.
> 
> This has been fixed by 66a4059ba72c ("MIPS: Only include mmzone.h when
> CONFIG_NEED_MULTIPLE_NODES=y")

That commit is already in the queues for 4.14, 4.19, and 4.20, so all
should be fine, right?

thanks,

greg k-h
