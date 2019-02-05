Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323E5C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0904320844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfBEKEH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:04:07 -0500
Received: from ozlabs.org ([203.11.71.1]:59119 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfBEKEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:04:07 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43v0Xj1NPfz9sMl;
        Tue,  5 Feb 2019 21:04:05 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: drop page_is_ram() and walk_system_ram_range()
In-Reply-To: <248f8aa2-10c2-2728-6f94-a56816a989e1@c-s.fr>
References: <a14aac5408f98cf8ad8723ffa874764ccb42d4d4.1548978750.git.christophe.leroy@c-s.fr> <875ztzonqd.fsf@concordia.ellerman.id.au> <248f8aa2-10c2-2728-6f94-a56816a989e1@c-s.fr>
Date:   Tue, 05 Feb 2019 21:04:03 +1100
Message-ID: <87tvhimu0c.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 04/02/2019 à 11:24, Michael Ellerman a écrit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> 
>>> Since commit c40dd2f76644 ("powerpc: Add System RAM to /proc/iomem")
>>> it is possible to use the generic walk_system_ram_range() and
>>> the generic page_is_ram().
>>>
>>> To enable the use of walk_system_ram_range() by the IBM EHEA
>>> ethernet driver, the generic function has to be exported.
>> 
>> I'm not sure if we have a policy on that, but I suspect we'd rather not
>> add a new export on all arches unless we need to. Especially seeing as
>> the only user is the EHEA code which is heavily in maintenance mode.
>
> If you take the exemple of function walk_iomem_res_desc(), that's 
> similar. It is only used by x86 it seems and exported for nvdimm/e820 
> driver only.
>
> See commit d76401ade0bb6ab0a7 ("libnvdimm, e820: Register all pmem 
> resources")

OK. Which begs the question whether we need both exported. It looks like
you could probably use walk_iomem_res_desc() with the right flags to do
the same thing as walk_system_ram_range().

>> I'll put the export in powerpc code and make sure that builds.
>
> I thought there was a rule that EXPORT_SYMBOL has to immediately follow 
> the function it exports. At least checkpatch checks for that.

Yeah that is a rule. But rules are made to be broken :)

I'll merge it for now with the export in powerpc code, if we want to we
can do a separate patch to move that export into generic code and get
acks for that.

cheers
