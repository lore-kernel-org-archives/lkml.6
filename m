Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2D7C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AF4206C2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 19:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544901592;
	bh=Q6If0fzuh1FsppF79amQJ0hLATN4nmV2rTG0e9yTBto=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=VTLv49q+nxgpEljwnXEh+MmeR78ZKaXXLqPZxYbir6duLiVhet9R5P31YdtQWsRBi
	 fDDdqAb2bZvtgN2sBZ8mnSZOTAGuN1Q7UcD5sNOnJsMtOW0fjdNM/WNJ7OS9NsEVXZ
	 02Pj0jIGaInPkBlFNF/hPj2X4DWg27ZQKXO+Q4ww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeLOTTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 14:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:34306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbeLOTTu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 14:19:50 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96C292171F
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 19:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544901589;
        bh=Q6If0fzuh1FsppF79amQJ0hLATN4nmV2rTG0e9yTBto=;
        h=From:Date:Subject:To:Cc:From;
        b=TT/Jkib/iOJ6rtsNz2eA5W2hDOj4VqllhhTJ+FMDIPcAxwDI4rWDNR6vhzqOwqBBu
         ytcOIfQJ3HUt09CNCgf6C3EakB92PBfr3D7JnpDyzMMSR9FQwpgEgJ9aW/2ayukIL/
         hHXXhGwD7RjfYm552sA1/70UpqwcHgHJqMwyGi0I=
Received: by mail-wr1-f49.google.com with SMTP id t27so8502145wra.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 11:19:49 -0800 (PST)
X-Gm-Message-State: AA+aEWak4KKNWdDr/wW/Ibs89DW0YhBMimCeKLrbmQ4UmOGgkBz+SWlL
        AKpQW17NJEoRAIXKTRb10Za3tDsUJxIHx9OLrxMe4g==
X-Google-Smtp-Source: AFSGD/W9HWZko51ZEMakf4O8v0Mwidf8uPqnD6kPziB6v9HQcPkdkInBVez2W2GdDdrkvNPN60zZ9QiyOYuuuVbScXY=
X-Received: by 2002:a5d:550f:: with SMTP id b15mr6458410wrv.330.1544901588089;
 Sat, 15 Dec 2018 11:19:48 -0800 (PST)
MIME-Version: 1.0
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 15 Dec 2018 11:19:37 -0800
X-Gmail-Original-Message-ID: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
Message-ID: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
Subject: Fixing MIPS delay slot emulation weakness?
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all-

Some security researchers pointed out that writing to the delay slot
emulation page is a great exploit technique on MIPS.  It was
introduced in:

commit 432c6bacbd0c16ec210c43da411ccc3855c4c010
Author: Paul Burton <paul.burton@imgtec.com>
Date:   Fri Jul 8 11:06:19 2016 +0100

    MIPS: Use per-mm page to execute branch delay slot instructions

With my vDSO hat on, I hereby offer a couple of straightforward
suggestions for fixing it.  The offending code is:

        base = mmap_region(NULL, STACK_TOP, PAGE_SIZE,
                           VM_READ|VM_WRITE|VM_EXEC|
                           VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
                           0, NULL);

VM_WRITE | VM_EXEC is a big no-no, especially at a fixed address.

The really simple but possibly suboptimal fix is to get rid of
VM_WRITE and to use get_user_pages(..., FOLL_FORCE) to write to it.

A possibly nicer way to accomplish more or less the same thing would
be to allocate the area with _install_special_mapping() and arrange to
keep a reference to the struct page around.

The really nice but less compatible fix would be to let processes or
even the whole system opt out by promising not to put anything in FPU
branch delay slots, of course.

--Andy
