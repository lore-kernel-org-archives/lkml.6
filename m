Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74925C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F3EE2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 06:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q73lU42R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F3EE2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729328AbeJ2PeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 11:34:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36894 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbeJ2PeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 11:34:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id g9-v6so7354887wrq.4;
        Sun, 28 Oct 2018 23:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fOJFBnytc7Cr0+rrTtY5amRnLODdjpgiMyx+hubPzzo=;
        b=Q73lU42RwX4n5mtynpnpKuHSn1IFwv6YsNgJGx5t4aXrCMapHVX8luPPRpoiF8WKJI
         TyqLECjhCmusefMHBkFQS1UtzHmNWLpdDH0HWAaa9ym40KIltVlukT6jVtF7aynDuwKT
         T0s+NWqn4NYEjTf0DWmIAOmjZkEduanN5eNeosNfvoUd7eHtmzXylDi4RvEOKwqsV80M
         00mUAAE1FI8mxdAca2dotlVx/36xX9ALJsWbfv513WB4+Tv0POJZb03BVug9KGJC/WUF
         IVDG3j1uLIPP7hHQ1ceAfL12bn6TitfDFGMAYZgHByKXh8wnkYrOVZJ6rk/U6YtqTvex
         nypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fOJFBnytc7Cr0+rrTtY5amRnLODdjpgiMyx+hubPzzo=;
        b=NadVBlWlN3jFHk24Yyi015DsxAr5z+iT2q5JXFccHIePRXHiLD+Iye7uAQqE9Cd+Gs
         LB+n9qR5jpqeZx0pALjbvoAG0TlYY8ijzX+nwd+3YjyKGEKetaIt+25sATujNq92AYM7
         yaa5XQJOA2GysCaECNqVv/aMF8g20OYxeDmBQ1cDHp6WkLfNk07bIypKgKp9W0gVVUWJ
         XFnvwlENW5irojKLU/fJvOu9/BddFHKplAopWrq/RA6t1dLHtD4jGUm944+esW8poRLv
         mopb/QhLmXwBP4m9C+/GZi9XiSmSuqDIIGLjVtH+aUyaDPDMZynuQG0c7cKknab04bkJ
         KFIw==
X-Gm-Message-State: AGRZ1gI8yQd7ILRFKTBisUByFuQIlmUxVN1DNrpB9DlyZez2FCziv+H0
        zecNAsbVbFd4MoROE8l8HUSmReLg
X-Google-Smtp-Source: AJdET5cOfzc8UyM97nYUA1oKXL3ZDvSY07wqxLzxENfk7R2RgXAALv2c5ZjGvdvWUJWJK1RuXU3SDw==
X-Received: by 2002:adf:b109:: with SMTP id l9-v6mr13011026wra.101.1540795604006;
        Sun, 28 Oct 2018 23:46:44 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t77-v6sm25010242wme.18.2018.10.28.23.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 23:46:43 -0700 (PDT)
Date:   Mon, 29 Oct 2018 07:46:40 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ovich00@gmail.com, kernel-hardening@lists.openwall.com,
        nigel.edwards@hpe.com, Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        Ahmed Lotfy <A7med.lotfey@gmail.com>
Subject: Re: [PATCH V5 0/5] KVM: X86: Introducing ROE Protection Kernel
 Hardening
Message-ID: <20181029064640.GE128403@gmail.com>
References: <20181026151223.16810-1-ahmedsoliman0x666@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181026151223.16810-1-ahmedsoliman0x666@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com> wrote:

> This is the 5th version which is 4th version with minor fixes. ROE is a 
> hypercall that enables host operating system to restrict guest's access to its
> own memory. This will provide a hardening mechanism that can be used to stop
> rootkits from manipulating kernel static data structures and code. Once a memory
> region is protected the guest kernel can't even request undoing the protection.
> 
> Memory protected by ROE should be non-swapable because even if the ROE protected
> page got swapped out, It won't be possible to write anything in its place.
> 
> ROE hypercall should be capable of either protecting a whole memory frame or
> parts of it. With these two, it should be possible for guest kernel to protect
> its memory and all the page table entries for that memory inside the page table.
> I am still not sure whether this should be part of ROE job or the guest's job.
> 
> 
> The reason why it would be better to implement this from inside kvm: instead of
> (host) user space is the need to access SPTEs to modify the permissions, while
> mprotect() from user space can work in theory. It will become a big performance
> hit to vmexit and switch to user space mode on each fault, on the other hand,
> having the permission handled by EPT should make some remarkable performance
> gain.
> 
> Our model assumes that an attacker got full root access to a running guest and
> his goal is to manipulate kernel code/data (hook syscalls, overwrite IDT ..etc).
> 
> There is future work in progress to also put some sort of protection on the page
> table register CR3 and other critical registers that can be intercepted by KVM.
> This way it won't be possible for an attacker to manipulate any part of the
> guests page table.

BTW., transparent detection and trapping of attacks would also be nice: 
if ROE is active and something running on the guest still attempts to 
change the pagetables, the guest should be frozen and a syslog warning on 
the hypervisor side should be printed?

Also, the feature should probably be 'default y' to help spread it on the 
distro side. It's opt-in functionality from the guest side anyway, so 
there's no real cost on the host side other than some minor resident 
memory.

Thanks,

	Ingo
