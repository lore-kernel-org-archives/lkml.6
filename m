Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD80AC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 19:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6395624CC0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 19:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6395624CC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeFWTsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 15:48:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:49567 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751744AbeFWTsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 15:48:03 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5NJlJnn007635;
        Sat, 23 Jun 2018 14:47:19 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id w5NJlHFu007628;
        Sat, 23 Jun 2018 14:47:17 -0500
Date:   Sat, 23 Jun 2018 14:47:16 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     christophe leroy <christophe.leroy@c-s.fr>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/xmon: =?utf-8?Q?avoid_?=
        =?utf-8?Q?warnings_about_variables_that_might_be_clobbered_by_=E2=80=98lo?=
        =?utf-8?B?bmdqbXDigJk=?=
Message-ID: <20180623194716.GY16221@gate.crashing.org>
References: <20180622192718.24242-1-malat@debian.org> <b41b244e-78b8-c85f-9122-427ad04cccf8@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b41b244e-78b8-c85f-9122-427ad04cccf8@c-s.fr>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 06:59:27PM +0200, christophe leroy wrote:
> 
> 
> Le 22/06/2018 à 21:27, Mathieu Malaterre a écrit :
> >Move initialization of variables after data definitions. This silence
> >warnings treated as error with W=1:
> >
> >   arch/powerpc/xmon/xmon.c:3389:14: error: variable ‘name’ might be 
> >   clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
> >   arch/powerpc/xmon/xmon.c:3100:22: error: variable ‘tsk’ might be 
> >   clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
> 
> Is that an invalid warning ?

No, both are correct warnings.  GCC can not see which functions it only
has a declaration of can call longjmp.

> Otherwise, I'd expect one to fix the warning, not just cheat on GCC.

Yes, the patch seems to change the code in such a way that some versions
of GCC will no longer warn.  Which does not make to code any more correct.

Either restructure the code, or make the var non-automatic, or make it
volatile.


Segher
