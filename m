Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DD4C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2083320862
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 07:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iy+d07Uz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2083320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbeG0JPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:15:38 -0400
Received: from mail-eopbgr690049.outbound.protection.outlook.com ([40.107.69.49]:20194
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729443AbeG0JPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYh9ath+94JK4yRB97q4BvZs39nK7askMpXcSOR+IRI=;
 b=iy+d07Uz1SH5nPa2zMA2/h5nwXv8HDJ4zCUViJnLFfifDIeW1EGIxd+nYFGy1ZpcM+gyweGST2t2zaLUNSxy2eaVjwgiDPAYb5OxQScTSRjTnSuw0TZ8cxtHf18s1eXKQw2vwapFdCfjhigUR8bPD6diGKpVyPYnUYZnmOAbclc=
Received: from MWHPR02MB2816.namprd02.prod.outlook.com (10.175.50.14) by
 MWHPR02MB3360.namprd02.prod.outlook.com (10.164.187.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.17; Fri, 27 Jul 2018 07:54:55 +0000
Received: from MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726]) by MWHPR02MB2816.namprd02.prod.outlook.com
 ([fe80::8453:d61e:5ced:a726%3]) with mapi id 15.20.0995.019; Fri, 27 Jul 2018
 07:54:55 +0000
From:   Anurag Kumar Vulisha <anuragku@xilinx.com>
To:     Felipe Balbi <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "v.anuragkumar@gmail.com" <v.anuragkumar@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] usb: dwc3: core: Enable AutoRetry feature in the
 controller
Thread-Topic: [PATCH v4] usb: dwc3: core: Enable AutoRetry feature in the
 controller
Thread-Index: AQHUJX1I0O40Uyr1X0WpCF8F0oAZwKSisWiAgAABQ9A=
Date:   Fri, 27 Jul 2018 07:54:55 +0000
Message-ID: <MWHPR02MB281691F0330533A4A90396A7A72A0@MWHPR02MB2816.namprd02.prod.outlook.com>
References: <1532677280-30945-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
 <87h8klyv94.fsf@linux.intel.com>
In-Reply-To: <87h8klyv94.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anuragku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR02MB3360;6:2Nor/ehmuzqEP7NiRQlLL2ve40NohJAUTfg9fjC1NyAg8CEDzQc0J8tUDnbrNtPU1RafImBI5jxsuaSUjPBQU7G652vNPZRUW/4lpjl+OZ95zf5BQdnnm4DylH9O9fvNPILZoG487VIis8XltQLZ0l47O9Wtw8VxGhzUdJP9eO41Tlkz993XxVTykfgUqRaZO+qOpO9Z6fun/4jc/FyCpqOSCSw+k6SeWUzC/6T7uleEFyJZez5nse9B447l9uGowP2XFz6+wVzeE5LNspVlpFmPrbqQo9pqcHQMRW7U33Uxj8hgLy2DHyKFvMba+ZXP1tSBVSLcCiO799KZEc85VZKNKdUL6hgnb5a+nAfdN9963beeTOmMhe+msDRWYJG/7hNM/K09ccoJ/SQsh2UjlXfNTH4H1H8S9okPSrbcFutJEmt4tCtKG/hbtywYMgX1HznZa3aF9/K4s4b3PgYYgg==;5:XsrWOIxT28com1c9vi/RjZ9iEqGLr9gagj7eMi5D+neM1Qbns9zyVMSFDbiGtqgU6LCfgUkwRmhPyOm7LYcaTeJmgeK/5+EFoYY7JpmnEG3TlVuyHh6EvV6D3p1qr/VaYQ9seRVPcjkXuDojdTHHDvxS5po6emgY5zHMC3OmHHA=;7:CnNdMQ6epdbM8fnHGjAoq1AxmcX+AVfUAc3CIJU27BcA5swlbI2kB3vEwHEWBocaQn0j6n5XUStynQfwtExl6I2jO1Yth7N4HXrHNhE/cMkDQ+dIxLGl6br7m+I6+pc9pO6hF5pRx7i6PNKdPTAnYzP1MTfTM90jlMMDKzXRH/qEOrinY37EB8pIT5GaE2Gqj54rilqM+6A4bbcrSr6lwerjnSsDYy/a75JpxB+7M9M6zgmpjQWoLz7WC75rikBg
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 339e51b2-f73a-4ed0-10e3-08d5f3963e44
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MWHPR02MB3360;
x-ms-traffictypediagnostic: MWHPR02MB3360:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB3360ABB5C9C083BB8B8DB4E8A72A0@MWHPR02MB3360.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MWHPR02MB3360;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3360;
x-forefront-prvs: 07467C4D33
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(39860400002)(396003)(199004)(189003)(26005)(316002)(105586002)(106356001)(486006)(74316002)(14454004)(54906003)(66066001)(39060400002)(110136005)(8936002)(33656002)(55016002)(97736004)(2900100001)(2906002)(53936002)(9686003)(186003)(551934003)(8676002)(6436002)(6246003)(6116002)(3846002)(86362001)(76176011)(2501003)(6506007)(7696005)(256004)(446003)(25786009)(5250100002)(305945005)(102836004)(68736007)(81156014)(478600001)(11346002)(81166006)(7736002)(4326008)(476003)(229853002)(99286004)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3360;H:MWHPR02MB2816.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: s7h1q88udvvgjDD+lwbvl3zg7Ko4H+7H3QfFLA/3y9jtHz57Rb4EwnQM6DvVWeXQVt4uEYdcc9TAZ7YCZA0CwzifQAm2Poosdvab/MQ5yvJRFD++qqJSdAw/4uoahHTtzLW+q+pd3/YdBqxgES4lUWh2RJ7waIbRqpJi7ruabwe3LMsiLkrjW+ju8cClcKFC7L8WGO8PHEK3vapIOBn9gESHjZ987cnmGa4s3GmusZPuWF0fZG39y6wRk++dUES2VVMjC4NxJlDQhCGaoTJT6M/Ovh4+2A3AA7d35qAfUnRW/KJje3ig2Pj7ZpXJq5v2uYM4913WvyhDw8/bHYaq1qxAuc/gHPv0qq21fiaTrmA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339e51b2-f73a-4ed0-10e3-08d5f3963e44
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2018 07:54:55.5623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3360
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Felipe,

>> replies with terminating retry ACK (Retry=3D1 and Nump =3D=3D 0).
>> Enabling this Auto Retry feature in controller, on seeing any
>> transaction errors makes the core to send a non-terminating ACK
>> transaction packet (that is, ACK TP with Retry=3D1 and Nump !=3D 0).
>> Doing so will give controller a chance to recover from the error
>> condition.
>>
>> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>
>now applied. I've slightly modified commit log to make it read a bit bette=
r.
>
Okay. Thanks a million for helping me in correcting the patch.

Regards,
Anurag Kumar Vulisha
>--
>balbi
