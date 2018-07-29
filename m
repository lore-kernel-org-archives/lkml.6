Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B63C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 15:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10B220881
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 15:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2jIwzVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10B220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeG2R2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 13:28:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34927 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbeG2R2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 13:28:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so10071411wrt.2;
        Sun, 29 Jul 2018 08:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=qik5EZhO6nCv6/GEahsT+raUFb0n02OsuKth8kudm0U=;
        b=Y2jIwzVzMUyKAL2xUU5oaNql0cTk+v2Ul++fMHHo0QVKFyV3rJvhcaxiQgh+IJBTEK
         IDVs8DEvaLMvlARpCSUoJEpBXpuNmCjQDida/r3I5rN0Q7AUzPHqNax5cY+JupV4m7fb
         VPGni7L8gcS0cXVLzFGvj2PKaDDZtVy1Zv90Ei4+EoTOS55uppeBAntVQnetsKn14VU6
         wN0u74pFWzNX8YTmi14WhknKjgN77B/KCKfPqDKJlQuNpkpJ1DpoxQjgOgYqj6P3XyE5
         S34jaez56CiQxqe4m9ceP7dCwdACrjalvw29c/4yBUMuRUwfIP6cp8e1pPT9GY+CJYKC
         3pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=qik5EZhO6nCv6/GEahsT+raUFb0n02OsuKth8kudm0U=;
        b=PEDM5MQGId5GwauCQrdONDz9w6I/BGsneZHGpWFHrTdM9HXuGrPvXYyacb0N+0WJIZ
         9ocFMDG59RhKIoX2d1Lshjb7l7lZkn32nUa2s2c8NrMe7elYbbMc+qrnU5+gAsDNqmME
         8sAGn4O9FaFLceU9FsQd8HgQh9cibeci+t4cGGkPCBSnVLpm7m0a9E8y9AzxOdtF5hEx
         WYQZUIpyJGXxRBG8WxULIpFSapbpCz9dYqY1GcqZ0AzT8phn1Urd4mw2XKlm7ZqWFfGG
         tOGQ4jMGBG4kngwCfiyn/LY8uVGNTz7xQrRgwdXv6M15FgxttGpp8j3KntmR/pq8kikz
         +7RA==
X-Gm-Message-State: AOUpUlEVobYD1BIZcxsWk2oSYkbW/E86IPTNb3UXcEw4KXrO/XPFqGup
        +Zo29Lw+L+jUPg51IzPDa+2BAH6pz9wo1oV5XhE=
X-Google-Smtp-Source: AAOMgpe/kNqdo74LklaeBSrU1B3jy6HegqfsHX8dralVLImpugTKoNQkElibgZwO50nsxJmH+infDPva6VlQ15mwbEk=
X-Received: by 2002:adf:ba12:: with SMTP id o18-v6mr14493157wrg.249.1532879847255;
 Sun, 29 Jul 2018 08:57:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e64f:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 08:57:06
 -0700 (PDT)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 29 Jul 2018 18:57:06 +0300
Message-ID: <CAADnVQL=yTRvNLun2_oiwDvUvpvTV9=pOLyNhu=_cQ2sX04p5w@mail.gmail.com>
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
To:     Daniel Colascione <dancol@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        Chenbo Feng <fengc@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joel Fernandes <joelaf@google.com>,
        Alexei Starovoitov <ast@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 10:17 PM, Daniel Colascione <dancol@google.com> wrote:
> On Sat, Jul 14, 2018 at 11:18 AM, Joel Fernandes <joel@joelfernandes.org>
> wrote:
>>
>> By the way just curious I was briefly going through kernel/bpf/arraymap.c.
>> How are you protecting against load-store tearing of values of array map
>> updates/lookups?
>>
>> For example, if userspace reads an array map at a particular index, while
>> another CPU is updating it, then userspace can read partial values /
>> half-updated values right? Since rcu_read_lock is in use, I was hoping to
>> find something like rcu_assign_pointer there to protect readers against
>> concurrent updates.  Thanks for any clarification.
>
>
> I'm also curious about the answer to this question.

i'm not sure I understand the question.
bpf_map_type_array is a C-like array.
There is no locking of elements.
If single program executing on two cpus
and accesses the same value it will collide.
Same goes for user space vs prog parallel access.
bpf long_memcpy is an attempt to provide minimal
level of automicity when values are aligned and
size==long.
