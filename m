Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625DDECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F30B213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 19:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F30B213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeJJChi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:37:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58315 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbeJJChi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:37:38 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (jfdmzpr04-ext.jf.intel.com [134.134.139.73])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w99JJ6it1166093
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 9 Oct 2018 12:19:07 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
Subject: Insanely high baud rates
To:     linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <3fcef1c1-d746-ae82-c0e6-f079b1a53ffb@zytor.com>
Date:   Tue, 9 Oct 2018 12:19:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending to a wider audience]

In trying to get the termios2 interface actually implemented in glibc,
the question came up if we will ever care about baud rates in excess of
4 Gbps, even in the relatively remote future.

If this is something we care about *at all*, I would like to suggest
that rather than defining yet another kernel interface, we steal some
bits from the MSB of the speed fields, alternatively one of the c_cc
bytes (all  likearchitectures seem to have c_cc[18] free) or some field,
if we can find them, in c_cflags, to indicate an exponent.

With 5 bits from the top of the speed fields, the current values would
be identical up to 248 Gbps, and values up to ~288 Pbps would be
encodable ±2 ppb.

In the short term, all we would have to do in the kernel would be
erroring out on baud rates higher than 0x0fffffff (2^28-1 due to
implicit one aliasing rhe first bit of a 5-bit exponent – less than 2^27
are functionally denorms.) However, I'd like to put the glibc
infrastructure for this now if this is something we may ever be
interested in.

Thoughts?
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
