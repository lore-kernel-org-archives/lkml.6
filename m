Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA90EC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8652D24747
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:17:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8652D24747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbeGBRRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:17:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:33910 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752215AbeGBRRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:17:01 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w62HGXUi019291;
        Mon, 2 Jul 2018 12:16:33 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w62HGV2u019290;
        Mon, 2 Jul 2018 12:16:31 -0500
Date:   Mon, 2 Jul 2018 12:16:31 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Kees Cook <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
        Paul Mackerras <paulus@samba.org>,
        Anatolij Gustschin <agust@denx.de>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: mpc5200: Remove VLA usage
Message-ID: <20180702171631.GA16221@gate.crashing.org>
References: <20180629185339.GA37582@beast> <CAK8P3a3zrXii=bxBm1zHWMHWgYLCQ0rpo460zmKyfsf_-nxxhQ@mail.gmail.com> <CAGXu5jJz0zP_DvGqZsBjKZ_vY0=xKoUxCLVxXgUPAbcXS6aMNg@mail.gmail.com> <87fu12mnf7.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fu12mnf7.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 11:33:32AM +1000, Michael Ellerman wrote:
> What if we write it:
> 
>        char saved_0x500[0x600 - 0x500];
> 
> Hopefully the compiler is smart enough not to generate a VLA for that :)

It is a VLA if the array size is not an integer constant expression.  This
is defined by C; the compiler has nothing to do with it.  0x600-0x500 is
an integer constant expression, so this is not a VLA.

But if you meant if GCC will ever do a dynamic stack allocation for a fixed
size local variable: yes indeed, I hope not!

(Sometimes GCC can avoid this even with VLAs; but in this example we do
not even have a VLA, so it's easier than that :-) )


Segher
