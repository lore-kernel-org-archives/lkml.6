Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C130C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583B42082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ZZVrDpHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583B42082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbeLGSpS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:45:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35945 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeLGSpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:45:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so2351425pfc.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=klopY/IsuJEDowTc4qrt4dyez0fGpBDt1xs5/j2mVbY=;
        b=ZZVrDpHfZs52iuETgv3m44IeOtThlIBsuU8+93Vxx7aBcyIR3CfRT2lS31h8wJewmV
         Tki/oz/jT6A7N4MGx481OP3Ps6TfITealhGoP+JTLC5p3O6m82JGXuTjm4MWJPiDDJCd
         9EM9eqL6VYHHdGU1Bbtl+2lYmINTz3fkchPJj6pBGjTeh2ZntnCGYTTqejWBvjffftmA
         toRKjgdsx+CHfywJWPgM5ghK05Brr0Nyal9TZfyhadDDwN7cBZzDrkwfdK203vs0gGwr
         AjaKi368ZuHFSEclC49QQ0orgjY0eyXcBcs8mUkDr49hFKBs8OxYP3kz6S111fXbWDUC
         Z4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=klopY/IsuJEDowTc4qrt4dyez0fGpBDt1xs5/j2mVbY=;
        b=ntkXjX78qIDxl11ufUxsB1G1KEv5CauOKa+HUnbmJMUqmiZX9dahw3bSbWRnKbtLFH
         M9LCyAOFCIDVCxddZ/FkSH/G7IvydH5e9yISBwf3YjQPHUbNuAXpFfx2D8A0mFbmMKa0
         01WpHwnNoG0+W3AVDg+5A0xmWGBAUzZqmofkqYU+nv882BJAkhsg4LYP6Zt6d+aXNxtK
         VLef4z12hdFV25gSyBE82U9v7rugeILri+ra3MCkBEvJesD8tLKB1nPHG5V1Q8YGpSUN
         Qw+JyrWGUMcU9H69GfnoiHe1aaBMciXe31cIBYxlWl7Jursyjq8nZ5owegUyUBzH+ls3
         /kwQ==
X-Gm-Message-State: AA+aEWYyX/yEe9wxaAJeihBToM7GJ6ghmJ8HWoHirxUs4ph6BL7v65jB
        vsqFciIRVx9MHGh9WegRWQw3BA==
X-Google-Smtp-Source: AFSGD/XwDgPF73po7jcMK0WLUnbQk9jaegnMO7Qp7EVNMCgsiulHRkkPkb3v6ey4N4xdmNlmrKTYkg==
X-Received: by 2002:a63:f515:: with SMTP id w21mr2938694pgh.220.1544208313756;
        Fri, 07 Dec 2018 10:45:13 -0800 (PST)
Received: from localhost ([216.3.10.7])
        by smtp.gmail.com with ESMTPSA id y89sm6257168pfa.136.2018.12.07.10.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 10:45:13 -0800 (PST)
Date:   Fri, 07 Dec 2018 10:45:13 -0800 (PST)
X-Google-Original-Date: Fri, 07 Dec 2018 10:44:39 PST (-0800)
Subject:     Re: [PATCH RFC 4/7] riscv/vdso: don't clear PG_reserved
In-Reply-To: <20181205122851.5891-5-david@redhat.com>
CC:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-mediatek@lists.infradead.org, david@redhat.com,
        aou@eecs.berkeley.edu, tklauser@distanz.ch,
        akpm@linux-foundation.org, mhocko@kernel.org, willy@infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     david@redhat.com
Message-ID: <mhng-3e6b4869-d5d7-42f4-a9d8-789a6772f52a@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Dec 2018 04:28:48 PST (-0800), david@redhat.com wrote:
> The VDSO is part of the kernel image and therefore the struct pages are
> marked as reserved during boot.
>
> As we install a special mapping, the actual struct pages will never be
> exposed to MM via the page tables. We can therefore leave the pages
> marked as reserved.
>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/riscv/kernel/vdso.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
> index 582cb153eb24..0cd044122234 100644
> --- a/arch/riscv/kernel/vdso.c
> +++ b/arch/riscv/kernel/vdso.c
> @@ -54,7 +54,6 @@ static int __init vdso_init(void)
>  		struct page *pg;
>
>  		pg = virt_to_page(vdso_start + (i << PAGE_SHIFT));
> -		ClearPageReserved(pg);
>  		vdso_pagelist[i] = pg;
>  	}
>  	vdso_pagelist[i] = virt_to_page(vdso_data);

I'm going to assume this will go in through another tree along with the rest of 
the set assuming everyone else is happy with it.

Acked-by: Palmer Dabbelt <palmer@sifive.com>

Thanks!
