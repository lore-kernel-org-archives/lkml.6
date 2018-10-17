Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4460ECDE3C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7572821473
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 23:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="X9kzU68g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7572821473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbeJRHKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 03:10:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41655 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbeJRHKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 03:10:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id q7-v6so3656768wrr.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 16:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Svrost9crF1K1HXLEU+kRGKOwXnhUoTtsfifvRNdJ4g=;
        b=X9kzU68guCruKNVz7s+sdlIogUst5+Sts3Lq4oH5KrYtTkFcJq6l6KLQD0tFAkFB0Y
         zVb0Jj7Q9S1tTlQgvBDTCchQ7Sh0K5e+nTFp62LdmDB4fd1WF5ZPRvAfyRxgk9aAxCFF
         9Lz7fWtS8xPChkRHTzinvUOvaWTrttR0RPjCRmndSWmiLYEWtFQwPA04SleLgzDMtp4F
         UKnkljkR4lwBvWcRvye8nyCLhvfWhMbzRVzFlKck8BxqXOl8QYIXnDEKTp4qGniEbCaC
         eK67MhtcAJ81ItUwT4lmJZhbqP2QRg1TIE03LLOryuIGSyc7EabfPHXxqwpIa7eQFSQZ
         xEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Svrost9crF1K1HXLEU+kRGKOwXnhUoTtsfifvRNdJ4g=;
        b=InpD5MrwSjyampTsVj2HeNuawSq0aGYdTYBmHfPY5xzfTcbq5AtoZGgJZM7E2UXozP
         m/Lhl8gOdN9jKJxID9UPi6wte5TSV1E44/ayXDTxBBq+EOWaPE1EeyrF8dZYB5ZDSTKR
         EnCzHFXMXs1Zh7j2Ccoa2kV/bSYcm32vAdzaWRBKnQMoltQkjZEFD1Ve5sakLpMIX7tN
         sP25UD1bb3yf2aiQ90xg6kJEkDd6vo577wA1h3VEB+XvSSEEr55Bt+5gt5g1IMizcGPZ
         yJnz4spulnm7jbCEf791QXRUhNeOWppIt/lOPAzvOOMUbYOWayDW9vRoSqqNcv8oKpIo
         uPAw==
X-Gm-Message-State: ABuFfoiB/zOUKNHHZCQ6B+JjohPtQ/ME5yN6BSy0CJRqJEtbAzVf2a2e
        CcHdFIsYtKRodeX4G9mPoujY6A==
X-Google-Smtp-Source: ACcGV63QE+27dbapXJmjyalcOcMJeR4bUUX991cMsZ8JHMezKWITXO53qOi7Of4KdeNcErmhyXHc4g==
X-Received: by 2002:a5d:4dc6:: with SMTP id f6-v6mr36730wru.80.1539817939762;
        Wed, 17 Oct 2018 16:12:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8070:8895:9700:8197:8849:535a:4f00])
        by smtp.gmail.com with ESMTPSA id v76-v6sm4212803wmd.32.2018.10.17.16.12.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 16:12:18 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        Christian Brauner <christian@brauner.io>
Subject: [PATCH 0/1] fs: cap max_files at LONG_MAX
Date:   Thu, 18 Oct 2018 01:11:48 +0200
Message-Id: <20181017231149.26302-1-christian@brauner.io>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

This is a follow-up to [1] and [2] that caps the file-max sysctl at
LONG_MAX and rejects any larger values with EINVAL because of the way
percup counters work. This intends to align the kernel side of files_max
handling as well by capping the maximum number of files at LONG_MAX
until such time as we have the need and the precision for percpu
unsigned long counters.

Note, that in a quick discussion with Tejun investigating percpu unsigned
long counters it became obvious that technically, both LONG_MAX and
ULONG_MAX should be unreachable. Given that an fd is usually larger than 2
bytes one would likely run out of address space before even reaching the
LONG_MAX limit.

Al, I suggested this patch in [3] but I didn't see you reply so I'm not
sure whether you would be in favor of this or not.

Thanks!
Christian

[1]: https://lkml.org/lkml/2018/10/17/74
[2]: https://lkml.org/lkml/2018/10/17/184
[3]: https://lkml.org/lkml/2018/10/17/555

Christian Brauner (1):
  fs: cap max_files at LONG_MAX

 fs/file_table.c | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
2.19.1

