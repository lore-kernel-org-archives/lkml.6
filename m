Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EFDC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECA320841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ePIlP+hi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECA320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732636AbeHAAPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:15:12 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:39560 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732379AbeHAAPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:15:11 -0400
Received: by mail-pg1-f176.google.com with SMTP id a11-v6so9773808pgw.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 15:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cUldiSBlkj7H/UAA2DMoqTQntQ4WXIwQd8jMN7FJVCM=;
        b=ePIlP+hi16mmNh4G7d9kHSNeOr7fnF7DRCHIv0JbEFA/0B0hTMYI8IrmxwV8utPbQs
         vYSffKGu7TqmVovlYz/Xj1bEPTSqBSQ46zEIhz6qfP2g7aqxg6Howk7b7ADLmY8ja9DY
         UhhpEz1B0nMCtDRk+DVCVAtuTdWbQGypE38cSBZOmmI2H3UTzKkm8K9PFKvB6utgiscL
         QzCl2tqPBBv1znwbeWwL+nRcZ/5yTGhxZj9XRoFTySEHR6eeZ9D/DYOHl6Lk+CaRmfgL
         nAKr9FLmgVXGogU+m/OcltLoTa0K4ArxpbzCn120PtnJ8ZINmwqxXnGi6BFJFe6MUAPY
         Jk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cUldiSBlkj7H/UAA2DMoqTQntQ4WXIwQd8jMN7FJVCM=;
        b=K00qlSgifBDTphMTV8JdLQ4JVBx9l4CSdVMIqIw5u8C0oTVhCxeTDQ9ZddzS43/j+k
         jEnlKQPkYdP6jqdvK4GlWNf+ChuwLpXp4g6/C4loYPpoQBZQc5L+ojAwNoAkKuBGmeVg
         IH13rN1OHOGaF9WvqeIAwQ5hFL8OXGsS1M1MwTEWeWa16T2Gu/3oa1uDfwWXR0zL5Nr4
         aPVXXAz5/Px4Q3kgQOnw4KBEG3pnGIm93LQg0IErxmhCyr1AQdFfW4AHmrs3P7VdxPAi
         INDmMFnuItfj7UrqHul0bBG8lwUyM2KPuaFEqgExBO7nkqGbk3F7QLyY0ninSBNN0mFT
         AzwQ==
X-Gm-Message-State: AOUpUlGfrwp4ZpvbmbOHlik9EUuanhWub/z4NdZ5seaEeKdwft4Roszq
        007n2OjHzFLXJZ5hqh6Nijn9J/x0RgCbRwqujKPmVIEbomLGzw==
X-Google-Smtp-Source: AAOMgpdoxMxV56cu1t65hR3kH6fzgOmMkr0gpe8euitsrS+Kvko52yDobOfSQBon2ApYVHrSHBZbKaViw3Wxy/qcpwc=
X-Received: by 2002:a62:ca0d:: with SMTP id n13-v6mr23858903pfg.69.1533076361644;
 Tue, 31 Jul 2018 15:32:41 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 31 Jul 2018 15:32:30 -0700
Message-ID: <CAKwvOdku_BOi6m2ugaef6=8+VH_+KAHH-Ch+uZZqMr8WAKARCw@mail.gmail.com>
Subject: Getting the instruction pointer on a per arch basis
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Pirama Arumuga Nainar <pirama@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        Mark Salyzyn <salyzyn@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently looking into cleaning up the code duplication between
current_text_addr() and _THIS_IP_, virtually every implementation of
current_text_addr() and _THIS_IP_ itself are basically:

#define _THIS_IP_ ({ __label__ _l; _l: &&_l; })

For a few arch's, they have inline assembly instead (for
current_text_addr()).  Examples:
* s390
* sh
* ia64
* x86 (um and 32b)
* c6x
* sparc

I have a patch that cuts down on the duplication, but I don't
understand why the few arch specific implementations are necessary.  I
could reduce the duplication further if it's ok to just use the
statement expression.

Does anyone know why this is the case?
-- 
Thanks,
~Nick Desaulniers
