Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DA7C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0121020827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uigLF1K+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0121020827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeKEM6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 07:58:20 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43467 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbeKEM6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 07:58:19 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so12464403qkr.10;
        Sun, 04 Nov 2018 19:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4dkeUMbr8EKhVUR0l3Nr9X0+wZC2nOn4tfLbUjniIZg=;
        b=uigLF1K+NfYiVmAOCRW57mofkLMfZ+ZyXrFBY8BeTeycpjSgBl1wOgs57K2tdhqua7
         6w8LF2/1AWpRsyYLLMGTWSer5Rroa9JawdJXDF8jc8URfBNsJ3zOW5PABrf/J6iukCI6
         9KpkR6FZ42yl0hOfoSh0usaYrsGBLctEcQoixxs/mrcnLMjzfEStui/wdvVSbZl27852
         ScICQBqMv0u7CSWD0xz7CnBcP7vmza8OxdTbF7I1hN7aabJN28IkGaKlexoz4BSdv+MV
         seHxvRe/rOKCQPri/a2NPIAYQiVXQxuDUE6x6bN4dlP+9Bz5xqxawRQK+wG9Xy6AVvCS
         V5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4dkeUMbr8EKhVUR0l3Nr9X0+wZC2nOn4tfLbUjniIZg=;
        b=AN2Vf0klk2zkQLihRq0l6yNooPMm61ZMjgj8I2If1Xv5i5u31YOu23cQG5LepBOkhT
         2hQyt8zCkXxoPp7cPehfVN2iPRY8C3eyxb3kxjsaNqi7gbnMPbwC0oMSLlXN2lQdF9Qa
         2L1yr7wBWNs2TI+PkisRfIboVbmSOJAacbbUf8HehYmYv9Dvar+hY0vew9OhMqNE7d2F
         3zLwOSkzlMEJxk1mNgNYN+JdXtFhRK21XhItqViF1ItNN6PoCIPnxnaOdsLbAuxN4xKr
         PvTiwmoLvWrjgVp7mg6YNnrXvf75y7DLMYMaR7eCuzsl3kEq3Rf8Lc2f7kaOT8zTXieb
         susA==
X-Gm-Message-State: AGRZ1gIbg4RwtxPMxP+MLw2jyvKV062ebcxFzGoXzwnCFdKGsEjWSIk0
        cCzaevBdWFiS+vSLhrYH5KImT/enqA8it7eaII0=
X-Google-Smtp-Source: AJdET5funyAdrKFv94eQMqshyCGIRFam5x5MnpBHQt2Uygr8zqG1s4EAUx6u2EhG1PJlgCmmkFT7hXl5L2J7VgThMuA=
X-Received: by 2002:a0c:a802:: with SMTP id w2mr17137259qva.198.1541389246487;
 Sun, 04 Nov 2018 19:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20181102160710.3741-1-v.mayatskih@gmail.com> <baca6444-0ef8-2b3b-4ff9-84737f4ecd32@redhat.com>
In-Reply-To: <baca6444-0ef8-2b3b-4ff9-84737f4ecd32@redhat.com>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Sun, 4 Nov 2018 22:40:34 -0500
Message-ID: <CAGF4SLhvhdO4UXOwmv-65VJ0suid8xFm819_tZa+caUCuv+HRQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] vhost: parallel virtqueue handling
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 4, 2018 at 9:52 PM Jason Wang <jasowang@redhat.com> wrote:

> Thanks a lot for the patches. Here's some thoughts:
>
> - This is not the first attempt that tries to parallelize vhost workers.
> So we need a comparing among them.
>
> 1) Multiple vhost workers from Anthony,
> https://www.spinics.net/lists/netdev/msg189432.html
>
> 2) ELVIS from IBM, http://www.mulix.org/pubs/eli/elvis-h319.pdf
>
> 3) CMWQ from Bandan,
> http://www.linux-kvm.org/images/5/52/02x08-Aspen-Bandan_Das-vhost-sharing_is_better.pdf
>
> - vhost-net use a different multiqueue model. Each vhost device on host
> is only dealing with a specific queue pair instead of a whole device.
> This allow great flexibility and multiqueue could be implemented without
> touching vhost codes.

I'm no way a network expert, but I think this is because it follows a
combined queue model of the NIC. Having a TX/RX queues pair looks like
a natural choice for this case.

> - current vhost-net implementation depends heavily on the assumption of
> single thread model especially its busy polling code. It would be broken
> by this attempt. If we decide to go this way, this needs to be fixed.
> And we do need performance result of networking.

Thanks for noting that, I miss a lot of historical background. Will
check that up.

> - Having more threads is not necessarily a win, at least we need a
> module parameter to other stuffs to control the number of threads I
> believe.

I agree I didn't think fully about other cases, but for the disk it is
already under controll: QEMU's num-queues disk parameter.

There's a certain saturation point when adding more threads does not
yield lot more more performance. For my environment it's about 12
queues.

So, how does it sound: the default behaviour is 1 worker per vhost
device. If the user needs per-vq worker he does a new VHOST_SET_
ioctl?
-- 
wbr, Vitaly
