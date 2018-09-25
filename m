Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A37EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EDD208D9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 06:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EDD208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbeIYMGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 08:06:39 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36730 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeIYMGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 08:06:39 -0400
Received: by mail-qk1-f193.google.com with SMTP id a85-v6so898869qkg.3;
        Mon, 24 Sep 2018 23:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9QdH8jLYEpenqSyesUgI+vFc1hrjooKs4UPjXvQb/Rs=;
        b=uPP4gK0aXQBCmW0PKtHJXZD+0e7U19J7aKexXZ7T/n7snnDZ2PNwYCwt898u/lYweM
         69TePN7z80jUDOuME88zE56NhjCRKUnJQmdhZKhqPvQlaAQAj/Qv4AgC8bEZkiu6LH2K
         ljrWpJ6HL2mqnbLvByWRhRa1Jw+VFt5tFkQzlDvI7Rg2IbJfoKTlQiK58cb4aCuS0IQE
         Deumzx2LbOrO/g75e8/Nz4RqlEPBYK8E55iWk9gL+vPFLQZT0vpRLs1cvDXjwrixUqvs
         JQVhAD60SHlQVXNw8gb8eqM4S5LBnOp3V34azLqfqYffG5AJliMnU6JLRQ4bJtxaDH+D
         ui6g==
X-Gm-Message-State: ABuFfogmSPI5b2MGq1NScoQKjrjZPkSN+l9dIiFdbUEzQFDk2sTKa8ln
        lkd7kIgUA/IZDnbrEdRP+6EAUmFPzakT0fiewBQ=
X-Google-Smtp-Source: ACcGV60ocXbeZUJBviKcEm6tRvPMvk8YfGmcqF0qfT5T/IvbcgpUuRG7rZYZ5GZ2YRw5vgAd7so/AHYgSc0QTuKjqcE=
X-Received: by 2002:a37:7347:: with SMTP id o68-v6mr1481384qkc.291.1537855244889;
 Mon, 24 Sep 2018 23:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
 <1536913980-4811-3-git-send-email-firoz.khan@linaro.org> <CAK8P3a1PCnHy1JX4T21LjOr3ZGAVLdqxQaPYfLHAgM-9Y5yxVg@mail.gmail.com>
 <CALxhOngVYQRwbcUg6c_3LcKAEoBwyN1B478LqRGmWEGL004--w@mail.gmail.com>
 <CAK8P3a2hi-Ndh7X-9r3NhBUJXQBTBFsTU==GbHesy6YD9idCJA@mail.gmail.com> <87efdi5rm6.fsf@concordia.ellerman.id.au>
In-Reply-To: <87efdi5rm6.fsf@concordia.ellerman.id.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 25 Sep 2018 08:00:28 +0200
Message-ID: <CAK8P3a2=kxoum6hcPR2UN_St2PaFtZud_NNVkK9rHaf=N7ym-g@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: Add system call table generation support
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Firoz Khan <firoz.khan@linaro.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxram@us.ibm.com,
        leitao@debian.org, Boqun Feng <boqun.feng@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 2:48 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Tue, Sep 18, 2018 at 2:15 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> >> On 14 September 2018 at 15:31, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Fri, Sep 14, 2018 at 10:33 AM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > But all three existing architectures (x86, s390 and arm) already
> > have the capability to parse the table and generate different output
> > from that.
>
> Yeah, we want that on powerpc too.
>
> If the script needs to be more complex that's fine, if it can't be
> shared across arches that's fine, the main thing for me is that wiring
> up a syscall can be done by adding a single line in a single file.

Yes, that's definitely the idea, we want to make it easier for everyone.
We need at least a special case for mips, which needs three separate
input files (the tables are completely different) to generate four versions
of the output, plus a future extension to use the generic table for their
new one.

For powerpc, I'm hoping that both the table format and script can be
completely generic and not need a special case that is different
from the others, but if we need some extra magic to handle the SPU
syscalls, we can still do that with a private script.

      Arnd
