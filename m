Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE23DECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6642D2064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6642D2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gblabs.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeGTU7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:59:34 -0400
Received: from 61.239-255-62.static.virginmediabusiness.co.uk ([62.255.239.61]:55194
        "EHLO office.gblabs.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbeGTU7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:59:34 -0400
X-Greylist: delayed 1807 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jul 2018 16:59:33 EDT
X-Footer: Z2JsYWJzLmNvLnVr
Received: from [172.16.36.160] ([82.71.45.69])
        (authenticated user a.richman@gblabs.co.uk)
        by office.gblabs.co.uk (Kerio Connect 9.2.5 patch 3) with ESMTPSA
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
        Fri, 20 Jul 2018 20:39:43 +0100
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
From:   Alex Richman <alex.r@gblabs.co.uk>
Subject: Very slow SYS_io_destroy()
Message-ID: <27245a6a-a827-2662-215c-05ccdff65768@gblabs.co.uk>
Date:   Fri, 20 Jul 2018 20:39:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing some weirdness with AIO, specifically SYS_io_destroy() is 
taking upwards of ~100000 microseconds (~100 miliseconds) per call.
How long is that call expected to take?  I can see from the source that 
it's waiting e.g. for requests to finish but at the time of my call all 
requests are already finished (and SYS_io_getevent()'d)...

Here's some logs for example (<annotations for clarity>):
1532115053.520016 > hook_1(1073741824, 94766015790162, 14, 100, 
139919450371008, 15) -> 0x7ffe9e505770
<3 IOCBs prepared, CMD_PWRITEV IOVs, 1 IOV per write, 14 bytes per write>
1532115053.520035 = {prep(0 - fd: 4, o: 0, b: 0x7ffe9e504658, n: 1, p: 
0, fl: 0)}
1532115053.520037 = {prep(1 - fd: 5, o: 0, b: 0x7ffe9e504658, n: 1, p: 
0, fl: 0)}
1532115053.520038 = {prep(2 - fd: 6, o: 0, b: 0x7ffe9e504658, n: 1, p: 
0, fl: 0)}
<IOCBs submitted>
1532115053.520415 = {submit(-1978707968, 3) -> 3}
<io_events retreived>
1532115053.520417 = {done(0 - r: 14)}
1532115053.520418 = {done(1 - r: 14)}
1532115053.520419 = {done(2 - r: 14)}
1532115053.520420 = {complete(3) -> 14}
<io_cxt destroyed>
1532115053.639594 = {destroy(-1978707968) -> 0}
1532115053.639601 = (0x7ffe9e505770 = 0)

Between the complete(3) line and destroy(-etc) line only 
SYS_io_destroy() is being called.  It's the only possible source of that 
lost ~100 miliseconds...

Any ideas?

Many thanks,
- Alex.

-- 
Alex Richman
alex.r@gblabs.co.uk
Engineering
Tel:+44 (0)118 455 5000
www.gblabs.com


