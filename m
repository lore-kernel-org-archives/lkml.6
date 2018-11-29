Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EDEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F3B213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hmojGzx+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F3B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbeK3Cch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:32:37 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34015 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeK3Cch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:32:37 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so2119349ljd.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 07:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Fe0bFDF0tnGy1/SpErRomGpN2OMq9bozCOXBR7sqtoI=;
        b=hmojGzx+wZiLDFrgtDB9szlVGCz98/b8H4YdU5q5NmDrGGKMFTP7O5LoyA3gJSgJ+j
         I6DdZNMX1fr+ewcEAMare5DBiH6MxW1WxVHtlfq21prLqJO0bcGTE82dvCr8hhgC76tx
         wfkIXL2petrVIi7SLdTgalhSZlfphat71j8pE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Fe0bFDF0tnGy1/SpErRomGpN2OMq9bozCOXBR7sqtoI=;
        b=B6liQGV8YNID9dWFeLFwPSUY37vt9mTaTy4OjpiJXpe866jOLTUrQVZEYtdHzyf8/q
         ENozzTPFNQ5PjvFh+IBkRzKRbBxljyT5LYlOQC6tUZTs/jWUcaYDKhDxDPXjefyigrkB
         gQSDS17sun0F2+NPMqaxsWJsHXMzmSH6JW1QrgR0/30W6yDUXPkxV87WRlpBcpj9b47c
         wadsxkPKWad1WK8hT3UZZMUi2XLcpW1lDoZXdTukcBmhUrfkrFG5rPRk1+3QmMRg++5w
         M62eB2XDtnS09ZlHkzmA7yEgcJuc11Pzwu27vX9z60OUhU4stZH9Vq/Es1IsnfFwLwYr
         iBPQ==
X-Gm-Message-State: AA+aEWZo+zzWTmiZpHn1NIdY98YOPuNYnksQnmB7UPd1Ppvfhb0YKz7J
        8iDFD7gXpGmx10S541wAH6AVsg==
X-Google-Smtp-Source: AFSGD/VCozSAtQgXqxujHIVFnY5x0huGgEN6STRLMQXPfzcfp+r7r9p8zX5tt3k/8Jdh86iPUKJc7g==
X-Received: by 2002:a2e:8449:: with SMTP id u9-v6mr1531976ljh.121.1543505210937;
        Thu, 29 Nov 2018 07:26:50 -0800 (PST)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id y23-v6sm330469ljk.95.2018.11.29.07.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 07:26:50 -0800 (PST)
Date:   Thu, 29 Nov 2018 17:26:48 +0200
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: drop vid0
 configuration in dual_mac modey
Message-ID: <20181129152646.GC23230@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
References: <20181125234626.28474-1-grygorii.strashko@ti.com>
 <20181126162644.GA23230@khorivan>
 <7f2c5e66-3b42-f921-c52d-236f5adc44bf@ti.com>
 <20181126200757.GB23230@khorivan>
 <fcc8efa1-1f19-baa3-872d-5c76a1b7dce0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fcc8efa1-1f19-baa3-872d-5c76a1b7dce0@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:15:46PM -0600, Grygorii Strashko wrote:
