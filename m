Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66EADC43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFEB20878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFEB20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbeG1Uxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 16:53:53 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:35625 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730407AbeG1Uxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 16:53:52 -0400
Received: from [192.168.0.5] (ip5f5bf3cc.dynamic.kabel-deutschland.de [95.91.243.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 07C732012BACB8;
        Sat, 28 Jul 2018 21:26:19 +0200 (CEST)
To:     amd-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
From:   Paul Menzel <pmenzel+amd-gfx@molgen.mpg.de>
Subject: [RFC] Improve on using delays greater than a few milliseconds
Message-ID: <38e52b4d-3149-fa4e-aa22-1a1edd31a34a@molgen.mpg.de>
Date:   Sat, 28 Jul 2018 21:26:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux folks,


Trying to decrease the boot time, mostly with ftrace by using [1], I 
noticed a lot of delays. Out of curiosity I searched for all calls of 
`mdelay()` in the driver *amdgpu*.

> $ git grep mdelay drivers/gpu/drm/amd/amdgpu
> drivers/gpu/drm/amd/amdgpu/atom.c:              mdelay(count);
> drivers/gpu/drm/amd/amdgpu/atombios_encoders.c:                 mdelay(1);
> drivers/gpu/drm/amd/amdgpu/cik.c:               mdelay(10);
> drivers/gpu/drm/amd/amdgpu/cik.c:               mdelay(10);
> drivers/gpu/drm/amd/amdgpu/cik.c:               mdelay(10);
> drivers/gpu/drm/amd/amdgpu/cik.c:                               mdelay(100);
> drivers/gpu/drm/amd/amdgpu/cik_ih.c:    mdelay(1);
> drivers/gpu/drm/amd/amdgpu/cz_ih.c:     mdelay(1);
> drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c:  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c:  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c:  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c:  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/iceland_ih.c:        mdelay(1);
> drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c:          mdelay(5);
> drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c:          mdelay(1);
> drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c:          mdelay(5);
> drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c:          mdelay(5);
> drivers/gpu/drm/amd/amdgpu/psp_v10_0.c: mdelay(20);
> drivers/gpu/drm/amd/amdgpu/psp_v10_0.c: mdelay(20);
> drivers/gpu/drm/amd/amdgpu/psp_v3_1.c:  mdelay(20);
> drivers/gpu/drm/amd/amdgpu/psp_v3_1.c:  mdelay(20);
> drivers/gpu/drm/amd/amdgpu/psp_v3_1.c:  mdelay(20);
> drivers/gpu/drm/amd/amdgpu/psp_v3_1.c:  mdelay(20);
> drivers/gpu/drm/amd/amdgpu/psp_v3_1.c:  mdelay(1000);
> drivers/gpu/drm/amd/amdgpu/si.c:                                mdelay(100);
> drivers/gpu/drm/amd/amdgpu/si_ih.c:     mdelay(1);
> drivers/gpu/drm/amd/amdgpu/tonga_ih.c:  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:  mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:                  mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:                  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:                  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:                  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:                          mdelay(20);
> drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c:                          mdelay(30);
> drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:  mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:                  mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c:  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c:  mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c:                  mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c:  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:          mdelay(1);
> drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:          mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:          mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:                          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:                  mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:                  mdelay(10);
> drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:          mdelay(1);
> drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:          mdelay(5);
> drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/vce_v2_0.c:                  mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vce_v2_0.c:                  mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vce_v2_0.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vce_v2_0.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vce_v2_0.c:  mdelay(100);
> drivers/gpu/drm/amd/amdgpu/vce_v2_0.c:          mdelay(1);
> drivers/gpu/drm/amd/amdgpu/vce_v2_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:                  mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:          mdelay(100);
> drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/vce_v3_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:                  mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:  mdelay(100);
> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:  mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:                  mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:          mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:  mdelay(1);
> drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c:  mdelay(5);
> drivers/gpu/drm/amd/amdgpu/vega10_ih.c: mdelay(1);
> drivers/gpu/drm/amd/amdgpu/vi.c:                mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vi.c:                mdelay(10);
> drivers/gpu/drm/amd/amdgpu/vi.c:                mdelay(10);

Looking through it, there are a lot of delays over ten milliseconds. 
Quite a few of 100 ms and once one second. I am wondring, why in these 
cases a while loop cannot check if the condition, that is waited for, 
became true. If the hardware engineers really designed the device that 
way, they should be contacted to improve that design in the future.

Do you you think the situation could be improved? I know, I am not a 
amdgfx developer – that datasheets are (often) missing –, but could the 
proposal below help? That could be checked during reviews.

For delays higher than five seconds, a comment must be added, why that 
delay is needed. Citing the datasheet name, revision and section is enough.

Additionally, for delays greater than 20 ms, a FIXME comment should be 
added and the situation explained in the commit message.


Kind regards,

Paul


[1]: https://01.org/suspendresume
