Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD08ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B314920871
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="RnDkgRHk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UemoOPq5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B314920871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbeGLUlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:41:46 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33932 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732512AbeGLUlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:41:45 -0400
Received: by mail-yw0-f196.google.com with SMTP id j68-v6so10953562ywg.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zTZAdsj3LaGt0R+V4g8HPRJLlgetDfWYobZ5rk6Bzxg=;
        b=RnDkgRHkeGopbLxyAQU7SCoQtSKcJ1K5Iinlzh1BQ9KoC/HL8NwYfbcxB7xxLyL4Bz
         Hhf3SJ50aKwzqnxdtwVsKx9gYXZFAS07KUEJvfRb/3H0OQKyA5Lxz4vCjcpbvckNkBt6
         AUWpIE8q7GnpQHAYaUSMUbAGC9p8gMyP10UD9qE7zsdYMWKcQC61q2iD9PD4hAp/sDqz
         PLhJfkpf6Ha2qjUeHMqL4Qo0t3CwTuRsB8mbJTjRx1fnQdpRsJuUVQUT3QhMS/3U33a6
         BQD7IE7cMFmtAZKlY09AZ9DgSvSMjbETa7MGcDj09RdDn+Z5m4FBLOg2beGMu9OUNNmy
         n7WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zTZAdsj3LaGt0R+V4g8HPRJLlgetDfWYobZ5rk6Bzxg=;
        b=UemoOPq5BPo30ivv1V8ih8WuIWIA5x/BoI3TE/1+i90WnE2y2aBuBH8f8BjjJa7N/g
         WBtXQc8rOP3ASydt1Fhc/4xJANuIc2HOiCOcyCRHtsKwvrVRCdOhUIyhsVOTV+zVawsQ
         Efoa3VeG87UqYTgtcbTzms3Zf71NmL7bet/NI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zTZAdsj3LaGt0R+V4g8HPRJLlgetDfWYobZ5rk6Bzxg=;
        b=cHVCioEFqmjAprh4rLjNfKnHN9kaVtbA0qtuE5py4EwFoWxDXKTZYgLsqD4IlrgodG
         FXQd3i0TM3Eul4mtHP3tGdNfklHsykySaUcXF6IEBdOh+WstzB5qb8qjWwXHE3QJ9jSd
         4y8rxe5tqFFEwns0+ZuJSRurc1SF1ycZM8f737KlG5cavFTspKxRs/78kMvl4ilDA+7O
         RpYxifcC+5Wr+y5GINz7MkRKJuzLN7nXCw8t9oYxUJBzQ1jwvSsbRwZao8wylxGBvqvZ
         Q1w5CM5VpxIeaJ6S4KpqAjeSCbT/b37wAg37Gt0en9E1uH+Dx9NH1DvDh+i/j/J8RHt0
         0RVg==
X-Gm-Message-State: AOUpUlGJoUtRCYk7fizljJfSgsRgTd1fRgvY2Y5Da6GgmcU6GQcdVkXh
        ZnA7OQSHDgUoWKFyGQHcreYVpn/VyRrjjn/XrFNo1g==
X-Google-Smtp-Source: AAOMgpc7GMwnXcEOuLpJeh02O1aR4884TSqQGuJuotOuT8TrIMN1rnLvrB5D75vZOykbzzTHUfSaBFWChgNKc/JmwYs=
X-Received: by 2002:a0d:e2cd:: with SMTP id l196-v6mr1831631ywe.38.1531427434052;
 Thu, 12 Jul 2018 13:30:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Thu, 12 Jul 2018 13:30:33
 -0700 (PDT)
In-Reply-To: <CAGXu5jLUME9cjntUUed9EYukzEaODDzqRmtGht=uu7YVAG2WWg@mail.gmail.com>
References: <20180711203619.1020-1-keescook@chromium.org> <20180711203619.1020-14-keescook@chromium.org>
 <CAK8P3a1k+cy9wAVNQMWE4tdA4aV8tiu6K3haLc+kMPt0iiUQ9Q@mail.gmail.com> <CAGXu5jLUME9cjntUUed9EYukzEaODDzqRmtGht=uu7YVAG2WWg@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 12 Jul 2018 13:30:33 -0700
X-Google-Sender-Auth: qaaxhdfIYlg1TLQaIhGXaB4PlVM
Message-ID: <CAGXu5jK7iRv1HE7JgW95vTgg5vhye4dxjfoQyN3G7HZzp7nZhA@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] rxrpc: Prepare to remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Eric Biggers <ebiggers@google.com>,
        Alasdair Kergon <agk@redhat.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lars Persson <larper@axis.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Rabin Vincent <rabinv@axis.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        dm-devel@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 1:23 PM, Kees Cook <keescook@chromium.org> wrote:
> On Thu, Jul 12, 2018 at 8:11 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, Jul 11, 2018 at 10:36 PM, Kees Cook <keescook@chromium.org> wrote:
>>> Two uses of SKCIPHER_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
>>> (when less than 2048) once the VLA is no longer hidden from the check:
>>>
>>> net/rxrpc/rxkad.c:398:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>> net/rxrpc/rxkad.c:242:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>>>
>>> This bumps the affected objects by 20% to silence the warnings while
>>> still providing coverage is anything grows even more.
>>>
>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> (adding David Howells to cc)
>>
>> I don't think these are in a fast path, it should be possible to just use
>> skcipher_alloc_req() instead of SKCIPHER_REQUEST_ON_STACK() here.
>> From what I can tell, neither of the two are called in atomic context, so
>> you should be able to use a GFP_KERNEL allocation.
>
> Sure, I can do that instead.

Actually, I think this can actually be adjusted to just re-use the
stack allocation, since rxkad_verify_packet() finishes one before
doing another in rxkad_verify_packet_1():

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 278ac0807a60..d6a2e7cab384 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -316,10 +316,10 @@ static int rxkad_secure_packet(struct rxrpc_call *call,
  */
 static int rxkad_verify_packet_1(struct rxrpc_call *call, struct sk_buff *skb,
                                 unsigned int offset, unsigned int len,
-                                rxrpc_seq_t seq)
+                                rxrpc_seq_t seq,
+                                struct skcipher_request *req)
 {
        struct rxkad_level1_hdr sechdr;
-       SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
        struct rxrpc_crypt iv;
        struct scatterlist sg[16];
        struct sk_buff *trailer;
@@ -549,7 +549,7 @@ static int rxkad_verify_packet(struct rxrpc_call
*call, struct sk_buff *skb,
        case RXRPC_SECURITY_PLAIN:
                return 0;
        case RXRPC_SECURITY_AUTH:
-               return rxkad_verify_packet_1(call, skb, offset, len, seq);
+               return rxkad_verify_packet_1(call, skb, offset, len, seq, req);
        case RXRPC_SECURITY_ENCRYPT:
                return rxkad_verify_packet_2(call, skb, offset, len, seq);
        default:


-Kees

-- 
Kees Cook
Pixel Security
