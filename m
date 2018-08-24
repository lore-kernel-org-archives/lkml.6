Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125E8C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BDA208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EfXclA0H";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="c+kwUFUg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BDA208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeHXLyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:54:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59482 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeHXLyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:54:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2578360555; Fri, 24 Aug 2018 08:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535098841;
        bh=kkLxmCWlVcMQWNzI8Qe8xnUuiHCLfYVtYFG6iV4JSMA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EfXclA0H/6SdkI6aj3Bj/BcCU71HLH7SJBhVYTjBy7gtgOj8aEKDalZ3MUwGXaOUO
         yjohcbU/+B7vYVMIevPO8kAMuYFneo+XRJSH/zwhURiUSQW+wIyxfwsVLYue3vDJxT
         glO/ByrL17gk1VAZIUyo6mjLH9so0uHZ4L0nE2dM=
Received: from potku.adurom.net (88-114-240-52.elisa-laajakaista.fi [88.114.240.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EB0D601A0;
        Fri, 24 Aug 2018 08:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535098840;
        bh=kkLxmCWlVcMQWNzI8Qe8xnUuiHCLfYVtYFG6iV4JSMA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=c+kwUFUg+x+fBiseURCqoXa58RBxITpzaqUJ56bsccrL1GV8qgJozkjY0uCK6BQHy
         hSOtI6ZmuGaH79Ae0xwtpZ7hyYdUgYt+tf6ml1xWvM8UW5TzS5ezb8fVLafqp3ucAV
         sskc1FUiNIY/IYOA0IxzCxrWfAV5d/j5zYxTN+Ig=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EB0D601A0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mt76: Fix comparisons with invalid hardware key index
In-Reply-To: <20180824080817.GA6651@redhat.com> (Stanislaw Gruszka's message
        of "Fri, 24 Aug 2018 10:08:18 +0200")
References: <20180823212738.18431-1-geert@linux-m68k.org>
        <20180824080817.GA6651@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Date:   Fri, 24 Aug 2018 11:20:35 +0300
Message-ID: <87pny8jhv0.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> writes:

> On Thu, Aug 23, 2018 at 11:27:38PM +0200, Geert Uytterhoeven wrote:
>> With gcc 4.1.2:
>>=20
>>     drivers/net/wireless/mediatek/mt76/mt76x0/tx.c: In function =E2=80=
=98mt76x0_tx=E2=80=99:
>>     drivers/net/wireless/mediatek/mt76/mt76x0/tx.c:169: warning:
>> comparison is always true due to limited range of data type
>>     drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c: In function =
=E2=80=98mt76x2_tx=E2=80=99:
>>     drivers/net/wireless/mediatek/mt76/mt76x2_tx_common.c:35:
>> warning: comparison is always true due to limited range of data type
>>=20
>> While assigning -1 to a u8 works fine, comparing with -1 does not work
>> as expected.
>>=20
>> Fix this by comparing with 0xff, like is already done in some other
>> places.
>>=20
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Ack for mt76x0. I think Lorenzo already posted patch for mt76x2.

Yeah, Lorenzo's patch is here:

https://patchwork.kernel.org/patch/10570555/

As Geert's patch seems to be more complete I'm planning to take Geert's
version.

--=20
Kalle Valo
