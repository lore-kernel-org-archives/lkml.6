Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B832DC07D5C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633F32086D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X0MkJhrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 633F32086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933501AbeFMCmE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 22:42:04 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43305 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932869AbeFMCmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 22:42:02 -0400
Received: by mail-io0-f194.google.com with SMTP id t6-v6so1783815iob.10;
        Tue, 12 Jun 2018 19:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOfK/p+ZMsZuavq/UhIx63GhVZ3oKo4UXeTdSf78RK8=;
        b=X0MkJhrKZ8B0PK1ElXjJvUXWamhPWGO4bIwdQlSKP+0JPGy9GYGsulHa/g5a5h4gZm
         essP57PXGynwR/aWwEO6Woz4qSqlWRcoMMTAXqBSZDdtauIRMnPCH0ePEUwl2sLGN3XE
         GrQrGCzjHsskPQUFQMt0JE26iDuopYSfy66EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOfK/p+ZMsZuavq/UhIx63GhVZ3oKo4UXeTdSf78RK8=;
        b=QSWbsp3mUUn8qGVYZZVNh4zDj2zbGFZlCdrPYnfa/E6jkU64tISRIJuKXKX57x4WbL
         1/9cUYyQ4epSGRg+urVPya4t9h6Ip5XQj1zQYSgw/5QNWMFRrl5VQIA4FeoAU5wj1wqg
         nXdihkoEgU/FbOOl/RirhwG/OU+it0iyws1H/AFyXu5OOOmibFipX34Do5iBRnQXpHQY
         kXGBtLOHHtWEIyGuvVH72Yv+3RILPpRsJ8Njn2I+NRKu5z1E/AuLJvluScEXQ7VyaDOD
         MTXRnoZpdG38bT1m5LHEDvu8Lq3zy5smmgejrfZJjBhjHlEzkRhA6RdRJyy/ycwBF95a
         ErGQ==
X-Gm-Message-State: APt69E2F43Ig/uUPCayqBGmjFA+vWzcBNgoxdUAbruNWEijqF5xd1NxQ
        M+iheWF2z0BFyD2deHpc1doZo5Fvgcmaw1xhwAM=
X-Google-Smtp-Source: ADUXVKIXXxtay8I5J+DIzRfCdo4kZgRhpwYsyBo6Z82WQcpMcIrx9K4YmGr7HQh6KcXLyTeIWtyaKIAyiaGU1UHrr8Q=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr3146310iov.203.1528857721812;
 Tue, 12 Jun 2018 19:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com> <CA+55aFwvE5G7MV7AV4naAXdbFoszc4JNKEj_QtYqpLFfa2RXtA@mail.gmail.com>
In-Reply-To: <CA+55aFwvE5G7MV7AV4naAXdbFoszc4JNKEj_QtYqpLFfa2RXtA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 19:41:50 -0700
Message-ID: <CA+55aFza9udpsCY=_YuBoshgVoXSce-Ja-nsqRbm5eJ6MgXK1g@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 7:18 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The attached patch _may_ be the right thing to do. It's not pretty.

.. and when I decided to actually do some minimal kvm testing with
that patch, I notice that we've apparently broken kvm entirely during
this merge window, and I just get

  Error: KVM_CREATE_VM ioctl
  Warning: Failed init: kvm__init

when doing lkvm run.

Bisecting. But that's unrelated to the recent kvm build breakage.

               Linus
