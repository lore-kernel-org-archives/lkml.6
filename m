Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFD6C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BFC2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvLkx6iN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BFC2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeILCt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:49:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbeILCt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:49:56 -0400
Received: from gmail.com (unknown [104.132.51.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A2F62086A;
        Tue, 11 Sep 2018 21:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536702519;
        bh=Ko0OEgkZDVzV75bhiJSv3C2IuMSO9y6/iuD0iBBk63g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PvLkx6iN1KX5gKbh1Kk0s2SM+Mc2D4TDuhkUCu4IjCbUMSRDNTEQ/lsKjL1u5f9gb
         t9MIIhG8Pd6WVchBP9wm2WMKElTF7WZwjjd8uNfASBXXOxYf6nwRrh98d+TflgxKNN
         uO23okcR19ZYK/jjU/YY6dtFWgap2AELzs5QL0UI=
Date:   Tue, 11 Sep 2018 14:48:38 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Samuel Neves <sneves@dei.uc.pt>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>, mingo@redhat.com,
        X86 ML <x86@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH net-next v3 05/17] zinc: ChaCha20 x86_64 implementation
Message-ID: <20180911214837.GB81235@gmail.com>
References: <20180911010838.8818-1-Jason@zx2c4.com>
 <20180911010838.8818-6-Jason@zx2c4.com>
 <alpine.DEB.2.21.1809111021250.5110@nanos.tec.linutronix.de>
 <CAEX_ruFFWsW897DuFEbz9+6av02bMwDgiA9GxV+=SBtyKG7LJw@mail.gmail.com>
 <alpine.DEB.2.21.1809111106420.5110@nanos.tec.linutronix.de>
 <CAHmME9qPk7iOVspOJOhN0M+C=v+i6GNq9XkDnXXJ=puoFV0Gfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qPk7iOVspOJOhN0M+C=v+i6GNq9XkDnXXJ=puoFV0Gfg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 03:12:14PM -0600, Jason A. Donenfeld wrote:
> Hey Thomas,
> 
> On Tue, Sep 11, 2018 at 3:09 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > This is covered on the 02/17 commit message, whose relevant paragraph follows:
> > Well, being only cc'ed on only half of the patches does not really help.
> 
> Sorry about that. I'm happy to Cc you on the whole series for next
> round if you want. Just let me know. In the meantime:
> 
> https://patchwork.ozlabs.org/project/netdev/list/?series=65056
> https://lore.kernel.org/lkml/20180911010838.8818-1-Jason@zx2c4.com/T/
> 
> Regards,
> Jason

Please Cc linux-crypto on the whole patch series, including the cover letter.

- Eric
