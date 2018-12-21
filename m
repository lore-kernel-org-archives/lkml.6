Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC24C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1253621928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SYRvioeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391586AbeLUTNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:13:44 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:33413 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391554AbeLUTNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:13:43 -0500
Received: by mail-it1-f196.google.com with SMTP id m8so16407207itk.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=j2oAUt4jyL6e37+Xbe+JP//F9OOKtUzFXnNxZVSuIEc=;
        b=SYRvioeCOHSqQdroUeSCNlhNj23L9EU68HxCBxen2jDNlUPLHe9EtjIq6tY28LtLV8
         ars/vw3fVO4E9ptp/OI+8FDblbD0xp8FSyCl17fjZZBsCgqu8JhAPG87p6eN7VYfWHZ8
         Fhe6C2hliVZmo7Pic8WvvkUb56vhRPcwR9XKeAxentdRATB6SbmhkuT5T9rqLOmqpIz4
         HLRjwxMwWENJrkJhlUsT7dXlvKQ1pdhKZV/beBFuLt2bnHdta3A6UP7CaExVq+HoXJKv
         ctHUFUjgvQEnpIm+o+IIgaUaMoFhY2jWxU/ENJWEk/muEHfWPsw9IhiLb+YjuqGW4kHO
         dXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=j2oAUt4jyL6e37+Xbe+JP//F9OOKtUzFXnNxZVSuIEc=;
        b=qbAuER25G+9OHb9aeam5lETHInoNfJ9i+kK5DxnJxZLvu7kEIIBbAk4+WRS1bbJ4hi
         WZmkwtyfaoxtJBZTGL/COyp2NPMVuybaQWv7QSqFpdzBHKjfy9CJjylGshgNX7TxAAS8
         qt34ty6D0a/C2xxC6lgtbg0POYzOeu+yw73ep3dBrVdUviOqixJjYG0GwpsqKzVVqfS1
         M15GjQOj3Yn/byDmLYyIXYcQeu7wYmgEo6/2Azq8NGSNQh2H5Ciy4nzsyMzNf2AOIATE
         FdfNGlSNnie4n/oqjFRbBHuvXgtgxaY1/u09OMsFJtz/OQ7g7Rj0wb+SLLase7yXutdi
         bY9w==
X-Gm-Message-State: AA+aEWZQdeXEkcWDnqi1ak9QYL/ojmfJ9sqgccfempQcecpMMrKq+gQQ
        vHOYLM8liDOJxJ7C/xLaPFWB9Q==
X-Google-Smtp-Source: AFSGD/XOUbC+fklxz9aFaTEUJi7KXttkYU9LHbXJgdEi9NwNREdsCnB5BHM5zK45C328S8rmWMYV3Q==
X-Received: by 2002:a24:41aa:: with SMTP id b42mr2677320itd.148.1545419622477;
        Fri, 21 Dec 2018 11:13:42 -0800 (PST)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id g186sm6420614ite.39.2018.12.21.11.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 11:13:41 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-Google-Original-From: Paul Walmsley <paulw@sifive.com>
Date:   Fri, 21 Dec 2018 11:13:41 -0800 (PST)
To:     Alistair Francis <Alistair.Francis@wdc.com>
cc:     "Palmpalmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: defconfig: Enable Generic PCIE by default
In-Reply-To: <20181221190615.19003-1-alistair.francis@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1812211110260.777@viisi.sifive.com>
References: <20181221190615.19003-1-alistair.francis@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alistair,

On Fri, 21 Dec 2018, Alistair Francis wrote:

> Enable generic PCIe by default in the RISC-V defconfig, this allows us
> to use QEMU's PCIe support out of the box. Also remove the Xilinx PCIe
> support by default as this is rarely used and conflicts with the more
> commonly used (out of tree) MicroSemi PCIe root complex.

There are many folks working on FPGAs who use the Xilinx driver.

Also, we should not remove support for an in-tree driver because an 
out-of-tree driver conflicts.  The right approach is to get the 
out-of-tree driver upstream.

Enabling general support for PCIe in the defconfig should be fine, though.


- Paul

