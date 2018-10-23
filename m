Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A162C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BBA20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 09:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WzhNYuho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BBA20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbeJWRrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:47:33 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:41271 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJWRrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:47:33 -0400
Received: by mail-lj1-f170.google.com with SMTP id u21-v6so662573lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ISFsbrVIlOGOELJ62+NBkKgPGroYGp92vujbYXOckWI=;
        b=WzhNYuhoRrS+hX1mdTUzO2XnL4fGfsNxyCYDskZWSMAsl6pQ/DcPa33YS6aJU2AfPm
         pINChOyq6bSsSO64e6Zy2NHV0OCbOOmCKTiw8hcCvdBQdVHaZo+JXc1KQ1W6wcNH+1Um
         UFhpgwEALtCeSokj+e+usF/jz/J4XLlJ4jJFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ISFsbrVIlOGOELJ62+NBkKgPGroYGp92vujbYXOckWI=;
        b=DMhql6tuZS4ntZNzO/J30Fo4UQa40re3m5hPVVYl1DYGMR/zf4MCWuaq+woOdgG2Cu
         Uhals+A5gm7NlTB7tCUKmglb6Rqpw2Jqr17apFzWG1hyZKoAQsIiq++AqhA+xtLPqLWf
         NU9e/xnghOH3i+rLYvQoO0W6/PHRoJIpB4a0o5CRU2y7S0MttwoejAiKx5IOEPHAnV0k
         HbSocW//oIi8Z570bxiU6LdGcfuIA8WyeDMV/yj6IULVpS25py8yK0uyLPaDsZWYbW6O
         EPQ0qBqbgGXdI7Pio7rdXGSeVLkQR52CTgFzUfkzhFFwlS17go3F9UCcQDpdBPlfxAwk
         LgIw==
X-Gm-Message-State: ABuFfohSktP1L6FTxugpHkmvLENEUE04pCTrF6BtExeBLVC1gW03yBuj
        76BPpRBuadPrPb4lFrBo5ilhwWq2pfFBm9+u
X-Google-Smtp-Source: ACcGV61ZFS+S4WYxnfOUqOWxTmUz+OKuXdrxe3qhZhuxua/FDLsrDJLZ3vKz9vuSvpgCHBpl4zLYtA==
X-Received: by 2002:a2e:9e88:: with SMTP id f8-v6mr31528657ljk.142.1540286697595;
        Tue, 23 Oct 2018 02:24:57 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id x141-v6sm130022lff.32.2018.10.23.02.24.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 02:24:56 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id c24-v6so545745lfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 02:24:56 -0700 (PDT)
X-Received: by 2002:a19:1cc3:: with SMTP id c186-v6mr11044345lfc.16.1540286696177;
 Tue, 23 Oct 2018 02:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181022143915.GA387@light.dominikbrodowski.net>
In-Reply-To: <20181022143915.GA387@light.dominikbrodowski.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 23 Oct 2018 10:24:40 +0100
X-Gmail-Original-Message-ID: <CAHk-=whdTOFurCd7rCjOA5dsvmXY2z57mbP=1dNPXetF46kpVQ@mail.gmail.com>
Message-ID: <CAHk-=whdTOFurCd7rCjOA5dsvmXY2z57mbP=1dNPXetF46kpVQ@mail.gmail.com>
Subject: Re: [GIT PULL] pcmcia odd fixes for v4.20-rc1
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 3:39 PM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> These are just a few odd fixes and improvements to the PCMCIA core
> and to a few PCMCIA device drivers.

Pulled,

             Linus
