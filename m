Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83845ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B16B20877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 18:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A5bKc0lC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B16B20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733076AbeITAEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:04:15 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37291 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731627AbeITAEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:04:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id h69-v6so3099976pfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:to:from:in-reply-to:cc
         :references:message-id:user-agent:subject:date;
        bh=G8M+E2pJrSnO7MPpugYXxul8f5634foVMjSjoFPO0A4=;
        b=A5bKc0lCd31bmbu/M8iE7xwi3uUIdwwdMrjyZhe78vKCVV+p0804WNcS/ABTvCPOED
         pgWv8uDpC81W1Hb8H6gCIzTQoMbny5Rnka5FM0DvVcdaiAK8qy2VBWe8iJlnDRGYBzzw
         DfzD3+3HTU4PMiyReZH2O+d50ERL6IhGpkekA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:to:from
         :in-reply-to:cc:references:message-id:user-agent:subject:date;
        bh=G8M+E2pJrSnO7MPpugYXxul8f5634foVMjSjoFPO0A4=;
        b=oZv/fNfeTVE3JUIkuzdGf0ylZX0MM5kr2TOFetixrHu/kmoMjhfCCTNT9CVl26sk7d
         JMcb/8s2GBHsioArYVYKaW6ksgYegVzT+1Hv8VS6mIG7plAseynY+SuBz/ow3/9l4jQR
         S36t28l3Xc0L9DaGGGZ2li8oIkOZmahaJR7zhiuX/ZJt7LtbQyq9+WSnlkSX2QCyMtaS
         FwmCZwi8ig4UalfpwnZFkdAUm8msm0muZHCrf6bK/3wwBULKBkDV7LR2hIoWDnBY8c+2
         ngcEL2HXUE9dqqQy1mbw8OvHhdKTuTNAec7JTGVLJdVgGO0diWKVV7n3iE5Kwgkeo+D8
         9oKQ==
X-Gm-Message-State: APzg51DyEjj6zlj+ASvbZzq2qEJpZUuYk9BFCUFIVZupTM9aez1EMFT7
        btvmPwOZEluB9IGklPFp82JRKbzw1vs=
X-Google-Smtp-Source: ANB0VdaqtlUxuXwfXDZuatoO7jSKbdAJ/51pSk1Ija4hY+dvTtLD0rmbn8K5XVHxpg2H5gpQyvKsHg==
X-Received: by 2002:a63:4281:: with SMTP id p123-v6mr1804515pga.91.1537381506841;
        Wed, 19 Sep 2018 11:25:06 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:7e28:b9f3:6afc:5326])
        by smtp.gmail.com with ESMTPSA id f87-v6sm55632765pfh.168.2018.09.19.11.25.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 11:25:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Wolfram Sang <wsa@the-dreams.de>
From:   Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180918221646.GA970@kunai>
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
References: <20180918194126.138455-1-swboyd@chromium.org> <20180918221646.GA970@kunai>
Message-ID: <153738150448.119890.13258586980997802695@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] i2c: i2c-qcom-geni: Properly handle DMA safe buffers
Date:   Wed, 19 Sep 2018 11:25:04 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Wolfram Sang (2018-09-18 15:16:46)
> =

> > This fixes a problem where the kernel oopses cleaning pages for a buffer
> > that's mapped into the vmalloc space. The pages are returned from
> > request_firmware() and passed down directly to the i2c master to write
> > to the i2c touchscreen device. Mapping vmalloc buffers with
> > dma_map_single() won't work reliably, causing an oops like below:
> =

> Exactly the reason why I implemented I2C_M_DMA_SAFE. Did you also notice
> the helper i2c_get_dma_safe_msg_buf() which you maybe could use for
> len > 32?
> =


Yes I noticed that after sending the patch, thanks for pointing it out.

But now when I try to use it I'm not exicted when the buffer is bounced
but we fail to map the buffer with the DMA APIs. For an I2C_M_RD
message, presumably we would call i2c_release_dma_safe_msg_buf() in this
error case, but that will cause the original buffer to be copied over
which seems wasteful to do, but I guess it's OK. I suppose we could have
another function like:

void i2c_release_dma_safe_msg_buf_on_err(struct i2c_msg *msg, u8 *buf)
{
        if (!buf || buf =3D=3D msg->buf)
                return;

        kfree(buf);
}

so that we don't copy over the buffer on failure and still properly free
the buffer that we setup. Or we can pass an argument to
i2c_release_dma_safe_msg_buf() to indicate if we should do the memcpy or
not? Removing the I2C_M_RD flag from the message on failure doesn't
sound like a good idea.

Either way, I can resend the patch with the releasing and duplicate
memcpy and we can discuss this minor optimization.

