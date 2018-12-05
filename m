Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A880C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3449120850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:14:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3449120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bakke.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeLETN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:13:59 -0500
Received: from smtprelay0067.hostedemail.com ([216.40.44.67]:40210 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727606AbeLETN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:13:58 -0500
X-Greylist: delayed 529 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Dec 2018 14:13:57 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 3FB6A18020DB3;
        Wed,  5 Dec 2018 19:05:09 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 26B75182CF66B;
        Wed,  5 Dec 2018 19:05:08 +0000 (UTC)
X-Session-Marker: 6461674062616B6B652E636F6D
X-HE-Tag: coil62_663d10cb1d15b
X-Filterd-Recvd-Size: 3591
Received: from [192.168.6.106] (219.92-221-209.customer.lyse.net [92.221.209.219])
        (Authenticated sender: dag@bakke.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Dec 2018 19:05:01 +0000 (UTC)
Subject: Re: [PATCH v2 BlueZ] hid2hci: Fix udev rules for linux-4.14+
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-bluetooth@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Kay Sievers <kay.sievers@vrfy.org>,
        =?UTF-8?Q?Zbigniew_J=c4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180620164240.6535-1-ville.syrjala@linux.intel.com>
 <20181204204117.14964-1-ville.syrjala@linux.intel.com>
 <20181205070621.GE16346@kroah.com> <20181205154032.GT9144@intel.com>
From:   Dag B <dag@bakke.com>
Message-ID: <c2f9f862-0bf1-be6b-ad9f-8c375d4b8ff0@bakke.com>
Date:   Wed, 5 Dec 2018 20:09:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181205154032.GT9144@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05.12.2018 16:40, Ville Syrjälä wrote:
> On Wed, Dec 05, 2018 at 08:06:21AM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Dec 04, 2018 at 10:41:17PM +0200, Ville Syrjala wrote:
>>> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
>>>
>>> Since commit 1455cf8dbfd0 ("driver core: emit uevents when
>>> device is bound to a driver") the kernel started emitting
>>> "bind" and "unbind" uevents which confuse the hid2hci
>>> udev rules.
>>>
>>> The symptoms on an affected machine (Dell E5400 in my case)
>>> include bluetooth devices not appearing and udev hogging
>>> the cpu as it's busy processing a constant stream of these
>>> "bind"+"unbind" uevents.
>> What is causing a "stream" of bind and unbind events?  This only happens
>> when a device is attached to a driver or removed from a driver, which is
>> caused by something else happening.
> Not sure if it's just due to this thing causing devices to
> appear/disappear during bind/unbind events or what.
>
>> This should not be a normal
>> occurance, unless something odd is happening to your hardware?
> It's not specific to my hardware. Lot's of people are affected.
> See eg.
> https://bugs.launchpad.net/ubuntu/+source/systemd/+bug/1759836
>
> Acutally looking through that bug it seems someone else noticed
> hid2hci failing lot in the logs. So maybe it's just that we already
> switched the mode during "add", and then we try to redo the same
> thing during "bind" which fails, and that then causes and unbind?
> Dunno, udev is beyond me.
>
>
There is another bluetooth scenario where a cpu core peaks at 100%.
This is when a bluetooth keyboard goes out to lunch/suspends/disappears.
No idea if this is related to the original issue, asking forgiveness if 
it is not.
I have found it challenging to attract any attention to the problem, 
despite it not being an entirely new or uncommon occurence.

Google the following terms: bluetooth keyboard bluetoothd linux 100% cpu



By chance, I discovered a supposed fix for this on github today. I have 
not had the chance to test it (or if it even applies) yet:

https://github.com/peak3d/bluez/commit/9cc3c1afd793e40b1a0cdc4a13e08b5e2575759e

Could someone please shine a light on the sanity of this patch?



Dag B
