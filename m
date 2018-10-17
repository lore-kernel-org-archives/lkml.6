Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23706C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA072148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 00:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEjpdEJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEA072148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeJQH4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:56:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46249 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbeJQH4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:56:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id o21so24369811otb.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 17:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2sMUxT205HmbQShPvHfeDzKS3yTEbKJ1KBOkS/XXA1M=;
        b=kEjpdEJHAyFrG+5xsDLneRPU7YYEKmuX5qQBa1yEc6cIGWlMv4nob1Gy7xlTSfFxZD
         lSBk5BV//uX37TiWFuhEbFfhOBDgiKBs6U0/e/1tAGPIC/rdIJZyFMbdBuURajeCJXOZ
         tLT8pWHFCJR7A5+JX95ajEJkLtWUq74m+sT78PlJrBpGh4vO2r71UapDWCU7ZLKq9wYY
         jUtu5k90cK1YwslHa6NkFpLadoB2hyg5oyw9e89L5gsLBh3zf302qNiFjrG82w13G8+0
         2XJFCUPv+8w2DJmH4fJPoQw/62krqBn568p052y4BcAIlXVRLJa3Rl0el+5mxe8UzvEY
         9H2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2sMUxT205HmbQShPvHfeDzKS3yTEbKJ1KBOkS/XXA1M=;
        b=e8PnL8RaQCQP2IRuoaBdG1Q+NrNqoLnXN6TW2hJUcPKnorFc7VTW/MEiVP4t1tiBae
         /IBHWXNVMjDW030nJwhEu62yU5A+CMD8g90+a0EEE1qpxSPBjDY9BTGdvjd/EQunndi4
         YXEySEoKMG062mA8QyH/N3KMt17KKwPq4FyIFkqGTAmvYc6hjPDPPIqKzJPbBNDJu3zE
         rn5CzPlib2FwSELn9T2IyB/D7oQj71b214iBouQMepCGfygdQSNkScsLK4AaFXRqW/H9
         Vx3YTrD/Kf5Jl+qQ9BRG0VxhHhTJm2JVRIqPJrpgiN9b1T1TrhGMuAfSSjoScDGkR/a6
         amsg==
X-Gm-Message-State: ABuFfogq6bf6gM7hH25TfCBmEIVzBwEwkAoExQUmkQuPLxl5yPF6pYRk
        BvRxnsi8BhvVJSjp2euSIkNVglb49eIKFmo5GL0Xew==
X-Google-Smtp-Source: ACcGV616VdpN3wXQ7WPROSKnTHCoDZzwOlDGKicArYCtIXp/+K8tcDH/r0A7PapgpoqMseT4BYWDw2LmFsdhvrhRjuI=
X-Received: by 2002:a9d:2117:: with SMTP id i23mr14536965otb.230.1539734593534;
 Tue, 16 Oct 2018 17:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-13-brendanhiggins@google.com> <bad13afe8c71860a85f12130a57fe9a96f017cf3.camel@perches.com>
In-Reply-To: <bad13afe8c71860a85f12130a57fe9a96f017cf3.camel@perches.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 16 Oct 2018 17:03:01 -0700
Message-ID: <CAFd5g44VQqJVhUPQLHWzaXMbjJeGNs2nDZYTmzQ8OV7dyTXfVg@mail.gmail.com>
Subject: Re: [RFC v1 12/31] checkpatch: added support for struct MOCK(foo) syntax
To:     joe@perches.com
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 4:59 PM Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2018-10-16 at 16:51 -0700, Brendan Higgins wrote:
> > This adds struct MOCK(foo) as a NonptrType so that it is recognized
> > correctly in declarations.
>
> I think this commit message is lacking context.

Oh sorry, you are right. We added macros for generating mocks from
types, so we decided to name the generated mock types struct MOCK(foo)
(where the base type is struct foo); this commit makes checkpatch not
complain at this new syntax.
