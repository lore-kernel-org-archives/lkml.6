Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5031BC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040D9208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="s6EaSojg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040D9208FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732394AbeGKKLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:11:51 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:54619 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbeGKKLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=y5yfunVxp4DOrwESlanCf+NRERNJHfnK1sCEAT88Az0=; b=s6EaSojg9C0HoGf/BqGiXPpPYp
        b/2oLQkVBu4DHc5U5XDCx3N2Rz0LbkveNbdT8tTrWczQeUAR+LXApYAfhmcyqkLYTdjZUPQRA7By7
        nNnufjVq6/hYjtuSV58PbzgET6MkrAEaUFaE0n6NfMXRazyzKSdx6ICn30g9bLz8QlLkw3FimuPwW
        cz2IqHndKiQkKdcLYwT8C91BE6pJk6Z38fZkYlLNO457nTROHEBq+GSYG8gABl3e68T/bv+8n9KcQ
        xRgq1GyaoxX9Y8r320Ki5GX4FLjwoJnNYg4vFO5hoLjLZJMnDPmC7c1zcVs1VGd6blpwgYsMKKJDI
        oq2XFh2g==;
Received: from dsl-hkibng22-54faa2-250.dhcp.inet.fi ([84.250.162.250])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1fdC2g-0004sq-40; Wed, 11 Jul 2018 13:08:14 +0300
To:     p.paillet@st.com, broonie@kernel.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Subject: Boot WARN with patch "regulator: core: Link consumer with regulator
 driver"
Message-ID: <83491a3e-cfed-6673-244e-e720f338db92@kapsi.fi>
Date:   Wed, 11 Jul 2018 13:08:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 84.250.162.250
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing the following spew during boot with Tegra210 with the patch 
"regulator: core: Link consumer with regulator driver", recently applied 
to linux-next:

[    1.196664] ------------[ cut here ]------------
[    1.201480] kobject: '(null)' ((____ptrval____)): is not initialized, 
yet kobject_put() is being called.
[    1.219186] WARNING: CPU: 2 PID: 23 at lib/kobject.c:688 
kobject_put+0xa4/0xe8
[    1.230026] Modules linked in:
[    1.241081] CPU: 2 PID: 23 Comm: kworker/2:0 Not tainted 
4.18.0-rc4-next-20180711 #66
[    1.258637] Hardware name: NVIDIA Jetson TX1 Developer Kit (DT)
[    1.258651] Workqueue: rcu_gp srcu_invoke_callbacks
[    1.272055] pstate: 60000005 (nZCv daif -PAN -UAO)
[    1.272064] pc : kobject_put+0xa4/0xe8
[    1.272071] lr : kobject_put+0xa4/0xe8
[    1.272078] sp : ffff000009be3cf0
[    1.279387] console [ttyS0] disabled
[    1.283662] x29: ffff000009be3cf0 x28: 0000000000000000
[    1.283673] x27: ffff8000fb30aeb8 x26: ffff000008e20690
[    1.283686] x25: ffff0000093e2118 x24: ffff8000fff7b480
[    1.314668] x23: ffff000008135358 x22: ffff8000fff7b4c0
[    1.325719] x21: ffff8000fff7b4c8 x20: ffff8000fafae600
[    1.325727] x19: ffff8000faa54850 x18: 0000000000000010
[    1.346022] x17: 0000000000000000 x16: 0000000000000000
[    1.346022] x17: 0000000000000000 x16: 0000000000000000
[    1.356805] x15: ffffffffffffffff x14: 75705f7463656a62
[    1.356805] x15: ffffffffffffffff x14: 75705f7463656a62
[    1.356813] x13: 6f6b20746579202c x12: 64657a696c616974
[    1.356813] x13: 6f6b20746579202c x12: 64657a696c616974
[    1.374670] x11: 696e6920746f6e20 x10: 7369203a29295f5f
[    1.374670] x11: 696e6920746f6e20 x10: 7369203a29295f5f
[    1.374678] x9 : 5f5f6c6176727470 x8 : ffff0000085c9810
[    1.404186] x7 : 6220736920292874 x6 : 000000000000000d
[    1.414785] x5 : 0000000000000000 x4 : 0000000000000000
[    1.414793] x3 : ffffffffffffffff x2 : ffff000009301010
[    1.414801] x1 : a7cf02699fb4fa00 x0 : 0000000000000000
[    1.424623] Call trace:
[    1.424632]  kobject_put+0xa4/0xe8
[    1.424645]  __device_link_free_srcu+0x24/0x48
[    1.435235]  srcu_invoke_callbacks+0xf0/0x170
[    1.435242]  process_one_work+0x1e0/0x318
[    1.435247]  worker_thread+0x40/0x428
[    1.435259]  kthread+0x124/0x128
[    1.445628] loop: module loaded
[    1.449599] ---[ end trace ce0b4f0828c5eeaf ]---
[    1.449619] ------------[ cut here ]------------

After reverting the patch, the kernel boots without the warning.

Thanks,
Mikko
