Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D095EC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1D62081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gvcVmyfx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F1D62081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbeLCXv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:51:27 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42138 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbeLCXv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:51:26 -0500
Received: by mail-lf1-f66.google.com with SMTP id l10so10539742lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=srQ7G2tCGTWc8nIq2cNHrfeia/FB/Zy69J4EahA0Hkg=;
        b=gvcVmyfxsmIIZ2mdDWTwW4sWSYUOtzdwqyTD3m/0s0y+TW+FFHulP1hXIM4Nw0M5ks
         VtjTCNrK0amlmBb1NZnJRrYKs5K5sneHK9SOGffP8+O7VYkao2AcipD3o53mo6Y0eyQ+
         2I8uHeNoiwqnx1zzzcA85S3iN3q8YjY/zByLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=srQ7G2tCGTWc8nIq2cNHrfeia/FB/Zy69J4EahA0Hkg=;
        b=jnDz5O3pqlRT2pfUJ5n6BPFaCUyLCu910dZB5qq03cK2cmQaeAwKwINYWkGc9DZQuy
         15igU4QFv0d1E/54TQ0BQHkXsW4tQUm4+dFS67hvhT4SXZL4akg2YiL1v/cFFuI0Usn1
         XEkqhuf7xb0bmoHBxFdgpq3mR3uy1S+OqUJyquHuo4oxZNehBfVF3rda0o9XOdaWi9AC
         4AyAR3gZvKKt7UzUC8FA4aXSFlDaMnl4EmyPOW+R3UlcEDzIY2NQMkW+mDYZ7CRIpekc
         0tVcB70WAJ+KQW4qHNtlVrETDMp/pcLjeUFo92MYrBDonIE8WRHlnsvsLIeofjta1XhD
         5/xA==
X-Gm-Message-State: AA+aEWZ8/LbCkILKKEYZX98uBL+gAr0IyEiraz8EnPTOMmqhPN5OW1Zo
        QdZjZ20eW4h870kOy9DvABgzSQ==
X-Google-Smtp-Source: AFSGD/VENQci9MRlgaqM2FnQQAjDXo+Tyd5xbpKiKyggFqTDxa4xf9yOdUowjdEepGPTSyOu26VgxQ==
X-Received: by 2002:a19:2755:: with SMTP id n82mr2896993lfn.94.1543881084077;
        Mon, 03 Dec 2018 15:51:24 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id f8sm2646324lfb.2.2018.12.03.15.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:51:23 -0800 (PST)
Date:   Tue, 4 Dec 2018 01:51:21 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     davem@davemloft.net, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com, andrew@lunn.ch
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for
 uc and mc address lists
Message-ID: <20181203235119.GF23230@khorivan>
Mail-Followup-To: Florian Fainelli <f.fainelli@gmail.com>,
        davem@davemloft.net, grygorii.strashko@ti.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com, andrew@lunn.ch
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
 <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 02:17:00PM -0800, Florian Fainelli wrote:
>On 12/3/18 10:40 AM, Ivan Khoronzhuk wrote:
>> Update vlan mc and uc addresses with VID tag while propagating address
>> set to lower devices, do this only if address is not synched. It allows
>> on end driver level to distinguish address belonging to vlans.
>
>Underlying driver for the real device would be able to properly identify
>that you are attempting to add an address to a virtual device, which
>happens to be of VLAN kind so I am really not sure this is the right
>approach here.
>
>From there, it seems to me that we have two situations:
>
>- each of your network devices expose VLAN devices directly on top of
>the real device, in which case your driver should support
>ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid to know when VLAN devices
>are create and maintain a VLAN device to VID correspondence if it needs
>to when being called while setting the addresses
>
>- you are setting up a bridge that is VLAN aware on one of your bridge
>ports, and there you can use switchdev to learn about such events and
>know about both addresses as well as VIDs that must be programmed into
>your real device
No limits to have any "middle" device between real end device and
virtual one, not only a bridge, but also other kind. And as it's generic
change, it should cover all such cases, the simplest example is:
real_dev/macvlan/vlan.

>
>It seems to me that what you need may be something like either:
>
>- notifications on slave devices when addresses are added via
>ndo_set_rxmode()
>
>or
>
>- dev_{uc,mc}_sync() should be augmented with a "source net_device"
>argument which allows you to differentiate which network device is the
>source of the address programming. That way, no need to "hash" the MAC
>address with a VID, any network device specific information can be
>provided and in the real device driver you can do: if
>(netif_is_vlan()... etc.)
No issue to retrieve vlan dev if it's directly on top of real dev.
Issue is to get it when it's not directly connected as it's not in
vlan_info group list. Who knows what else can be "structed" on top of
real dev till the vlan device. Please look on reply for cover letter,
as it seems requires similar response.

