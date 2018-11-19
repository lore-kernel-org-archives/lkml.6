Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F74C43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A868620851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A868620851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ab.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730861AbeKTHnZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:43:25 -0500
Received: from tyo162.gate.nec.co.jp ([114.179.232.162]:38553 "EHLO
        tyo162.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbeKTHnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:43:25 -0500
Received: from mailgate02.nec.co.jp ([114.179.233.122])
        by tyo162.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wAJLGHvw001196
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 20 Nov 2018 06:16:17 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAJLGH10031514;
        Tue, 20 Nov 2018 06:16:17 +0900
Received: from mail03.kamome.nec.co.jp (mail03.kamome.nec.co.jp [10.25.43.7])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wAJLEkLl027588;
        Tue, 20 Nov 2018 06:16:17 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.137] [10.38.151.137]) by mail02.kamome.nec.co.jp with ESMTP id BT-MMP-5708903; Tue, 20 Nov 2018 06:07:29 +0900
Received: from BPXM09GP.gisp.nec.co.jp ([10.38.151.201]) by
 BPXC09GP.gisp.nec.co.jp ([10.38.151.137]) with mapi id 14.03.0319.002; Tue,
 20 Nov 2018 06:07:28 +0900
From:   Kazuhito Hagio <k-hagio@ab.jp.nec.com>
To:     Bhupesh Sharma <bhsharma@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Boris Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Anderson <anderson@redhat.com>,
        James Morse <james.morse@arm.com>,
        Omar Sandoval <osandov@fb.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
Thread-Topic: [PATCH v2] x86_64, vmcoreinfo: Append 'page_offset_base' to
 vmcoreinfo
Thread-Index: AQHUfSzksqNl5RpqX0mS8g+hu1PRe6VXaKBA
Date:   Mon, 19 Nov 2018 21:07:27 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC03560F84@BPXM09GP.gisp.nec.co.jp>
References: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
In-Reply-To: <1542318469-13699-1-git-send-email-bhsharma@redhat.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [143.101.134.156]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/2018 4:47 PM, Bhupesh Sharma wrote:
> Adding 'page_offset_base' to the vmcoreinfo can be specially useful for
> live-debugging of a running kernel via user-space utilities
> like makedumpfile (see [1]).

I agree.

> Recently, I saw an issue with the 'makedumpfile' utility (see [2] for
> details), whose live debugging feature is broken with newer kernels
> (I tested the same with 4.19-rc8+ kernel), as KCORE_REMAP segments were
> added to kcore, thus leading to an additional sections in the same, and
> makedumpfile is not longer able to determine the start of direct
> mapping of all physical memory, as it relies on traversing the PT_LOAD
> segments inside kcore and using the last PT_LOAD segment
> to determine the start of direct mapping.

Actually, the KCORE_REMAP segments were already removed from kcore by
commit bf904d2762ee ("x86/pti/64: Remove the SYSCALL64 entry trampoline")
and kcore's program headers got back to the previous ones, but this
fact shows that they are changeable.

So I think that if we have this NUMBER(page_offset_base) in vmcoreinfo
for x86_64, user-space tools (especially makedumpfile) would become
more stable against changes in kcore and vmcore, rather than depending
on their PT_LOAD values.

Thanks,
Kazu


