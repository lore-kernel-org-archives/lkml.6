Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B56C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7239E2089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HU71PMl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7239E2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbeJBVqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:46:40 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:36841 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727970AbeJBVqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:46:39 -0400
Received: by mail-pl1-f171.google.com with SMTP id p5-v6so1840477plk.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=d2CF0k82WvxlhQY1DrC5bSUsm2VCZF/3wkDQIrTo6sQ=;
        b=HU71PMl3Wri9ctt6+i3RPVSSh3glZ2Cm6Pvwchek4UgHdFe5kIjVVa6uVECKNSuwnN
         rWFx1/rhovlA3d9tXQrIrO92iwa7/UnYjrlmLqT09kLXnOkJY2lYH4rGj8reOyYCHlyU
         XZcSlLW9zjZCsP+woxXTzEOdkprY2nOEC8tQmh+hp/285HQcU1Isa3pcQRmfZqDFlRqQ
         HYZGSBDjWexLRJFQ+6kqIr4ApKD1OnEJLonPOEeTxImcOxJOaalRgY5+PkTxHURgOPQc
         1HkEKzumbMyrO6xbLDV135H2q+i2xwgTeie5zT4y/TY9b8szvqWRW+4MxdpXcqLhR+fu
         yF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=d2CF0k82WvxlhQY1DrC5bSUsm2VCZF/3wkDQIrTo6sQ=;
        b=Pye/gPRwgX06ySifQH2cBkyH2H6dJqPaBxsMJ4Mix6KEpZpyf+dd22tMVcYKqhCZlp
         TmStG3C6KrA/LN4VJ9K+TVPpO2gFooIK0KWZYKqS5O9OnjXVh4PKMmA8ESfHQDsCjxHl
         48BUeMxWzawrDtePO7qq93gQ1N+8GxwJiBdIOCu+9UFsKdm4/6zNDz58fW0jMhS8MgR2
         pEeidP4cDzuVx6iBIxOShHFxiGjdX8aiWUNgu2lrr0RZ66W1MTh+v6/hMqMkRqoRf9hx
         BRVoHVO8PHpDnSFkoXVKuUOnW//GOspOyr5k4Ywq0OYIj0leJkLrtL50ylevtCPSlLTL
         vbRg==
X-Gm-Message-State: ABuFfoirDfseZ1dW384NxmkLWTMGoSh0xbqi96smmzHbrBlJfGaSO3Dg
        jdZa5s4c3Z2CbXBP3SDAsba8Hg==
X-Google-Smtp-Source: ACcGV62EwD4y3SBd8pwUOyD33jtOAiS4o1ikoySfClbcM6K097toJJ2gI6ii95BlqwDJpEP74IFhUw==
X-Received: by 2002:a17:902:784a:: with SMTP id e10-v6mr17044577pln.197.1538492569681;
        Tue, 02 Oct 2018 08:02:49 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id p24-v6sm20376372pgm.70.2018.10.02.08.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 08:02:48 -0700 (PDT)
Date:   Tue, 02 Oct 2018 08:02:48 -0700 (PDT)
X-Google-Original-Date: Tue, 02 Oct 2018 08:01:58 PDT (-0700)
Subject:     Re: [PATCH v3 3/5] lib: Add umoddi3 and udivmoddi4 of GCC library routines
In-Reply-To: <20181002145041.GC3889@infradead.org>
CC:     zongbox@gmail.com, aou@eecs.berkeley.edu,
        Christoph Hellwig <hch@infradead.org>, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-2b0c98e6-298b-4fc4-842c-809002de3451@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Oct 2018 07:50:41 PDT (-0700), Christoph Hellwig wrote:
>> The udivmoddi4 and umoddi3 are copies from libgcc in gcc. There are other
>> functions use the udivmoddi4 in libgcc, so I separate the umoddi3 and
>> udivmoddi4 for flexible extension in the future.
>
> Can you please mention which exact version of an external projected
> you imported things from?  That will generally help if/when someone
> has to dig into diverging versions.
>
>> +++ b/lib/udivmoddi4.c
>> @@ -0,0 +1,310 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +/*
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see the file COPYING, or write
>> + * to the Free Software Foundation, Inc.
>> + */
>
> The SPDX tag was supposed to replace this boiler plate.  On the other
> hand I'm surpriced there is no Copyright statement here - the FSF is
> usually very good about having them uptodate in every GNU project.

I suggested he import the gcc-4.2.1 version, which has a big copyright notice

    /* More subroutines needed by GCC output code on some machines.  */
    /* Compile this one with gcc.  */
    /* Copyright (C) 1989, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999,
       2000, 2001, 2002, 2003, 2004, 2005  Free Software Foundation, Inc.
    
    This file is part of GCC.
    
    GCC is free software; you can redistribute it and/or modify it under
    the terms of the GNU General Public License as published by the Free
    Software Foundation; either version 2, or (at your option) any later
    version.
    
    In addition to the permissions in the GNU General Public License, the
    Free Software Foundation gives you unlimited permission to link the
    compiled version of this file into combinations with other programs,
    and to distribute those combinations without any restriction coming
    from the use of this file.  (The General Public License restrictions
    do apply in other respects; for example, they cover modification of
    the file, and distribution when not linked into a combine
    executable.)
    
    GCC is distributed in the hope that it will be useful, but WITHOUT ANY
    WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.
    
    You should have received a copy of the GNU General Public License
    along with GCC; see the file COPYING.  If not, write to the Free
    Software Foundation, 51 Franklin Street, Fifth Floor, Boston, MA
    02110-1301, USA.  */

so it looks like something went wrong here.  Zong: did you go back and 
re-construct this function from the GPLv2 source?
