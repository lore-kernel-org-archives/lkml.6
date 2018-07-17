Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAE0ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3382E20BED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 00:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HO87daZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3382E20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeGQBUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 21:20:02 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38607 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbeGQBUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 21:20:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id t2-v6so16718022edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 17:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id;
        bh=M1ylQ2h6nt5cB5CdLkcoQhEX7ylNyRSBzL+F5Mo/yeE=;
        b=HO87daZhGkKKK/Qdlf30//cpHln5xjbMSqflS/HxRp4ZlGug2btjOQTqV9+DltLwd8
         Umg+ri9Gk4JAdAmdFox8Rn00VvEH4hn0EUUiUKTK+cdXOEOxzd8hoBVrnBDxuFN02dTt
         DjssaLFaOEEbn9f1gvidIteOcHjxNFg3PzjqgC01y8g8xaKZrbPaihc84yxs3flMpDlX
         pYbRxX/rWtS9MTwnbchhqaQhefq6YUuGAdenHS680WPEv+JRpphzvgPncbBLfKyvr7Yd
         lBHTtMEtCU/S5/XdoQL1CFrMkzVRKsu7T6JOS3jALE8OUykshQe0/32JjAh1dzXtw9vs
         lquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M1ylQ2h6nt5cB5CdLkcoQhEX7ylNyRSBzL+F5Mo/yeE=;
        b=L1/EKvKRuoFfuBjKzRtENcwuor0EpaAaP29Od3WYlBl46YguLaXsHk3shTwSsoR4n/
         2+c/8/2+ii5J0UAgEPeOfPh3QvUozu7G9UPI5DldCmrEi6Kw/wpxAoDFse4iZFxarNf0
         cG3hasWN3mI4HqeaGbzpMls72RywHdW0lbNS6aI+dHXOyWFFyIYTIHn8E1w1uknLhj5h
         W1iXVzk1LNAl+GrX/ViBWKpyK0iJqmeinWw344ftkHWPBxKDYU2lX9GECeau5XFtsk5h
         tTtdcsTjIS0OV2dQFQb5eGvVJ4H+6mW+1WDSFlc0i2haoxatwjf1vjvxIVyNcgownqZ8
         uu0Q==
X-Gm-Message-State: AOUpUlHYzztGITSsuv49Lkvuj24n7Qtsh15+HqnMF3RIfKroQFi1m9n+
        HIE2ybA5I2pyZ4KgvqgAx0bP468qY64=
X-Google-Smtp-Source: AAOMgpcLX3sgyPVUFm7JiPQCcolFzw9OMBpEgiJmD3YDCDzxhojDwLoxBbmc7drYt7+XBOsmoXScyg==
X-Received: by 2002:a50:8d12:: with SMTP id s18-v6mr14829469eds.238.1531788606313;
        Mon, 16 Jul 2018 17:50:06 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z4-v6sm15063842edi.90.2018.07.16.17.50.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 17:50:05 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-efi@vger.kernel.org, netdev@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [RFC 0/2] compat: in_compat_syscall() differs on x86
Date:   Tue, 17 Jul 2018 01:50:02 +0100
Message-Id: <20180717005004.25984-1-dima@arista.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading xfrm (ipsec) code I've found such code:

: #ifdef CONFIG_COMPAT
:         if (in_compat_syscall())
:                 return -EOPNOTSUPP;
: #endif

While I can read that it's false on native i386, it's a bit misleading
and in result it's better to introduce a helper for that.
Grepping other code, I've found that there are already such helpers.
And the uniq behavior of in_compat_syscall() on x86 is disturbing.

Adjusting it to generic with the following..

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Cc: linux-efi@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>

Dmitry Safonov (2):
  x86/compat: Adjust in_compat_syscall() to generic code under !COMPAT
  compat: Cleanup in_compat_syscall() callers

 arch/x86/include/asm/compat.h  |  9 ++++++++-
 arch/x86/include/asm/ftrace.h  |  4 +---
 arch/x86/kernel/process_64.c   |  4 ++--
 arch/x86/kernel/sys_x86_64.c   | 11 ++++++-----
 arch/x86/mm/hugetlbpage.c      |  4 ++--
 arch/x86/mm/mmap.c             |  2 +-
 drivers/firmware/efi/efivars.c | 16 ++++------------
 include/linux/compat.h         |  4 ++--
 kernel/time/time.c             |  2 +-
 net/xfrm/xfrm_state.c          |  2 --
 net/xfrm/xfrm_user.c           |  2 --
 11 files changed, 27 insertions(+), 33 deletions(-)

-- 
2.13.6

