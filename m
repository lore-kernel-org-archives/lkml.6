Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7699BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E06217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550520084;
	bh=SY1oZD5j8Ks5oRzz60AjJRDBFiyfj5CrU3rcYVcKNK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KowG8I8Ev8Sdw65NpV5gWqqkfr12zLWjN32KumaOiFdWeKaboqlxWFg/abvcqmYqF
	 OVB6Ml7tsGyW95UeUgLuaRZDE7/tydAb7k5ZPRc0/M4Ex9lqpM7UdIwUBMlXQqdtbW
	 kdu8H/8OTOBJMZmL/8F24il62ATx2wQ4EOO3N/BI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfBRUBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:01:23 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45652 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfBRUBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:01:22 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so30248316ota.12;
        Mon, 18 Feb 2019 12:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y3fBCzVJ+IFAl2IKW///XvVmMSodPHdurOmaqMNQlQw=;
        b=TnfAMKoVorOccoWH9NthStNMbDMNZGuDbhNTPgaPcYBRXqFhcqKa4WdiaVpT4cGIhv
         nOsWQvVY9aDBPQZ812/fk+W5HM1vB8a3blW2MfrZFh3UkpjeEEZKLvulUIK9Xa6NQO4z
         UyeyW1fAgOPDvmgKNnKi3nkVSVDg4huaxYPTMc/z7iFq93wLI5bDVcmtrfvi/G52ElDB
         miJbbARCYIBJtK70TqyTDUBGgHE12vJMGTotMgHuIQOEOphCyAw7TBsJdx9rUP6gcyBq
         TzF8TXLom31/ckuFDcYeSEZ+tOcMVpApKo50dQkNKXPKaEfP2/C57+YctRhJ3gXHh0IF
         4cjQ==
X-Gm-Message-State: AHQUAuaRZtty2Zc/njd6h/8a9jJMUa7S9u8TpaZKvXNGOqk3F21UeVBP
        eVRBmXtcfJGJ8CJKXbXLzg==
X-Google-Smtp-Source: AHgI3IY1ToZXEDJTkjotJ6MF47OA0T72HTuLMZuH0FXGF+bENDzzOp3azBkgtpg04QWcHYfiaufiHA==
X-Received: by 2002:aca:4cc3:: with SMTP id z186mr323944oia.90.1550520081033;
        Mon, 18 Feb 2019 12:01:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 88sm2901580otx.57.2019.02.18.12.01.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:01:20 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:01:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        devicetree@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 08/10] mtd: rawnand: denali: decouple controller and
 NAND chips
Message-ID: <20190218200119.GA27213@bogus>
References: <1549955582-30346-1-git-send-email-yamada.masahiro@socionext.com>
 <1549955582-30346-9-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549955582-30346-9-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 04:13:00PM +0900, Masahiro Yamada wrote:
> Currently, this driver sticks to the legacy NAND model because it was
> upstreamed before commit 2d472aba15ff ("mtd: nand: document the NAND
> controller/NAND chip DT representation"). However, relying on the
> dummy_controller is already deprecated.
> 
> Switch over to the new controller/chip representation.
> 
> The struct denali_nand_info has been split into denali_controller
> and denali_chip, to contain the controller data, per-chip data,
> respectively.
> 
> One problem is, this commit changes the DT binding. So, as always,
> the backward compatibility must be taken into consideration.
> 
> In the new binding, the controller node expects
> 
>   #address-cells = <1>;
>   #size-cells = <0>;
> 
> ... since the child nodes represent NAND chips.
> 
> In the old binding, the controller node may have subnodes, but they
> are MTD partitions.
> 
> The denali_dt_is_legacy_binding() exploits it to distinguish old/new
> platforms.
> 
> Going forward, the old binding is only allowed for existing DT files.
> I updated the binding document.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2: None
> 
>  .../devicetree/bindings/mtd/denali-nand.txt        |  39 +-

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/mtd/nand/raw/denali.c                      | 453 ++++++++++++---------
>  drivers/mtd/nand/raw/denali.h                      | 117 +++++-
>  drivers/mtd/nand/raw/denali_dt.c                   |  98 ++++-
>  drivers/mtd/nand/raw/denali_pci.c                  |  30 +-
>  5 files changed, 500 insertions(+), 237 deletions(-)
