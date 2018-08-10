Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BD9C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFF822418
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFF822418
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbeHJQ7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:59:16 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:46978 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727432AbeHJQ7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:59:16 -0400
X-IronPort-AV: E=Sophos;i="5.53,220,1531778400"; 
   d="scan'208";a="342063467"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2018 16:29:05 +0200
Date:   Fri, 10 Aug 2018 16:28:58 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Denis Efremov <efremov@linux.com>
cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] coccicheck: return proper error code on check fail
In-Reply-To: <CADKZ3FLsksV8-cCE6aOnZnLbYj3SSAkPnMs_VRQB3g0V3mUYcg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1808101627230.3390@hadrien>
References: <20180810133636.8340-1-efremov@linux.com> <alpine.DEB.2.20.1808101541270.3390@hadrien> <CADKZ3FLsksV8-cCE6aOnZnLbYj3SSAkPnMs_VRQB3g0V3mUYcg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Aug 2018, Denis Efremov wrote:

> > Do you mean that there is an error in the behavior of coccicheck or that coccicheck finds an error in the source code?
>
> An error in the source code.
>
> Here is an example of how the patch changes the behavior of 'make
> coccicheck' (my comments after the ###):
> Current behavior:
> $ make M=mymodule coccicheck
> mymodule/file1.c:97:4-14: ERROR: Assignment of bool to non-0/1 constant
> mymodule/file2.c:104:4-19: ERROR: Assignment of bool to non-0/1 constant
> mymodule/file2.c:577:1-15: code aligned with following code on line 583
> mymodule/file3.c:439:5-10: Unneeded variable: "error". Return "0" on line 449
> mymodule/file4.c:451:5-7: Unneeded variable: "rc". Return "0" on line 455
> mymodule/file5.c:433:5-8: Unneeded variable: "ret". Return "0" on line 607
> mymodule/file6.c:433:5-10: Unneeded variable: "error". Return "0" on line 440
> mymodule/file7.c:774:2-3: Unneeded semicolon
> coccicheck failed     ### <-- Check failed

Are you sure that this coccicheck failed has any connection to the various
messages printed above it?  Normally Coccinelle has no idea about the
semantics of messages printed using python script code.  I'm not sure what
would cause it to return an error code because a particular script was
activated.

julia

> $ echo $?
> 0 ### <-- But error code signals that everthing is OK
>
> After this patch:
> $ make M=mymodule coccicheck
> ...
> coccicheck failed
> make: *** [Makefile:1636: coccicheck] Error 2
> $ echo $?
> 2 ### <-- The patch changes error code
>
> Why does this matter?
> 1) Because it's clear from the source code that the original intention
> was to return an error code of checking command, not the "echo
> 'coccicheck failed'" command.
> 2) Automated testing systems (CI, for example) rely on the return code.
>
