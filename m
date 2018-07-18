Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B253ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA042075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA042075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbeGRVqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 17:46:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39878 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726633AbeGRVqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 17:46:50 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 664807262F;
        Wed, 18 Jul 2018 21:07:07 +0000 (UTC)
Received: from [172.31.27.48] (dhcp-17-185.bos.redhat.com [10.18.17.185])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D1712156893;
        Wed, 18 Jul 2018 21:07:06 +0000 (UTC)
Subject: Re: [PATCH net] bonding: set default miimon value for non-arp modes
 if not set
To:     =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS1?=
         =?UTF-8?B?4KS+4KSwKQ==?= <maheshb@google.com>
Cc:     linux-kernel@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S . Miller" <davem@davemloft.net>,
        linux-netdev <netdev@vger.kernel.org>, stable@vger.kernel.org
References: <20180718184936.16037-1-jarod@redhat.com>
 <CAF2d9jgCxvXaGo3E0hSc7i78vXStXM=BuhHFDjs817b19yT0WA@mail.gmail.com>
From:   Jarod Wilson <jarod@redhat.com>
Message-ID: <83c0327d-8e93-6036-c34b-f8d59223b974@redhat.com>
Date:   Wed, 18 Jul 2018 17:07:07 -0400
User-Agent: Mutt/1.5.21 (2010-09-15)
MIME-Version: 1.0
In-Reply-To: <CAF2d9jgCxvXaGo3E0hSc7i78vXStXM=BuhHFDjs817b19yT0WA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 18 Jul 2018 21:07:07 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 18 Jul 2018 21:07:07 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jarod@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-18 3:51 PM, Mahesh Bandewar (महेश बंडेवार) wrote:
> On Wed, Jul 18, 2018 at 11:49 AM, Jarod Wilson <jarod@redhat.com> wrote:
>> For some time now, if you load the bonding driver and configure bond
>> parameters via sysfs using minimal config options, such as specifying
>> nothing but the mode, relying on defaults for everything else, modes
>> that cannot use arp monitoring (802.3ad, balance-tlb, balance-alb) all
>> wind up with both arp_interval=0 (as it should be) and miimon=0, which
>> means the miimon monitor thread never actually runs. This is particularly
>> problematic for 802.3ad.
>>
>> For example, from an LNST recipe I've set up:
>>
>> $ modprobe bonding max_bonds=0"
>> $ echo "+t_bond0" > /sys/class/net/bonding_masters"
>> $ ip link set t_bond0 down"
>> $ echo "802.3ad" > /sys/class/net/t_bond0/bonding/mode"
>> $ ip link set ens1f1 down"
>> $ echo "+ens1f1" > /sys/class/net/t_bond0/bonding/slaves"
>> $ ip link set ens1f0 down"
>> $ echo "+ens1f0" > /sys/class/net/t_bond0/bonding/slaves"
>> $ ethtool -i t_bond0"
>> $ ip link set ens1f1 up"
>> $ ip link set ens1f0 up"
>> $ ip link set t_bond0 up"
>> $ ip addr add 192.168.9.1/24 dev t_bond0"
>> $ ip addr add 2002::1/64 dev t_bond0"
>>
>> This bond comes up okay, but things look slightly suspect in
>> /proc/net/bonding/t_bond0 output:
>>
>> $ grep -i mii /proc/net/bonding/t_bond0
>> MII Status: up
>> MII Polling Interval (ms): 0
>> MII Status: up
>> MII Status: up
>>
> This doesn't seem correct since the MII interval set is 0. It should
> set to 100 by default for this mode. This may be the side effect of
> brining up the bond with default more (balance-rr) and then bringing
> bond-down before configuring it. You can probably get away by just not
> bringing down the bond (step 'set ip link bond0 down) in your recipe
> above. But irrespective of that step, this mode  needs miimon and
> should have been set correctly.

I don't think bringing the bond down matters. We run bond_check_params() 
at module load time, and above, it's loaded via 'modprobe bonding 
max_bonds=0', with no mode= set, so bond_check_params() sets bond_mode 
to BOND_MODE_ROUNDROBIN. When we get down to the miimon checks, we check 
for !bond_mode_uses_arp(BOND_MODE_ROUNDROBIN), which ends up false, so 
we never drop into the code block that sets miimon to 100, meaning it's 
still 0. Then we set up a new bond via sysfs as mode 802.3ad, which goes 
through bond_option_mode_set(), which then also does a 
bond_mode_uses_arp() check, but doesn't currently DO anything if you 
also (correctly) have arp_interval=0, so the bit there that would have 
set miimon to 100 also gets skipped. This just makes sure this setup 
path does get a reasonable default value if none was set.

-- 
Jarod Wilson
jarod@redhat.com
