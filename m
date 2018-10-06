Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404F5C00449
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 00:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0B96213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 00:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i6Nwshzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0B96213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbeJFHFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 03:05:24 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46790 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeJFHFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 03:05:24 -0400
Received: by mail-yw1-f65.google.com with SMTP id j202-v6so5943815ywa.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 17:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HMSE6orMcmHkT2mznbA9dUcPMyTPZXa48sNNzlO0+58=;
        b=i6NwshzgwU7p1ZMqUx8Mnrhvq3vm/KFXIziIcg/g8tznm15ZVMSOSKMw/nw7vEssYL
         FXH1EGJLgaouLa343tOvGmuWEYMti54aSRyecqv0DUYI/nz2afw3jokrHJE0LMH2kLBR
         Gb5MmByCKOwD6AnYMhNU4+V7gYUJeDh2GI7l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HMSE6orMcmHkT2mznbA9dUcPMyTPZXa48sNNzlO0+58=;
        b=kjVfQOjVQLErHod86K3sAPaBVzNKfFMfK21ACCsei+rVvJPGTx7EZwqCG4Q4DXPjz4
         VWO4fKintnzUf7pBb0zHUGYpCGrUdGpOELT9QriL4zKlGoQoTTFCUrcjvi2mn3UfTDp3
         8qhxfoXl1v4uHNAIAoEQnfZ1/N4y949t507BASHVsEVPlheWDIDTgYlGS74XpXCFgIay
         TV4MILRMqRnRGiKKlohLfkdfsscE5mPi1pQTA6VtP/mqob7G4Uol2S41UUzyRkys0+Dd
         JhItaVjzdGXbEJybPZIg1oEoQsuf579fJ49XjsSbNBPPRhteJUULl8TpvaKgdC14XWzD
         /5sw==
X-Gm-Message-State: ABuFfoiEmAfXQjLYYtXEsXLjSP/hZGjAbQ245XGZVOvFM8LjpOYJiT17
        y9+FOZwDXJafLluBwLJxip6sMUzU0AE=
X-Google-Smtp-Source: ACcGV62qcnCGph1FMLID41KqjLhf460jAOqKT9sEROqq1/GuHMSKs79tSB4HnvS6LOYBLRe+gegjRQ==
X-Received: by 2002:a0d:f0c1:: with SMTP id z184-v6mr7671962ywe.479.1538784259682;
        Fri, 05 Oct 2018 17:04:19 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id l30-v6sm8188026ywa.104.2018.10.05.17.04.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 17:04:18 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id y76-v6so5963577ywd.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 17:04:18 -0700 (PDT)
X-Received: by 2002:a0d:cd84:: with SMTP id p126-v6mr7956103ywd.288.1538784257867;
 Fri, 05 Oct 2018 17:04:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Fri, 5 Oct 2018 17:04:16 -0700 (PDT)
In-Reply-To: <20181005235131.GA27193@kroah.com>
References: <20181005233559.GA37919@beast> <20181005235131.GA27193@kroah.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 5 Oct 2018 17:04:16 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJfs0KpRa6yag=ud0sJVW-tM-E4xuvgCMnBdFfDck5E1g@mail.gmail.com>
Message-ID: <CAGXu5jJfs0KpRa6yag=ud0sJVW-tM-E4xuvgCMnBdFfDck5E1g@mail.gmail.com>
Subject: Re: [PATCH v4.19-rc7] treewide: Replace more open-coded allocation
 size multiplications
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 4:51 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Fri, Oct 05, 2018 at 04:35:59PM -0700, Kees Cook wrote:
>> As done treewide earlier, this catches several more open-coded
>> allocation size calculations that were added to the kernel during the
>> merge window. This performs the following mechanical transformations
>> using Coccinelle:
>>
>>       kvmalloc(a * b, ...) -> kvmalloc_array(a, b, ...)
>>       kvzalloc(a * b, ...) -> kvcalloc(a, b, ...)
>>       devm_kzalloc(..., a * b, ...) -> devm_kcalloc(..., a, b, ...)
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Has this had any testing in linux-next?

No; they're mechanical transformations (though I did build test them).
If you want I could add this to linux-next for a week?

> And when was "earlier"?

v4.18, when all of these were originally eliminated:

026f05079b00 treewide: Use array_size() in f2fs_kzalloc()
c86065938aab treewide: Use array_size() in f2fs_kmalloc()
76e43e37a407 treewide: Use array_size() in sock_kmalloc()
84ca176bf54a treewide: Use array_size() in kvzalloc_node()
fd7becedb1f0 treewide: Use array_size() in vzalloc_node()
fad953ce0b22 treewide: Use array_size() in vzalloc()
42bc47b35320 treewide: Use array_size() in vmalloc()
a86854d0c599 treewide: devm_kzalloc() -> devm_kcalloc()
3c4211ba8ad8 treewide: devm_kmalloc() -> devm_kmalloc_array()
778e1cdd81bb treewide: kvzalloc() -> kvcalloc()
344476e16acb treewide: kvmalloc() -> kvmalloc_array()
590b5b7d8671 treewide: kzalloc_node() -> kcalloc_node()
6396bb221514 treewide: kzalloc() -> kcalloc()
6da2ec56059c treewide: kmalloc() -> kmalloc_array()

The new patch is catching new open-coded multiplications introduced in v4.19.

-Kees

-- 
Kees Cook
Pixel Security
