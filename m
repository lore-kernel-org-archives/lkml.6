Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC145C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2F720878
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2F720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIGMMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:12:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52542 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725940AbeIGMMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:12:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9211926368;
        Fri,  7 Sep 2018 07:33:15 +0000 (UTC)
Received: from [10.72.12.68] (ovpn-12-68.pek2.redhat.com [10.72.12.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40E3C112C247;
        Fri,  7 Sep 2018 07:33:10 +0000 (UTC)
Subject: Re: [PATCH net-next 09/11] tuntap: accept an array of XDP buffs
 through sendmsg()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-10-jasowang@redhat.com>
 <20180906134834-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ac494845-1fcc-602b-dec9-c11109f55518@redhat.com>
Date:   Fri, 7 Sep 2018 15:33:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906134834-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 07 Sep 2018 07:33:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 07 Sep 2018 07:33:15 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月07日 01:51, Michael S. Tsirkin wrote:
> On Thu, Sep 06, 2018 at 12:05:24PM +0800, Jason Wang wrote:
>> This patch implement TUN_MSG_PTR msg_control type. This type allows
>> the caller to pass an array of XDP buffs to tuntap through ptr field
>> of the tun_msg_control. If an XDP program is attached, tuntap can run
>> XDP program directly. If not, tuntap will build skb and do a fast
>> receiving since part of the work has been done by vhost_net.
>>
>> This will avoid lots of indirect calls thus improves the icache
>> utilization and allows to do XDP batched flushing when doing XDP
>> redirection.
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> Is most of the benefit in batched flushing or skipping
> indirect calls? Because if it's flushing we can gain
> most of it easily by adding an analog of xmit_more.
>

Should be both. XDP_DROP doesn't flush but it gives obvious improvement.

Thanks
