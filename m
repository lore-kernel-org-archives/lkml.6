Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A833FC43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3CE20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546949020;
	bh=3Y50bE/HW6vUntmQuwunX1pbWqLvPzumPjNYxVTHtBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EPeAkHBg5OPt81qjzW/YMlaN6wMUsJu2wYH7xXh1zsuHbISGo/nyT3j2Hs8VL1Yft
	 YlZs4IdCF53E++N7hePRJjKORQcgMlKqzLWxz36gruk6Tn0VocA9sOyJ/HJ2YQsgGB
	 1s8B486Wnnai19VrfYLtebgRZL/hGQLAhtiRxCC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfAHMDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:03:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfAHMDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:03:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8028420685;
        Tue,  8 Jan 2019 12:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546949019;
        bh=3Y50bE/HW6vUntmQuwunX1pbWqLvPzumPjNYxVTHtBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nRJwB7H3fdDMYNuWqmlqIn1+JEzMPxwO4Pyo+90xvgvRRBh+MBKxqZ5YIQW8CYzvl
         +IzkoTorAHtORdPMQs6hsFJDPq7YKFO8llZ0IgRMEdO/Uux1pHS1VkRnUOJLBfWoX3
         FTLFmB/Df72dAaq2UFyU3BhhjCpima9VOjt5Y6f0=
Date:   Tue, 8 Jan 2019 13:03:36 +0100
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
Message-ID: <20190108120336.GA10356@kroah.com>
References: <20190107105330.372621917@linuxfoundation.org>
 <20190107105337.790421457@linuxfoundation.org>
 <CADVatmNw3X2WuUXSY9hP_n7ar2Hi8xUCh+BovQz2=c8RGRnwkQ@mail.gmail.com>
 <20190108073804.GC2102@kroah.com>
 <CADVatmMjQwBMP+_-Kh+0J17vNVWOUmuKkODMhf8WOOfQSEgCuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmMjQwBMP+_-Kh+0J17vNVWOUmuKkODMhf8WOOfQSEgCuQ@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 09:54:53AM +0000, Sudip Mukherjee wrote:
> On Tue, Jan 8, 2019 at 7:38 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jan 07, 2019 at 09:17:22PM +0000, Sudip Mukherjee wrote:
> > > Hi Greg,
> > >
> > > On Mon, Jan 7, 2019 at 1:14 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > 4.14-stable review patch.  If anyone has any objections, please let me know.
> > > >
> > > > ------------------
> > > >
> > > > From: Huacai Chen <chenhc@lemote.com>
> > > >
> > > > commit bb53fdf395eed103f85061bfff3b116cee123895 upstream.
> > >
> > > This has been fixed by 66a4059ba72c ("MIPS: Only include mmzone.h when
> > > CONFIG_NEED_MULTIPLE_NODES=y")
> >
> > That commit is already in the queues for 4.14, 4.19, and 4.20, so all
> > should be fine, right?
> 
> I am not seeing it in 4.14.92-rc3.  Am I missing something?

Nope, you are right, I cut-pasted the wrong git id.  ugh, still feels
like monday...

let me fix this up now and push out all new -rc releases...

thanks,

greg k-h
