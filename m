Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487CCC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AEE25292
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeOXKpMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AEE25292
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeFXQZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 12:25:04 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:40159 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbeFXQZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 12:25:03 -0400
Received: by mail-pl0-f43.google.com with SMTP id t6-v6so309486plo.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=lMhM0i22B3jMapgEuuELtSp+zmNR2CnrS3PLfX7waBg=;
        b=QeOXKpMdOz8QbZDEE4lx3tN+Q75U2UXkaX9onmLfYyW8+AMJ7ZVTOXxwm0AiWGYAz/
         0E4HHVS/A7wC1QVdGDUS+bC4KdRMXH0+kzAawqAbWsMeBnHpATOFHjJEHZiha7psVFqL
         ePN6f8FQabPLaNHLMn5srWbUUVxhpsK3fNbh0/wrKLDE6mSVBckIdrkbADybKo/mcGl0
         7cyuK85pKRiE69OubL2NCv8L5vdi0Gli9S2h9SMVA8YYG7jtmrcqCo280TKHJ9LaZeMH
         HDi9Gu2NC1y7Bzn5mXALRXTanVB5KXL9nzLsuiSHRNfCTIBKSStCMilLstSmextmsU/2
         qb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=lMhM0i22B3jMapgEuuELtSp+zmNR2CnrS3PLfX7waBg=;
        b=BeD8uLgYw3Dyt0tjS8i+YaLE4tnRo9Awl1RHj/rES33nS0k3STtE8LqOZkL406WuPJ
         IKopX83MUJggPyPbMu9PenUgGfRDDFKTQ0nR6AGy4qmaGmQMK7eV9f3d5xAlkrkg3JEd
         HoHivP6dRbJHjRT/JTrkawgXUj4KUxBn/jbn6MjGs2xvqHnCw7GatjqjSSY0G2/3aSM8
         cNfuM9iEWD/8pTb0vu2DPoXlfpZdi1qVLN5KM1afAn7VAdW7jixfuttczpK89adWHMhe
         X6abCjLZHx8UsxS+Z0eCCOCkJv5x5FIjW2JnriTDZxGngnEduom4e8Bxd9Wk7uRvu4uM
         /0cw==
X-Gm-Message-State: APt69E2+vDfkzOt4SielQuugVLS0HUvMKE7MMcZAUOYUqf1nPpmy8MQW
        Jc0vPzzUceVC+XVjWbB4/+k=
X-Google-Smtp-Source: ADUXVKJWJ/vqiEg2huwCH1csc+rHgp0kQSYQQgTc4VDRz00DcAtg90z+Ls0zaN181nXLgwcwpkOwMA==
X-Received: by 2002:a17:902:5a3:: with SMTP id f32-v6mr9145259plf.109.1529857502757;
        Sun, 24 Jun 2018 09:25:02 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id g4-v6sm25816164pfg.38.2018.06.24.09.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 09:25:01 -0700 (PDT)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Build/qemu test results for v4.18-rc2
Message-ID: <0ecc33a4-60c0-f978-f281-99844508d09a@roeck-us.net>
Date:   Sun, 24 Jun 2018 09:25:00 -0700
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
	i386:allyesconfig
	i386:allmodconfig
	mips:defconfig
	mips:allnoconfig
	mips:defconfig
	mips:allmodconfig
	mips:allnoconfig
	mips:bcm47xx_defconfig
	mips:bcm63xx_defconfig
	mips:nlm_xlp_defconfig
	mips:ath79_defconfig
	mips:ar7_defconfig
	mips:e55_defconfig
	mips:cavium_octeon_defconfig
	mips:malta_defconfig
	mips:rt305x_defconfig
	mips:defconfig
	nds32:defconfig
	nds32:allnoconfig
	sparc32:allmodconfig
Qemu test results:
	total: 153 pass: 140 fail: 13
Failed tests:
	mips:malta_defconfig:nosmp
	mips:malta_defconfig:smp
	mips64:malta_defconfig:nosmp
	mips64:malta_defconfig:smp
	mipsel:24Kf:malta_defconfig:nosmp:initrd
	mipsel:24Kf:malta_defconfig:smp:initrd
	mipsel:24Kf:malta_defconfig:smp:rootfs
	mipsel:mips32r6-generic:malta_32r6_defconfig:smp:rootfs
	mipsel64:malta_defconfig:nosmp:rootfs
	mipsel64:malta_defconfig:smp:initrd
	mipsel64:malta_defconfig:smp:rootfs
	mipsel64:fuloong2e_defconfig:fulong2e:rootfs
	mipsel64:64r6el_defconfig:boston:rootfs

Only the mips problem is new, introduced with commit784e0300fe9fe ("rseq: Avoid infinite
recursion when delivering SIGSEGV"). The other problems have all been previously reported.

Guenter

