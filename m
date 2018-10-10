Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419F3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C762085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Rcm19+Fj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C762085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJKDCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 23:02:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38742 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeJKDCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 23:02:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id f29-v6so3138783pff.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=M2w2XblAESyeqU/73xyqGeI6nGSYi06KzgHwKcVbWtM=;
        b=Rcm19+Fj60SaHqTaNahXjW9wSZMxY1sakAoyABlN8pwsKv5ioTZuBvyoRWL9d89d4E
         j3E1c2nSoC9d1s6heB5OIBa9wJt/3WONheHatFI2+rx7nbgX9qW+Q9ELXig0FYDIiywQ
         kmjQBtvZHV/Sf/dVb8rdBKu9TE1WtNr3YofXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=M2w2XblAESyeqU/73xyqGeI6nGSYi06KzgHwKcVbWtM=;
        b=JVD2hFymncYpROJ7QonUJNfYdx8YOBZADgsm27FmuHuOlzuKM/FxtePe1sR4+qWneJ
         LxCopd3IZvYnfS7P4x7YOeUgkw1JBmNeBsT2L5eK6raYVWvz23FSXcea1uHLWteOffgN
         01hJlGOBH6ooKFlgN3EZTdxfpI1kQNd+fGyTaM16+LRaaVFzd21Z9CAGOgXGZOoOlcNj
         xUz0ITz0OFZvxVcnkz0XOBjkyho6MgvvlChUiB6GlaPvR5NOllLoI8tWdFCUhbPrMjfJ
         APdzGHYU1UJKuROu55FzFUqfy/8X4pwCqQTgHmrp3hR/KkgdlTJO1odae6cjlJBtft/z
         NxXQ==
X-Gm-Message-State: ABuFfoiqC/GnAykZjf+eMgF4poTHuiOAaAH3Z9x9gdVHv3crvdVToEIS
        4QITNOWPWNtvMazmOffGco2fT6cm90g=
X-Google-Smtp-Source: ACcGV60XtL5EIdm1fG7ZAVhN8TqMWMKogn9p45DR7NG/9cJ1qJv5eIKyamn+8hY5nyctRm+EBBLLTQ==
X-Received: by 2002:a63:f5a:: with SMTP id 26-v6mr30821974pgp.100.1539200336325;
        Wed, 10 Oct 2018 12:38:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id m10-v6sm24812308pgp.94.2018.10.10.12.38.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 12:38:55 -0700 (PDT)
Date:   Wed, 10 Oct 2018 12:38:54 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Kees Cook <keescook@chromium.org>
Subject: First coccinelle script, need some help.
Message-ID: <20181010193854.GA93016@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I am trying to determine if a function argument is used across the whole
kernel for a certain kernel function.

I mustered up enough courage to write my first coccinelle script after a few
late nights of reading up about it :)

Here is .cocci script. I am trying to find if address is used at all in any
possible definitions of pte_alloc():

$ cat ~/pte_alloc.cocci
virtual report

@pte_args depends on report@
identifier E1, E2;
type T1, T2;
position p;
@@

 pte_alloc@p(T1 E1, T2 E2)
 {
...
(
...
 E2
...
)
...
 }

@script:python depends on report@
p << pte_args.p;
@@
coccilib.report.print_report(p[0], "WARNING: found definition of
apte_alloc_one with address used in the body")

The above warning does fire on the following test.c program:

struct page *pte_alloc(struct mm_struct *mm, unsigned long address)
{
        address++;
         if (condition()) {
                return NULL;
        }
}

But, *not* if I move 'address' into the if block:

struct page *pte_alloc(struct mm_struct *mm, unsigned long address)
{
         if (condition()) {
              address++;
              return NULL;
        }
}

I could not understand why, In my view the "address" expression should be
matched across the function body even within if blocks. But if I move
"address" into the if block, then the match doesn't occur any longer.

My coccicheck command is as follow:
make coccicheck COCCI=~/pte_alloc.cocci MODE=report  M=test/test.c

What am I missing? Thanks for any help.

thanks,

 - Joel

