Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBB2C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEC320844
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="D7XgfaaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BEC320844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbeGaSEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:04:12 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:55556 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbeGaSEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1533054187; x=1564590187;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=EYZGT79sWJ2amfZsp7rj5mMXDAfBc3xY49Y9HP+Z9xo=;
  b=D7XgfaaOwp2hfpB0hqcb5Z7fWLjq7pdmeMxQwVKWmv9ffcYMft7W159x
   rBt23PmINw3L0MwufYaUwTTxsnTDSfIWBhhGZFVo7SKIE47BAUKSOrjUK
   f6llINBD8SEwuaHNFv8Clml2HqLArpwNANjejE3pOR5NVz9pJqUhAAlid
   s=;
X-IronPort-AV: E=Sophos;i="5.51,427,1526342400"; 
   d="scan'208";a="690379070"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Jul 2018 16:23:03 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w6VGN01q072278
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 31 Jul 2018 16:23:01 GMT
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 31 Jul 2018 16:23:00 +0000
Received: from EX13D02EUC001.ant.amazon.com (10.43.164.92) by
 EX13D02EUC001.ant.amazon.com (10.43.164.92) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 31 Jul 2018 16:23:00 +0000
Received: from EX13D02EUC001.ant.amazon.com ([10.43.164.92]) by
 EX13D02EUC001.ant.amazon.com ([10.43.164.92]) with mapi id 15.00.1367.000;
 Tue, 31 Jul 2018 16:23:00 +0000
From:   "Sironi, Filippo" <sironi@amazon.de>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Borislav Petkov <bp@alien8.de>,
        "prarit@redhat.com" <prarit@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/microcode: Don't duplicate code to update ucode cpu
 info and cpu info
Thread-Topic: [PATCH] x86/microcode: Don't duplicate code to update ucode cpu
 info and cpu info
Thread-Index: AQHUKONPbG1VHRsMgUaKlKhSn4McN6SpeCsAgAALjIA=
Date:   Tue, 31 Jul 2018 16:23:00 +0000
Message-ID: <5C646084-CE58-41A5-AC57-E42D996C4212@amazon.de>
References: <1533050970-14385-1-git-send-email-sironi@amazon.de>
 <20180731154140.GA15243@kroah.com>
In-Reply-To: <20180731154140.GA15243@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.83]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F944ACE86126D4DA761B2CD3261E1F5@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 31. Jul 2018, at 17:41, Greg KH <gregkh@linuxfoundation.org> wrote:
> =

> On Tue, Jul 31, 2018 at 05:29:30PM +0200, Filippo Sironi wrote:
>> ... on late microcode loading when handling a CPU that's already been
>> updated and a CPU that's yet to be updated.
>> =

>> Signed-off-by: Filippo Sironi <sironi@amazon.de>
>> ---
>> arch/x86/kernel/cpu/microcode/amd.c   | 15 +++++++++------
>> arch/x86/kernel/cpu/microcode/intel.c | 10 ++++++----
>> 2 files changed, 15 insertions(+), 10 deletions(-)
> =

> <formletter>
> =

> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> =

> </formletter>

Greg,

If you're concerned that this isn't a fix, keep in mind that this is going
to be a prerequisite for https://lore.kernel.org/patchwork/patch/969070/ ,
which is a bug and was sent to stable.

Filippo


Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B

