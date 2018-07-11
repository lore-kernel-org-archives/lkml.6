Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5C0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3840C20C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="swTZh0uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3840C20C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbeGKQEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbeGKQEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:04:42 -0400
Received: from mail-yw0-f174.google.com (mail-yw0-f174.google.com [209.85.161.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E32D20C0B;
        Wed, 11 Jul 2018 15:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531324783;
        bh=yuJtATNcTluX0YYvzolm37e7lk3R3Jk4xIGag1bxLyc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=swTZh0uuPa7OkI7if6b8FtidNNCLEtitjkF/Cegl8+HoLRQ1wBZl16fc3Sh1fnVxW
         u00udz7pIb/HNdGeqUzkmpZ54zKapd54BYHTai/tPKz5D9TCscLaIgCd+BPWs+Qk9W
         utZE/A/pb/haFfMneYnPgQx7kTJvVYVO54numuu0=
Received: by mail-yw0-f174.google.com with SMTP id q129-v6so6520862ywg.8;
        Wed, 11 Jul 2018 08:59:43 -0700 (PDT)
X-Gm-Message-State: APt69E1Rtfn4CcPle3vP2dd184pDrhERi75i65R4+TUaQmgo+JL4PC0D
        Lh05UWoUqiiz4kjs71AseenZJjdh62dlU2adoSg=
X-Google-Smtp-Source: AAOMgpdlRbHJ5n5oTL+ZIxUQvb/mQKSqSfYiYgBOUUzPh65vbt0TFxYn3CDVzVf06YYHnTbqXI9n+RHf+wFZqQLgEck=
X-Received: by 2002:a81:a348:: with SMTP id a69-v6mr12202243ywh.142.1531324782340;
 Wed, 11 Jul 2018 08:59:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:8182:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 08:59:01
 -0700 (PDT)
In-Reply-To: <5553262.evi6GU8epL@pcbe13614>
References: <5553262.evi6GU8epL@pcbe13614>
From:   Alan Tull <atull@kernel.org>
Date:   Wed, 11 Jul 2018 10:59:01 -0500
X-Gmail-Original-Message-ID: <CANk1AXRewvAAxRi=kmCNL3CEki9ODk7LvLS6q8Hd64JRanyfew@mail.gmail.com>
Message-ID: <CANk1AXRewvAAxRi=kmCNL3CEki9ODk7LvLS6q8Hd64JRanyfew@mail.gmail.com>
Subject: Re: fpga: fpga_mgr_free usage
To:     federico.vaga@cern.ch
Cc:     linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 7:38 AM, Federico Vaga <federico.vaga@cern.ch> wrote:

Hi Federico,

> Hi Alan,
>
> I have another point that I would like to discuss. It is about the
> usage of 'fpga_mgr_free()' which does not look like consistent.
>
> This function, according to the current implementation, can be used by
> an FPGA manager user and it is used by the FPGA manager itself on
> device release. This means that the user can only use this function if
> fpga_mgr_register() fails (to clean up), otherwise the user must NOT
> use this function, otherwise we most likely get an oops (NULL or
> invalid pointer). The example here is correct, this is what we should
> do:
>
> https://www.kernel.org/doc/html/latest/driver-api/fpga/fpga-mgr.html
>
> But I suggest to document it better or prevent this type of mistakes
> from happening. Following a couple of proposals
>
> ------
> 1.
> Document it better. This is easy, in the fpga_mgr_free() kernel-doc
> comment we explain that the use of this function must be limited to
> clean up the memory on a registration failure. If an FPGA manager has
> been successfully registered then it will be freed by the framework
> itself.
>
> But still, this does not prevent an oops from happening.
> ------
> 2.
> Remove the fpga_mgr_free() from fpga_mgr_dev_release() and ask the
> user to free the manager when necessary.
>
> This makes the usage consistent: the user creates and destroy its own
> objects. This is also consistent with our other discussion where we
> said, among the other things, that the module that uses the FPGA
> manager can the owner of the fpga_manager data structure.

You're not the first to complain about this.  I think I'll err on the
side of consistency and implement your option 2 here.

Alan
