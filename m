Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBIQcx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 11:32:53 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751028AbeBIQcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 11:32:52 -0500
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nikita Leshenko <nikita.leshchenko@oracle.com>
Cc: kvm <kvm@vger.kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] KVM: lapic: stop advertising DIRECTED_EOI when in-kernel IOAPIC is in use
References: <20180209130133.28387-1-vkuznets@redhat.com>
        <292414F1-6978-497E-9CE2-3847E171150B@oracle.com>
Date: Fri, 09 Feb 2018 17:32:47 +0100
In-Reply-To: <292414F1-6978-497E-9CE2-3847E171150B@oracle.com> (Nikita
        Leshenko's message of "Fri, 9 Feb 2018 17:20:48 +0200")
Message-ID: <877ermyvgw.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Leshenko <nikita.leshchenko@oracle.com> writes:

> The patch looks correct, however I’m confused about why you consider
> this to be a bug in the guest rather than a bug in KVM.
>
> The spec for x2APIC states:
> "The support for Directed EOI capability can be detected by means of
> bit 24 in the Local APIC Version Register” (Intel’s x2APIC spec, 2.5.1
> Directed EOI)
> It seems to me that Windows did the right thing by testing for the
> presence of directed EOI feature rather than implying it exists by
> testing a version number. KVM did the wrong thing by advertising a
> feature it doesn’t support.
>
> Therefore I think that you should change the comment to something like
> “KVM’s in-kernel IOAPIC doesn’t support Directed EOI register, so don’t
> advertise this capability in the LAPIC Version Register.” instead of
> talking about buggy guests, as it may confuse future readers of this
> code.
>

Before disabling EOI broadcast guests should check if IOAPIC is of
proper version - the fact that you can disable EOI broadcast doesn't
automatically mean that you can later do EOI through IOAPIC... 

Anyway, I got the impression that last time conversation ended up with
'this is a guest bug' conclusion
(https://www.spinics.net/lists/kvm/msg148187.html - see Radim's and
Ladi's comments) but I'm not insisting - if now we conclude this is not a
Windows issue let it be it. But let's just fix it once and for all :-)

-- 
  Vitaly
