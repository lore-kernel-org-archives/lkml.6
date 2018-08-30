Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CB4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6ED5205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:21:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="nHATwWfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6ED5205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeH3SXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:23:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42772 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeH3SXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:23:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id l9-v6so3947492pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 07:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aoI080CPwhG85LE9Qm2J4k1qy/1a3lX8PRxHMzS4nbk=;
        b=nHATwWfw/AiyL2CnW5bDmFmRTrii71U1fQKjMz7fE8oFuSP9tiWP5qBoMXKq0TMvsB
         h7sntVkV/Hf+29Vh5CaeKMZ0Kv56b2LGSJZj/JtnMTLFTOE/Zb6b5dJuJJ9L1Gvwh6+A
         /ZxlJAV/niyChNT8kYCMgLKVXdO2nL5r++/cyFcOkvC35gzdx2Pvh1akGRdYjZVACmlv
         o9kexAbrsUIMLAjZE63vJyiJGz25TT47m32AN3Vdzc+wEEWSk/66c0sehO9udSuCkNXZ
         Zzn2itwIUes+1Lt5iE7M1luGohtjZdBwTLzWZ5SYxCSHhK1ADNl2DOic2mu+xJjAUPR3
         za6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aoI080CPwhG85LE9Qm2J4k1qy/1a3lX8PRxHMzS4nbk=;
        b=rb/E8dpjdJ0x+wHF8+YJuxQ/TcZUJgtk2kz6+7/MS2EK7ToDMhEyK71TvjdqwER6nF
         10mSUg6Sa6lfO66bHMcB288guMErBNX/llR2ylqsV1tbpWgvXorJfRbPmNNcPX1b20Y1
         9e15nsoe2NhbDS93ZJ6fj/Y1C90XlfvkdaZIrYRF5tbU1O9dwKjxQlRilBfoE/tWUwPf
         Xp2CRNi5xrETdAj3693nOdDERKnb+mvooFqEGUbiM9a7Ymw1SyaE1SlbJfscGHqp9J2r
         YxANuHOHI0t/ZpUuzai0P/1jSqmyGKtjuI5EARhntZOMYJu1MmZ3sUloa4zSROj3PQGl
         k0Mw==
X-Gm-Message-State: APzg51BWdDZOf8ZqxguzrFeHtubceLWqVLkowyK8rhHlIKLKqHKwNNFU
        wxYdSBp74vUc6As54YEeVBC3ig==
X-Google-Smtp-Source: ANB0VdabjOePh2ZO8rdf+0TaBvcdi3cOGxoVD3M6oxJTybIpAtyFYIbcO60XxhZt3s+UdZPhI6QRhQ==
X-Received: by 2002:a62:8a4f:: with SMTP id y76-v6mr10687469pfd.233.1535638881142;
        Thu, 30 Aug 2018 07:21:21 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:95da:ae9a:fa1d:9655? ([2601:646:c200:7429:95da:ae9a:fa1d:9655])
        by smtp.gmail.com with ESMTPSA id p26-v6sm14255643pfi.183.2018.08.30.07.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 07:21:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] x86/nmi: Fix some races in NMI uaccess
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <alpine.DEB.2.21.1808301535110.1210@nanos.tec.linutronix.de>
Date:   Thu, 30 Aug 2018 07:21:18 -0700
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Rik van Riel <riel@surriel.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A71C1AF9-5C7D-4A04-84CB-4C5FE6D0DA58@amacapital.net>
References: <dd956eba16646fd0b15c3c0741269dfd84452dac.1535557289.git.luto@kernel.org> <7202F39D-B4C2-4FA0-868E-2D03BD313BD7@gmail.com> <alpine.DEB.2.21.1808301535110.1210@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 30, 2018, at 6:36 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Wed, 29 Aug 2018, Nadav Amit wrote:
>> at 8:47 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>>> In NMI context, we might be in the middle of context switching or in
>>> the middle of switch_mm_irqs_off().  In either case, CR3 might not
>>> match current->mm, which could cause copy_from_user_nmi() and
>>> friends to read the wrong memory.
>>>=20
>>> Fix it by adding a new nmi_uaccess_okay() helper and checking it in
>>> copy_from_user_nmi() and in __copy_from_user_nmi()'s callers.
>>>=20
>>> Cc: stable@vger.kernel.org
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Nadav Amit <nadav.amit@gmail.com>
>>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>>> ---
>>>=20
>>> Nadav, this is intended for your series.  Want to add it right
>>> before the use_temporary_mm() stuff?
>>=20
>> Sure. Thanks! I will apply the following small fix:
>>=20
>>> +
>>> +#ifdef CONFIG_DEBUG_VM
>>> +    WARN_ON_ONCE(!loaded_mm);
>>> +#endif
>>=20
>> Will be changed to VM_WARN_ON_ONCE() in the two instances.
>=20
> Unless I'm completely lost, this can just be applied to tip right
> away. It's not depending on anything else.
>=20

Fine with me. Do you want to do the VM_WARN_ON cleanup yourself or should I s=
end a v3?=
