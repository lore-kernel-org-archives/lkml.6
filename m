Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7923C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C7A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77C7A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbeJ3Flv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:41:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729566AbeJ3Flv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:41:51 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 899C3307EA85;
        Mon, 29 Oct 2018 20:51:29 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 763F3106425A;
        Mon, 29 Oct 2018 20:51:29 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 492AB4BB79;
        Mon, 29 Oct 2018 20:51:29 +0000 (UTC)
Date:   Mon, 29 Oct 2018 16:51:29 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <65007864.26733351.1540846289100.JavaMail.zimbra@redhat.com>
In-Reply-To: <nycvar.YFH.7.76.1810261724510.23511@cbobk.fhfr.pm>
References: <20181003171936.11271-1-vdronov@redhat.com> <nycvar.YFH.7.76.1810261724510.23511@cbobk.fhfr.pm>
Subject: Re: [PATCH 0/3] HID: debug: fix the ring buffer implementation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.200.22, 10.4.195.25]
Thread-Topic: debug: fix the ring buffer implementation
Thread-Index: IW/L82K8Zzx9DXyopaMBvBWxe741tA==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Mon, 29 Oct 2018 20:51:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jiri,

Thank you for the reply and your opinion. It appeared that my own implementation
of a ring buffer was kind of "inventing a wheel", as "kfifo" is already is the
kernel and it may work as a ring buffer quite well. I would like to rewrite my
patchset and use kfifo instead in a new one. Please, ignore this my patchset and
I'll try to submit v2 soon.

This also will answer to "how was it tested" concern, as I believe, kfifo was
quite tested.

Best regards,
Vladis Dronov | Red Hat, Inc. | Product Security Engineer

----- Original Message -----
> From: "Jiri Kosina" <jikos@kernel.org>
> To: "Vladis Dronov" <vdronov@redhat.com>
> Cc: "Benjamin Tissoires" <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
> Sent: Friday, October 26, 2018 5:25:21 PM
> Subject: Re: [PATCH 0/3] HID: debug: fix the ring buffer implementation
> 
> On Wed, 3 Oct 2018, Vladis Dronov wrote:
> 
> > This patchset is fixing some aspects of the ring buffer implementation in
> > drivers/hid/hid-debug.c. This implementation has certain problem points:
> > 
> > - it may stuck in an infinite loop
> > - it may return corrupted data
> > - a reader and a writer are not protected by spinlocks, which can lead to
> >   the corrupted data
> > 
> > The suggested patchset is a new ring buffer implementation which overwrites
> > the oldest data in case of an overflow. One can verify the suggested ring
> > buffer implementation by fuzzing it with modified kernel and fuzzer-reader
> > at: https://gist.github.com/nefigtut/33d56e3870b67493cc867344aed2a062
> 
> Vladis,
> 
> thanks for cleaning it up. I actually like your rewrite quite a lot.
> 
> Quick question -- how well was it tested in which scenarios?
> 
> --
> Jiri Kosina
> SUSE Labs
