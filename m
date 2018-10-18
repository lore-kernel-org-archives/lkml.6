Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF99EECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BD520866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mt2S6KjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BD520866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbeJSGpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:45:05 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40104 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeJSGpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:45:05 -0400
Received: by mail-lj1-f181.google.com with SMTP id r83-v6so29165551ljr.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FPgNYC9Wo3HfP/bcQeFolpgGa809OtH9KLcnjIBG4A=;
        b=Mt2S6KjDtfo/o1ZgZHEvBvXIcEvaYhcuotzC2SywQjccz4KAAhGgIq3zpA5JxoN7lJ
         GKAy1B1BkV8sAVrxH5g1chkQfRVL5RHD+dEnqRTWDadAC9F/ngts0gL6/0m7CwoeiIJO
         MfFQRzXwPsB68DL82Fgqy/cQqC1fHNLYeZ5iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FPgNYC9Wo3HfP/bcQeFolpgGa809OtH9KLcnjIBG4A=;
        b=fUzhYer32q9hZgR65Fd/DhcHg3YWOFZAhGQOjNpvXF7IkVGbR9y+JYGJ187iUtXIoR
         r5KVJSXd8ELl1Z/Yn4UUavLkQNr6YCOHI9nsv/XmhtimLaHVmW4kbYDde95ZMZtox9TN
         7JTJ3CEAC2p436V/M/hj2wiOWZHG9swlsEyfYJRTkpc43lWriUkNPErksC7JiAQOgPKR
         5+sc1d4chLIsb+a9E2CURnM+BUkNZG4cH6Wi7dgujmEN4ZumQqgA1nLR2VvuyiFZzYFW
         t08YHLRfKEgyfJENwQ5BoSVjCuPB8xIe13u906sWgBCM7zD7+dvTpHv6h6pIjZTXMMc2
         mscA==
X-Gm-Message-State: ABuFfohLJY6pQPWgLYvn/z+IAx7j5xXwXuX2DzF+tbrOKWYf8xph498r
        zjHMKxa3kpL8Su98xdzL9Vy4CGQ+zNg=
X-Google-Smtp-Source: AJdET5dRXOcnQGQ4/gPBoyeYwaDa8Qg1EjWM4lBvq/w2UkdVQeqzdYvk3Mss71K+B4kf0cXotHFdkw==
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr1577427ljh.59.1539902514209;
        Thu, 18 Oct 2018 15:41:54 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id z19-v6sm4837174ljk.20.2018.10.18.15.41.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 15:41:53 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id o14-v6so29205845ljj.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:41:52 -0700 (PDT)
X-Received: by 2002:a2e:9d05:: with SMTP id t5-v6mr8572156lji.57.1539902511968;
 Thu, 18 Oct 2018 15:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20181018220350.220357-1-evgreen@chromium.org> <153990178286.53599.2223333358659390565@swboyd.mtv.corp.google.com>
In-Reply-To: <153990178286.53599.2223333358659390565@swboyd.mtv.corp.google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 18 Oct 2018 15:41:15 -0700
X-Gmail-Original-Message-ID: <CAE=gft48VyPFAGdxzZ7QK=ixUwU_+PXVux7iq+YH+t-u1pAvLw@mail.gmail.com>
Message-ID: <CAE=gft48VyPFAGdxzZ7QK=ixUwU_+PXVux7iq+YH+t-u1pAvLw@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: Remove unused arrays in SDM845 GCC
To:     sboyd@kernel.org
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 3:29 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Evan Green (2018-10-18 15:03:50)
> > This change removes a parent map and parent name array that
> > appear to be completely unreferenced.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
> > ---
>
> Applied to clk-next. Can you change your commit text style going forward
> to match Documentation/process/submitting-patches.rst, section 2, for an
> "imperative mood"?
>

Thanks. Will do.
