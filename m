Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1332DC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 21:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E352087E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 21:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E352087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933440AbeFPVCe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 17:02:34 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44063 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933319AbeFPVCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 17:02:32 -0400
Received: by mail-lf0-f68.google.com with SMTP id p23-v6so7637189lfh.11;
        Sat, 16 Jun 2018 14:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tzkAfTbELaQ5+K4PoFgOq7mc7OGjnREa9FOC3QC9XZ8=;
        b=bfI3LzGJZckTjojqmEvbyDYSbIGJ+2I2YFMgWPf0o62G3JhO2f72XjwSPqwZ4qEsHJ
         Olar5W+GRwGdo6sQ6MbkxojIuDOREd7OT3EfTlz88o+PvDD1PBjD3NF7BptEfcQJcsNq
         G6sw5f3uzkDvhjUAFkcigyOwSb8ywqqv/SBr3/d714FxccSJqqHt3G/oNjZ1PeJpzsB6
         NpvJRqKBpdDryFI3xOOqxNDyPzeBKZSuQ+B6LyakwvR+9bvwt5Z377Mc6PPiMIFwm9Cc
         aerrUFop1KYHKdougcAHqACGdsYBJZohxndKLzXN4TKOjO9L8Tkd2U1IS6ObzD/kUhhk
         zkjg==
X-Gm-Message-State: APt69E18mjOzylyOIP/6HxnuhZAIPdiE4az9ZSKdzf+t6dsyLagnlnfL
        1MFuIva5uLZTtVoRYVTzX31jqHBO
X-Google-Smtp-Source: ADUXVKLMp4O6sAVeHi4ieicTtzFWPo4QhAXP7wgdjwsALTB20OabtK+9oSWJblzGt4JqQSA5PtGJAw==
X-Received: by 2002:a19:380a:: with SMTP id f10-v6mr4208290lfa.47.1529182951061;
        Sat, 16 Jun 2018 14:02:31 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id c20-v6sm2036260lji.82.2018.06.16.14.02.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 14:02:30 -0700 (PDT)
From:   efremov@linux.com
To:     Steffen Klassert <steffen.klassert@secunet.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] xfrm4: Remove export declaration from xfrm4_protocol_init
Date:   Sat, 16 Jun 2018 23:58:40 +0300
Message-Id: <20180616205840.19822-1-efremov@linux.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

The function xfrm4_protocol_init is exported as GPL symbol and
annotated as __init. That is reasonable only in the case when
this function is called from another's module __init section.
Otherwise, we will face section mismatch error. xfrm4_protocol_init
is used in xfrm4_init along with xfrm4_state_init and xfrm4_policy_init.
The last two functions are not exported as GPL symbols. According to
this, it seem's like there is no reason to export xfrm4_protocol_init too.
Fix potential section mismatch by removing export declaration
from xfrm4_protocol_init.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 net/ipv4/xfrm4_protocol.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv4/xfrm4_protocol.c b/net/ipv4/xfrm4_protocol.c
index 8dd0e6ab8606..0e1f5dc2766b 100644
--- a/net/ipv4/xfrm4_protocol.c
+++ b/net/ipv4/xfrm4_protocol.c
@@ -297,4 +297,3 @@ void __init xfrm4_protocol_init(void)
 {
 	xfrm_input_register_afinfo(&xfrm4_input_afinfo);
 }
-EXPORT_SYMBOL(xfrm4_protocol_init);
-- 
2.17.1

