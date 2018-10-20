Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE33C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C774321534
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 14:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C774321534
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJTW0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 18:26:06 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:56421 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeJTW0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 18:26:06 -0400
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Oct 2018 18:26:04 EDT
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 8533980444;
        Sat, 20 Oct 2018 16:08:36 +0200 (CEST)
Date:   Sat, 20 Oct 2018 16:08:35 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Jim Wilson <jimw@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH 0/2] modpost: skip section mismatch warnings on ELF local
 symbols by default
Message-ID: <20181020140835.GA3351@ravnborg.org>
References: <20181020131911.22443-1-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020131911.22443-1-paul.walmsley@sifive.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=FUAdSMgXcLSmITUp8T8A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

> modpost: skip section mismatch warnings on ELF local symbols by default
> 
> modpost, by default, reports section mismatch warnings on ELF local
> symbols.  This caused false positive warnings to be reported for a
> local symbol name that would otherwise be elided by matching against a
> name pattern.  This was observed using a RISC-V toolchain that generates
> section anchors.
> 
> To avoid this noise in the common case, this patch series disables
> section mismatch warnings on ELF local symbols by default.
This part is fine.

> It also
> adds a modpost command line switch to re-enable these warnings, since
> I wasn't able to convince myself that section mismatch warnings on ELF
> local symbols were completely useless; just mostly useless :-)
modpost is not supposed to be used outside the kernel build.
And therefore if we introduce a new option then the infrastructure
to enable that option should also be in place.
In this particular case I cannot see why we should add the possibility
to include local symbols, in other words do not add the option.
Wait a few days before you kill it, maybe others see the usefulness of it.

I checked if there were any options supported by modpost that
was not configurable in makefile.modpost.
And I could see that the -M and -K options in getopt() was leftovers.
The code that used these option was was dropped in:
a8773769d1a1e08d0ca15f890515401ab3860637 ("Kbuild: clear marker out of modpost")

Could you add a patch that delete these on top of what you already have.

	Sam
