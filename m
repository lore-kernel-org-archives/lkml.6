Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AC5C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 04:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4530320896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 04:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrUF4ODi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4530320896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751659AbeFQEnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 00:43:07 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:41556 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbeFQEnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 00:43:06 -0400
Received: by mail-pg0-f49.google.com with SMTP id l65-v6so6089875pgl.8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 21:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=x7LYl7mjooQIxciVdPeEiqFLc8ol6Wa7attYpxKkALA=;
        b=qrUF4ODi4uDhEAF3jUp3VurJ6jJYmrc4sdk4IPaehF5NjkdIvkGKfF22rgeHoUcW1M
         Au4kxvbYJ7GRG28ksWaSnId2HyEOrKXHJP2ay6eTO9psfPQdsw3V3SE2ZkpeEhNDphQQ
         UBWasRVOKU7OhkAU5D8A2R6t3B5QVDp83+Tx8sg9ZqzlXV9XoHX7X93cSlNu7UiUaXpZ
         WrjwSX7GJxuXqzxiZPQC7dsxNHEDdjL7/3GqR22xda+pgh1qxo9eYfJPB4mtDr30mQUY
         PfRmJftfy80otjXPnNGJ4soqFk8SY+8iyhROv3NAcJo1X+rY7rJUe2ZteTeIgqn04zkr
         etqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=x7LYl7mjooQIxciVdPeEiqFLc8ol6Wa7attYpxKkALA=;
        b=U0szrD9hGdVzO5mJ76g2VfDeQdMlWk6MW/hVK0Yn5T5ihESJ3Z/3bnjhyMPtSBV7xw
         WvsWSFWmeyseUwhrfMJnlUTb+XKNVTzJFkfDCGbnVdtyBXMJbpbH8ZLgo3PO2d4aSIY1
         H0IG+YzBccnHlmfOrvQ/so9BOSUSchTISXj5dsm0G4yHuMlaxGJnjyVZ8163xY6gLQSr
         Bum5ir2fZakYKD6dn10faFy5hrpmWL+rmFtFE2osRUOiQvkhfl1eKLx2p+RA3yQ0A78A
         jPsQCD9PpgB6TL3vmocjtBgn60/kKOpnqd+gPSbEncz0hqcxs7Zo1gryj+NTI8vItuWv
         aE9w==
X-Gm-Message-State: APt69E2I4b4rxBLX0uL/tcD5wYR9Sex9MjWkTVrYIRf/1aKejRg3wrAv
        dOzJxIXcrpLKHvFbv8avBNYYZw==
X-Google-Smtp-Source: ADUXVKJW+0WR23In8xuGzELVevk2z0mR302OqLn1RvIcT9NvIkHvZyPBp3E/nt/73aOfMktZDnvWUw==
X-Received: by 2002:a65:5cc8:: with SMTP id b8-v6mr6874235pgt.85.1529210584045;
        Sat, 16 Jun 2018 21:43:04 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id u18-v6sm16166436pfm.152.2018.06.16.21.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 21:43:03 -0700 (PDT)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: v4.18-rc1: Build and qemu test results
Message-ID: <75d5be41-1892-287d-81ff-55814a7553b1@roeck-us.net>
Date:   Sat, 16 Jun 2018 21:43:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build results:
	total: 134 pass: 113 fail: 21
Failed builds:
	arm:allmodconfig
	c6x:dsk6455_defconfig
	c6x:evmc6457_defconfig
	c6x:evmc6678_defconfig
	h8300:allnoconfig
	h8300:edosk2674_defconfig
	h8300:h8300h-sim_defconfig
	h8300:h8s-sim_defconfig
	i386:allyesconfig
	i386:allmodconfig
	ia64:defconfig
	ia64:allnoconfig
	mips:defconfig
	mips:allnoconfig
	mips:defconfig
	nds32:defconfig
	nds32:allnoconfig
	s390:allmodconfig
	sparc32:allmodconfig
	unicore32:defconfig
	unicore32:allnoconfig
Qemu test results:
	total: 150 pass: 146 fail: 4
Failed tests:
	mips:malta_defconfig:nosmp
	mips:malta_defconfig:smp
	mips64:malta_defconfig:nosmp
	mips64:malta_defconfig:smp

Build errors as well as the qemu test failures are mostly due to
some last minute changes around memblock_virt_alloc_try_nid_raw()
and similar functions (also seen in  next-20180615, but not in
next-20180614). There are also a few other errors which have
accumulated during the commit window. Interestingly, almost all
build errors started to be seen in -next only _after_ the commit
window opened. Go figure.

Details are available at http://kerneltests.org/builders/.

Guenter
