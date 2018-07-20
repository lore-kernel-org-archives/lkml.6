Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3E5ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802F82084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802F82084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbeGTG6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 02:58:47 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:29553
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727364AbeGTG6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 02:58:46 -0400
X-IronPort-AV: E=Sophos;i="5.51,377,1526335200"; 
   d="scan'208";a="273562945"
Received: from abo-214-111-68.mrs.modulonet.fr (HELO [192.168.0.15]) ([85.68.111.214])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jul 2018 08:03:35 +0200
Date:   Fri, 20 Jul 2018 08:03:35 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Dominique Martinet <asmadeus@codewreck.org>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] coccinelle: suggest replacing strncpy+truncation by
 strscpy
In-Reply-To: <20180720055705.GA2810@nautica>
Message-ID: <alpine.DEB.2.20.1807200759230.2349@hadrien>
References: <1531555951-9627-1-git-send-email-asmadeus@codewreck.org> <1532047018-23754-1-git-send-email-asmadeus@codewreck.org> <alpine.DEB.2.20.1807200731240.2349@hadrien> <20180720054050.GA32233@nautica> <alpine.DEB.2.20.1807200745400.2349@hadrien>
 <20180720055705.GA2810@nautica>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Jul 2018, Dominique Martinet wrote:

> Julia Lawall wrote on Fri, Jul 20, 2018:
> > On Fri, 20 Jul 2018, Dominique Martinet wrote:
> > > I guess there is no value in the script landing first by itself, I'll
> > > just remove the script path from the commit messages and resend the
> > > first few this weekend.
> >
> > It's not that there is no value to the script.  The problem is that I
> > don't know if the script is correct - I'm not familiar with these string
> > functions.  Once the script is in the kernel, it stays there beyond your
> > patches, so I would prefer to know that it is correct up front, rather
> > than having to remove it afterwards.
>
> I understand, I didn't say there is no value in the script ("landing
> first by itself" doesn't mean it should/can not be taken later)
>
> I'll bump this thread again in a couple of weeks after having resent
> most of the other patches

Thanks.

The rule is also not so efficient in the patch case, because you have the
rule r that matches the pattern, and then the ok rule at the end that
matches the same pattern.  It would be better to put depends on org ||
report in the rule r, and let the patch rule be freestanding, ie just
declare dest, src, and sz, not r.dest, etc.

If you like, you can also add the context case by just putting a * in
front of the strncpy call in the r rule.  That highlights the change in
diff-like output, which can in general be useful to see the context in
which the issue occurs.

julia
