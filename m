Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB05ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E124A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNet+nMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E124A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbeGQUxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:53:35 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33493 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbeGQUxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:53:35 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so2098147ljj.0;
        Tue, 17 Jul 2018 13:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0EOkkrjdokhjjplL6VmY1cMUFbw5PzevGLVnA1Ec94c=;
        b=nNet+nMy9jRtlvsD7a0c/e+SdOP09JT4j7rsbhrxoN9FCSfXKJNSH3KPt+Im2BsJLl
         pGgWvbHE420tej8oMK1OutpMEQ2or2Vq/iGo3PuGAQBSkAUiy4ISRlRRS/6/a5sDsILs
         pBXp8cNAUfweh6Lu7hFFLiniLvYETAr/tTqbUXvtBhUjFviTfZQK9MUagpkSSTFpCinl
         FWOOvYs3Yn7FVuNmlQFOKk3lkFWUqz88I8VmjmldegG4mGq0hHELyDdUU0TTMU7Mk40e
         0Lx8EYhu9nktFz7zkHbZj10pVmE8IN3d7RI6Id6PD6o5jqAEeflPHADuYTtSWsBYqDzm
         vD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0EOkkrjdokhjjplL6VmY1cMUFbw5PzevGLVnA1Ec94c=;
        b=PeHRHqFyuKylqhX/YqRYxk2Ms0YxyH0zj+w+hRoudI64WAb2JN71TxH7RseShKeOlL
         v+5ryw7So+wSmvptKDR72ICiKc1+ukilYuoLpZHZZ0fqYGmp3Kg4/V/+oQsMuVIHc15q
         3g3WggcroM/9LssIiwcVYTsNB40WyVcL8yppC3//iCNEzS+gHKynM2Wup8HdKUFn4/2k
         YHeauKLah4iCAYIKcT04i2veQbXnCsC1otJcSCAwtQQF6PG0+J5KAccNbhMYT7wCLYHF
         PpKh4g1XxCnH34k6nMn27n6pe5ntJp053DedxGBSmX6EPKl82uJslKm7Bug/pmueQiNe
         BhOg==
X-Gm-Message-State: AOUpUlF0H/1iSwyPJ4rhlR8K6SM92DvB9juwDREu2/ObOa2Wu+Oxz/QK
        7WzqnTXzpMmAmgcgTAGrf8k=
X-Google-Smtp-Source: AAOMgpff28qOhqX29Mp2cw/nzZYbDFdRmQ3gbrz202mF9Eyhn1SS7HE+xTkfCk6LWKZKwmR3aLRBzA==
X-Received: by 2002:a2e:2f19:: with SMTP id v25-v6mr2373311ljv.113.1531858756563;
        Tue, 17 Jul 2018 13:19:16 -0700 (PDT)
Received: from z50.localnet (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id f22-v6sm274656lfh.27.2018.07.17.13.19.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 13:19:15 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3] mtd: rawnand: ams-delta: use GPIO lookup table
Date:   Tue, 17 Jul 2018 22:20:00 +0200
Message-ID: <1706255.htvcsQMCeE@z50>
In-Reply-To: <20180717213736.3cd0a747@bbrezillon>
References: <20180525222046.11200-1-jmkrzyszt@gmail.com> <20180709193850.20191-1-jmkrzyszt@gmail.com> <20180717213736.3cd0a747@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Tuesday, July 17, 2018 9:37:36 PM CEST Boris Brezillon wrote:
> ...
> Sorry, but we can't apply this patch now because of the dependency on
> those 2 commits. I guess it's not a big issue if we defer it to 4.20.
> Alternatively, we could consider queuing it to mtd/fixes after 4.19-rc1
> is out, but we'll need a good reason to do that (like a regression
> that this patch is supposed to fix). Note for your future contributions:
> for this kind of cross-subsystem changes, it's better to let everything
> go through a single tree (usually done by sending all patches in a
> single series and explaining the dependencies between the patches in
> the cover letter),

Good advice, Sine I have in my queue a patch for OMAP that depends on this 
one, and still another one with the same dependency issues, I'll take the path 
you suggest and resend those three as a series to be merged via OMAP.

Thanks,
Janusz



