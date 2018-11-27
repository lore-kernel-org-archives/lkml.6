Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B9AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348232086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 16:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 348232086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbeK1Dak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 22:30:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45974 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbeK1Dak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 22:30:40 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77F0A83F3D;
        Tue, 27 Nov 2018 16:32:13 +0000 (UTC)
Received: from vitty.brq.redhat.com.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73B2E100191D;
        Tue, 27 Nov 2018 16:32:11 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>,
        Roman Kagan <rkagan@virtuozzo.com>,
        "KY Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Cc:     "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 1/4] x86/hyper-v: move synic/stimer control structures definitions to hyperv-tlfs.h
In-Reply-To: <CY4PR21MB0773225F986528897624BAA6D7D00@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <20181126154732.23025-1-vkuznets@redhat.com> <20181126154732.23025-2-vkuznets@redhat.com> <20181126200413.GA7852@rkaganb.sw.ru> <87wooyk6na.fsf@vitty.brq.redhat.com> <CY4PR21MB0773225F986528897624BAA6D7D00@CY4PR21MB0773.namprd21.prod.outlook.com>
Date:   Tue, 27 Nov 2018 17:32:10 +0100
Message-ID: <87in0ijxbp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 27 Nov 2018 16:32:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Out of pure curiosity I decided to check what 'gcc -O3' produces when we
use bitfields and masks. As of 'gcc version 8.2.1 20181105 (Red Hat 8.2.1-5) (GCC)'

1) bitfields:

struct abc {
	int enabled:1;
	int _pad:7;
	int vec:8;
};

int is_good(struct abc *s) {
	if (s->enabled)
		return s->vec;
	else 
		return 0;
}

results in
 
is_good:
        xorl    %eax, %eax
        testb   $1, (%rdi)
        je      .L1
        movsbl  1(%rdi), %eax
.L1:
        ret

2) masks

#include <stdint.h>

#define S_ENABLED 1
#define S_VEC_MASK 0xff00
#define S_VEC_SHIFT 8

int is_good(uint16_t *s) {
	if (*s & S_ENABLED)
		return (*s & S_VEC_MASK) >> S_VEC_SHIFT;
	else 
		return 0;
}

results in

is_good:
        movzwl  (%rdi), %edx
        movzbl  %dh, %eax
        andl    $1, %edx
        movl    $0, %edx
        cmove   %edx, %eax
        ret

so bitfields version looks somewhat more efficient. I'm not sure if my
example is too synthetic though.

-- 
Vitaly
