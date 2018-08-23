Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7387C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61723208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WU+tBu7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61723208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbeHXCpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:45:33 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42138 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbeHXCpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:45:33 -0400
Received: by mail-lj1-f195.google.com with SMTP id f1-v6so5429982ljc.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QBXIMofpR3cuEx2GwFD1N8xdDQOs3VI3zhz3GJA67HE=;
        b=WU+tBu7OBS66qeBFnjgYsYQc8/qM9+9IBHkAFPzl2mfUbwa/pK6YdD814Nw1n5i206
         e8Zc4AXqs/SQ783Oi7iDlqtfExNwWJGD5EO7H/dQgcFKQ8O0keBj9JyGy5Twtaf7qLGw
         k3scAxFv5SUiO3UbEUHuoJzWwghp/vlRI896g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QBXIMofpR3cuEx2GwFD1N8xdDQOs3VI3zhz3GJA67HE=;
        b=Ug7HpV5EXGOVyDpDkiBkD6XLZJhp/JD5bYHz/rvbewsFHDeCy6WFexEKtQyl54WCbs
         FTIEeJnnsfmtVKgjsnhzfYGg0tK79d/ZP5CtbVQ1ut36SLW4ja8aE/1IP2PvRDzm+9Gr
         YhDcWRFpefgcN+r3dI3sX72zTpfknTWcycSmdiGxCYPexCEvn3RJ+71tuvjdi67RSRSY
         XvCCMf71Fh1X0SbnL+iXRi9F0ZcVl12eL2+6keRVS9oP8bEalMA2vW22RwPDqyfz+3J7
         YAIQrbAAr9w248rzXOiuU57w2N2BTtHidAkEA8g1xxxqsBWVz5HoBxlFU/qo1TKaade8
         WApA==
X-Gm-Message-State: APzg51DKjhXi3aHksZdi9S4U/YqN15vRd7hDg9pW1My75fHH9/PfZeT9
        8PGHFDuQC7zQuX8FgR34ZTIJyJv3Q1k=
X-Google-Smtp-Source: ANB0VdbKopE9r5YHMAjLbR3MjhZeGduCeJYY9xlTWkY0z9OGTCKFfZtAAybVl8zmTw4XBsOdhEEh2Q==
X-Received: by 2002:a2e:54b:: with SMTP id 72-v6mr4583124ljf.152.1535066017353;
        Thu, 23 Aug 2018 16:13:37 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id a4-v6sm1055382lfe.54.2018.08.23.16.13.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 16:13:37 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 203-v6so5424626ljj.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:13:37 -0700 (PDT)
X-Received: by 2002:a2e:89c5:: with SMTP id c5-v6mr18857779ljk.19.1535065686985;
 Thu, 23 Aug 2018 16:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <1534550915-18230-1-git-send-email-vnkgutta@codeaurora.org>
 <1534550915-18230-4-git-send-email-vnkgutta@codeaurora.org> <CAE=gft4vheqe9Yqb3H_gMChUmQqvmBeeWvKWCf_j4sWrFceFiQ@mail.gmail.com>
In-Reply-To: <CAE=gft4vheqe9Yqb3H_gMChUmQqvmBeeWvKWCf_j4sWrFceFiQ@mail.gmail.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 23 Aug 2018 16:07:30 -0700
X-Gmail-Original-Message-ID: <CAE=gft6GTuk+j81J+jTNqD_6VFQym=gb6aJ==cbcg-6odVq3qg@mail.gmail.com>
Message-ID: <CAE=gft6GTuk+j81J+jTNqD_6VFQym=gb6aJ==cbcg-6odVq3qg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drivers: edac: Add EDAC driver support for QCOM SoCs
To:     vnkgutta@codeaurora.org
Cc:     robh@kernel.org, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 23, 2018 at 4:04 PM Evan Green <evgreen@chromium.org> wrote:
>
> On Fri, Aug 17, 2018 at 5:08 PM Venkata Narendra Kumar Gutta
> <vnkgutta@codeaurora.org> wrote:
> >
> > From: Channagoud Kadabi <ckadabi@codeaurora.org>

Also checkpatch.pl complains a bit about this patch:

            WARNING: Non-standard signature: Co-developed-by:
            #14:
            Co-developed-by: Venkata Narendra Kumar Gutta
<vnkgutta@codeaurora.org>

            WARNING: please write a paragraph that describes the
config symbol fully
            #63: FILE: drivers/edac/Kconfig:460:
            +config EDAC_QCOM

            WARNING: DT compatible string "qcom,llcc-edac" appears
un-documented -- check ./Documentation/devicetree/bindings/
            #536: FILE: drivers/edac/qcom_edac.c:430:
            + { .compatible = "qcom,llcc-edac" },

            total: 0 errors, 3 warnings, 533 lines checked

-Evan
