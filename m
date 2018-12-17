Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799A6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDA0214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 20:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="arxHPzIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389556AbeLQUby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 15:31:54 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34279 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbeLQUby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 15:31:54 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so10505765lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 12:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqbw3DMvQBU8eaLAf9coNhVz/GN4ymPGp87RBHaV0EE=;
        b=arxHPzIcrvE54EF5Vb+Yt5VhNzFg8uHuyhok0Sy9yl4KHBGJLEWIc3vQ2by54oE14j
         LP8D45a0k9v8k7AGiMGtsORn5Z4c5EMrV+tSUsZEMheaL+MINv2cuBxCIkpNW/ANkxmH
         nIwu7EVEmMWe30nZXyc9V05eljnHS9wFY94og=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqbw3DMvQBU8eaLAf9coNhVz/GN4ymPGp87RBHaV0EE=;
        b=QEioK2YtoOvLZUvhlNf2BG0ghoxrq12XSLA4KjR+Y4xIscyzyTszG1N0CrHWapRETS
         NV/RaenyNNEWqBF7fEhXe/ZVuAhUxSYcLdpOsI7F1/LmSKDkxVxoaepd+ZtvLFp+NVpp
         cj6H9AGAtNbrNiViYTjrQfSLWoMNLdpMkuqLwKLZ5CMySNrk5xXIskuUXavvXfxCk0RU
         bOaOFIH9gcBSYahOdNp2i+iiVo8BLPK6NEIJeRGw5Bck5swjJVhwCOx5zcR/gqbya4U0
         /FLTvmoArHssZD0kSGk0oSIPf1TnAAQQshqswPvAZC5ithe3DsQZ2Py1CKo+cPxlyo56
         DCww==
X-Gm-Message-State: AA+aEWZjrCydyCNQ8g9YmsTw6SAngl/1greKf0SIKTuTIs8FeK47lafc
        CavIK1O5tSfjLGcpAzqhIITTbAKQyS4=
X-Google-Smtp-Source: AFSGD/V5FHf5sxQUfXxYSdy94xctFYYGhmLHQ8i7RzcDbGaAzMuJpEF2aAtuNqPxWRGZWD7Xl370vQ==
X-Received: by 2002:a19:d70f:: with SMTP id o15mr8678372lfg.134.1545078711566;
        Mon, 17 Dec 2018 12:31:51 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id u15-v6sm3208332lja.63.2018.12.17.12.31.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 12:31:49 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id c19-v6so12224977lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 12:31:48 -0800 (PST)
X-Received: by 2002:a2e:9819:: with SMTP id a25-v6mr9288670ljj.6.1545078708422;
 Mon, 17 Dec 2018 12:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20181128232019.GC131170@gmail.com> <20181217181244.220052-1-ebiggers@kernel.org>
 <CAHk-=whmh8WdcKHdYjioJNjyeewv=fO1H0hxXqDh6kiX0YvzmQ@mail.gmail.com>
 <CAHk-=wi8iGD8zHuPr38m9MUwDwf3qy2FYSbyoQ_Ygky+D-pU1Q@mail.gmail.com>
 <CAHk-=wjsMJeEkJbE3QhM3SY-DT9VsnMWNQKMNsG9TetnjREWDQ@mail.gmail.com> <1545078067.10804.13.camel@linux.ibm.com>
In-Reply-To: <1545078067.10804.13.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Dec 2018 12:31:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=whO8vApZK-4zBeEhUm4Mp-OMii1V9oVCmoOaGZ2faitcg@mail.gmail.com>
Message-ID: <CAHk-=whO8vApZK-4zBeEhUm4Mp-OMii1V9oVCmoOaGZ2faitcg@mail.gmail.com>
Subject: Re: [PATCH RESEND] KEYS: fix parsing invalid pkey info string
To:     zohar@linux.ibm.com
Cc:     ebiggers@kernel.org, James Morris James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:21 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> It's being used for parsing and displaying the policy, which do need
> to be in sync.

Yes, but it needs a comment somewhere.

Also, the way you use those enums as array indices also implies that
for your case, Opt_err should definitely not be -1, and it should
instead be at the *end* of the enum list (the same way it's at the end
of the array).

That would also automatically mean that "Opt_measure" would have value
0, and the pl(token) macro shouldn't need any offsetting at all,
because the enums and the array indices just automatically match up
(as long as they are always updated together!)

               Linus
