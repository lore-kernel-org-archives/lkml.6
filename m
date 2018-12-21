Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C91CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF5C21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TUrGM0Lm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbeLUWeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:34:18 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44371 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbeLUWeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:34:18 -0500
Received: by mail-io1-f68.google.com with SMTP id r200so4877320iod.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 14:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dapPdIq4NKdTh83FqnhWp0jd26+pQIFL0Exxw5JzCR8=;
        b=TUrGM0LmrTxQhfbOcdK3KDEG5tlXmracmSOB4bf5C5gLT14ebG7o2mIPBBjxSO8KTE
         ZHGpdMoGkz4pMmHrQXjSuzOSS9EMJ3YdRGo8jMXjnlV+U6j1zoq7oDay5sn1zEaxv0dZ
         SeV+XXjQlyrr6kSCMVtJpV26mLO6+fQ7OwTqc0b51oPMRrG3NcAq/san+Vk29m3AjqSw
         5oG6EBU8FHK9Uil2bGk17J60tm6bcZcHFnuyziQ8EntwFOZWoiopkXqSgplygaGViNTI
         LKIOZglDl3hiSz8OiJLP7057iRGtneqm5RR1mEn0whL87zOHwXd/Nk1NQih0Pn0C1Mlk
         fdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dapPdIq4NKdTh83FqnhWp0jd26+pQIFL0Exxw5JzCR8=;
        b=in8DNTGZsYr7oJZ4NIQEIF9XiV2hEY0PTNECd8yQmzpjj/7Elj36G9hTm9kSScvb16
         +Bbi+MLOAQBS0cc58ntYZipB9c/OTdiyrBss19SwdZpBBWyjOakHVBOrLxMqNJkYzFi+
         FE4H8J7k8W5Gfw9lp41J1kv2z0C28XbFzufzXFgkvKl8Mdvke669GnMbF6Le80a/umwp
         vh6T4NT6/1HjVCcj/NEwqOBQUFlP7olXBLSXcFDbnNHK1Nn7WJNS30A/dlMiELZ8nsBe
         L1Vqo0lCAZDnBSGlsa/b+6SmcuQ/Bl2Ll3euKA0hI5A/JBeOBGIjswgH9MsvXRPSlgh9
         EJzA==
X-Gm-Message-State: AJcUukd0eIAaD2XSPcpG84DKoHA+ecl/9Vkk0kll5kOqurYVzOIgeHav
        hm8DSryVbPzJYqjvQllLG7auOg==
X-Google-Smtp-Source: ALg8bN5INRrfwIN7FYvGklwMugKzphGmDxv32z6zCKDkr9zI9EirpQLrlby0YwCSYEzfJ/yYPjXt/Q==
X-Received: by 2002:a6b:b443:: with SMTP id d64mr2954767iof.227.1545431657200;
        Fri, 21 Dec 2018 14:34:17 -0800 (PST)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id c21sm10987266iob.22.2018.12.21.14.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 14:34:16 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Fri, 21 Dec 2018 14:34:15 -0800 (PST)
To:     Alistair Francis <Alistair.Francis@wdc.com>
cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: defconfig: Enable Generic PCIE by default
In-Reply-To: <c51c125f40a12a3afdd8272bbbf0670673a15349.camel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1812211433290.777@viisi.sifive.com>
References: <20181221190615.19003-1-alistair.francis@wdc.com>  <alpine.DEB.2.21.9999.1812211110260.777@viisi.sifive.com>  <541e8b85bc2d3010741daadddc71ada52b847b8f.camel@wdc.com>  <alpine.DEB.2.21.9999.1812211124180.777@viisi.sifive.com>
 <c51c125f40a12a3afdd8272bbbf0670673a15349.camel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Dec 2018, Alistair Francis wrote:

> On Fri, 2018-12-21 at 11:27 -0800, Paul Walmsley wrote:
> > On Fri, 21 Dec 2018, Alistair Francis wrote:
> > 
> > > When the MicroSemi driver does eventually go upstream this will
> > > probably have to be discussed though as either the config or device
> > > tree will need to be edited to ensure only one PCIe device is
> > > present.
> > 
> > The right way to do that is to have two separate DT files: one for the 
> > HiFive-U board alone; the other for the HiFive-U plus the expansion 
> > board combo.  There shouldn't be any problems with keeping both 
> > drivers enabled in the defconfig.
> 
> Agreed, the only problem is that the device tree comes from the boards
> firmware at the moment.

The switchover is in progress:

https://lore.kernel.org/linux-riscv/41dac7a1-3f66-6a3f-8a68-206688e5bd9e@sifive.com/T/#t


- Paul

