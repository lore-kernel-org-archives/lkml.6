Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A37C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 515E32073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qvkryEsd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515E32073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeH3SCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbeH3SCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:02:20 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 593C420837;
        Thu, 30 Aug 2018 14:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535637604;
        bh=1xt5Oju/LA5eT/tMsK8FqwU2jENVEt36up7ILXM8nPk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qvkryEsdNtPq19SmNk6AKoHyAgdTa4uvWWXRykK2XvTXgN+jJ1+Y0IcbnO0IDcGEl
         YKgjz3M/Th1Jx4D+POGpgBG2d1LCF0kn3g2ZTRyfF+UHd7vMoQ/eiMEZlAyQPNr4tl
         r0Zk0r4ri61iyXwZjqsgHvQRXGCn2Kjcow820LxI=
Received: by mail-wr1-f53.google.com with SMTP id k5-v6so8164984wre.10;
        Thu, 30 Aug 2018 07:00:04 -0700 (PDT)
X-Gm-Message-State: APzg51Acbq1RZLfZI5z5vjyvSeVWwhNyD4aVf9met+BY3yv0bqHBipVu
        ZWUHC4jNUHhrfQNRdjpFicN8nXZazV4mURQ3VhY=
X-Google-Smtp-Source: ANB0VdZ1bF4qYb64dtb8iYRWHo1blv1g6UJ1crBv+4Gh1ehjUn/euiVrK9ZXQKHqFJOvoJxoJM+nEN7qzaF4KJ+OS+Y=
X-Received: by 2002:adf:b726:: with SMTP id l38-v6mr7344507wre.115.1535637602886;
 Thu, 30 Aug 2018 07:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJKOXPfVXnazraHq-NCCM+h26FFi1U6Z3OSYOX17XH3bj-UDLQ@mail.gmail.com>
 <3053033.se6UkFii4W@tauon.chronox.de> <CGME20180830130922epcas1p35b0395da64de59107a805c6b99d770c2@epcas1p3.samsung.com>
 <CAJKOXPd7JdzM2_PiHkS1ix1yU9hZmMbGDZaL07vbON0XzORH=w@mail.gmail.com> <20180830132732eucas1p12b941ed065276c0cbed6e7b1e01a30dc~PrH1zJtnY2603926039eucas1p1b@eucas1p1.samsung.com>
In-Reply-To: <20180830132732eucas1p12b941ed065276c0cbed6e7b1e01a30dc~PrH1zJtnY2603926039eucas1p1b@eucas1p1.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 30 Aug 2018 15:59:51 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfNjHRXVic=ycJ3yek-1ufL7v8MkUM9ZBhyOnj0SEaHSw@mail.gmail.com>
Message-ID: <CAJKOXPfNjHRXVic=ycJ3yek-1ufL7v8MkUM9ZBhyOnj0SEaHSw@mail.gmail.com>
Subject: Re: Locking for HW crypto accelerators
To:     k.konieczny@partner.samsung.com
Cc:     smueller@chronox.de, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2018 at 15:27, Kamil Konieczny
<k.konieczny@partner.samsung.com> wrote:
>
> On 30.08.2018 15:09, Krzysztof Kozlowski wrote:
> > [...]
> > Thanks Stephan for hints. Let's assume the each of init, update and
> > final are atomic... but how about the relation between update and
> > final? I have two concurrent users in user-space but only one HW:
> >
> > Process A:             Process B:
> > init() and set_key()
> >                        init() and different key
> > update(some_data)
> >                        update(different_data)
> > final()
> >                        final()
> >
> > The final() from process A will now produce the result of hashing/CRC
> > of some_data and different_data (and even maybe mixed with init() for
> > different key). All because in the meantime process B added its own
> > data to the HW.
> >
> > Best regards,
> > Krzysztof
> Can your hardware do export/import ?
>
> If yes, you can use workqueue and guard HW with spinlock,
> as in exynos hash in s5p-sss.c (or see other drivers).

Yes, workqueue doing all necessary HW initialization would be the
solution here as well. The point is what later Herbert wrote - I need
to take care about the HW state because the requests even for shash
will be coming in random order.

Best regards,
Krzysztof
