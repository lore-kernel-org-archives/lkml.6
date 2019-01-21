Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342E7C31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB2221773
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=c0d3.blue header.i=@c0d3.blue header.b="KQJjYS4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfAUHMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:12:16 -0500
Received: from mail.aperture-lab.de ([138.201.29.205]:41508 "EHLO
        mail.aperture-lab.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbfAUHMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:12:13 -0500
From:   =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1548052003; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=sEhfWJYqA29Pz16OCpp7Wty9NiKkb3D8sgprmFvRLBk=;
        b=KQJjYS4l0OBXklqoxJiqz7Cf8zDgzDU4DIN1K/KUkoHQ3qQUqWnlgYPo4ocBs1X6vnRI+v
        nmszf0WQF5SqHjep7/oH9IZNCkk2sEV3hKeKPnySeg0w9gJ6wG/0EpVedd6O69+d/uoC6j
        Y4TkcyIr/W0VmscCKnAHCbAsxxqgzQkBqDHqg2IBoNZXm24EaiV6dE9hSCcqWOWZ3F7OPd
        wg+A7FYTkgABQBUcOOFU7tIzxZpIw8GsIfK8kuxiwRetPRfW6Ine6mMPCJo6gASeGWM9iR
        1dsBG5NfpwJ3iD4MnkUJTcaOgglcp/atYWr2vAsrvTAH0kmAxReXsQYvRRYylw==
To:     netdev@vger.kernel.org
Cc:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/4] bridge: implement Multicast Router Discovery (RFC4286)
Date:   Mon, 21 Jan 2019 07:26:24 +0100
Message-Id: <20190121062628.2710-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue;
        s=2018; t=1548052003; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=sEhfWJYqA29Pz16OCpp7Wty9NiKkb3D8sgprmFvRLBk=;
        b=SBRm6wrIRs07nT0drDrdj3MblQ8D3GZUgRQSIMHZ+4Y+s33TkUb758FY6i9zP5z0fBf/Mu
        x39YpsdGO2BDb6xJo/MssiHQkVgqh12puYy5FBNj0XFfmNFumdbZU9EKomuEs43vcM+ynr
        OhY2bayaVSPM1MZeTaMMsS/acaRWdrfOR96zErqmVFCtCOIMpsTufWAyQIWnT/v7m22z6W
        Y4R+rpPd9+ASXSxdxMxXt8L9E3BViF2IMVgRYIISptJVifFPsmY1vd14H12s3TQBBWX6ob
        IsnvNkPS5DFblHLMz7CvAagax/FRn3dayo06XJ7ictHlFaUImCqXv8Lp3XCxWA==
ARC-Seal: i=1; s=2018; d=c0d3.blue; t=1548052003; a=rsa-sha256; cv=none;
        b=cBN/NRu9mt6YKTTfYMTYAwqF19gfDKbsmsTHMtxt2m8nFUvYF6qHFS1/QtkY/zUXLMlyzx
        HKiImdsVBo8U+3YN6zortaG4DYVtWqRgJTN2LIU/OoconUYnYB9fIUA40xqZjrrolVkwI6
        FaposmuO9+YsGQS7bWbng/MYvblM1fhXyT75AKyYwwFckMX43txGp3yDJvghAoRUfXoe7V
        cpR9gbhfaGYAJ1dELLUrwq2ypNNDeYRtorySc5+dT7nPY32OtY6iJlUahUFHrdWvKdyeXO
        SDG7bV3Hqxg+JPbL70rYJtlDJx/CgTO79BBVr8xjONBSRZpSFVClJhqbB7pVbg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset adds initial Multicast Router Discovery support to
the Linux bridge (RFC4286). With MRD it is possible to detect multicast
routers and mark bridge ports and forward multicast packets to such routers
accordingly.

So far, multicast routers are detected via IGMP/MLD queries and PIM
messages in the Linux bridge. As there is only one active, selected
querier at a time RFC4541 ("Considerations for Internet Group Management
Protocol (IGMP) and Multicast Listener Discovery (MLD) Snooping
Switches") section 2.1.1.a) recommends snooping Multicast Router
Advertisements as provided by MRD (RFC4286).


The first two patches are refactoring some existing code which is reused
for parsing the Multicast Router Advertisements later in the fourth
patch. The third patch lets the bridge join the all-snoopers multicast
address to be able to reliably receive the Multicast Router
Advertisements.


What is not implemented yet from RFC4286 yet:

* Sending Multicast Router Solicitations:
  -> RFC4286: "[...] may be sent when [...] an interface is
     (re-)initialized [or] MRD is enabled"
* Snooping Multicast Router Terminations:
  -> currently this only relies on our own timeouts
* Adjusting timeouts with the values provided in the announcements


Regards, Linus

---

Changes in v2:

* rebased to current net-next/master (no conflicts/changes)


