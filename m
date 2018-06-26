Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2D7C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789F226D4F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KvxV0grZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789F226D4F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbeFZPmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:42:08 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13017 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbeFZPmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1530027728; x=1561563728;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=HPJ+Yrg+nBnyP/+xbx/1BogRAhkUGB334M3i+xP0kLk=;
  b=KvxV0grZxN5IgzdjgzZ4ByTYekyvYfd8tUiIB2XinNIK0BVnJwJgr39s
   /RWPBlgHhuXUCGTPQh620NwKBCELq344/96qVndamFYsAN/bhNLEgTQfY
   oxxZXUUHrdQMp7cO9h7Ox6AP5fG3Nx1Be61uMObfF7py1kBLnVQfLrVqz
   MSr4aq2LrVhbz5uXaYVhlfOkp229VaDbFBmroJrqVvMIlESCp7yqYVuk2
   XGUA2u1xVS3/EiebfoTrshivFjDb59ohJKb/vVPD32096M0V9unYZYBpA
   LwKtqHCa/D0Z39vHIl6jM1Wb6AVXwxsKxpGChQ02E4BqfHftRjxnWB7eq
   Q==;
X-IronPort-AV: E=Sophos;i="5.51,274,1526313600"; 
   d="scan'208";a="83130648"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2018 23:42:07 +0800
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Jun 2018 08:31:41 -0700
Received: from thinkpad-bart.sdcorp.global.sandisk.com (HELO [10.111.67.248]) ([10.111.67.248])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2018 08:42:07 -0700
Subject: Re: Tracing to console
To:     "rostedt@goodmis.org" <rostedt@goodmis.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
References: <08fe327a686f590008de3d6f43c880c655c648c2.camel@wdc.com>
From:   Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <351b4a0d-b66d-b32c-2066-b638a566de64@wdc.com>
Date:   Tue, 26 Jun 2018 08:42:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <08fe327a686f590008de3d6f43c880c655c648c2.camel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steven and Ingo,

Did I report this observation to the right people?

Thank you,

Bart.

On 06/15/18 14:01, Bart Van Assche wrote:
> Hello Steven,
> 
> If I run the following commands as root:
> 
> cd /sys/kernel/debug/tracing
> grep pm_ available_events > set_event
> echo function >current_tracer
> grep scsi_ available_filter_functions | while read a b; do echo $a; done >set_ftrace_filter
> echo 1 >events/printk/enable
> echo 1 >tracing_on
> echo 1 >/proc/sys/kernel/tracepoint_printk
> echo - - - >/sys/class/scsi_host/host0/scan
> 
> then the following appears on the console:
> 
> console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: console: console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: console: console: console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> console: console: console: console: console: console: console: console: console: console: console: ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [ ... ]
> 
> I assume that the repeated "console: " prefix is a bug and also that the same
> line repeats over and over again is also a bug? I ran into this with commit
> 017b3f8a10ca ("scsi: snic: fix a couple of spelling mistakes: "COMPLETE"").
