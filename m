Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26530C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35AD22EC0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KFT6YVEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D35AD22EC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbeGEPkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:40:11 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:52749 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753400AbeGEPkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:40:09 -0400
Received: by mail-it0-f68.google.com with SMTP id p4-v6so12591478itf.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 08:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kSUYQLHyLcSFkGc1/b0yqUFkZZqqNVuedC4iwKh0QeA=;
        b=KFT6YVElt6KiPl2D0D3isFxdjgaCW9y/pfetWK9PZ4g4118f09sS3QSKcgErgDPp08
         LvlvNxQqdGkwH9CsjN06dyHI2VvhQ1dWMJgVOzIVc/nGGMAfKxvnlFi9ob7U3MuULOCJ
         /GhoGhk5BVUrum8eIVHpamO8ufZcptnH7bmx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kSUYQLHyLcSFkGc1/b0yqUFkZZqqNVuedC4iwKh0QeA=;
        b=lf118f55bUsjMjsnPZ5fbKJy6Ytr3wjCDHRXShOgWKT5JP2v9OQPYaoZSAKsZUivdO
         pw8EFkni9WOxHpDqHRBDky2XG7b+OYTX1hkGyGV+/Hb2RIJR/HcVnjmo5cOKh0lWkQfV
         B+hchvVfcFUQEa1keF/o9msdoAJ1zi6i6FGbR7Tu5WlATvqkrennShSKgtdA1JQKD7OE
         cnYnOvGXCBE6SD06I4YknMZxY697jV2B6aK71OIX00vXBVCD+EG3pf8oGeos/QFLTCvM
         qSvHqmAEmdkT3a+/dUMIMCpd1JJb0oV3+hLmqjLkdv7RrehIqE7pmywHENNNRzUSjHf2
         ACcw==
X-Gm-Message-State: APt69E3Z+KhrTMrww5qWycYlQOS8H2bWLBXDcugvPol9o7d59Hb6kCUH
        7pX0aRdQ/Ztd0wlfaLdJKnCgQVWon1sp7xNlaVSF0w==
X-Google-Smtp-Source: AAOMgpdplCtN8ydEkGqfaSiDVp+5BQw029f5wSrEzvVft3a6GBTdSS4RUANeGmjHR0vj9IQxxaYvOCd3ptCvd/cU91o=
X-Received: by 2002:a02:982:: with SMTP id 2-v6mr5155955jam.79.1530805208799;
 Thu, 05 Jul 2018 08:40:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:e492:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 08:40:08 -0700 (PDT)
X-Originating-IP: [2a02:168:5628:0:496f:7dc5:66d7:a057]
In-Reply-To: <87in7q33ei.fsf@intel.com>
References: <2ac6e3da22119f714406925139e40f4d835d11a4.1525962971.git.mchehab+samsung@kernel.org>
 <20180510163456.GC30442@bombadil.infradead.org> <20180510105105.5cb0d54f@lwn.net>
 <87in7q33ei.fsf@intel.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 5 Jul 2018 17:40:08 +0200
Message-ID: <CAKMK7uEJV4MamSFPg6Bn8TZ6UcruNdAD3goTSvsivSAq09k1nA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] scripts/kernel-doc: Auto-detect common code-blocks
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 1:03 PM, Jani Nikula
<jani.nikula@linux.intel.com> wrote:
> On Thu, 10 May 2018, Jonathan Corbet <corbet@lwn.net> wrote:
>> On Thu, 10 May 2018 09:34:56 -0700
>> Matthew Wilcox <willy@infradead.org> wrote:
>>
>>> I think this is a bit fragile.  Why not just search for ':\n'?  Is
>>> there ever a case where we want to write:
>>>
>>> /**
>>>  * foo is a bar:
>>>  * wibble
>>>  */
>>> and have wibble not be a code-block?
>>
>> Yeah, we might want to write something like:
>>
>>  - Leading off a bulleted list
>>
>>  1) or a numbered list
>>
>> for example.  That's why I was thinking of looking for explicit markers
>> for such lists.
>>
>> It'll take some playing around with to have a hope of getting right,
>> methinks.
>
> We had serious trouble with the old DocBook toolchain because the tool
> pipeline was so long, and each step had its own expectations and quirks.
> For example, remember the escaping needed for xml in kernel-doc? Or tmpl
> xml files being invalid xml because of the docproc directives? One of
> the big benefits of the current toolchain is minimizing the amount of
> special casing magic required.
>
> The more we add custom syntax sugar in kernel-doc, the more we run the
> risk of running into hard problems later on in the Sphinx phase. For
> example, our own syntax preventing the use of legitimate rst syntax. And
> now we get somewhat reasonable error messages from Sphinx when things go
> wrong; we didn't get that when the impedance mismatches caused issues
> with the old toolchain. They were hard to debug and mostly nobody even
> bothered. We should work to reduce the amount of special processing in
> kernel-doc, not the other way round.
>
> The use of "::" is a valid and arguably rather non-invasive rst token
> for indicating the following indented block is a literal block. Adding
> heuristics (especially ones based on English language magic words) will
> lead to bigger problems than it's trying to solve.

Very late +1 on this. I think :: plus a 4 char indent is a very
non-intrusive way to shut up sphinx, and most reasonable maintainers
can be convinced of the same. Some insists on making docs worse for
everyone for some ideal of plain text purity in comments
unfortunately.

And I also fully agree with Jani on maintainability headaches with
custom syntax and heuristics. It just makes debugging toolchain issues
extremely painful. What we have right now is about the bare minimu
that was required for a smooth transition, and no more.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
