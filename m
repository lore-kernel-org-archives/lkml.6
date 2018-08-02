Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C49C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BF22150E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 17:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ODa5YUIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BF22150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbeHBTHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 15:07:54 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:44556 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeHBTHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 15:07:53 -0400
Received: by mail-io0-f196.google.com with SMTP id q19-v6so2598591ioh.11;
        Thu, 02 Aug 2018 10:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zr+QMBFeFm5iKYvjvtJBuG2IB1pyP4f3pvMBYQBTMH0=;
        b=ODa5YUIn+d+Ph6Q7pWhxq6Z9pL8fAdnttG6w9igrh+tLJtVGskHpbIbPnDV+Qmjdpp
         IEcWr/fJvne1sZMK1tEZMuhddGA3+LUDHGV9WYSXbDQLAlJSbG8v+CSwZbwW0JTBiK0e
         HAFoypYpIWKHX+bWY4R//kpP54XIKXiRy8txY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zr+QMBFeFm5iKYvjvtJBuG2IB1pyP4f3pvMBYQBTMH0=;
        b=FiV867KcfN8IqbfVBjCIWTsRhtIdDg2Y60eyGRUqguuPQtcPDWnK1Rag7+Ylz1yh8W
         h1aHLzuTM/GdAZIyb1AddgP1Vcytaiz5BbWmD/K4qjbzYGpL8GRmntVnu90olPQRaBxB
         oaziV/RXZgwcST3sHF7BhNW2NbRAGXazuZzwPNw4ur7qg49D6DlVDwQuA7m/w7Xvltkc
         xqqukmJILC88/kETAGk9dLsNgQPGqM/eFbVS3GiiQSYV8LV3L4sUpbU3CkCXyYCu1ddC
         kFIjun1VXcfsAAdVt8xpIiCPWpEx6IJxygU9BdEsRNE7i3rgYUi4mfaxViYJmkgt7wXj
         WxGw==
X-Gm-Message-State: AOUpUlGj4lEzX2+ouSZjvT7s2+0Tt/xMqd3aIMQW1ZN6HFmme7XtuUPs
        DaWVsXN+ZwIMCiryHJBLbUz2mHuYImPLkTKee86KtEl6
X-Google-Smtp-Source: AA+uWPw73F2RBbaDoqJc2RjuCX8qP1I0EP5tPtFJlQ+P0QVp6K08wN8lVBOPOyaQcjpUxjiZnTEhX5/kuehDv9kyDGQ=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr3333912iom.238.1533230151277;
 Thu, 02 Aug 2018 10:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180801.213753.1303803168352407122.davem@davemloft.net>
In-Reply-To: <20180801.213753.1303803168352407122.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Aug 2018 10:15:40 -0700
Message-ID: <CA+55aFz5EWE9OTbzDoMfsY2ez04Qv9eg0KQhwKfyJY0vFvoD3g@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 9:37 PM David Miller <davem@davemloft.net> wrote:
>
> Fixes keep trickling in:

Pulled.

Btw, on an unrelated issue: I see that Jason actually made the pull
request to have wireguard included in the kernel.

Can I just once again state my love for it and hope it gets merged
soon? Maybe the code isn't perfect, but I've skimmed it, and compared
to the horrors that are OpenVPN and IPSec, it's a work of art.

              Linus
