Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552B5C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9D720825
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G9WNBz1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9D720825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390115AbeKQDF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:05:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39048 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbeKQDF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:05:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id c72so6984835pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=kpBoHgmOhN3LkMqkGpPGOvm/Fnxa3FRWSSY+xh/aFy4=;
        b=G9WNBz1VWb2+bpSH7A2MRusy3Khc031pTt2+5QbO+SInYhQfcM7XusBbXbdQF57Kep
         jUiSCn71t6bBhRX9kLvmJbMLmGoY0XJ04XngwZbkEG6zD58HDnp6PTAixynyknWKz9Pz
         zYAGq3AoNxs90CJAvTV1t7Z5qFa7FQnXfgHkTSumk5aJ0wH+r8oWHkl7myu8RrdM2M0U
         26vTp1RMqTo7J4HiHijGD0BjPA9r9rFvzEJziYxoGeP5NJJDB9vM+Guq3Iasw6GN7xxV
         +XgaUcd09IIPfz8lwevJ8JLaFA8BypVIkxUof3itA0EtslFfh79wH+0vdwNGhYPg8pHS
         vnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=kpBoHgmOhN3LkMqkGpPGOvm/Fnxa3FRWSSY+xh/aFy4=;
        b=iBTwTLiy9+TxrRzuuN4gRDuPOpLUQlpTmGSTRVH+hWFZXPyrehyGaIKNdFW41G3/Z0
         gcq//0gJGQVSsoGcswa4MFiDIa4Qj3Cgr4of2HTUYS2o8Qkg5/G6BnEN1tKXRkKrSD+M
         09jVkpbM3Qc6Tj5MlWPoWmjbQa5Ey1ycHk3KcGBJ3WSOKOdZPV4t+K07hrxwoAOTPMq2
         xEBonLrOeiKbDIa+P0RIvrTQ5rh9vS9pUUqD6trigD3HDCOyIGDZD4VfTBfbLgk3Tmx0
         fmA++ncnTUTrsYZXr2eAqthFVcrSAiFHXr/aAzWXk3cOxs5n5KPgFqerypYqJinWQljz
         KJgA==
X-Gm-Message-State: AGRZ1gKGfdwx+yarqjtEcYN5g87ZtbqtbYNRWl5uIeMGAxGgb8NJl6nj
        l0tziN3dmLKnGIggoXEDjoiCxg==
X-Google-Smtp-Source: AJdET5dUt6eKgbrD04wNFfmJgzRAcUchuJFFblOU/G4XJkm6D34n//w+0lNyCYgfHM2dqnkV47+pLw==
X-Received: by 2002:a63:e615:: with SMTP id g21mr10841155pgh.290.1542387137227;
        Fri, 16 Nov 2018 08:52:17 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z83-v6sm37608428pfi.4.2018.11.16.08.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:52:16 -0800 (PST)
Date:   Fri, 16 Nov 2018 08:52:16 -0800 (PST)
X-Google-Original-Date: Fri, 16 Nov 2018 07:01:12 PST (-0800)
Subject:     Re: [PATCH v2] RISC-V: recognize S/U mode bits in print_isa
In-Reply-To: <20181109214217.27494-1-me@packi.ch>
CC:     linux-riscv@lists.infradead.org, me@packi.ch,
        aou@eecs.berkeley.edu, atish.patra@wdc.com, anup@brainfault.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     me@packi.ch
Message-ID: <mhng-e9ecd06a-7b9c-4b0f-af31-2c4c3b64c1a5@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Nov 2018 13:42:16 PST (-0800), me@packi.ch wrote:
> Removes the warning about an unsupported ISA when reading /proc/cpuinfo
> on QEMU. The "S" extension is not being returned as it is not accessible
> from userspace.
>
> Signed-off-by: Patrick Stählin <me@packi.ch>
> ---
>  arch/riscv/kernel/cpu.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 3a5a2ee31547..b4a7d4427fbb 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -64,7 +64,7 @@ int riscv_of_processor_hartid(struct device_node *node)
>
>  static void print_isa(struct seq_file *f, const char *orig_isa)
>  {
> -	static const char *ext = "mafdc";
> +	static const char *ext = "mafdcsu";
>  	const char *isa = orig_isa;
>  	const char *e;
>
> @@ -88,11 +88,14 @@ static void print_isa(struct seq_file *f, const char *orig_isa)
>  	/*
>  	 * Check the rest of the ISA string for valid extensions, printing those
>  	 * we find.  RISC-V ISA strings define an order, so we only print the
> -	 * extension bits when they're in order.
> +	 * extension bits when they're in order. Hide the supervisor (S)
> +	 * extension from userspace as it's not accessible from there.
>  	 */
>  	for (e = ext; *e != '\0'; ++e) {
>  		if (isa[0] == e[0]) {
> -			seq_write(f, isa, 1);
> +			if (isa[0] != 's')
> +				seq_write(f, isa, 1);
> +
>  			isa++;
>  		}
>  	}

This looks good to me.  I'll target it for the RCs, as it's fairly small and 
that warning fires too often.

Thanks!
