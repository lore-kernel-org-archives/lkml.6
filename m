Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B86C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04804253F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 03:17:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04804253F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752955AbeFYDRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 23:17:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752405AbeFYDRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 23:17:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0211887928;
        Mon, 25 Jun 2018 03:17:09 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B80D5111DCF7;
        Mon, 25 Jun 2018 03:17:00 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        lcapitulino@redhat.com, keescook@chromium.org, tglx@linutronix.de
Cc:     x86@kernel.org, hpa@zytor.com, fanc.fnst@cn.fujitsu.com,
        yasu.isimatu@gmail.com, indou.takao@jp.fujitsu.com,
        douly.fnst@cn.fujitsu.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 0/2] x86/boot/KASLR: Skip specified number of 1GB huge pages when do physical randomization
Date:   Mon, 25 Jun 2018 11:16:54 +0800
Message-Id: <20180625031656.12443-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 25 Jun 2018 03:17:09 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 25 Jun 2018 03:17:09 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a regression bug fix. Luiz's team reported that 1GB huge page
allocation will get one less 1GB page randomly when KASLR is enabled. On
their KVM guest with 4GB RAM, which only has one good 1GB huge page,
they found the 1GB huge page allocation sometime failed with below
kernel option adding.

  default_hugepagesz=1G hugepagesz=1G hugepages=1

This is because kernel may be randomized into those good 1GB huge pages.

And also on those bare-metal machines with larger memory, one less 1GB huge
page might be seen with KASLR enabled than 'nokaslr' specified case. It's
also because that kernel might be randomized into one of those good 1GB huge
pages.

The solution in this patchset is to skip specified number of GB huge
pages when do kernel physical randomization. If the specified number of GB
huge pages is bigger than amount of good GB huge pages which system can
provide, it's consistent with the current huge page implementation.

v1->v2:
  There are several code style problems and typos which were pointed out
  by Ingo, fix them in this patchset.

Baoquan He (2):
  x86/boot/KASLR: Add two functions for 1GB huge pages handling
  x86/boot/KASLR: Skip specified number of 1GB huge pages when do
    physical randomization

 arch/x86/boot/compressed/kaslr.c | 96 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 5 deletions(-)

-- 
2.13.6

