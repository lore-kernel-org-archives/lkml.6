Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F03ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED602124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYEWKy3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED602124D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbeGLUqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:46:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40775 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732594AbeGLUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:46:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id e13-v6so7886940pff.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 13:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zLPg+ZMnkHqRoRSwpuhB3kNpy3QtB4EcoIMhtTIlVRU=;
        b=jYEWKy3uovlwTXZ90J1mh5IF0CkQJ/QURWm7iqHaRd8s4Ve87CGtf9K6EHA8/K8sI1
         8AwPyJeZSQ7bix9WeiEyPSb5xQh50XSO0ZnNCeXoh0mUZQTrAtHPzh4a+3MEYyk/tsmr
         SiDcOsqvOvYhM3M51BeGH/rTtKMlv2PyEvBa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zLPg+ZMnkHqRoRSwpuhB3kNpy3QtB4EcoIMhtTIlVRU=;
        b=bvEOYWJRRRqeRj2/pKyrKVPDS6uAjoKVdqLrc83du5xN6QoYCIkdRk+TpM0MGulbaO
         ZDrxB0P7vz5t698EYkPjcE7Rq6tuN6OraX2s9eryXj3DjhCRfkUCs6Q6aeJ/ZYACMVR3
         rO/zxeSdcr7Gzh/alqLzl2qAqbfeaLivdU16gxlua7gabJ80viR1+47sZQeW/gIUoJq3
         WPWDWUpk0Jg641KUGNKxDeOHkE1XlE+8nxbeytaTg1UmtlUJ9qInVWcd1FxuHYU5SXXC
         IXtwKWMukQ07Xh3qvNl1l9HWNKoHQS2e5gtqxiQpPCyTTOSfMeCtKZpSQAw0KDFyUVWd
         /m0A==
X-Gm-Message-State: AOUpUlGCbxhuaC5gNuHLi8OqJ762+16A/5VfT+ixE+TgYzKDSniZR4U7
        RPB2uy7LUmr1lbt/XAvlQXAbgA==
X-Google-Smtp-Source: AAOMgpdokCGULGhAijb+GNgOV6l0nM0UVFXhKSGGbJ6Kwo7/s2U5v6HTGuEgaRrgWLol//zbttVEBA==
X-Received: by 2002:a63:1902:: with SMTP id z2-v6mr3374052pgl.86.1531427706198;
        Thu, 12 Jul 2018 13:35:06 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l25-v6sm8734824pff.8.2018.07.12.13.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 13:35:05 -0700 (PDT)
Date:   Thu, 12 Jul 2018 13:37:46 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Message-ID: <20180712203746.GG545@tuxbook-pro>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1530542283-26145-8-git-send-email-zohar@linux.vnet.ibm.com>
 <CAKv+Gu-nky1yX59TL2FNQ-0q7Sy399t2WpVWSy7jqYpQY4Fxjw@mail.gmail.com>
 <1531165294.3332.40.camel@linux.ibm.com>
 <CAKv+Gu-knHeBRGqo+2pb3X9cCjwovEykoXUf=DZyP7aJpoS60A@mail.gmail.com>
 <CAKv+Gu8qjzh_Tta=n9C+cfXO29e_5RcLqfQSpvR5r7QmqzHbEg@mail.gmail.com>
 <20180710191951.GF1731@minitux>
 <CAKv+Gu_C0H9LoqeC3PkKhaKr0TQys=1TcYFNG-JUivnN_YgBKQ@mail.gmail.com>
 <1531425793.3568.275.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1531425793.3568.275.camel@linux.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12 Jul 13:03 PDT 2018, Mimi Zohar wrote:

> On Wed, 2018-07-11 at 08:24 +0200, Ard Biesheuvel wrote:
> > On 10 July 2018 at 21:19, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> 
> > > Tbh the only case I can think of where there would be a "race condition"
> > > here is if we have a device that is polling the last byte of a
> > > predefined firmware memory area for the firmware loader to read some
> > > specific data into it. In cases where the firmware request is followed
> > > by some explicit signalling to the device (or a power on sequence) I'm
> > > unable to see the issue discussed here.
> > >
> > 
> > I agree. But the latter part is platform specific, and so it requires
> > some degree of trust in the driver author on the part of the IMA
> > routines that request_firmware() is called at an appropriate time.
> 
> Exactly.  Qualcomm could be using the pre-allocated buffer
> appropriately, but that doesn't guarantee how it will be used in the
> future.
> 

Agreed.

But a device that starts operate on the firmware memory before it's
fully loaded (and verified) will likely hit other nasty issues. Using a
traditional request_firmware() and memcpy() or simply mapping the buffer
into the remote piecemeal would have the same issue.

So I think that regardless of using IMA, if you don't have the ability
to control your device's view of the entire firmware buffer atomically
you must write your device drivers accordingly.

Regards,
Bjorn
