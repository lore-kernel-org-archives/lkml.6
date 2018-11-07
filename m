Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7497C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C04920844
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 01:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eViEMRS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C04920844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbeKGK5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 05:57:02 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:43184 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbeKGK5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 05:57:01 -0500
Received: by mail-ot1-f51.google.com with SMTP id k9so13356628otl.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 17:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JlNlVxe5Ty/jfNcPeaLPX3rUnKgotdYEk6vhAA+mPls=;
        b=eViEMRS+Q89tAWNlKtzCoIt+JTaqVt6rnSgwCj8v0xYE6PBUCFk1Mqflimz2myldMx
         zKMTqJNErAVNi9BOs32B6ROIShGdAY0QdDjAgCdThAPUlPIy7juFNaor2Iit3D6WmoM6
         4piEMQUmWD1oVbZ2gvn16AxcvpT8i8SPWLuj8YAPmA3i0jRZud4/Q+p8B+57+SHYzee+
         eJqrTdd5JXMUrFlWCP5AxxnRTE3Uo24UIU0vntf9Nxt5V6FU8wFUUAZ6vOdrgH6RPSJF
         GXioj2y3sHNZHhmyZ96BsIwRp4/s2KYdHUJuUA0xUXv1eh/AbjOCjSfTZRycpJZ83HOR
         Pq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JlNlVxe5Ty/jfNcPeaLPX3rUnKgotdYEk6vhAA+mPls=;
        b=l+Q1vM6c02tMWjEnG+fhNClchPux3yJFmvN/0OuWlOPo4jBEWL9QKhOGS+kqoSNaDx
         txwwPakwv6ONVrDCKPmGsWaLzCv+BqbQS+icKeCE5Akg4mRCukIPZnvBYe7VH+60TH3w
         bY38CSWzNDBJNP6ZlmVHtoVgeA4d3qTb6PCa5SiLkoSCvMI/aAI01u4p9PkewWXjJlWb
         crBzcgYcZqc6BSCIfXaRGePY/OmuFQs5Rnnh6mh5srE7IPBnL/yIerMHMpgIMAL0qgdw
         jKrXO7fmwRXuvep96jVCvZQA9D/y11MI4GR3Ql+E6PnqnB+oRL32pTE01vt6yqGEwKLd
         +ixg==
X-Gm-Message-State: AGRZ1gIywj3uD5fwjaZfLxb7nbpGN21JpFnQisP/eVNjYfmNhYxtK95p
        EMZCSUE0NqMhGOrqwL010W+LbNvQxF6nBS4oTJ2fvQ==
X-Google-Smtp-Source: AJdET5cqbro1hHHhGCGPC6AcAC0hJVSbwNylWYNnM7CSlEQUu44WtdhQ+W+5y+6rcUJy1ws9qma6VgSSufjOipKR0+g=
X-Received: by 2002:a9d:654c:: with SMTP id q12mr11256028otl.338.1541554134295;
 Tue, 06 Nov 2018 17:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20181023235750.103146-1-brendanhiggins@google.com>
 <20181023235750.103146-2-brendanhiggins@google.com> <017b111f-d960-c1ef-46ae-eb0eb639fe5b@kernel.org>
In-Reply-To: <017b111f-d960-c1ef-46ae-eb0eb639fe5b@kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 6 Nov 2018 17:28:43 -0800
Message-ID: <CAFd5g45KNNGPVh4EBm8vKGdVhqajZZA0TU=CFbceJziYufb0Ug@mail.gmail.com>
Subject: Re: [RFC v2 01/14] kunit: test: add KUnit test runner core
To:     shuah@kernel.org
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh@kernel.org>,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 2, 2018 at 11:44 AM Shuah Khan <shuah@kernel.org> wrote:
>
> On 10/23/2018 05:57 PM, Brendan Higgins wrote:
<snip>
> > + * Example:
> > + *
> > + * .. code-block:: c
> > + *
> > + *   void add_test_basic(struct test *test)
> > + *   {
> > + *           TEST_EXPECT_EQ(test, 1, add(1, 0));
> > + *           TEST_EXPECT_EQ(test, 2, add(1, 1));
> > + *           TEST_EXPECT_EQ(test, 0, add(-1, 1));
> > + *           TEST_EXPECT_EQ(test, INT_MAX, add(0, INT_MAX));
> > + *           TEST_EXPECT_EQ(test, -1, add(INT_MAX, INT_MIN));
> > + *   }
> > + *
> > + *   static struct test_case example_test_cases[] = {
> > + *           TEST_CASE(add_test_basic),
> > + *           {},
> > + *   };
> > + *
> > + */
> > +struct test_case {
> > +     void (*run_case)(struct test *test);
> > +     const char name[256];
> > +
> > +     /* private: internal use only. */
> > +     bool success;
> > +};
> > +
>
> Introducing a prefix kunit_* might be a good idea for the API.
> This comment applies to the rest of patches as well.

What about kunit_* instead of test_* and kmock_* instead of mock_*?
Does that seem reasonable?
