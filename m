Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20A6C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFBB2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Sp5JJf9W";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XgOZuwH3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CFBB2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754271AbeFTXFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:05:55 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:37265 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754210AbeFTXFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:05:53 -0400
Received: by mail-yb0-f194.google.com with SMTP id h141-v6so486140ybg.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=S2HCpZFP4Oe8GVuKL0bCH9cxVbaMdMNlqxOOmtqQHGE=;
        b=Sp5JJf9WXzZAw0QJV4nAqdQnU1jXM3r462IkBbtE8AYZ3dpO2qnEZNsKR23zFgc6IJ
         alxCuEUk3dWwPHVsIQRqug2RGkDlyWylee+1AWLV8WM/Me4lnGYAzTm+OuCDzoDAFKjD
         oAw2pL0iSM5MpntZV3jX3paFhFtH2CTea/2ufVq3G9bcBDFM3aQqBxGHGCt4tiJe3bfE
         UJx33kPp+vuaK8T6/8dGFibryWmqiHfa0FPIsF/MJ42hS0Q5QCFNK9nGihZwOYcQL16w
         2+WHw93tXXkbs91X2RA5F3K4eU6XO+L7jjz8ORJTUeCwOEv47gQxpd20LxsgahFbVcUE
         wvbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=S2HCpZFP4Oe8GVuKL0bCH9cxVbaMdMNlqxOOmtqQHGE=;
        b=XgOZuwH3MNDhdg7NXzHjZsRIpQnbaXnzq5S0UROXf9zMS0a7pZBG5VBgWiCvJxDG0t
         ZK1YNTqSOcPWBLgg8475kngqmByK70X6/UXRNnmRAHRu2+EB49PG2nAMlharQgCPcF7C
         sqGJflhv0JRUh/w2LO8XJst7c9544rtA8EoIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=S2HCpZFP4Oe8GVuKL0bCH9cxVbaMdMNlqxOOmtqQHGE=;
        b=YliHQEDgqJW2L+ML348EmiRFfTsziRC4CZWL0N3+2nVGX74q1lf7wNLyT4pWtVhjyt
         B259zODDHxQvtKyqV8vimKmAGQTZuvSHsYLvueCk84crVyIk3IGMsj7Fl1qwj+41HnTV
         IZuz2RGuddPF7h2fR5XZ625PGkVS7VFExgzaFi6uF229MAGw+wSy+qGeYsi41/kYb9VK
         wihQOpL64YFmkZRTu1mVA3dY+koOHcfQ2OBDMh/mSk/TW1VyT5q/h/qBNQA4xeMq/p66
         rBmvCQkZbX5F1bPx0zxmajcm0XxA8UpJVS6Y+86R/7eErS31Dq3pAjGYocgrMRcvKjSS
         dDNQ==
X-Gm-Message-State: APt69E10KYtfduVnQYJ1gBt1j04pupfVo/2XyB7aMvyU90IoJEdpFyWP
        WAodgaVB7aST2sdV99oxLxBgQ7b7Ip/maZX2XQnOGQ==
X-Google-Smtp-Source: ADUXVKIKPONko7Z/0y/Q942DrmgvQvPUlft41I7aAAVvVvnC+t7tmbvmWeG7trHy7x99v8JISIlc8YaQ3gp/wwUBlHw=
X-Received: by 2002:a25:f81e:: with SMTP id u30-v6mr9591125ybd.343.1529535952688;
 Wed, 20 Jun 2018 16:05:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 16:05:51
 -0700 (PDT)
In-Reply-To: <778b2a1b-d810-815b-0fba-8a1d191acd49@infradead.org>
References: <1529532570-21765-1-git-send-email-rick.p.edgecombe@intel.com>
 <1529532570-21765-2-git-send-email-rick.p.edgecombe@intel.com>
 <12014310-19f7-dc31-d983-9c7e00c8b446@infradead.org> <CAGXu5j+RgbMKqiBcsWMOZ-ci-rT19imgCoHtPKgDURF1tC+COg@mail.gmail.com>
 <778b2a1b-d810-815b-0fba-8a1d191acd49@infradead.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Jun 2018 16:05:51 -0700
X-Google-Sender-Auth: On0H1ZWgqq01b3r0NyDD02gRnEo
Message-ID: <CAGXu5j+TpZict=pSenHQ+_6V2fgoDrAGiB8sCd6bk-tb_Ec0zw@mail.gmail.com>
Subject: Re: [PATCH 1/3] vmalloc: Add __vmalloc_node_try_addr function
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kristen Accardi <kristen.c.accardi@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 3:44 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
> On 06/20/2018 03:35 PM, Kees Cook wrote:
>> On Wed, Jun 20, 2018 at 3:16 PM, Randy Dunlap <rdunlap@infradead.org> wrote:
>>> On 06/20/2018 03:09 PM, Rick Edgecombe wrote:
>>>> +void *__vmalloc_node_try_addr(unsigned long addr, unsigned long size,
>>>> +                     gfp_t gfp_mask, pgprot_t prot, unsigned long vm_flags,
>>>> +                     int node, const void *caller)
>>>> +{
>>>
>>> so this isn't optional, eh?  You are going to force it on people because?
>>
>> RANDOMIZE_BASE isn't optional either. :) This improves the module
>> address entropy with (what seems to be) no down-side, so yeah, I think
>> it should be non-optional. :)
>
> In what kernel tree is RANDOMIZE_BASE not optional?

Oh, sorry, I misspoke: on by default. It _is_ possible to turn it off.

But patch #2 does check for RANDOMIZE_BASE, so it should work as expected, yes?

Or did you want even this helper function to be compiled out without it?

-Kees

-- 
Kees Cook
Pixel Security
