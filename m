Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56677C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297A22081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:14:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297A22081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbeLJSOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:14:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43564 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728429AbeLJSOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:14:11 -0500
Received: from [IPv6:2a00:5f00:102:0:ec70:a07e:19ec:9e12] (unknown [IPv6:2a00:5f00:102:0:ec70:a07e:19ec:9e12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2E04426080C;
        Mon, 10 Dec 2018 18:14:09 +0000 (GMT)
Subject: Re: mainline/master boot bisection: v4.20-rc5-79-gabb8d6ecbd8f on
 jetson-tk1
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        tomeu.vizoso@collabora.com, Oleg Nesterov <oleg@redhat.com>,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        kernel@collabora.com
References: <5c09f05a.1c69fb81.95568.35c2@mx.google.com>
 <f24ba5f2-dcc8-45d2-9599-3a0d40fe4d95@linux.ibm.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <fc7d6d1c-4f0c-768a-b24f-309fcf745677@collabora.com>
Date:   Mon, 10 Dec 2018 18:14:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <f24ba5f2-dcc8-45d2-9599-3a0d40fe4d95@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2018 10:53, Ravi Bangoria wrote:
> Hi,
> 
> Can you please provide more details. I don't understand how this patch
> can cause boot failure.

The kernel Oops caused by the nouveau driver was treated as a
boot failure in the BayLibre lab, although it did not necessarily
mean the kernel had failed to boot to a login prompt.  This
configuration has now been changed to stop reporting things like
NULL pointer dereferences as boot failures, the only criteria for
a KernelCI boot test being to be able to get to the login prompt.

Side note: We may start reporting non-fatal errors found in the
kernel log somehow as part of an extended boot test with some
extra checks in the future, but that's a different topic.


> From the log found at
> https://storage.kernelci.org/mainline/master/v4.20-rc5-79-gabb8d6ecbd8f/arm/multi_v7_defconfig+CONFIG_EFI=y+CONFIG_ARM_LPAE=y/lab-baylibre/boot-tegra124-jetson-tk1.html
> 
[...]
> 
> 
> Both PC and LR are pointing to drm_* code. I don't see this anyway related to
> uprobes. Did I miss anything?

So for this particular bisection, there is a known problem in the
nouveau driver, pending this fix to be applied:

  https://patchwork.freedesktop.org/patch/263587/


I haven't investigated how your patch in uprobes.c makes the
issue appear in the nouveau driver but I suspect it's merely
uncovering it.  The patch linked above does fix the actual
problem in the nouveau driver.


>> * This automated bisection report was sent to you on the basis  *
>> * that you may be involved with the breaking commit it has      *
>> * found.  No manual investigation has been done to verify it,   *
>> * and the root cause of the problem may be somewhere else.      *

Seems like this is just what happened in this case.

Guillaume

