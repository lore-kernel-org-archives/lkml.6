Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC3DECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC20C2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 17:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cj2sEjdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC20C2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeJTBac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 21:30:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38464 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeJTBac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 21:30:32 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9JHNSeO015806;
        Fri, 19 Oct 2018 12:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539969808;
        bh=RpaX5RQi6eRvEAn203m8TI2WfcrsoILHSLUFEaQMnSo=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=Cj2sEjdgPhLqMXqPR7QeXwnnw4k5Dpv+RORas+Deuuw0I3gVMYCnuIjZYbqNFoUW0
         hDgoBvrjqlXKFvEce6VGx0ef0DsM4DClMsrnFlG5bycO1QvoId3RS2NWLjc1RS4678
         fMyyY4mcjIsrU+p6KvnhHTeP7xEjc2K0jtg6puXU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9JHNSrY003586;
        Fri, 19 Oct 2018 12:23:28 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 19
 Oct 2018 12:23:28 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 19 Oct 2018 12:23:28 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9JHNSNe021938;
        Fri, 19 Oct 2018 12:23:28 -0500
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: don't flush mcast
 entries while switch promisc mode
To:     <davem@davemloft.net>, <linux-omap@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20181018180006.7065-1-ivan.khoronzhuk@linaro.org>
 <6c34a3ce-dbee-538e-bda7-8dd485315267@ti.com>
 <20181019120408.GA3909@khorivan>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <36da9bb2-38b7-cc70-9569-8895e20c6d1f@ti.com>
Date:   Fri, 19 Oct 2018 12:23:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181019120408.GA3909@khorivan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/18 7:04 AM, Ivan Khoronzhuk wrote:
> On Thu, Oct 18, 2018 at 07:03:06PM -0500, Grygorii Strashko wrote:
>>
>>
>> On 10/18/18 1:00 PM, Ivan Khoronzhuk wrote:
>>> No need now to flush mcast entries in switch mode while toggling to
>>> promiscuous mode. It's not needed as vlan reg_mcast = ALL_PORTS
>>> and mcast/vlan ports = ALL_PORTS, the same happening for vlan
>>> unreg_mcast, it's set to ALL_PORT_MASK just after calling promisc
>>> mode routine by calling set allmulti. I suppose main reason to flush
>>> them is to use unreg_mcast to receive all to host port. Thus, now, all
>>> mcast packets are received anyway and no reason to flush mcast entries
>>> unsafely, as they were synced with __dev_mc_sync() previously and are
>>> not restored. Another way is to _dev_mc_unsync() them, but no need.
>>
>> User have possibility to add additional mcast entries or edit existing 
>> in switch-mode, which is now done using custom tool. So, Host in promisc
>> mode will not receive packets for mcast address X if port mask for this
>> addr set to (ALL_PORTS - HOST_PORT). Am I missing smth?
> 
> I didn't take into account the custom tool changing entries directly,
> but even in this case there is at least a couple of interesting
> questions:
> 
> 1) Before the patch applied only several days ago -
>    5da1948969bc1991920987ce4361ea56046e5a98
>    "ti: cpsw: fix lost of mcast packets while rx_mode update"
>    It was impossible to do correctly anyway, as all mcast entries not
>    in the mc list were flushed (after rx_mode cb), by:
>    cpsw_ale_flush_multicast(cpsw->ale, ALE_ALL_PORTS, vid);
>    and those in mc, rewritten by adding them back in corrected form.
>    ... or this cb was not supposed to be called at all ...

It's not allowed to manipulate ALE table in dual_mac mode, so your
patches are safe in dual_mac mode. For switch-mode (unless we  move
forward with switch dev) standard linux interfaces allows create
default mcast entries which then (if required) corrected using custom
tool now.

> 
> 2) What is the reason to add mcast switch entires
>    (ALL_PORTS - HOST_PORT) if its function is added anyway by
>    unreq_mcast & (ALL_PORTS - HOST_PORT) ?
>    So, doesn't matter it's added or not - it will work :-|.

because in switch mode not all traffic directed to the Host port -
only in promisc mode. Reason safety and performance - Host should not
receive traffic which is not designated for it.

promiscuous in switch mode:
- disables learning
- enables unicast flooding to Host port
- enables unregistered multi-cast flooding to the Host port
In other words, CPSW will continue forwarding packets between P1&P2, but 
also will "duplicate" packets to Host port. This will work only for
vlans which have host port as member.

> 
> 3) Even so, toggling promisc mode will clear all these changes anyway,
>    even I will call _dev_mc_unsync() after flushing them.

there can be records which are not under control of Linux now.

> 
> 4) If user can tune ALE table by hand, what stops him do it after moving
>    to promisc mode, seems he knows what he's doing?
> 
> 5) It could be possible only for not default vlan entries, but mcast
>    vlan support is not supported yet. Who is gona restore those
>    entries after promisc off?
> 
> This behaviour is arguable, and flushing mcast entries can bring more
> issues then leaving. For me it doesn't matter, I can archive the same
> by adding after flush one line, it's even shorter:
> __dev_mc_unsync(priv->ndev, NULL);

Again, unless we move forward with switch dev you can't assume that
Linux stack has full control over ALE table. Sry, hence this patch is
not a fix and can introduce changes in current behavior and cause
regression reports - NACK.

-- 
regards,
-grygorii
