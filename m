Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F191C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC2220879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC2220879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeLERle convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:41:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:48097 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbeLERld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:41:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 09:41:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,318,1539673200"; 
   d="scan'208";a="116253101"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga001.jf.intel.com with ESMTP; 05 Dec 2018 09:41:32 -0800
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 5 Dec 2018 09:41:32 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.128]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.54]) with mapi id 14.03.0415.000;
 Wed, 5 Dec 2018 09:41:31 -0800
From:   "Ghorai, Sukumar" <sukumar.ghorai@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Dmitry Torokhov" <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "rajatxjain@gmail.com" <rajatxjain@gmail.com>,
        "dtor@google.com" <dtor@google.com>,
        "Hegde, Raghuram" <raghuram.hegde@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v3 1/5] usb: split code locating ACPI companion into
 port and device
Thread-Topic: [PATCH v3 1/5] usb: split code locating ACPI companion into
 port and device
Thread-Index: AQHUgfT7UkY6xWQeNEOR6zSp3GNaBKVwfRIA///8W1A=
Date:   Wed, 5 Dec 2018 17:41:30 +0000
Message-ID: <D73ECEF0C711E34A8F972E4B87F540058FBCF24A@ORSMSX114.amr.corp.intel.com>
References: <20181117010748.24347-1-rajatja@google.com>
 <20181121235020.29461-1-rajatja@google.com> <20181205093228.GA1817@kroah.com>
In-Reply-To: <20181205093228.GA1817@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYmVlNGU4OGItYmQ5OC00MTMyLTg0NGQtZWFlYWE2ZjBmN2IzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibHEwMUI3RzlEc0dDUHhPTkFlQ0xBNjl0K3pYbTNMVlJ4VWNDdzk3bVB1bXpqY1NtZWtNZWRqSFJZNTdOOFNHMyJ9
x-ctpclassification: CTP_NT
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Nov 21, 2018 at 03:50:16PM -0800, Rajat Jain wrote:
>> From: Dmitry Torokhov <dtor@chromium.org>
>>
>> In preparation for handling embedded USB devices let's split
>> usb_acpi_find_companion() into usb_acpi_find_companion_for_device()
>> and usb_acpi_find_companion_for_port().
>>
>> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
>> Signed-off-by: Rajat Jain <rajatja@google.com>
>
>Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Tested-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
