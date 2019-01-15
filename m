Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645B8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACBF20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TS9y6zS6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OgmtptBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbfAOFzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:55:43 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:54394 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfAOFzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:55:43 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DDA7C6024C; Tue, 15 Jan 2019 05:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547531741;
        bh=kuhkdhzCgW4d7scFPgG0rdZ5IKsYRSc4ZVg+67tqgqU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=TS9y6zS6CsJsFZ8iTfBfheJctdXRy5s/idVayyZCSZ5OuQmjTeef/CQkaS7w0asd9
         UTuoJToKw8d0h1LcheMZ7x092IvERX0YaR+lXxgPlE+aJfqPDlP0KNZhettsboClRC
         0ux3kJ7QTDSbWc3SILS2yzQOmzjT8y1+yX/OrB3I=
Received: from x230.qca.qualcomm.com (37-136-114-46.rev.dnainternet.fi [37.136.114.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0CB2F6024C;
        Tue, 15 Jan 2019 05:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547531740;
        bh=kuhkdhzCgW4d7scFPgG0rdZ5IKsYRSc4ZVg+67tqgqU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OgmtptBiv8g457Qp/ZcnGmFIY19fTn8jz+sh26D6L+XStC2/PyEwIRIUSd7Y/cf2c
         ztOwLzzcIftLbBB2b/RA0TdMIoQkRXAJBXa6e9EYt+CW2thZbQQfizuiNREbkF3mzf
         bx8o7EzjRnGnrGH2EDFh7e28+Q5GARCQO1TunbpE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CB2F6024C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Silvio Cesare <silvio.cesare@gmail.com>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/8] libertas: change snprintf to scnprintf for possible overflow
References: <20190112152844.26550-1-w@1wt.eu>
        <20190112152844.26550-2-w@1wt.eu>
Date:   Tue, 15 Jan 2019 07:55:36 +0200
In-Reply-To: <20190112152844.26550-2-w@1wt.eu> (Willy Tarreau's message of
        "Sat, 12 Jan 2019 16:28:38 +0100")
Message-ID: <878szma2hz.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <w@1wt.eu> writes:

> From: Silvio Cesare <silvio.cesare@gmail.com>
>
> Change snprintf to scnprintf. There are generally two cases where using
> snprintf causes problems.
>
> 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
> In this case, if snprintf would have written more characters than what the
> buffer size (SIZE) is, then size will end up larger than SIZE. In later
> uses of snprintf, SIZE - size will result in a negative number, leading
> to problems. Note that size might already be too large by using
> size = snprintf before the code reaches a case of size += snprintf.
>
> 2) If size is ultimately used as a length parameter for a copy back to user
> space, then it will potentially allow for a buffer overflow and information
> disclosure when size is greater than SIZE. When the size is used to index
> the buffer directly, we can have memory corruption. This also means when
> size = snprintf... is used, it may also cause problems since size may become
> large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
> configuration.
>
> The solution to these issues is to use scnprintf which returns the number of
> characters actually written to the buffer, so the size variable will never
> exceed SIZE.
>
> Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
> Cc: Kalle Valo <kvalo@codeaurora.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg KH <greg@kroah.com>
> Signed-off-by: Willy Tarreau <w@1wt.eu>

I don't see any mention about which tree this should go to. Can I take
this to wireless-drivers-next?

-- 
Kalle Valo
