Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA0DC46463
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 532F12147D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 22:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532F12147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbeKUIsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:48:25 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:38095 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeKUIsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:48:24 -0500
Received: by mail-qt1-f179.google.com with SMTP id p17so1828645qtl.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 14:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=f2be768KpYJmoX92KNv+AIY/+GetthIEWypj9odidEc=;
        b=fSVmAbqPBsqM/hYqoiMZPFiw3Ut62H75jFa578GfUfl4RsFPxyAfnqX+okfZ6h7SPA
         w4Bd9utOJbZcI6cMHi3Mx98emY5fIgSzraACIAGV1ipu/jk98XP0Ojs7qnA9UuXVoTJi
         M/znHxxBJaYO7dGQ5pgvTq3w0cEENQifY/QNIRQfJ/9JZd9TdYUFBEsoJGfXY7kiMWYS
         j5Sf6Bl2dp8zzV7RlEUoWlxkQMa+7KKWKGW8gUoPAZQf/Cqdjqk9jYMgiC9UKHnXPCaM
         gs9XAfmSO/bra9nEs1AEl6M+VZS9cQWcFmm6OApjlA5JX72bW66zP0Li98xNJ16xznHZ
         85nw==
X-Gm-Message-State: AA+aEWYjX1N4QjQAz7ue4FD+mPQ6/7KNv0JPxrjyIX+lJoK0Mh/BOGGd
        GPUjpjvEQBdoXf5aIV7lH+U=
X-Google-Smtp-Source: AFSGD/WsA/1UzFC8xULvTqWAEilY6SarwusywNf5SsEcGAHhTQ8kmDo/jE5rv82r4H2FWPTKj+K0Pg==
X-Received: by 2002:a0c:8936:: with SMTP id 51mr3735578qvp.220.1542752222890;
        Tue, 20 Nov 2018 14:17:02 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::6:b015])
        by smtp.gmail.com with ESMTPSA id j95sm18911288qtb.74.2018.11.20.14.17.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 14:17:02 -0800 (PST)
Date:   Tue, 20 Nov 2018 17:16:59 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Eddie Hao <eddieh@google.com>, Vlad Dumitrescu <vladum@google.com>,
        Willem de Bruijn <willemb@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: LPC Traffic Shaping w/ BPF Talk - percpu followup
Message-ID: <20181120221659.GA61322@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie, Vlad, and Willem,

A few people mentioned to me that you guys were experiencing issues with
the percpu memory allocator. I saw the talk slides mention the
following two bullets:

1) allocation pattern makes the per cpu allocator reach a highly
   fragmented state
2) sometimes takes a long time (up to 12s) to create the PERCPU_HASH
   maps at startup

Could you guys elaborate a little more about the above? Some things
that would help: kernel version, cpu info, and a reproducer if possible?

Also, I did some work last summer to make percpu allocation more
efficient, which went into the 4.14 kernel. Just to be sure, is that a
part of the kernel you guys are running?

Thanks,
Dennis