>
>
>On 11/26/18 2:07 PM, Ivan Khoronzhuk wrote:
>> On Mon, Nov 26, 2018 at 12:57:20PM -0600, Grygorii Strashko wrote:
>>>
>>>
>>> On 11/26/18 10:26 AM, Ivan Khoronzhuk wrote:
>>>> On Sun, Nov 25, 2018 at 05:46:26PM -0600, Grygorii Strashko wrote:
>>>>> In dual_mac mode CPSW driver uses vid1 and vid2 by default to implement
>>>>> dual mac mode wich are used to configure pvids for each external ports.
>>>>> But, historicaly, it also adds vid0 to ALE table and sets "untag" bits for both
>>>>> ext. ports. As result, it's imposible to use priority tagged packets in
>>>>> dual mac mode.
>>>>>
>>>>> Hence, drop vid0 configuration in dual mac mode as it's not required for dual
>>>>> mac mode functionality and, this way, make it possible to use priority
>>>>> tagged packet in dual mac mode.
>>>> So, now it's enabled to be added via regular ndo.
>>>> I have similar change in mind, but was going to send it after
>>>> mcast/ucast, and - enabling same vlans patch...
>>>>
>>>> 2 things stopped me to add this:
>>>>
>>>> 1) Moving it to be enabled via regular call is Ok, but in dual mac mode
>>>> it causes overlaps, at least while vid deletion. So decided to wait till
>>>> same vlans series is applied.
>>>
>>> TI driver documentation mentions this restriction
>>> "While adding VLAN id to the eth interfaces,
>>> same VLAN id should not be added in both interfaces which will lead to VLAN
>>> forwarding and act as switch"
>> It's not accurate now.
>> This sw bug "acting like a switch" was fixed indirectly in LKML ).
>> And at least for upstream version, not TISDK, desc should be updated,
>> but better do this when it fixed completely and merged with TISDK.
>>
>> I know about this "written" restriction
>> (for tiSDK, and it's not TRM after all ...),
>> it can be avoided and it's partly avoided now ...
>
>I'd like to clarify point about supporting same VLANs in dual_mac mode,
>to avoid future misunderstanding, overall: it's *not* supported as
>adding same VLAN to both netdevices will cause unknown unicast packets
>leaking between interfaces and it can't be avoided - hw limitation.

Simple test shows no issues with ucast leaking.
But for current buggy ucast vlan implementation it's not possible to verify,
not sure but probably leaking in your case cuased by hidden toggling of
interface to promisc while added ucast to vlans or other reason or so.
Anyway I just decided to check specifically ucasts
 (macst as you know are not normal now).

For verification you need to apply ucast fix (including vlans) first:
https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=vlan_addr_flt_fix

This is generic fix (not sure it will be approved, need try RFC) but implement
the same as local fix for vlan ucasts:
https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=ucast_vlan_fix

Any of those are correct. I've used generic one.
Applied the following scheme:

                     +--------------------------+
                     | host 74:DA:EA:47:7D:9C   |
                     +--------------------------+

                        +---------------------+
			|       am572 evm     |
                        |    eth0      eth1   |
                        +----------+----------+
                        | eth0.400 | eth1.400 |
                        +----------+----------+
                            ^          |
                            |          |  +-----------+
 +-----------------+        |          |  |     PC    |
 | BBB eth0.400    |--------+          +->| Wireshark |
 +-----------------+                      +-----------+


1) Configure vlans on am572x evm
 ip link add link eth0 name eth0.400 type vlan id 400
 ip link add link eth1 name eth1.400 type vlan id 400

2) On BBB side:
 # ip link add link eth0 name eth0.400 type vlan id 400
Send ucast vlan traffic to the am572 evm, vlan ucast address is unreq on am572.
 # ./plget -i eth0.400 -t ptpl2 -m tx-lat -n 160 -s 10 -a 74:DA:EA:47:7D:66
 # ./plget -i eth0.400 -t ptpl2 -m tx-lat -n 160 -s 10 -a 18:03:73:66:87:42

3) Observe silence on PC wireshark.

Thus, no see issues with this.

PS: I'm sure in plget tool, you can use your own.

>
>Regarding vid0 - current default configuration of CPSW considers
>vid0/priority tagged packets as - untagged and assigns pvid to any
>such ingress packet inside switch. Hence, P0 (Linux host) egress port
>never modifies packet contents - this behavior is not visible to Linux.
>(EN_VID0_MODE=0, P1_PASS_PRI_TAGGED=0)

I can't verify everything with vlan0 at this moment (not time), just
shared my thoughts adding a notice it has same possible overlap issues
(or part of them) after this patch as regular vlans have.

>
>>
>> Also, for notice, while you add any of the vlans to any of
>> the ports, vlan0 is added to both of them.....restricted it or not.
>> Thanks to last changes in the driver it's not "acting like a switch"
>> The patch in question enables this in ndo, not me.
>>
>> #ip link add link eth0 name eth0.400 type vlan id 400
>> [  326.538989] 8021q: 802.1Q VLAN Support v1.8
>> [  326.543217] 8021q: adding VLAN 0 to HW filter on device eth0
>> [  326.554645] 8021q: adding VLAN 0 to HW filter on device eth1
>> [  326.572236] net eth0: Adding vlanid 400 to vlan filter
>>
>> I just propose to extend it later, when it's correct to do.
>> But if no harm (basically no harm, only if someone decides
>> to add vlan0 to both ports and then delete on one of them)
>> , at least you should take this into account.
>>
>
>
>
>-- 
>regards,
>-grygorii

-- 
Regards,
Ivan Khoronzhuk
