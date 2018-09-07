Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3F2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA92320857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 03:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA92320857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeIGHqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 03:46:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725743AbeIGHqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 03:46:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CB9785784;
        Fri,  7 Sep 2018 03:07:41 +0000 (UTC)
Received: from [10.72.12.125] (ovpn-12-125.pek2.redhat.com [10.72.12.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F059210073B1;
        Fri,  7 Sep 2018 03:07:36 +0000 (UTC)
Subject: Re: [PATCH net-next 01/11] net: sock: introduce SOCK_XDP
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20180906040526.22518-1-jasowang@redhat.com>
 <20180906040526.22518-2-jasowang@redhat.com>
 <20180906125615-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c176da90-9b03-e0ff-9e9f-570493530150@redhat.com>
Date:   Fri, 7 Sep 2018 11:07:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906125615-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 07 Sep 2018 03:07:41 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Fri, 07 Sep 2018 03:07:41 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年09月07日 00:56, Michael S. Tsirkin wrote:
> On Thu, Sep 06, 2018 at 12:05:16PM +0800, Jason Wang wrote:
>> This patch introduces a new sock flag - SOCK_XDP. This will be used
>> for notifying the upper layer that XDP program is attached on the
>> lower socket, and requires for extra headroom.
>>
>> TUN will be the first user.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> In fact vhost is the 1st user, right? So this can be
> pushed out to become patch 10/11.

Better with an independent patch, since patch 10/11 can work without XDP.

Thanks

>
>> ---
>>   drivers/net/tun.c  | 19 +++++++++++++++++++
>>   include/net/sock.h |  1 +
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index ebd07ad82431..2c548bd20393 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -869,6 +869,9 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
>>   		tun_napi_init(tun, tfile, napi);
>>   	}
>>   
>> +	if (rtnl_dereference(tun->xdp_prog))
>> +		sock_set_flag(&tfile->sk, SOCK_XDP);
>> +
>>   	tun_set_real_num_queues(tun);
>>   
>>   	/* device is allowed to go away first, so no need to hold extra
>> @@ -1241,13 +1244,29 @@ static int tun_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>>   		       struct netlink_ext_ack *extack)
>>   {
>>   	struct tun_struct *tun = netdev_priv(dev);
>> +	struct tun_file *tfile;
>>   	struct bpf_prog *old_prog;
>> +	int i;
>>   
>>   	old_prog = rtnl_dereference(tun->xdp_prog);
>>   	rcu_assign_pointer(tun->xdp_prog, prog);
>>   	if (old_prog)
>>   		bpf_prog_put(old_prog);
>>   
>> +	for (i = 0; i < tun->numqueues; i++) {
>> +		tfile = rtnl_dereference(tun->tfiles[i]);
>> +		if (prog)
>> +			sock_set_flag(&tfile->sk, SOCK_XDP);
>> +		else
>> +			sock_reset_flag(&tfile->sk, SOCK_XDP);
>> +	}
>> +	list_for_each_entry(tfile, &tun->disabled, next) {
>> +		if (prog)
>> +			sock_set_flag(&tfile->sk, SOCK_XDP);
>> +		else
>> +			sock_reset_flag(&tfile->sk, SOCK_XDP);
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>> diff --git a/include/net/sock.h b/include/net/sock.h
>> index 433f45fc2d68..38cae35f6e16 100644
>> --- a/include/net/sock.h
>> +++ b/include/net/sock.h
>> @@ -800,6 +800,7 @@ enum sock_flags {
>>   	SOCK_SELECT_ERR_QUEUE, /* Wake select on error queue */
>>   	SOCK_RCU_FREE, /* wait rcu grace period in sk_destruct() */
>>   	SOCK_TXTIME,
>> +	SOCK_XDP, /* XDP is attached */
>>   };
>>   
>>   #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
>> -- 
>> 2.17.1

