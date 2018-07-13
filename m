Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F2DAECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FE320858
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:23:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53FE320858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbeGMKhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:37:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbeGMKhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:37:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 31363406F8A3;
        Fri, 13 Jul 2018 10:23:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-149.rdu2.redhat.com [10.10.120.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5C1D2026D6B;
        Fri, 13 Jul 2018 10:23:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5731b5c4-e29d-30f6-095f-4a74f52cb72d@codesourcery.com>
References: <5731b5c4-e29d-30f6-095f-4a74f52cb72d@codesourcery.com> <cover.1530465325.git.ren_guo@c-sky.com> <27030.1531302693@warthog.procyon.org.uk> <20180712125152.GA5226@guoren>
To:     Sandra Loosemore <sandra@codesourcery.com>
Cc:     dhowells@redhat.com, Guo Ren <ren_guo@c-sky.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com,
        gnu-csky@mentor.com, thomas.petazzoni@bootlin.com,
        wbx@uclibc-ng.org, green.hu@gmail.com
Subject: Re: [PATCH V2 00/19] C-SKY(csky) Linux Kernel Port
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11102.1531477392.1@warthog.procyon.org.uk>
Date:   Fri, 13 Jul 2018 11:23:12 +0100
Message-ID: <11103.1531477392@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 13 Jul 2018 10:23:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 13 Jul 2018 10:23:15 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sandra Loosemore <sandra@codesourcery.com> wrote:

> I'm not familiar with the Fedora tools, but to build a complete toolchain
> you'll need library support as well and I'm not sure what the submission
> status/plans for that are.

The idea behind the cross-gcc package in Fedora is that it's for kernel builds
and bootloader-type things only.  It builds libgcc, but doesn't use kernel
headers or a C library[*] as this enormously simplifies things.

The reasons being:

 (1) Not all arches can use the same set of C libraries (some can't use glibc
     and some don't have a uClibc port).

 (2) I can only build each individual compiler against a single C library - so
     if you have two or more incompatible environments, you're out of luck -
     I can only use one.

 (3) Building lots more compilers for individual environments would massively
     increase the build size and time.  A full cross-gcc build now takes the
     best part of a day to build.

[*] Yes, there's one exception: it builds the arm compiler against an arm
    cross-glibc - not my idea.

David
