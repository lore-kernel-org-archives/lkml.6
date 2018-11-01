Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CDBC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B46120820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 16:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gFywNIKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B46120820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbeKBBTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 21:19:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44888 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbeKBBTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 21:19:06 -0400
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so10035544lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8/2I94BzHlFUsSl5PRFmx2pEst1qsblbvcc9OxXz70=;
        b=gFywNIKV9A3o1p6ehVR6nzq6zwJGxmtYdbcmxb9LSKIyjdDXqBkqKrjuL7Q/P/9C+M
         4UlKIVgh+Jif5rRDgFThO4RDUuc3mDRS80LtMUGsJTdzIN1x6Q6JSozQz2RMZGwfCWD8
         Am16cPWBG09XaI7YolUrrLrj6o/8HRErjpBpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8/2I94BzHlFUsSl5PRFmx2pEst1qsblbvcc9OxXz70=;
        b=lSFqotRRfmQ6n9KnuZ6hXrosVzJegD3NzRzzHFCemIqzDWZ7lOeD7DFy9KB7gu93Li
         +GwsYbbQExde0H68pisVFU1o6otWhaUx4VeXI4SbmwL+RFN7EvwisdJDF1AUgLuzwXuc
         4+GnSFjCChJBOXb95NxmE609YUWvWTsSiVOyJhWArxBR35gGU4339pdtU1eqv1T7vGeM
         1NpTVy8TqyvmJz7yLcipFPzfST6cscCo+QKfZ2HY3QAo46HRkmCAmZs6m6HZT4D8/jvN
         lzVjLrlQ/bt0rEixnOqig4b3cCDhfAHmeYpob9W4TPacxVY3Eie04jJvmmZwfQJktJkQ
         wHvA==
X-Gm-Message-State: AGRZ1gJ3sKkSNDhrmkVNSierfX3hg74bInUuOwu9J6+ercixweF7wZzx
        B79BIUJf8HoLD/G+H9ramEd2TLeDj87UPA==
X-Google-Smtp-Source: AJdET5fNQ0ETHgIFWV1/OvzZqPHKsRmQD+pZroBM88rBMt/H/2q8o8ntzBZLCoHblTXVeLLpAf8iCQ==
X-Received: by 2002:a2e:7403:: with SMTP id p3-v6mr4176016ljc.97.1541088927157;
        Thu, 01 Nov 2018 09:15:27 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t5-v6sm5125916lfg.90.2018.11.01.09.15.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 09:15:26 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id q6-v6so14577200lfh.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 09:15:25 -0700 (PDT)
X-Received: by 2002:a19:cb94:: with SMTP id b142mr4951844lfg.117.1541088925090;
 Thu, 01 Nov 2018 09:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20181031.184418.1509890447175181068.davem@davemloft.net>
In-Reply-To: <20181031.184418.1509890447175181068.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 09:15:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibB2urbpfEZnNkEHw4MHNJXdFOc4VC3mk+GWKbeNckRQ@mail.gmail.com>
Message-ID: <CAHk-=wibB2urbpfEZnNkEHw4MHNJXdFOc4VC3mk+GWKbeNckRQ@mail.gmail.com>
Subject: Re: [GIT] Sparc
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        sparclinux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 6:44 PM David Miller <davem@davemloft.net> wrote:
>
> Two small fixes, please pull.

Pulled,

                    Linus
