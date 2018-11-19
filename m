Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1254CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC223206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEcEzYR9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC223206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbeKTEub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 23:50:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40665 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730160AbeKTEua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 23:50:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so6229200wmf.5;
        Mon, 19 Nov 2018 10:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YPLphbMjZNXniT3q96fd1gHmG0H1PfCRj6RqlkIC8a0=;
        b=JEcEzYR9G+C5jQE6YEYa64ApahVwSY1RvEHwV70ZDPaYJjfzt2zzXWd/c0QeoNaOjw
         g0S/TX7QNySO5SPd+uX/1/F4phMwRhI1vmjD50WpsR70T+hPl6zn3R//32r0teK7C7U7
         PMv9RAeb4qfyADsktqVlZeIaC/dsC1Vhvhwz0Vyab65xCEt4nx5sGamM/WqlLOTcTAn+
         npWvLoplsmjJQ6T3l2DI8oogjWSdihkOCkziZ/evFmkhFw1RkPJhtjNRLK9/r4klHenL
         eZNkjsMtddsmjPKRzoap73fG6cSJtGpKAzSLPgoKgpEdMN0fS5MS9HzbixJ0lgC3E73b
         FNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YPLphbMjZNXniT3q96fd1gHmG0H1PfCRj6RqlkIC8a0=;
        b=qfu+RY5pICDjKR3n5kcYUs6PU0bMCDKPlgomg59AZdtlWV/0zLrjHb8373WZUmp/bk
         RsKrc5S48mpmm47GRzLI4PSmXuUY30JCdgPqtLZr42ltHgTB69OK8Qb+pIUDCtBJVc9S
         KvtvvcDJrkYI55WfK+pV6QIGpAswtgrXR6O6aHlU1scBoRPjAzsw1qOOpHp7uX16ga8o
         4EAIay3/hzMI1DFMAyDkppFzxKdudyS0mmIA6Gl6ZCG+tisE5oRp/lqmlDADNavFIQ7d
         NTpd6nle3WZStBxDxyn5MIW6l9FD+ntTGRKXgCTna4NdvKupAdxEjxO8LYnh/20r9YIk
         KxbQ==
X-Gm-Message-State: AA+aEWY8CNecJxGwXdaTyCPyFxvmRZb9BO3i9hkL4C3+e831F3kV+cd6
        +rx8ZXirBeaGZnFe61yOUWs=
X-Google-Smtp-Source: AJdET5cQYhDfdQR0rgjKUzxHy/slPvF1QD0Z2TXEkxbvxSxnz737BIfRNDX3V7GAgA4n7aDBGJqGyw==
X-Received: by 2002:a1c:947:: with SMTP id 68mr3000725wmj.35.1542651946739;
        Mon, 19 Nov 2018 10:25:46 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8d3c:3030:bb0b:6c69? ([2001:b07:6468:f312:8d3c:3030:bb0b:6c69])
        by smtp.googlemail.com with ESMTPSA id i13sm22276768wrw.32.2018.11.19.10.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 10:25:46 -0800 (PST)
Subject: Re: [PATCH v7 0/7] KVM: x86: Allow Qemu/KVM to use PVH entry point
To:     Maran Wilson <maran.wilson@oracle.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, jgross@suse.com
Cc:     boris.ostrovsky@oracle.com, bp@suse.de,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, hpa@zytor.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, linus.walleij@linaro.org,
        luto@kernel.org, mchehab@kernel.org, mingo@redhat.com,
        rdunlap@infradead.org, tglx@linutronix.de, thomas.lendacky@amd.com,
        hch@infradead.org, roger.pau@citrix.com, rkrcmar@redhat.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        George Kennedy <george.kennedy@oracle.com>
References: <1523920175-27287-1-git-send-email-maran.wilson@oracle.com>
 <9aeeaf85-6ecf-c1e2-640a-657f5bb0f8ef@redhat.com>
 <bf0112de-8ceb-d1e4-d787-bf6bde7a1f14@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <a0156b30-2e67-b68b-d555-a255acf2098e@redhat.com>
Date:   Mon, 19 Nov 2018 19:25:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <bf0112de-8ceb-d1e4-d787-bf6bde7a1f14@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/18 18:17, Maran Wilson wrote:
> On 11/16/2018 2:46 AM, Paolo Bonzini wrote:
>> On 17/04/18 01:09, Maran Wilson wrote:
>>> For certain applications it is desirable to rapidly boot a KVM virtual
>>> machine. In cases where legacy hardware and software support within the
>>> guest is not needed, Qemu should be able to boot directly into the
>>> uncompressed Linux kernel binary without the need to run firmware.
>>>
>>> There already exists an ABI to allow this for Xen PVH guests and the ABI
>>> is supported by Linux and FreeBSD:
>>>
>>>     https://xenbits.xen.org/docs/unstable/misc/pvh.html
>>>
>>> This patch series would enable Qemu to use that same entry point for
>>> booting KVM guests.
>> Hi Maran, what happened to this series (and to the QEMU work)?
> 
> Hi Paolo,
> 
> Thank you for the reminder. Sorry, I have been wanting to continue this
> work for a while now, but our team has been pulled in other directions
> and this one ended up getting temporarily pushed down the priority stack.
> 
> Let me discuss with my management and get back to you. I do want (and
> intend) to support and push this over the finish line.
> 
> In the meantime, if there are any folks out there with a specific
> business need for getting this done sooner rather than later

Well, we are interested in using this to avoid the decompression cost of
booting a "container-like" VM image.  I'm not sure what we will do about
that, but certainly getting this included in the upstream projects would
be a prerequisite.

If you really prefer to discuss things offlist, feel free to include me,
Stefan and Stefano.

Paolo

> and are
> able to invest a bit of time to collaborate on the remaining Qemu work,
> please feel free to ping me offline. We have some preliminary Qemu
> patches, but there is some additional work needed before they are ready
> wider review.
> 
> Thanks,
> -Maran
