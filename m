Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AF3C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35FB12077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f133jEgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35FB12077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbeIFCLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:11:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:40518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbeIFCLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:11:49 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2839E2073D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Sep 2018 21:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536183584;
        bh=Ab4/gmEdH4YjHMYoQeiftEgjOMTNg8MESm+y1gCDVCA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=f133jEgYJPiCpKK17TDExMqs8V6XdM9+GWamb+UJxms52qQMonU/o9VR5SRnnlZQZ
         9PfaMRQnTqZA7aJn9oZvW33Aki6YIw+7l/dQDgbVdKYN9FXshlHmmaTKvCd65aptc6
         ctotiAN+e7P8uZX9/5oJyEBg8y9WBlVdjUo20orM=
Received: by mail-wr1-f50.google.com with SMTP id j26-v6so9188022wre.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:39:44 -0700 (PDT)
X-Gm-Message-State: APzg51DV7uAbntIsnE/82yqWX/iBFXz8K3qD5izyGlIb7rdfEISiW1H9
        Itz2xV/Riqt7TYZnF0pmM7SgedR4hbQO22M1Ggf2zQ==
X-Google-Smtp-Source: ANB0VdakpaEzwIHp7A9nloUS+sRPKH6yOSCJOKMvdwoAbCD25xegBkLRzmgSLAgLwUsQUOz/KBfF6iCE/98uqP0YUwE=
X-Received: by 2002:adf:c98d:: with SMTP id f13-v6mr28401083wrh.148.1536183582725;
 Wed, 05 Sep 2018 14:39:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:7810:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 14:39:22 -0700 (PDT)
In-Reply-To: <6529a46e-ae83-5ff2-0152-1d5783f271c3@intel.com>
References: <20180807172920.8766-1-sean.j.christopherson@intel.com>
 <20180904195030.GA6269@linux.intel.com> <CALCETrU-HXfr_eAfeS1t7JH+-gOh0ZfAoGxjcOckxEX1fN_YDA@mail.gmail.com>
 <8a62de3e-defa-6681-c853-cd5140c5f0b5@intel.com> <CALCETrUKJ2qYVZRhDQEbVRPkgtj9VEdxc83ON9nAK-S52s7qmg@mail.gmail.com>
 <6529a46e-ae83-5ff2-0152-1d5783f271c3@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 5 Sep 2018 14:39:22 -0700
X-Gmail-Original-Message-ID: <CALCETrWBtQLRE69+YB2F3GUrnFQ6bXsq2LFCsh6-tFRkj=fTtw@mail.gmail.com>
Message-ID: <CALCETrWBtQLRE69+YB2F3GUrnFQ6bXsq2LFCsh6-tFRkj=fTtw@mail.gmail.com>
Subject: Re: [PATCH] x86/pkeys: Explicitly treat PK #PF on kernel address as a
 bad area
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 2:35 PM, Dave Hansen <dave.hansen@intel.com> wrote:
> On 09/04/2018 02:27 PM, Andy Lutomirski wrote:
>> Also, I doubt it matters right here, but !X86_PF_USER isn't quite the
>> same thing as "originating from kernel code" -- it can also be user
>> code that does a CPL0 access due to exception delivery or access to a
>> descriptor table.  Which you saw plenty of times while debugging
>> PTI... :)  I doubt any of those should be spurious, though.
>
> Yeah, you're talking about "implicit supervisor access".  Right?

Yes.
