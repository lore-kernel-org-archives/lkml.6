Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbeCIPqA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:46:00 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751096AbeCIPp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:45:59 -0500
Date: Fri, 9 Mar 2018 16:45:16 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>
Subject: Re: [PATCH v2 2/3] x86/kvm/hyper-v: remove stale entries from
 vec_bitmap/auto_eoi_bitmap on vector change
Message-ID: <20180309154516.GA21100@flask>
References: <20180301141514.3482-1-vkuznets@redhat.com>
 <20180301141514.3482-3-vkuznets@redhat.com>
 <20180308210804.GN12290@flask>
 <87muzhe0ls.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87muzhe0ls.fsf@vitty.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-09 16:21+0100, Vitaly Kuznetsov:
> Radim Krčmář <rkrcmar@redhat.com> writes:
> > This looks like it solves the problem when we get two SINTs with the
> > same vector back-to-back , but shouldn't these bits really be cleared on
> > EOI (either auto or manual)?
> 
> Hmm,
> 
> I was trying to address the following issue: guest programs SynIC's
> SINTx with some vector but later re-programs it with a different
> one. Without the patch synic->vec_bitmap and synic->auto_eoi_bitmap keep
> stale data. If there's no concurrent interrupt than we're safe, but what
> happens if there is one...
> 
> kvm_hv_synic_send_eoi() already goes through all SINTx but we already
> updated vector so it won't find any. We could've added something like
> 'old_vector' but what if the request with this vector came _after_ we
> re-programed SynIC (and, so, it wasn't meant to be serviced by SynIC?)?

I now read that TLFS puts the responsitiblity on guest OS when toggling
auto-EOI, so let's assume that the OS is to blame for disabling/changing
vectors with pending interrupts as well.

Applied all, thanks.
