Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039BCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A4B20847
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 20:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A4B20847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeH2AxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 20:53:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbeH2AxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 20:53:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DDF54401EF04;
        Tue, 28 Aug 2018 20:59:51 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (ovpn-204-130.brq.redhat.com [10.40.204.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3F1A2026D6B;
        Tue, 28 Aug 2018 20:59:48 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>
Cc:     "mhkelley58\@gmail.com" <mhkelley58@gmail.com>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel\@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf\@aepfle.de" <olaf@aepfle.de>,
        "apw\@canonical.com" <apw@canonical.com>,
        "jasowang\@redhat.com" <jasowang@redhat.com>,
        "marcelo.cerri\@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: [PATCH char-misc 1/1] Drivers: hv: vmbus: Make synic_initialized flag per-cpu
References: <1533004484-3937-1-git-send-email-mikelley@microsoft.com>
        <87ftzzodnv.fsf@vitty.brq.redhat.com>
        <CY4PR21MB0773EFCF6EA21CF8F9CE01E0DC2D0@CY4PR21MB0773.namprd21.prod.outlook.com>
        <8736vyo2tm.fsf@vitty.brq.redhat.com>
        <CY4PR21MB077375C31D9211486C328328DC0A0@CY4PR21MB0773.namprd21.prod.outlook.com>
Date:   Tue, 28 Aug 2018 22:59:47 +0200
In-Reply-To: <CY4PR21MB077375C31D9211486C328328DC0A0@CY4PR21MB0773.namprd21.prod.outlook.com>
        (Michael Kelley's message of "Tue, 28 Aug 2018 20:20:19 +0000")
Message-ID: <87va7uxl4s.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 28 Aug 2018 20:59:51 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 28 Aug 2018 20:59:51 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com> writes:

> From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Wednesday, August 1, 2018 2:26 AM
>
>> > I was trying to decide if there are any arguments in favor of one
>> > approach vs. the other:  a per-cpu flag in memory or checking
>> > the synic_control "enable" bit.   Seems like a wash to me, in which
>> > case I have a slight preference for the per-cpu flag in memory vs.
>> > creating another function to return sctrl.enable.  But I'm completely
>> > open to reasons why checking sctrl.enable is better.
>> 
>> Just a few thoughts: reading MSR is definitely slower but we avoid
>> 'shadowing' the state, the reading is always correct. In case there's a
>> chance the SynIC will get disabled from host side we can only find this
>> out by doing MSR read. This is a purely theoretical possibility, I
>> believe, we can go ahead with this patch.
>
> Vitaly -- just to confirm:  you are OK with the patch as is?  (I'll
> check, but I may need to rebase on the latest code.)

Yes, feel free to use my R-b tag.

-- 
  Vitaly
