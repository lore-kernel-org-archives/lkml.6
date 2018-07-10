Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104A0C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAD120881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 19:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GHu9GVTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAD120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732781AbeGJTUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 15:20:38 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45047 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732569AbeGJTUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 15:20:38 -0400
Received: by mail-pl0-f65.google.com with SMTP id m16-v6so8040734pls.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 12:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2FHkm7J3JFBU8jDq70+aeSWQOjpjy0bgC98oleZT/qo=;
        b=GHu9GVTILoKHv0hUkjNMhhOvNOsrooPHWKH479Rz+Dn7iq7ikHNb+yXBpHSaxnd2ny
         Y8hcHlTV3QxjQ8/So8kuw94e7NHabX51qtnHVyHJ9J190V69Qu6AIo2jUNDQl9gW9GWp
         ZLLj5DjbzgmYpFwVCMS2XIrpozLyyhow6ahSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2FHkm7J3JFBU8jDq70+aeSWQOjpjy0bgC98oleZT/qo=;
        b=fcyMNQj4U8dlJyqsH29Lqcag6hRgQXuYfe6uTVs8GIVX4+BwI5ssW6wvoatPQA++6p
         iwLi9bwGR6GihlkQYFyIIXneneyk9woqXf8j6EqjFux9uhtFN4WRGV5MzHNDNjxNcMyw
         krXO8aTLelaLqHrt7fQ+e5ByMeWqF62CguFQE7AL2qIHqRUXigpejFmNnu3d6qhMyRHA
         mdrHfS+u1QP5vqigckGgrAy4yroujhRe/yXR0iS2YnNPkM6ksFIl82sY7R50lCeBYb73
         HgLzKbWlckwXNhjuGXMtYAGDUg6utSa7L5QgotZZ6iD+cV9jWG2xOA9lK2KGFo7emNL4
         oDsQ==
X-Gm-Message-State: APt69E18V6rnILxJi/MRG53Jy2+b0DQJ1pcN36zdLDPmDfJkx7HOOcUv
        Li9WaIOynQd9+jqsZe+nQOvd0Q==
X-Google-Smtp-Source: AAOMgpcF9Cq9AWtHVb1dXUHL5hR1/2gSHECIFdQPqNqTDQ9DnqtQSYyCZ9QYl3usefcO+gMxnCGeYw==
X-Received: by 2002:a17:902:1703:: with SMTP id i3-v6mr25295761pli.263.1531250411924;
        Tue, 10 Jul 2018 12:20:11 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x68-v6sm30897918pfb.138.2018.07.10.12.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 12:20:11 -0700 (PDT)
Date:   Tue, 10 Jul 2018 12:19:51 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v5 7/8] ima: based on policy warn about loading firmware
 (pre-allocated buffer)
Message-ID: <20180710191951.GF1731@minitux>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
 <CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
 <1531165294.3332.40.camel@linux.ibm.com>
 <CAKv+Gu-knHeBRGqo+2pb3X9cCjwovEykoXUf=DZyP7aJpoS60A@mail.gmail.com>
 <CAKv+Gu8qjzh_Tta=n9C+cfXO29e_5RcLqfQSpvR5r7QmqzHbEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8qjzh_Tta=n9C+cfXO29e_5RcLqfQSpvR5r7QmqzHbEg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Jul 23:56 PDT 2018, Ard Biesheuvel wrote:

> On 10 July 2018 at 08:51, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 9 July 2018 at 21:41, Mimi Zohar <zohar@linux.ibm.com> wrote:
> >> On Mon, 2018-07-02 at 17:30 +0200, Ard Biesheuvel wrote:
> >>> On 2 July 2018 at 16:38, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
[..]
> > So to summarize again: in my opinion, using a single buffer is not a
> > problem as long as the validation completes before the DMA map is
> > performed. This will provide the expected guarantees on systems with
> > IOMMUs, and will not complicate matters on systems where there is no
> > point in obsessing about this anyway given that devices can access all
> > of memory whenever they want to.
> >
> > As for the Qualcomm case: dma_alloc_coherent() is not needed here but
> > simply ends up being used because it was already wired up in the
> > qualcomm specific secure world API, which amounts to doing syscalls
> > into a higher privilege level than the one the kernel itself runs at.

As I said before, the dma_alloc_coherent() referred to in this
discussion holds parameters for the Trustzone call, i.e. it will hold
the address to the buffer that the firmware was loaded into - it won't
hold any data that comes from the actual firmware.

> > So again, reasoning about whether the secure world will look at your
> > data before you checked the sig is rather pointless, and adding
> > special cases to the IMA api to cater for this use case seems like a
> > waste of engineering and review effort to me.

Forgive me if I'm missing something in the implementation here, but
aren't the IMA checks done before request_firmware*() returns?

> > If we have to do
> > something to tie up this loose end, let's try switching it to the
> > streaming DMA api instead.
> >
> 
> Forgot to mention: the Qualcomm case is about passing data to the CPU
> running at another privilege level, so IOMMU vs !IOMMU is not a factor
> here.

Further more, all scenarios we've look at so far is completely
sequential, so if the firmware request fails we won't invoke the
Trustzone operation that would consume the memory or we won't turn on
the power to the CPU that would execute the firmware.


Tbh the only case I can think of where there would be a "race condition"
here is if we have a device that is polling the last byte of a
predefined firmware memory area for the firmware loader to read some
specific data into it. In cases where the firmware request is followed
by some explicit signalling to the device (or a power on sequence) I'm
unable to see the issue discussed here.

Regards,
Bjorn
