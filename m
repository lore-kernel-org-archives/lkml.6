Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0FEC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C572120652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpBs2C28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C572120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeJHSG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:06:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39153 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeJHSG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:06:28 -0400
Received: by mail-qk1-f193.google.com with SMTP id q5-v6so11748914qki.6;
        Mon, 08 Oct 2018 03:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPtrMqlUB495o7e7WALIBw1M2Vie4Dg+l9YdC5YpcwE=;
        b=fpBs2C28n8YCMU4sokfCnxcBr7SCxLyn9W4uopEgscTt4aNJzSNRdynibkeNcgY7M1
         ZJpojf8siw0D1GQBuWYsb1vFJwMUu2v+wrwe5Wud3X9wtSNETH2GRIoUU5j/Jw2swiFV
         dJagCy+fHqEuJ/ICCMo1Tp7Ii1zY3CnC/Fj34xa6uEhUh8NC6bgTh+5YvoJQgrZ4mXqJ
         lae+Aqm5Fex4zIfWnGNUyP0rQ22/DRUejYwmU8O2YKrgHW3sjjUY4/6STrgOteP7VQKZ
         pvdZud+KYm1iUyvPyDg6hlFJ1DWq5ISABko9qK8JyD0uKucrd8eTADvHoihakSB6RWu+
         PbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPtrMqlUB495o7e7WALIBw1M2Vie4Dg+l9YdC5YpcwE=;
        b=m5mSQgoe5jZBfGVINZgF9MkaFTIaC3dafQGuDCdO5OmMFqb3MMIkjYp7jlGVgrE7Xk
         guF3SjTbXuy5+EPIQieQ75AV2AH7zfM+D9yfVHBxL516KBZHFU+DflpsI9O0KovvPv1w
         P24INU1DQfPgf95LCldrqWpr9P9impkIkrJCLoWpOov80NzJs1fLU1eDGsOOVmaqm2O+
         bR+JeAiRI+5vNjbrCvt+zHsUeABOmOyxfLr5AxYSv9Oq2mPtfkbWdVQcpIlIEF5xIO/P
         RTK1TiUfm4C3Cq4ymBCruXnG9bTxrpnMWJ+/ZTG/UbE2XnBs6e6NNEyx0qMczsscUZ2y
         x88w==
X-Gm-Message-State: ABuFfohsbn+UlckgwRWhEN0AORRo3pi0hISocL7xF0yOco32sw56+Hx/
        VpKWjlQa/PAC7LGGcEqCp0yMfkCUJxn8Ze5J31U=
X-Google-Smtp-Source: ACcGV605jmJUDWjCu6bKp1+I8gsFsP8XgMEJg+y71lhhpe4ceWQk0keWEY/1o7RAOR2t4qZRkF3KcuQYG7BJCtaem9A=
X-Received: by 2002:ae9:c307:: with SMTP id n7-v6mr13653437qkg.70.1538996118871;
 Mon, 08 Oct 2018 03:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181008144838.60d8ad83@canb.auug.org.au>
In-Reply-To: <20181008144838.60d8ad83@canb.auug.org.au>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Oct 2018 13:55:07 +0300
Message-ID: <CAHp75VdVLV9YKSzatcAuq4YmitjaERV6mOTEWiWnRf_yoUGJAA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the drivers-x86 tree with the tip tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 6:48 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the drivers-x86 tree got a conflict in:
>
>   drivers/platform/x86/intel_mid_powerbtn.c
>
> between commit:
>
>   f2c4db1bd807 ("x86/cpu: Sanitize FAM6_ATOM naming")
>
> from the tip tree and commit:
>
>   a8b60e484f3d ("platform/x86: intel_mid_powerbtn: Get rid of custom ICPU() macro")
>
> from the drivers-x86 tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks!
Looks good to me.

> --
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/platform/x86/intel_mid_powerbtn.c
> index 5ad44204a9c3,a8c0fbb7f799..000000000000
> --- a/drivers/platform/x86/intel_mid_powerbtn.c
> +++ b/drivers/platform/x86/intel_mid_powerbtn.c
> @@@ -121,12 -112,9 +112,9 @@@ static const struct mid_pb_ddata mrfld_
>         .setup  = mrfld_setup,
>   };
>
> - #define ICPU(model, ddata)    \
> -       { X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, (kernel_ulong_t)&ddata }
> -
>   static const struct x86_cpu_id mid_pb_cpu_ids[] = {
> -       ICPU(INTEL_FAM6_ATOM_SALTWELL_MID,              mfld_ddata),
> -       ICPU(INTEL_FAM6_ATOM_SILVERMONT_MID,    mrfld_ddata),
>  -      INTEL_CPU_FAM6(ATOM_PENWELL,            mfld_ddata),
>  -      INTEL_CPU_FAM6(ATOM_MERRIFIELD,         mrfld_ddata),
> ++      INTEL_CPU_FAM6(ATOM_SALTWELL_MID,       mfld_ddata),
> ++      INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,     mrfld_ddata),
>         {}
>   };
>


-- 
With Best Regards,
Andy Shevchenko
