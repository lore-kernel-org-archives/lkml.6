Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBA3C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FF2620850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 20:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wvd8CGMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF2620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbeLEUno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:43:44 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39819 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbeLEUno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 15:43:44 -0500
Received: by mail-it1-f195.google.com with SMTP id a6so22392870itl.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 12:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uRlXqNL9gwHSpE4ofxxG2/JE/FjB2jcEpjuVxGHgOPM=;
        b=Wvd8CGMzh+8RAR3S0+awyCteSzrQPwfkzxlf+cJtsgKtKEelEiLrcNfbqdea3zogm0
         NzT9gMkn9kG2UTwit9A7jYskGPGNfRhOSFI90HCVTO7wDat5JpiAhr4+AYDzyPRUa7eC
         norRp98mNSm8nLW5D/WburJNOfKxKtFJtq7IY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uRlXqNL9gwHSpE4ofxxG2/JE/FjB2jcEpjuVxGHgOPM=;
        b=GDhKiT7d7bHaEfNR+UW6ozTfABA4lO+ONjgAihtJXfXFgJWUpcwDLRZ37X7YPW1FAc
         OSy3CJuQMXZT0HuiXrXuUuPYnv4lIITR8HIEUNUM5Ou6A/ui7MDZgt5El+Y81mmv6649
         kEfhHkqocG9P2oiVZsZzVfWWILlXjjrDw4EaygD1vpVZyZHKRMFNW6qk1QbjMyPgNC3+
         VRwrNj2CwIMnOVMDxoAu4uFG1hUdLuIBP4MiFBlf9IVD1KaRF/wPJgARknpGGN7XWhBT
         BnhrzE3gMG7X8MMDCnXi7XorWqhaU3kEapDwcKZnHu6KjG6Bran4L4fKdoSadNDRu9Yj
         1o9g==
X-Gm-Message-State: AA+aEWa3MCn3J9ijCucQshDHsTRR+lZ+S02U/6JfRqoC2FkYo+5yBALK
        g/6+CKNgDv/wugM7t+rZFU0HBQ==
X-Google-Smtp-Source: AFSGD/V2OLgvcrwpfn+hltDjVSNtrNc5qtw+zlU0cGx4dmRikzsJDMEuDVCpK5ryCb3ytq8RzhRv/Q==
X-Received: by 2002:a24:94f:: with SMTP id 76mr17528038itm.169.1544042623507;
        Wed, 05 Dec 2018 12:43:43 -0800 (PST)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id b91sm6922993itd.26.2018.12.05.12.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 12:43:42 -0800 (PST)
Date:   Wed, 5 Dec 2018 14:43:41 -0600
From:   Dan Rue <dan.rue@linaro.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: firmware: remove use of non-standard diff
 -Z option
Message-ID: <20181205204341.7fd4ob5c6pwx375m@xps.therub.org>
References: <20181127031218.24419-1-dan.rue@linaro.org>
 <20181127031218.24419-2-dan.rue@linaro.org>
 <20181130023732.GO4922@garbanzo.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130023732.GO4922@garbanzo.do-not-panic.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 06:37:32PM -0800, Luis Chamberlain wrote:
> On Mon, Nov 26, 2018 at 09:12:15PM -0600, Dan Rue wrote:
> > diff -Z is used to trim the trailing whitespace when comparing the
> > loaded firmware file with the source firmware file. However, per the
> > comment in the source code, -Z should not be necessary. In testing, the
> > input and output files are identical.
> > 
> > Additionally, -Z is not a standard option and is not available in
> > environments such as busybox. When -Z is not supported, diff fails with
> > a usage error, which is suppressed, but then causes read_firmwares() to
> > exit with a false failure message.
> 
> NACK -- this breaks testing on debian:
> 
> Testing with the file present...
> Batched request_firmware() try #1: Files
> /tmp/tmp.8GWkoSo5jZ/test-firmware.bin and
> /sys/devices/virtual/misc/test_firmware/read_firmware differ
> request #0: firmware was not loaded
> 
> Please add a quirks check, enable it by default, and remove it for
> Busybox.

Thanks for the review. Shuah, can you please drop this one?

Dan

-- 
Linaro - Kernel Validation
