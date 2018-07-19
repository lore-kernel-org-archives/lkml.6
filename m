Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A47ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261DD206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 19:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOAA6XHB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261DD206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeGSUWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 16:22:51 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41216 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbeGSUWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 16:22:51 -0400
Received: by mail-oi0-f67.google.com with SMTP id k12-v6so17108434oiw.8;
        Thu, 19 Jul 2018 12:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qSekyBwr620PydII7U6nFO3hw4c1LuMTujqB1SKxuHU=;
        b=LOAA6XHB8ybH+luaw9He+mCl0jus7RHvQZYu8rcmUZeu6WxHW/QYEu10GBcLVFzczR
         Kg4UJxXBfO/ymwxYy4NcdnJ7M1Oww8EvSuqjN+CqBbmSXlvUH45wJtE9IqKbylw00QF5
         uppC5kARV0YU7USeLsQ7QkBFURjOxoOU2YgONgcR1K5RvaXSuiZ0710+5LTy8hjTk1SJ
         4XYyIT7P1vdnBwfJv8fH/pdXFIwguEDRdIwusBxqui5A2EzP4PkOn2+r8fsqKRVq7flS
         iIjXrKjEhtNHDOcVWOfVYFOj4e4swPl43GQBhWKmWImfTIuHxpEt0cudJT97lCDd+/I5
         Zt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qSekyBwr620PydII7U6nFO3hw4c1LuMTujqB1SKxuHU=;
        b=HaepwYYZol/xju1Q9Kw2g2sJinKQfVqT6VPQM4813Da1v8IsM7ne347Qg5whOmbsHA
         8wQ0FwCNYAwGU8hgEBfhi+5Gk4qPe/9d0lc8SbwY4GWciJpjduVFtaYUL8L0IfRetWq/
         yZ7PZMupcYHBNvbnJR1vp804PQM/rBLaxDXgIMPdY4V7M6IQVv1V6+ZIwiBY4LY31qIb
         eaTpmawSUHrytzOI60OIgvOFlcbzFSnZ7v2vfsBo02FuFslmDDcfIDUn3PYkaO3lL5UV
         LaX9eweF9p7QBHq/aHup3MbL22c+vyxfLXD+gl9ZijqAKaYc8cl3OnYY8SlbSBZtBxrN
         lOgA==
X-Gm-Message-State: AOUpUlEQ3HVTzoc24/wulatW281bYEu/p6/gXni31adjrGSBrIf8NT0M
        nY7fUgDgWa1vFpXHJ/uE7de4UesYzncrAG4UPxk=
X-Google-Smtp-Source: AAOMgpcfS1K4U5zvZ8Y+1Ypf/bqfJQFaN4sUNrfUqBJdIrIhpPEqpyE8/JxJuImBest48o76hKTDkrGdwjjVA1CsQDg=
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr13448913oif.71.1532029096499;
 Thu, 19 Jul 2018 12:38:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Thu, 19 Jul 2018 12:38:16
 -0700 (PDT)
In-Reply-To: <CAHQ1cqE7m6WO1t3YggrMrApFV2m2Y2G4NPDMcb6Ry9zQHC8xqw@mail.gmail.com>
References: <20180719005941.10458-1-andrew.smirnov@gmail.com>
 <CAOMZO5D1rKH+_wuJrhD6Cr4psQwnk7CHVWm6qi0Jv7vnTiazUQ@mail.gmail.com> <CAHQ1cqE7m6WO1t3YggrMrApFV2m2Y2G4NPDMcb6Ry9zQHC8xqw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 19 Jul 2018 16:38:16 -0300
Message-ID: <CAOMZO5AVLxoP7Xevkx2ri_hQXDFy-9cagU9kuwHWKmORgQhCDg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610: Add ZII CFU1 board
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Thu, Jul 19, 2018 at 4:07 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> I foolishly assumed building it with W=2 would reveal W=1 level
> problems as well, but apparently not. Will fix in v2. Same problems

You can also use W=12
