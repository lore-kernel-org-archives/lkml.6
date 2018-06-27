Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30000C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D858A25DDC
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D858A25DDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966386AbeF0TMs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 15:12:48 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:51044 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966127AbeF0TMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 15:12:46 -0400
Received: from [192.168.178.170] (pD95EF523.dip0.t-ipconnect.de [217.94.245.35])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 7B5AA28BD95;
        Wed, 27 Jun 2018 19:09:32 +0000 (UTC)
Subject: Re: [PATCH RFC 0/4] Adding DT functionality to w1 busses
To:     Rob Herring <robh+dt@kernel.org>
Cc:     zbr@ioremap.net, Mark Rutland <mark.rutland@arm.com>,
        szabolcs.gyurko@tlt.hu, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180619212744.794-1-daniel@zonque.org>
 <CAL_JsqLfzfJC=_NhJy=jFAqEgfi=cvjMcnkjdHdzfM2uhKGBAQ@mail.gmail.com>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <31d55df2-b5ba-f37e-7566-c73f58ba9b43@zonque.org>
Date:   Wed, 27 Jun 2018 21:12:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLfzfJC=_NhJy=jFAqEgfi=cvjMcnkjdHdzfM2uhKGBAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 26, 2018 11:39 PM, Rob Herring wrote:
> On Tue, Jun 19, 2018 at 3:27 PM, Daniel Mack <daniel@zonque.org> wrote:
>> In order to fully move battery-supplied devices over to devicetree, the
>> onewire subsystem must get some updates.
>>
>> Currently, the w1 bus system works like this. Device families, such as
>> battery controllers etc, are registered to the w1 core. Once a master
>> device is probed, it starts scanning the bus. Slave devices that are
>> revealed through this scan and that match previously registered
>> families are then registered, and their .add_slave() callback is
>> invoked.
>>
>> Some devices, such as the ds2760, use that callback to call
>> platform_device_alloc() at runtime with a fixed device name to
>> instanciate their only user. That user does the actual work, while the
>> slave device merely functions as an I/O proxy. In the user
>> implementation, the w1 slave device is accessible through
>> dev->parent.
> 
> Looks to me like you are letting the driver structure define the DT
> structure. This detail is all irrelevant to DT.
> 
>>
>> Now, for devicetree environments, this has to change a bit. First, slave
>> devices need to have a matching table so they can be listed as sub-nodes
>> of their master bus controller. Second, the core needs to match the
>> entries in these tables against the sub-nodes of the master node.
>> These two are trivial to do.
>>
>> The next question is how the w1 slave device and its user(s) are linked
>> together. I'm proposing a DT layout with the following example:
>>
>>          onewire {
>>                  compatible = "w1-gpio";
>>
>>                  w1_slave: slave@0 {
>>                          compatible = "maxim,w1-ds2760";
>>                  };
>>          };
>>
>>          battery-supply {
>>                  compatible = "maxim,ds2760-supply";
>>                  w1-slave = <&w1_slave>;
>>          };
> 
> This should just be one node and a child of the 1-wire master.

Yeah, you're right. This also makes the patch set much simpler.

Thanks for the feedback - I'll send another round of patches.



Daniel

