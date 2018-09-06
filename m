Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C1DC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE212075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 13:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGimWkTb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE212075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbeIFSUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:20:55 -0400
Received: from mail-pf1-f182.google.com ([209.85.210.182]:36293 "EHLO
        mail-pf1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729233AbeIFSUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:20:55 -0400
Received: by mail-pf1-f182.google.com with SMTP id b11-v6so5326011pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 06:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=crd1JrE3pk7b3o7vvNV0z4HVJlpQEXN1StwQPEV+Q7M=;
        b=gGimWkTbbbaf4ZJfQ7twieHlzgia83i/mqE8oDX94ymkb8IzKI8eyNaJy0i5FlTXCX
         /VHYTT6XtvyWjwEMxj4pLINnafcbxmdK6qPPTywAkgqUm8R5C3qIHdNVeLvp4sgTN+xU
         sLMYAezm6goChKHf0UPacm2/J7y+ayBtuKIFSzdtCDo7+zDa0Vop+igYQ2zGqEgqGccO
         t/oj05slB5tb2gSDF9juplmXkj8+1en/iunznoRQlMyBiqhrNnq1TWFs1WNMI694Do0z
         HzEfkaqP4vQa4W0b7hiI0R0BXXaKzKNd2r3TvFB8sRmyigtLqev6a8Q0lxj3602QDzzy
         /mrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=crd1JrE3pk7b3o7vvNV0z4HVJlpQEXN1StwQPEV+Q7M=;
        b=BZ2PRJOBqiOyGZ5aqm4OlFsS5E0XEqBsPEOGt3Me6mpwsUjmeZIaD1g5rh9FuZhbnV
         gNO82Jg8zKkFAUGcx4iqNaEh9yIEfuse1HgLd9dvyGVXWzigzabMFy1du8lMFA+lww4L
         FT2QGk3cKzwYoOJm/iKSEmnIVKdDgw9vkV0VMIx7SS7ZLjNaWxjhsCLjhLIcgSU9QJRF
         xzjz2FOA5uoVVfW0LW8SWFqgedrEr6FTlqxtIj/Ea/PGUMEfvGS8T2uEJGo53JhK0EAo
         wA2NMlkKN2tkTygoREcnoyfqv7K5G/3wrSEyjeaLfxiYrP3EVZ+A/JLY2JHnQq8HaNfw
         DgTw==
X-Gm-Message-State: APzg51CvDxBSkW2D4F75ui6DdFF8qAx1kHNrMA3xc2rnInmFgn76kjAI
        FjRcSqGtIo0ehj9ZbUmKy040ZeLo
X-Google-Smtp-Source: ANB0Vdb4LX0+2m1g9djd4AJ3uijtj7dTBo/q2+eNcb1SSLf5t8ySdDHpREeCrTyY4vdmmtc+2fY0yw==
X-Received: by 2002:a62:1089:: with SMTP id 9-v6mr2914289pfq.30.1536241517416;
        Thu, 06 Sep 2018 06:45:17 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id r23-v6sm9505491pfj.5.2018.09.06.06.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 06:45:16 -0700 (PDT)
To:     David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Widespread crashes in next-20180906
Message-ID: <2e8e31f5-4db5-4907-2d09-f6444bc78ede@roeck-us.net>
Date:   Thu, 6 Sep 2018 06:45:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build results:
	total: 134 pass: 133 fail: 1
Failed builds:
	sparc32:allmodconfig
Qemu test results:
	total: 311 pass: 76 fail: 235
Failed builds:
	<pretty much everything trying to boot from disk>

Error message is always something like

Filesystem requires source device
VFS: Cannot open root device "hda" or unknown-block(3,0): error -2

The only variance is the boot device. Logs in full glory are available
at https://kerneltests.org/builders/, in the "next" column.

I did not run bisect, but the recent filesystem changes are a definite suspect.

Guenter
