Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292A0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F4720661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrUH9t4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F4720661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeIDUtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:49:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47024 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDUtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:49:32 -0400
Received: by mail-lj1-f193.google.com with SMTP id 203-v6so3640206ljj.13;
        Tue, 04 Sep 2018 09:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvR5dF2cprh81dBnvRxuQCUTqlXG24YRLE+hhHW8EYo=;
        b=mrUH9t4JrNot8ZpUi1UD9nIyFbWd5jgZci9KKYz5KD4P+DH+OnJ8sbqckKDS9KSs8K
         BVQ1kQQdOrQIWuk5NQeQDgz/ZYTG9p1k79+hPYf3K7quB3Cr/3mbKkeweM5J/63SSy10
         RN6UC3HLF1WrN4hOzfm3MRJb1xoONfz6tGlaWMQ0Udz9vQk9dchU6SDV5xFGwwxRfTCA
         LWZi4gr4AkH4Egl/690a+wUY8UzxgTDujypllnxLcrJE/9wCS8FagTSRCq/DfFFJvNPJ
         DjqQRP1YD9YQLtBV/XiGSuLta1Ejh8VfBSWEeJjzKiOY8i5KStaa54+It4t9OlQodoE7
         jxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvR5dF2cprh81dBnvRxuQCUTqlXG24YRLE+hhHW8EYo=;
        b=gav1IS71k0p8utjZJuGt9r7lbIgcC+vo1CQQAAw14eXxWdiA4ZoODn5fgOlZmEWAkv
         h4rDD8GFF+yDlpel2UIPp/nWpS9LLfCFrvmSEeV1DufjC8m8iBjVKit1tNTGR/Pz+jtH
         AgmhQQ2BGd8r6+ojEFpqyXoUACQMPPzpv9IUs6IAjnXxkkIxzu+ME1eN1furD3vPdgUo
         bTJIvEQo2t1UDSeGRZnbtiufyl5vcGyn9zQ2wCNFBAs6r6CNl3xJ26kQx7e1oAUSxYe9
         tBGZ8EYE9TGLtkplWemKL2I6nncFGq4OXquoB7c+S5X8F4ZEM2uz12XfOy3kvxPeiTku
         SaBg==
X-Gm-Message-State: APzg51DIKh9x9QjTTZpShqNSHbZ53Nb1ef/MWbeHDOj3LDP7R21RkpDn
        jLBmNqstAdZChmP+LypE5g==
X-Google-Smtp-Source: ANB0Vdbhkn5WsV6xTUfP+bCYjB4kXWk+/710g9tAV4hNiAa901J/SMMeCy+DB1VuzF8uONcuuCTORQ==
X-Received: by 2002:a2e:9c82:: with SMTP id x2-v6mr15515836lji.131.1536078220591;
        Tue, 04 Sep 2018 09:23:40 -0700 (PDT)
Received: from tenshi.local (rin.nnov.ru. [95.79.31.27])
        by smtp.gmail.com with ESMTPSA id i22-v6sm4236625lfh.2.2018.09.04.09.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 09:23:39 -0700 (PDT)
Date:   Tue, 4 Sep 2018 19:23:38 +0300
From:   Aleksei Mamlin <mamlinav@gmail.com>
To:     Jes Sorensen <jes.sorensen@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtl8xxxu: Add rtl8188ctv support
Message-Id: <20180904192338.e9be91d4be447e33acefed5a@gmail.com>
In-Reply-To: <53022e37-e9dc-1cf8-ec3c-4df668f3c045@gmail.com>
References: <20180830140541.31964-1-mamlinav@gmail.com>
        <20180904081619.7353B606AC@smtp.codeaurora.org>
        <53022e37-e9dc-1cf8-ec3c-4df668f3c045@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018 11:36:50 -0400
Jes Sorensen <jes.sorensen@gmail.com> wrote:

> On 09/04/2018 04:16 AM, Kalle Valo wrote:
> > Aleksei Mamlin <mamlinav@gmail.com> wrote:
> > 
> >> The Realtek rtl8188ctv (0x0bda:0x018a) is a highly integrated single-chip
> >> WLAN USB2.0 network interface controller.
> >>
> >> Currently rtl8188ctv is supported by rtlwifi driver.
> >> It is similar to the rtl8188cus(0x0bda:0x818a) and uses the same config.
> >>
> >> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> > 
> > Patch applied to wireless-drivers-next.git, thanks.
> > 
> > 514502c3a70b rtl8xxxu: Add rtl8188ctv support
> 
> Looks good to me too - assume it's been tested?
> 

Yes, tested on my ARM tablet. It successfully connected to my home router
using wpa_supplicant. There is dmesg output:

[   16.887902] usb 2-1: This Realtek USB WiFi dongle (0x0bda:0x018a) is untested!
[   16.887916] usb 2-1: Please report results to Jes.Sorensen@gmail.com
[   17.133053] usb 2-1: Vendor: Realtek
[   17.133066] usb 2-1: Product: 802.11n WLAN Adapter
[   17.133076] usb 2-1: rtl8192cu_parse_efuse: dumping efuse (0x80 bytes):
[   17.133084] usb 2-1: 00: 29 81 00 a4 cd 00 20 00
[   17.133090] usb 2-1: 08: ff 00 da 0b 8a 01 03 41
[   17.133096] usb 2-1: 10: 32 00 85 62 9e ad 00 b3
[   17.133102] usb 2-1: 18: 10 00 00 3a 0a 03 52 65
[   17.133108] usb 2-1: 20: 61 6c 74 65 6b 00 16 03
[   17.133114] usb 2-1: 28: 38 30 32 2e 31 31 6e 20
[   17.133120] usb 2-1: 30: 57 4c 41 4e 20 41 64 61
[   17.133125] usb 2-1: 38: 70 74 65 72 00 00 00 00
[   17.133131] usb 2-1: 40: 00 00 00 00 00 00 00 00
[   17.133137] usb 2-1: 48: 00 00 00 00 00 00 00 00
[   17.133143] usb 2-1: 50: 81 00 00 00 00 00 00 00
[   17.133149] usb 2-1: 58: 06 00 2b 2b 2c 00 00 00
[   17.133154] usb 2-1: 60: 27 27 28 00 00 00 00 00
[   17.133160] usb 2-1: 68: 00 02 02 04 04 04 05 00
[   17.133166] usb 2-1: 70: 00 00 00 00 00 0a 00 00
[   17.133172] usb 2-1: 78: 10 00 00 10 36 00 81 00
[   17.133183] usb 2-1: RTL8188CU rev B (TSMC) 1T1R, TX queues 2, WiFi=1, BT=0, GPS=0, HI PA=0
[   17.133191] usb 2-1: RTL8188CU MAC: 00:b3:10:00:00:3a
[   17.133199] usb 2-1: rtl8xxxu: Loading firmware rtlwifi/rtl8192cufw_TMSC.bin
[   17.139167] usb 2-1: Firmware revision 80.0 (signature 0x88c1)

>
> Thanks,
> Jes


-- 
Thanks and regards,
Aleksei Mamlin