>
>Hopefully someone else will chime in.
>
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>>  include/linux/if_vlan.h |  1 +
>>  net/8021q/vlan_core.c   | 10 ++++++++++
>>  net/8021q/vlan_dev.c    | 26 ++++++++++++++++++++++++++
>>  3 files changed, 37 insertions(+)
>>
>> diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
>> index 4cca4da7a6de..94657f3c483a 100644
>> --- a/include/linux/if_vlan.h
>> +++ b/include/linux/if_vlan.h
>> @@ -136,6 +136,7 @@ extern struct net_device *__vlan_find_dev_deep_rcu(struct net_device *real_dev,
>>  extern int vlan_for_each(struct net_device *dev,
>>  			 int (*action)(struct net_device *dev, int vid,
>>  				       void *arg), void *arg);
>> +extern u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr);
>>  extern struct net_device *vlan_dev_real_dev(const struct net_device *dev);
>>  extern u16 vlan_dev_vlan_id(const struct net_device *dev);
>>  extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
>> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
>> index a313165e7a67..5d17947d6988 100644
>> --- a/net/8021q/vlan_core.c
>> +++ b/net/8021q/vlan_core.c
>> @@ -454,6 +454,16 @@ bool vlan_uses_dev(const struct net_device *dev)
>>  }
>>  EXPORT_SYMBOL(vlan_uses_dev);
>>
>> +u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr)
>> +{
>> +	u16 vid = 0;
>> +
>> +	vid = addr[dev->addr_len];
>> +	vid |= (addr[dev->addr_len + 1] & 0xf) << 8;
>> +	return vid;
>> +}
>> +EXPORT_SYMBOL(vlan_dev_get_addr_vid);
>> +
>>  static struct sk_buff *vlan_gro_receive(struct list_head *head,
>>  					struct sk_buff *skb)
>>  {
>> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
>> index b2d9c8f27cd7..c05b313314b7 100644
>> --- a/net/8021q/vlan_dev.c
>> +++ b/net/8021q/vlan_dev.c
>> @@ -250,6 +250,14 @@ void vlan_dev_get_realdev_name(const struct net_device *dev, char *result)
>>  	strncpy(result, vlan_dev_priv(dev)->real_dev->name, 23);
>>  }
>>
>> +static void vlan_dev_set_addr_vid(struct net_device *vlan_dev, u8 *addr)
>> +{
>> +	u16 vid = vlan_dev_vlan_id(vlan_dev);
>> +
>> +	addr[vlan_dev->addr_len] = vid & 0xff;
>> +	addr[vlan_dev->addr_len + 1] = (vid >> 8) & 0xf;
>> +}
>> +
>>  bool vlan_dev_inherit_address(struct net_device *dev,
>>  			      struct net_device *real_dev)
>>  {
>> @@ -481,8 +489,26 @@ static void vlan_dev_change_rx_flags(struct net_device *dev, int change)
>>  	}
>>  }
>>
>> +static void vlan_dev_align_addr_vid(struct net_device *vlan_dev)
>> +{
>> +	struct net_device *real_dev = vlan_dev_real_dev(vlan_dev);
>> +	struct netdev_hw_addr *ha;
>> +
>> +	if (!real_dev->vid_len)
>> +		return;
>> +
>> +	netdev_for_each_mc_addr(ha, vlan_dev)
>> +		if (!ha->sync_cnt)
>> +			vlan_dev_set_addr_vid(vlan_dev, ha->addr);
>> +
>> +	netdev_for_each_uc_addr(ha, vlan_dev)
>> +		if (!ha->sync_cnt)
>> +			vlan_dev_set_addr_vid(vlan_dev, ha->addr);
>> +}
>> +
>>  static void vlan_dev_set_rx_mode(struct net_device *vlan_dev)
>>  {
>> +	vlan_dev_align_addr_vid(vlan_dev);
>>  	dev_mc_sync(vlan_dev_priv(vlan_dev)->real_dev, vlan_dev);
>>  	dev_uc_sync(vlan_dev_priv(vlan_dev)->real_dev, vlan_dev);
>>  }
>>
>
>
>-- 
>Florian

-- 
Regards,
Ivan Khoronzhuk
