Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C904CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E57E20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 03:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E57E20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeIJIg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 04:36:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726024AbeIJIg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 04:36:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9077540201BC;
        Mon, 10 Sep 2018 03:44:33 +0000 (UTC)
Received: from [10.72.12.30] (ovpn-12-30.pek2.redhat.com [10.72.12.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5695310075FE;
        Mon, 10 Sep 2018 03:44:28 +0000 (UTC)
Subject: Re: [PATCH net-next 04/11] tuntap: simplify error handling in
 tun_build_skb()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-5-jasowang@redhat.com>
 <20180906130425-mutt-send-email-mst@kernel.org>
 <e1f17f51-5f99-df18-4185-6c6e4dfaba89@redhat.com>
 <20180907101645-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <372ec320-83cf-add5-acf7-27d876c3d604@redhat.com>
Date:   Mon, 10 Sep 2018 11:44:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907101645-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 10 Sep 2018 03:44:33 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 10 Sep 2018 03:44:33 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月07日 22:17, Michael S. Tsirkin wrote:
> On Fri, Sep 07, 2018 at 11:22:00AM +0800, Jason Wang wrote:
>>>> @@ -1668,6 +1668,9 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
>>>>    	if (copied != len)
>>>>    		return ERR_PTR(-EFAULT);
>>>> +	get_page(alloc_frag->page);
>>>> +	alloc_frag->offset += buflen;
>>>> +
>>> This adds an atomic op on XDP_DROP which is a data path
>>> operation for some workloads.
>> Yes, I have patch on top to amortize this, the idea is to have a very big
>> refcount once after the frag was allocated and maintain a bias and decrease
>> them all when allocating new frags.'
> Why bother with refcounting for a drop though? It should be simple.
>

Right, let me fix this.

Thanks
