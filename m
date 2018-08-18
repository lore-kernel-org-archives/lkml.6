Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEA3C41535
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142DD2178F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2c2OawT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 142DD2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeHRQpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:45:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44215 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeHRQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:45:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id r1-v6so4753347pgp.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mg4bKJ9y3hUPHnx/G4RPJo2EaAH7H3YIh6UprbJFbho=;
        b=k2c2OawTBd+kbn08YX5NVwZwzvhVTHhXUnNkDh96yMh2v6AnntRQWp/DxZA8d+GjUZ
         xJnNfW9WxM6fhByJ+8Yi7GxvQKJEkUkyJBaXjuhepu3pl0P5scVpkkNqTc1oJYN/jZWf
         SnC+8EKo7gE61ICblVBi/bE0M5r4gAAj+VU/SY/+VDKcZWV4KvQybSklq3Tuu0jayVyM
         qP4a/vCYpYlMRyX9qWwfsH/rigfMTaRsNlCxGvwZ2k2NT3KY2ugrSbx/4ltJK5aoamLh
         Fa3C8o5OkM24TWBewPLcAHfNly4xFAupIeZiyR1kLe/vy+/T4jIpuPSrx/9DjjXheQDD
         IhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mg4bKJ9y3hUPHnx/G4RPJo2EaAH7H3YIh6UprbJFbho=;
        b=INUVGDKJQ84hPT+rIYOlj/gSDAeqN0wywT2TfzkUf/OD0HaFmrcFLDP9K0m/3mvWhw
         pmKJEdgdznoP1L23pDSWdlBRdAWkG/cM0Nbe2tB3kH4hQQrqXfmGDUmD/pGmzAMRafvp
         uHcJTjmJc6yt46qiYRvE8TgzmTMPKvx6jYKD36r158SzQxm76r+DWGaMvujYuF9mCVZG
         kQzLJJlTk+vcORqY6kh8MX3hJx8cRK+tdBUT+aI/EPWWCtRzbE/np1Yf+IuiIdqsCvFv
         Wneitk8msS4ngajN0CCI1jZq60hUdrwKMySS/3UsRkIsAu2UxQAKIWBRYEjMUGA8r+fw
         l8Ww==
X-Gm-Message-State: AOUpUlHUL1zweIHWhSD9++95ol31AVBO99IQM75QHyycVdhr4X8nPv8O
        mhg2JuIL9nIjGTA0pM68Lpk=
X-Google-Smtp-Source: AA+uWPyvAYgZUm8CMZV77f6qRJ03Rmard0+cY4jiFPDhlPl0BYPJ92LsjkOjANxVX7vuRe9AMaWMzA==
X-Received: by 2002:a62:89d8:: with SMTP id n85-v6mr40467172pfk.83.1534599481552;
        Sat, 18 Aug 2018 06:38:01 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 82-v6sm6653192pgd.20.2018.08.18.06.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Aug 2018 06:38:00 -0700 (PDT)
Date:   Sat, 18 Aug 2018 06:37:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V Updates for the 4.19 Merge Window
Message-ID: <20180818133759.GA20049@roeck-us.net>
References: <mhng-4afb9897-29ed-4eb4-88d7-6cfb09a0a65c@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-4afb9897-29ed-4eb4-88d7-6cfb09a0a65c@palmer-si-x1c4>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Fri, Aug 17, 2018 at 01:28:11PM -0700, Palmer Dabbelt wrote:
[ ... ]

> 
> This tag boots a Fedora root filesystem on QEMU's master branch for me,
> and before this morning's rebase (from 4.18-rc8 to 4.18) it booted on
> the HiFive Unleashed.
> 

Do you have vmlinux embedded in bbl ?

With separate bbl and vmlinux, and the following qemu command line 
(with qemu 3.0)

qemu-system-riscv64 -M virt -m 512M -no-reboot \
	-bios bbl -kernel vmlinux \
	-netdev user,id=net0 -device virtio-net-device,netdev=net0 \
	-device virtio-blk-device,drive=d0 \
	-drive file=rootfs.ext2,if=none,id=d0,format=raw \
	-append 'root=/dev/vda rw console=ttyS0,115200' \
	-nographic -monitor none

all I get is

rom: requested regions overlap (rom mrom.reset. free=0x000000000001cbe8, addr=0x0000000000001000)

However, the she system boots fine with the same qemu command line if I use qemu
built from https://github.com/riscv/riscv-qemu.git, branch qemu-for-upstream.

Excellent - once this series hits mainline, I'll add riscv to my
boot tests.

Thanks,
Guenter
