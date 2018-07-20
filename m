Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994F1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A69A20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A69A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeGTKjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:39:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727321AbeGTKjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:39:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA2938182D0F;
        Fri, 20 Jul 2018 09:51:38 +0000 (UTC)
Received: from flask (unknown [10.43.2.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id E3FE32142F20;
        Fri, 20 Jul 2018 09:51:36 +0000 (UTC)
Received: by flask (sSMTP sendmail emulation); Fri, 20 Jul 2018 11:51:36 +0200
Date:   Fri, 20 Jul 2018 11:51:36 +0200
From:   Radim Krcmar <rkrcmar@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH v3 2/6] KVM: X86: Implement PV IPIs in linux guest
Message-ID: <20180720095135.GA8330@flask>
References: <1530598891-21370-1-git-send-email-wanpengli@tencent.com>
 <1530598891-21370-3-git-send-email-wanpengli@tencent.com>
 <20180719162826.GB11749@flask>
 <CANRm+CxztUxixUNtsfZC3D1Zeo8QJsTefc565CkMBqWyXVfuzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANRm+CxztUxixUNtsfZC3D1Zeo8QJsTefc565CkMBqWyXVfuzw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 20 Jul 2018 09:51:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 20 Jul 2018 09:51:38 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'rkrcmar@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-07-20 11:33+0800, Wanpeng Li:
> On Fri, 20 Jul 2018 at 00:28, Radim Krčmář <rkrcmar@redhat.com> wrote:
> > 2018-07-03 14:21+0800, Wanpeng Li:
> > But because it is very similar to x2apic, I'd really need some real
> > performance data to see if this benefits a real workload.
> 
> Thanks for your review, Radim! :) I will find another real benchmark
> instead of the micro one to evaluate the performance.

Analyzing the cpu bitmap for every IPI request on a non-small guest (at
least 32 VCPUs, ideally >256) during various workloads could also
provide some insight regardless of workload/benchmark result -- we want
to know how many VM exits we would save.

> > > +static void kvm_send_ipi_all(int vector)
> > > +{
> > > +     __send_ipi_mask(cpu_online_mask, vector);
> >
> > These should be faster when using the native APIC shorthand -- is this
> > the "Broadcast" in your tests?
> 
> Not true, .send_IPI_all almost no callers though linux apic drivers
> implement this hook, in addition, shortcut is not used for x2apic
> mode(__x2apic_send_IPI_dest()), and very limited using in other
> scenarios according to linux apic drivers.

Good point,
(xAPIC is using shorthands, so I didn't expect we'd stop doing so on
 x2APIC, but there was probably no need.)

thanks.
