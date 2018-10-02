Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9CAC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A45720666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="QoittbjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A45720666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeJBVhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:37:47 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:39465 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:37:47 -0400
Received: by mail-pl1-f182.google.com with SMTP id w14-v6so1807309plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=r8vY+r45ERP3hgnbfsBlOdhRBy9zzbtGvcMP35kZByc=;
        b=QoittbjDYBiQ1D8tc63N1Qd8GGAyXxPXg5YQB6tUAZQpxjtWhQDLFe/LfTdaW/skoG
         pa25SdJOBVqz3/FKJrm6MgxAbkwhuQS+SJdUewvL3117ddLeGZhRwUHqb753HWjssDax
         5b0qP99rh4Ft2q+rBUcabOvKKF82KUYX8pk54rUUYwqGufmNJgkvumoaWGaj8C9JYjpP
         E8DXwRDTRfl3K0wK278mAfnzu2qSQE7m1AlZnyOHgQ2L+yH2KD9giYaFxVy5iWr18mlR
         XvwHt3GC1ji5PG8TQY3RnxQ3Lf6KEKeL4e7XRm/Iyi3KVFbOHhsx3iv8IZ+Xcn1GIRW4
         MH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=r8vY+r45ERP3hgnbfsBlOdhRBy9zzbtGvcMP35kZByc=;
        b=DTERbc8PvWDEw+JaBbcs4ZD9z6+kiKPJjQQ3LuRqKjXbmjdWbrlJwvbKe1fX2/9BDl
         oNICC3fCU41S9YAKo6EDjN+X8djKrmo9muJuwPk4ZebLCPqeEYegaAe5RsE3dKMHloZz
         L9kOMIGqv+HkRA3jqDUySOIG/Q+ZkB7/m8lFL4us6SpVWjmpflEinD3ztkWwg2BzVZfb
         viwuXhhRwVHkGpqo3u9QdgjLiMn9QZwRfdMDMeT2n9Td9jRcQWxaKX73CI2mjCmojTPe
         zb9k1bjoQNyqh3EynelS+6Vpyb+GYFdRdCc8JIFrisC2repytx3Xi0kNRb1I/4q9iPFT
         XG4w==
X-Gm-Message-State: ABuFfog4lF8RsU7AXrTz7uUZRpugeeZgifKgn1RXAkFNEEq6H50jzefm
        KEAxVpk/rv7JD5arMOz/utHHRw==
X-Google-Smtp-Source: ACcGV63Y2+dM5URlmzmFg/b6x4YUxUOQ6iP0gPQq4Do3Ew51xuJ3k0yLPqTvZoiH7C4rD1EAjQEn5Q==
X-Received: by 2002:a63:6385:: with SMTP id x127-v6mr14847465pgb.10.1538492039470;
        Tue, 02 Oct 2018 07:53:59 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.googlemail.com with ESMTPSA id f83-v6sm27348685pfa.109.2018.10.02.07.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 07:53:58 -0700 (PDT)
Subject: Re: RESEND and REBASE arm+arm64+aarch32 vdso rewrite
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>
References: <20181001175845.168430-1-salyzyn@android.com>
 <CALAqxLWCbw0bmYeB9Vfi5wXJcnLRnE0TYxy1h5WkHLehHv8KFg@mail.gmail.com>
 <8c09a380-7bc8-a353-aeb7-6591e6c57f68@android.com>
 <20181002085041.GV30658@n2100.armlinux.org.uk>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <7b5611cb-5bd0-d906-7013-31dbe55f8dbb@android.com>
Date:   Tue, 2 Oct 2018 07:53:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002085041.GV30658@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 01:50 AM, Russell King - ARM Linux wrote:
> On Mon, Oct 01, 2018 at 01:44:52PM -0700, Mark Salyzyn wrote:
>> Despite the gain of 0.4% for screen-on battery life, where Android has a mix
>> of 64 and 32 bit applications, thus still relevant _today_ on 64 bit
>> architectures (providing vDSO32 for 32-bit applications).
> I don't think the issue is what you think it is.  0.4% gain is
> equivalent to almost (but not quite) 1 minute extra for a lifetime of
> 4 hours.  Is that really noticable, and is it worth the churn from
> merging this series?

Screen on battery life, all other components of the system active, 
backlights, touchscreen, sensors etc and it still had a measurable 
impact on power from the portion that came from the CPU complex. This 
impact came solely from 32 bit applications left over on the 64-bit 
platforms that did not formerly have vDSO support. 32-bit applications 
are not going away even with the advent of 64-bit (sound media framework 
on Android is 32-bit).

Reduction in power is also an increase in performance. The 
microbenchmarks show ~3-10 fold improvement in the actions of acquiring 
the time of various sorts for 32-bit applications on 64-bit. A savings 
in the range of sub-microseconds each time(sic) adds up to 0.4% battery 
improvement overall.
> Given that the gain is so marginal, I can see why people find it
> difficult to get excited about this series to spend the time reviewing
> it.
The reviews were intense over the years IMHO, appeasing several 
stakeholders and testers. Its that final ACK that has been elusive. I 
have gotten private emails from ARM many times promising some 
engineering to look at these waiting patiently without feedback.

The changes, as requested in the reviews of the past, turned also into 
moving most vdso maintenance for all architectures of ARM into lib/vdso 
with no reduction in microbenchmark performance for the other 
configurations, at least two additional non-arm architectures look like 
they could readily switch over to using it as well. This is a major win 
for maintenance (and was not part of the original set).

As a result switching 64-ARM vdso assembler to C is a win for 
maintenance if upstream'd.

Given the Android will need to place these patches in their common tree 
(not there yet because I have required upstream first, but with limits, 
2 years seems a bit long to wait for a project started in ARM, then I 
was asked to help push it forward), not having them upstream, tested, 
with many eyes on the code, will be a pity and will result in a possible 
maintenance burden on up to 13000 phone devices.

-- Mark
