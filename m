Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CEAC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708FB208A3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 03:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czxLcv0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 708FB208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeLDDET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 22:04:19 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36971 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbeLDDES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 22:04:18 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so12613735edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 19:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LNhoGL7zfHN5svR/eFzG5x54keR65ytgnMiMjw6zLBA=;
        b=czxLcv0ErRJlrciRkth8Sf35Knb+3wDFic7TmablL6s8vexE0BpzTsYaezHYWsBGSb
         UPskY1sjMjLTINcHq8GVT3bfpdwurlDKwEB+XNRGiYmAjsTdmFFUfe4u4IPnMlQXRm8M
         KKBqpdWjO4FMWhImDn7JTCoRmpuIkh+bzNbrxQxXayEzZkqMKmhGJCUzBNx+Ez/UYV1P
         Xh3Uh/GxNqwPA6vwnrf1GUz5ILV6rBhxoG2OCtVwv8JP00wuj5zft9dqKt4WmECWoYrF
         7Qhcs+CccI9/xn+UKIYdCqiERvGIl+DBC26szUSGC+RnETMIiLqOOR+w85GzlGFwgMgF
         F0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LNhoGL7zfHN5svR/eFzG5x54keR65ytgnMiMjw6zLBA=;
        b=BWDNpjpkNWLPqQwIRmAA7iSp7s/lTKmOQtq4HfPvb+dUUCy7M6byeNYfAnBq5gTMjR
         Cv0v9edb6NSrmGM4wqwOjZoxf3LnccXB2Rv0tJvO831++E7u2V0li/ZZAGAu+XL3Cc+f
         3V35VBh+hYNUzlcsQnbZErGj0FrQsvhPdx5wRfdszvWfxnoKvOFViF4MgZJ7FQ1L5iU3
         hfZgLYSpyXMMXiauFop8c5Wgo3slui5REzZF7R5A5oxAUOrZbV8x79ruSpOkgUFkv3H+
         E38YF3u4aVzcdho+gupulOQJ20i0tB9K1xXSSlEps2+OjR9gAhRBdorL+SxawxM7IbNp
         49mw==
X-Gm-Message-State: AA+aEWb7q4bW94DhHx/8T2njiMKHm3GTqy/1au3uy+rqtkEAz+3rnJOm
        LyEsEyfKlZhIkoauZ6qb65Y=
X-Google-Smtp-Source: AFSGD/V8hy9clne/czaZA8bUIQ3Jqd21YV0uDbexNxk98zus9eRpLzXIX2HDfTRl5VdCylfO6ZvPBg==
X-Received: by 2002:a50:b205:: with SMTP id o5mr16079907edd.245.1543892657191;
        Mon, 03 Dec 2018 19:04:17 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id i46sm261927eda.37.2018.12.03.19.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 19:04:16 -0800 (PST)
Date:   Tue, 4 Dec 2018 03:04:15 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Yueyi Li <liyueyi@live.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] memblock: Anonotate memblock_is_reserved() with
 __init_memblock.
Message-ID: <20181204030415.zpcvbzh5gxz5hxc6@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <BLUPR13MB02893411BF12EACB61888E80DFAE0@BLUPR13MB0289.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BLUPR13MB02893411BF12EACB61888E80DFAE0@BLUPR13MB0289.namprd13.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 04:00:08AM +0000, Yueyi Li wrote:
>Found warning:
>
>WARNING: EXPORT symbol "gsi_write_channel_scratch" [vmlinux] version generation failed, symbol will not be versioned.
>WARNING: vmlinux.o(.text+0x1e0a0): Section mismatch in reference from the function valid_phys_addr_range() to the function .init.text:memblock_is_reserved()
>The function valid_phys_addr_range() references
>the function __init memblock_is_reserved().
>This is often because valid_phys_addr_range lacks a __init
>annotation or the annotation of memblock_is_reserved is wrong.
>
>Use __init_memblock instead of __init.

Not familiar with this error, the change looks good to me while have
some questions.

1. I don't see valid_phys_addr_range() reference memblock_is_reserved().
   This is in which file or arch?
2. In case a function reference memblock_is_reserved(), should it has
   the annotation of __init_memblock too? Or just __init is ok? If my
   understanding is correct, annotation __init is ok. Well, I don't see
   valid_phys_addr_range() has an annotation.
3. The only valid_phys_addr_range() reference some memblock function is
   the one in arch/arm64/mm/mmap.c. Do we suppose to add an annotation to
   this?

>
>Signed-off-by: liyueyi <liyueyi@live.com>
>---
>
> Changes v2: correct typo in 'warning'.
>
> mm/memblock.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/mm/memblock.c b/mm/memblock.c
>index 9a2d5ae..81ae63c 100644
>--- a/mm/memblock.c
>+++ b/mm/memblock.c
>@@ -1727,7 +1727,7 @@ static int __init_memblock memblock_search(struct memblock_type *type, phys_addr
> 	return -1;
> }
> 
>-bool __init memblock_is_reserved(phys_addr_t addr)
>+bool __init_memblock memblock_is_reserved(phys_addr_t addr)
> {
> 	return memblock_search(&memblock.reserved, addr) != -1;
> }
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me
