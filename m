Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BD8C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0D42152D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD0D42152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbeHTJtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 05:49:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeHTJtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 05:49:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D1F2804B9F1;
        Mon, 20 Aug 2018 06:34:49 +0000 (UTC)
Received: from [10.72.12.186] (ovpn-12-186.pek2.redhat.com [10.72.12.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FEBD2026D66;
        Mon, 20 Aug 2018 06:34:43 +0000 (UTC)
Subject: Re: [RFC PATCH net-next V2 0/6] XDP rx handler
To:     David Ahern <dsahern@gmail.com>,
        Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, mst@redhat.com
References: <1534130250-5302-1-git-send-email-jasowang@redhat.com>
 <20180814003253.fkgl6lyklc7fclvq@ast-mbp>
 <5de3d14f-f21a-c806-51f4-b5efd7d809b7@redhat.com>
 <20180814121734.105769fa@redhat.com>
 <03ab3b18-9b13-8169-7e68-ada307694bc1@redhat.com>
 <08bf7aec-078a-612d-833f-5b3d09a289d0@gmail.com>
 <aa9cf883-7822-70a7-5ab5-c873b69c2098@redhat.com>
 <f4c0346d-6665-5312-0310-ffbda505b7ec@gmail.com>
 <2792239a-ed3b-d66e-0c1c-e99455311eff@redhat.com>
 <ae0e09a1-a20a-a2fc-36a0-82e109216bf4@gmail.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9a1d9340-8fd0-4e27-0938-adf361fe6939@redhat.com>
Date:   Mon, 20 Aug 2018 14:34:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ae0e09a1-a20a-a2fc-36a0-82e109216bf4@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 20 Aug 2018 06:34:49 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Mon, 20 Aug 2018 06:34:49 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年08月18日 05:15, David Ahern wrote:
> On 8/15/18 9:34 PM, Jason Wang wrote:
>> I may miss something but BPF forbids loop. Without a loop how can we
>> make sure all stacked devices is enumerated correctly without knowing
>> the topology in advance?
> netdev_for_each_upper_dev_rcu
>
> BPF helpers allow programs to do lookups in kernel tables, in this case
> the ability to find an upper device that would receive the packet.

So if I understand correctly, you mean using 
netdev_for_each_upper_dev_rcu() inside a BPF helper? If yes, I think we 
may still need device specific logic. E.g for macvlan, 
netdev_for_each_upper_dev_rcu() enumerates all macvlan devices on top a 
lower device. But what we need is one of the macvlan that matches the 
dst mac address which is similar to what XDP rx handler did. And it 
would become more complicated if we have multiple layers of device.

So let's consider a simple case, consider we have 5 macvlan devices:

macvlan0: doing some packet filtering before passing packets to TCP/IP stack
macvlan1: modify packets and redirect to another interface
macvlan2: modify packets and transmit packet back through XDP_TX
macvlan3: deliver packets to AF_XDP
macvtap0: deliver packets raw XDP to VM

So, with XDP rx handler, what we need to just to attach five different 
XDP programs to each macvlan device. Your idea is to do all things in 
the root device XDP program. This looks complicated and not flexible 
since it needs to care a lot of things, e.g adding/removing 
actions/policies. And XDP program needs to call BPF helper that use 
netdev_for_each_upper_dev_rcu() to work correctly with stacked device.

Thanks
