Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACC3C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87E7257E2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 14:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="V/hDslNp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRjMDuJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87E7257E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752279AbeGBOAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 10:00:17 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:42640 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752174AbeGBOAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 10:00:13 -0400
Received: by mail-oi0-f67.google.com with SMTP id n84-v6so16549329oib.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 07:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vpw6Ww1tpLgsBd6Nu8uo/mAKx/FeFyXKYaSP/QRgOhs=;
        b=V/hDslNpjeiKvLGZxdADc1r0R1Mzk3YkG81xPmQjZcKKwf7/exRyWxpXlS36VT6DGd
         t6NMKVuQwF8tMSSX3gqPepqPdPDxqzJPnMOsbOMWhs3iTKoMLG9oiMJR8vj132qn4rGx
         U0M7zi1iuZP7kh1icc+MgptslQyllIVmpN+58Q9yFioOEeIY6lS8EtfqMs+3LC6+5WVS
         nkdLItnSU8XL0zsZ6yqobZgx1RtD+weYfQkeIaYr6IFVi27ChmwhcpA/IDcrqAqZuInh
         RXK00tWG2z5soMmFTH5AfkCJhetiS4MXagqnfEYepo1FvwFzBV6xkhmLhyhOgwWzpx33
         J8cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vpw6Ww1tpLgsBd6Nu8uo/mAKx/FeFyXKYaSP/QRgOhs=;
        b=jRjMDuJYo7IL0YLCiU0JNSFieESsmNVZ0aaGvCX3U/QC9mW99X5wmajYjD5cDJADcE
         wglo32wwv6LizY6/fmnNTIpAQjMHWtkAKgdQxGzqC+AekteymGcdoacCXhE2JiP58NBe
         hyYFv6zNImL5jX0iG6sZNH1Coo+exDPItzNgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vpw6Ww1tpLgsBd6Nu8uo/mAKx/FeFyXKYaSP/QRgOhs=;
        b=cIMgah9+RIio4wRflZYsnehDbf9ZLa7/cjE7qmFSyLc7skZggxfjDbrODDaxHCChDX
         mpyV577MmsbQa3C1W809KLiABPBN24K4VN9P7xPsTc8/YLwhB3WnPFUusaC6PCnoG8D0
         3QqmvXKzwgwD8xKWHqjjKJIs5Mq5K/IurYbIeI4qXcDhLjFnwjoaCg/NUYcAQV/bKKRS
         Cmhd+dtD9w0XnqUd9r0KWv3DLsQzi8GNITGiVtwZW9db4TzY0ZkhiuInhcNTMqSEf1St
         0aN2HVlRKH91EdeERSu+JnCJBhQjy9Ti51SipV7Mg+5uo9IhSMPOFlk0sK98XlUDHytb
         66pw==
X-Gm-Message-State: APt69E3jjx8iLO63BrQgUlu6+zl2aCS9Pw0m6YTTlk/Eiyb1ArTahJvH
        sEVGz+ipfBDnxGT/liHRXNii+p+lr3ykDbh5MS2uBxNW6/E=
X-Google-Smtp-Source: AAOMgpcCjyzUrj4C/AoInFz7N4W95qLdmOjvPAUDj6LQu9z/uFfMXQQq5VhP1OLq/b4liNqH2ml+MYu7lnzHISwOLEM=
X-Received: by 2002:aca:b1c1:: with SMTP id a184-v6mr4147222oif.182.1530540012206;
 Mon, 02 Jul 2018 07:00:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:3745:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 07:00:11 -0700 (PDT)
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 2 Jul 2018 19:30:11 +0530
X-Google-Sender-Auth: Nt0yT9EWSpyfUpZdWScNuhrAKd8
Message-ID: <CAHLCerNj83pYHDJg2aHoqOqJ6NEg+OWHT-RW4SDbEHrwJXYEtw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] thermal: tsens: Refactoring for TSENSv2 IP
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        smohanad@codeaurora.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 6:14 PM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> This series is a mixed bag:
> - Some code moves to allow code sharing between various v2.x.y versions of
>   the TSENS IP,
> - new qcom,tsens-v2.4.0 DT property for SDM845 and a generic qcom,tsens-v2
>   property as a fallback compatible for all v2.x.y platforms,
> - new platform support (sdm845)
> - a cleanup patch and
> - a DT change to have a common way to deal with the SROT and TM registers
>   despite slightly different features across the IP family and different
>   register offsets.
>
> Rob mentioned offline that we should expose the full version string of the
> TSENS IP (x.y.z) and have a fallback compatible. I hope patch 4 does what
> you were looking for.
>
> Regards,
> Amit

Forgot to append the changelog. Here it is.

Changes since v3:
- Introduce qcom,tsens-v2.4.0 property and make qcom,tsens-v2 a
  fallback, compatible property.
- Rename ops_v2 to ops_generic_v2

Changes since v2:
- Based on review, moved tsens-8996.c to tsens-v2.c and changed
  corresponding function names, struct names to allow for generic tsensv2
  platforms
- All v2 platforms will now only need to use the qcom,tsen-v2 property
- Added a DT patch to initialize tsens driver on sdm845, now that 4.18-rc1
  will contain an sdm845.dtsi

Changes since v1:
- Move get_temp() from tsens-8996 to tsens-common and rename
- Change 8996 DT entry to allow init_common() to work across sdm845 and
  8996 due to different offsets

> Amit Kucheria (6):
>   thermal: tsens: Get rid of unused fields in structure
>   dt: qcom: 8996: thermal: Move to DT initialisation
>   thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
>   thermal: tsens: Add support for SDM845
>   thermal: tsens: Check if we have valid data before reading
>   arm64: dts: sdm845: Add tsens nodes
>
>  .../devicetree/bindings/thermal/qcom-tsens.txt     |  2 ++
>  arch/arm64/boot/dts/qcom/msm8996.dtsi              | 12 ++++++-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               | 16 +++++++++
>  drivers/thermal/qcom/Makefile                      |  2 +-
>  drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c}  | 39 ++++++++++++----------
>  drivers/thermal/qcom/tsens.c                       |  6 ++++
>  drivers/thermal/qcom/tsens.h                       |  7 ++--
>  7 files changed, 62 insertions(+), 22 deletions(-)
>  rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (66%)
>
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
