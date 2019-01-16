Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07445C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FC420657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KffyDV8j";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="l2I0fi6D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393925AbfAPQkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:40:36 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:33612 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfAPQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:40:35 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C5DF46024C; Wed, 16 Jan 2019 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547656834;
        bh=LTNl5opQEAF0OmpEvB5gPXZGQRpm0v4EAPUEUgDKgrk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KffyDV8jtTVOvnxBFNzrpBVhTLsBjbk2IwnOz1WOiFF+gwXPwhC3qNGf3+RUZoJMJ
         SsS8R7v++87OY0bGp4+mk6O7ji6GQAAXF/PdUO4KRSHllb6271Q2ligfA3bAm/QPHI
         8FZ4X9Jo77ElhCzTURNd0lOWHnfT8pAQZN+vsc0k=
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB5106024C;
        Wed, 16 Jan 2019 16:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547656833;
        bh=LTNl5opQEAF0OmpEvB5gPXZGQRpm0v4EAPUEUgDKgrk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=l2I0fi6DBZxwf4dkoI5Uo8dcsbgT03x2+6k6XR1ENoIXQTn9ZGaJl7eIZIe9cgP0e
         vnhcGaoPAn4+RQag9sc7j3lXhvstdU+KJtzQ1OKF2pO+rmOoHyeBONV6L1I7dW7quw
         zFrJpMdfQ2T6ts3SC24SsaaIc6WRgaFTwedcUioA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB5106024C
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
        <20190112152844.26550-2-w@1wt.eu> <878szma2hz.fsf@codeaurora.org>
        <20190115203503.GA7117@1wt.eu>
Date:   Wed, 16 Jan 2019 18:40:29 +0200
In-Reply-To: <20190115203503.GA7117@1wt.eu> (Willy Tarreau's message of "Tue,
        15 Jan 2019 21:35:03 +0100")
Message-ID: <87a7k04kua.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <w@1wt.eu> writes:

> On Tue, Jan 15, 2019 at 07:55:36AM +0200, Kalle Valo wrote:
>> Willy Tarreau <w@1wt.eu> writes:
>> 
>> > From: Silvio Cesare <silvio.cesare@gmail.com>
>> >
>> > Change snprintf to scnprintf. There are generally two cases where using
>> > snprintf causes problems.
>> >
>> > 1) Uses of size += snprintf(buf, SIZE - size, fmt, ...)
>> > In this case, if snprintf would have written more characters than what the
>> > buffer size (SIZE) is, then size will end up larger than SIZE. In later
>> > uses of snprintf, SIZE - size will result in a negative number, leading
>> > to problems. Note that size might already be too large by using
>> > size = snprintf before the code reaches a case of size += snprintf.
>> >
>> > 2) If size is ultimately used as a length parameter for a copy back to user
>> > space, then it will potentially allow for a buffer overflow and information
>> > disclosure when size is greater than SIZE. When the size is used to index
>> > the buffer directly, we can have memory corruption. This also means when
>> > size = snprintf... is used, it may also cause problems since size may become
>> > large.  Copying to userspace is mitigated by the HARDENED_USERCOPY kernel
>> > configuration.
>> >
>> > The solution to these issues is to use scnprintf which returns the number of
>> > characters actually written to the buffer, so the size variable will never
>> > exceed SIZE.
>> >
>> > Signed-off-by: Silvio Cesare <silvio.cesare@gmail.com>
>> > Cc: Kalle Valo <kvalo@codeaurora.org>
>> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
>> > Cc: Kees Cook <keescook@chromium.org>
>> > Cc: Will Deacon <will.deacon@arm.com>
>> > Cc: Greg KH <greg@kroah.com>
>> > Signed-off-by: Willy Tarreau <w@1wt.eu>
>> 
>> I don't see any mention about which tree this should go to. Can I take
>> this to wireless-drivers-next?
>
> Possibly. It addresses a small memory disclosure issue when using debugfs,
> and as such it should probably also be submitted to stable branches, so
> please use the most suitable tree that doesn't add too much extra delay.

Ok, I'll queue this for 5.0 and apply it to wireless-drivers instead.

-- 
Kalle Valo
