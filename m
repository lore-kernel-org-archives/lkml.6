Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D16C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD75C25976
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbqPFZ1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD75C25976
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755426AbeFYMqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:46:00 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42492 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbeFYMp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:45:58 -0400
Received: by mail-pl0-f68.google.com with SMTP id w17-v6so6748969pll.9;
        Mon, 25 Jun 2018 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSPlhiFwLc7MF8cGllxjlXz+iZ1Z+NVN44uM5kW45jM=;
        b=VbqPFZ1QAVVjRAmGZsGlomYg+7QquCEXMYQBNpsYEoH/bUEurcjEg+QKWOD6ft79Nu
         QXKDW3nnhhcb9RIL7GL4KywW7utk/dqc8+XwGGNQcxE90gbvGMyIK2nS8jfvHqetWs8x
         aAfnwH1NuDzWRfGTPUyUvLZJ7ya1r0jKJnYotkx38a4D9vH7aIhMwWCQcbf+/BrVIFko
         8ilUshu1do1OB3ixA7dprKbJObzrbSdcI1vxbEKc4TSmtbjUkZDsFwR1kpNUOS+Ma65c
         aY7exYF9NRaqwKn8mqNL5EpfCe3EuStiDGy+xb+cCOc1BNyJ8kKQl1tQFsJSpPYxTa94
         7+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OSPlhiFwLc7MF8cGllxjlXz+iZ1Z+NVN44uM5kW45jM=;
        b=W1N9Gzj86Efu+8ZsvQk8zr9cwrbfSJoxjGHZlJtD911ipS1cLebD+ArcWrBYYMvUai
         J9YIz3F7fQK7LMOt8yFQc28Qn8Fw80UzH7cXjHD/MX8HyyDt27MdO9CXiX83WBzaGW0r
         evR2X9Lbj08o70T3FMkOJfSUwu4r//JedUyNNbzu8H6wCy2Cu/P9YqKuvHwFumj3GbZI
         zaGp8VEgpur0VKz1vogMpfKTPD0RBMJP3U51Dxb6lHYE/rVs7/jAfAdJuiGl9TRDDpsI
         JzeHv2w5gmT/WBTjaY71Hup/bFgzKgoASdzMXMqVzrjx47PhIE4lvIY2mkr26G6EEZ7G
         OSfw==
X-Gm-Message-State: APt69E0b8hfoQeimbOsj3Ab/IutrxF5JkFuXDSsKGeg/29Y2rZwOfduo
        06v4K02i5fonpPvpU8hEZBeWV73S
X-Google-Smtp-Source: ADUXVKI3/L4kC+HoyqNBOtBEV90lkthTgc2ACHcd5NvqJLy5FxWzC80DZpg0Jl5pv3ud1ux0axCLUg==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8-v6mr12450787plp.148.1529930757557;
        Mon, 25 Jun 2018 05:45:57 -0700 (PDT)
Received: from localhost (g134.124-44-9.ppp.wakwak.ne.jp. [124.44.9.134])
        by smtp.gmail.com with ESMTPSA id v27-v6sm25062287pfi.23.2018.06.25.05.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 05:45:57 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        Eric Biggers <ebiggers3@gmail.com>,
        linux-crypto@vger.kernel.org, Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 0/2] Fix GCC -Wstringop-truncation warnings
Date:   Mon, 25 Jun 2018 21:45:36 +0900
Message-Id: <20180625124538.21051-1-shorne@gmail.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When compiling OpenRISC kernels with our new toolchain based on GCC 9.0.0 I am
seeing various -Wstringop-truncation warnings.  There might be more as I am not
compiling all drivers/modules yet, if someone thinks thats helpful let me know.

I discussed this with Greg KH at the OSS Summit Japan 2018 and it seems no
one has pointed these out yet, so here are the patches...  Actually, the crypto
issue was reported before, but the patch was discarded as it introduced a data
leakage bug pointed out by Erix.

As for merging, I think the maintainers should pick these up separately.  Let me
know if you want something else.


Changes since v1:

 - Fix paper-bag bug in kobject patch, using memcpy() now
 - Fix data leakage issue crypto patch pointed out by Eric Biggers

-Stafford


Stafford Horne (2):
  crypto: Fix -Wstringop-truncation warnings
  kobject: Fix -Wstringop-truncation warning

 crypto/ablkcipher.c | 2 ++
 crypto/blkcipher.c  | 1 +
 lib/kobject.c       | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.17.0

