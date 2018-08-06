Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6FFC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318AA21A0C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 12:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="CTxcJ8Uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318AA21A0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbeHFOOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:14:23 -0400
Received: from mail-by2nam03on0056.outbound.protection.outlook.com ([104.47.42.56]:4480
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731048AbeHFOOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+QiH2wEOhX9VlW0KyJrQTqiPK1GevQA95+rq5/Cimw=;
 b=CTxcJ8UuV4cFaNo3CpisARyqAsxK0k2AgddTKbYDw0s45N/BZ+8wIo5MEFA6I5edgV8mG6LrRkvLn/IIzD0E9UqDnWMWqseLHckLT8U1K7A5RGX0zM7d+FwvZZYheroP19P1K2tXKveGkCxd33Fg2j3YLiKgcYxqfx6QrsxTAhg=
Received: from BN6PR03CA0087.namprd03.prod.outlook.com (2603:10b6:405:6f::25)
 by BY2PR03MB553.namprd03.prod.outlook.com (2a01:111:e400:2c38::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.15; Mon, 6 Aug
 2018 12:05:29 +0000
Received: from BN1AFFO11FD011.protection.gbl (2a01:111:f400:7c10::101) by
 BN6PR03CA0087.outlook.office365.com (2603:10b6:405:6f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1017.14 via Frontend Transport; Mon, 6 Aug 2018 12:05:28 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BN1AFFO11FD011.mail.protection.outlook.com (10.58.52.71) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.13
 via Frontend Transport; Mon, 6 Aug 2018 12:05:28 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w76C5R2K012447
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
        Mon, 6 Aug 2018 05:05:27 -0700
Received: from linux.analog.com (10.50.1.110) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Mon, 6 Aug 2018
 08:05:26 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <broonie@kernel.org>
CC:     Stefan Popa <stefan.popa@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <mark.rutland@arm.com>, <davem@davemloft.net>,
        <mchehab+samsung@kernel.org>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/6] iio: accel: Add adxl372 driver
Date:   Mon, 6 Aug 2018 15:04:41 +0300
Message-ID: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(346002)(2980300002)(438002)(189003)(199004)(72206003)(478600001)(336012)(48376002)(7696005)(4326008)(476003)(2616005)(50226002)(316002)(44832011)(486006)(7416002)(51416003)(8936002)(426003)(186003)(26005)(77096007)(5660300001)(966005)(126002)(16586007)(2906002)(305945005)(110136005)(54906003)(246002)(6666003)(7636002)(356003)(8676002)(6306002)(106002)(36756003)(50466002)(47776003)(53416004)(14444005)(106466001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR03MB553;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BN1AFFO11FD011;1:TWR8p9a7CQhp6nnEiACEiqsRgAottO7h4RO9HtLAZGuWivgTKmG8zGXnu9EsvwHngSpnDj1iqD4UjUiKdwYvN5cchWZc9V/IMqcEjPzFWQUBnyEfdeJvGSBaMUqztcW4
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aab129a-c8ec-453e-cce6-08d5fb94e677
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;3:KAeloTtMdL+JCUnai1fvEVGVfbKhRkWyvHStlHWm6d8H0Bwj6DDL82Y2etqi3eicMGaU3Rj4UOLE5NQZ7ZjJjhzMYjK3L4cweqCiqGsMxMqNG5861K6l2eH62PRZmutniEOAWbS4opoi4zXCe2RrmctgriyvHCh4QNy27Gmh2E/XPUYarmQf1fDkebVC/U/g43+Ah5HSqwVaPOEsJZVyMzCLtQncttDj/TJFTdsBCz3T498F4fGbj2N2G5GtFIibCqRXxD8ZNd1YUrF050lRACcV3/vqdxHHtvLoZdLWNiuxl1GtuKIiCVjAEMnFhfgWrhF+a9mwm805wyVFmga7rZwsHjpZqfQHnZZKm5HHZOI=;25:t0KtIb26vbgGFCx9eYSqGSvlSYWSr+ohcLBk1AJC4c5Q+BK3Y8qRLBG9WrFdxH7uJN+bxzpo9yKHrTOtmfmksVrDOvkmEgRfYzTCisCmyGMtDl1woTc4+Krd226aPxH/pagldvAFJRCy9WJdPTOWFXRZSSWmgK4GFWxon8k1tpXRWSCiyEG+PY3Sa18iMBZkegARyzocRK0vZnEyrl3csur595gIhYayhwb+sRnSdnn4tDlz4CQiiQngaBR9ip8MhpkZSdvKVGDQBH0ELkSb9OzNGIW8SE9aozZGLC0tDFUN1k1hiKwe+l7reVmBr92paP8wItcAy1Ur6Y7YieynYw==
X-MS-TrafficTypeDiagnostic: BY2PR03MB553:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;31:L551aN2i3q7YSLWw1Lox4xG+Bwo/ffljysiL8pJsoWppIGl/9GL6yhCKDljTPrQEyikftViq3toCvBOhojhPdnO7FicL+yEDkSl+UqOFlcskW4qj4V01NEUKjJk9FzAcOjmXrlAnBBQbt3T1PjK+q1JPDsI6QoWPIMCjbS8Oir6g+q1AxFFPJaZfZ/IDJ5pJVpE2EQiHbuaNEGl7HGgq2q8fyjKdsRZtF66kMtoAZMM=;20:w6GGbG6NrrzZO8sRuPbgGdvmYFW9zCNtztWthGuIKbUyhlmI/ZwXaAHTNWPTis6exKzSPBk0jjE2uUVGoRF7eWPn4braVpKmXu5V3RxLt3FaaJzqZr8CXqxGBmt8jNZjbmLD7BCjvs6nOSPgPugaNdczyWpvLi+CskbiNbnXGI3RRNvhePy3t2wBJ0gD01QcAWyiTxgnDuoPF6ytxsrM84sKUEO2Y9yFHmPVtDTXvZS64lIXuxPagzyZp4f3J/4MujpRdA1sM7kNSLiGP/Y5AimmllUBpECgu7S3l53C+Uw2RKRjymKO3tL0JYrrEFj7J7yBkGlaV3nIIS5dTeLGI4SDNDKBVwbmxZZ6cVsSwTxRmAqBQH1BNBXK1tKUxXeupjEQJHOcUQpG3OlCdvgTCSWXkuITvgabbvekkYf5B85tCBayOAmhv8rFcd39AU3QjP2wPK0/qBwDsT2MFKtvP9WGiEH0Y4eYYz+qRl4//JX+gADZ8WmC3qBAk2D4Ynv8
X-Microsoft-Antispam-PRVS: <BY2PR03MB5538C15C03B4EE19C92A5D79D200@BY2PR03MB553.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93004095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BY2PR03MB553;BCL:0;PCL:0;RULEID:;SRVR:BY2PR03MB553;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;4:gn1nEIj469ro6pmmtvUmaEe9/WwU5oFwIfM6djk7Uz3poXP/e49UMTBwCW1RBHexcs/6dKbd6LyCYyoZBVYpMnZNRcBx8wS/pKA/sMnEjyjIVKWuK4FemdbXFlcAK1pQZrbuFOWpRaIiTwdHRHcdpoZw/3N9VQHWcdnUZbYjmdH5Ri3FOa4D3FdaoV9g1SNDRWKp6uqm979htU2sWkhHwkNXRUi0g6YV/WMTZ4K5svfGJlpRjiGZJmSal0LjlxiA1eSCxepArjbjjpSQIDka5eG0brPjDsKblDcCh9aCtMOZjkor0QpDylrMl+WxPQ9e
X-Forefront-PRVS: 07562C22DA
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR03MB553;23:dkY5MmH/MNYbFb7iSPJNddVwhacX9CRWiRkJnOpq3I?=
 =?us-ascii?Q?xlsVOOhN4D3YeC9IzKa9rLF2PJPgCvGmYzCkn1dh2S9r1/24Q8KzUQZ1fJT4?=
 =?us-ascii?Q?LbGr+fEPAI8UsgIZ+QAFaKKwWtuk4EN16YCCfskcAaz8jSMLir/Mz4Ryn13P?=
 =?us-ascii?Q?1xL6fHPeLlrK4an8HZhaukZd/8PleRG/LMm9r+O9gQcbem064MU4Mmw+VRD8?=
 =?us-ascii?Q?L54qgutq1T7QJc+tA7gTy19RmOxaG9F5PF7X9OqMBZiX/bfMPBTBsjpnyQpq?=
 =?us-ascii?Q?4l390Oc7djo8Oe7YQMgT4oI7caVeCpqYS27WvBIZqvS0HH4Vr+S/NRZHEhyd?=
 =?us-ascii?Q?DSUM41qQzduKl9mvwXJ6TWe4uX7ZKeRx3MOStzuYFMAqwHez9qy0CuAZnUz+?=
 =?us-ascii?Q?f9soBNLD/gNMNT5ApgaoZ8g+wt/U5kPBB1P9RA5mbbmabFKRISoGZXOPt6kz?=
 =?us-ascii?Q?u371dMOIBW9aOB3S+ZwnQDPVAoVIc3Tds4wwqR9BZP+uwK0JPKUm69+dmgr5?=
 =?us-ascii?Q?LrFZ3XnCtmVJa9cc5O7zsGzOkYLlSljFPz7NPWxZo87XFszrz+YDvJXQanZ7?=
 =?us-ascii?Q?h3gaQKF2uOMDXXenFrelDyc4FXoqqZZpWUyjy0e6Mu54o3x+s7fyaK7QBjV8?=
 =?us-ascii?Q?ZRkESIUo7KySMkb/k868p5Wd0PFAObHef24jTwy79JtZTNdJ/ujP8nh0TqcC?=
 =?us-ascii?Q?HkbFbTSEr02alPYXepVR2QblU0rSgnWOWAvnF3meaq/GTTDgpfQ6KNiTmyWf?=
 =?us-ascii?Q?tzeSXnidN2CA+qJ4PiUXZD4+2GpmO9SkPNQFjm2wz/7llqJzRZR98HU3enh8?=
 =?us-ascii?Q?+G8cxLRQJjMaGaWTjZrvAiMURL0Hqz1csFDgyqQ7U19Bg1W0bUlHJyKJKr9+?=
 =?us-ascii?Q?VkRNlPktunXdv0+jINKk5rbsaUltLBaVuXAi63powjQa5MbViA0aG7XdwVxs?=
 =?us-ascii?Q?6ELW2fn/+cY3grVFd1Xy/l4CX6e/yt207QsD9c8WHsEAzLhlWgJ0jYTyGJb/?=
 =?us-ascii?Q?BAgQ0MkHUynlUBW5CmbmRlRwhKETyq6YHHukAL+1t4Dhx9QfDUT37iUcSI62?=
 =?us-ascii?Q?b61WLDTXVdlGjBkYDuf8ATuJMP?=
X-Microsoft-Antispam-Message-Info: peDFILLnXH19/v8ctM6Oq0p32K6jNYDD04zCZUsxpvAdsQc9wdXtFsXo51k/PbJRBCUBvZgVzvVStiPAPdA4JBHp/A8h0PCzLbEwQYjlTyQ+Yp7rmqttFJrFq7q4HAmV1I/m6Urp6u/FSh8LoyDx9F2fQgMoQETGBy8F1+zTKRvVJGqZtFdB/ks4s9O9ye+UTh6Xw/cRgQjLzCCue9AnYYoSUkG/xtSK4TbIitS6+6eHnr20vs8rXb5a0M4/m8aHjlAuF60eYT9u5e/uf8uLdhSyZeO4xuulfSXgMtN+EiRY4Rk7nABbZTnX4zYqOusPIghklFcevVGheL6xqDzFTfYpcEp936tUiR+SJKyQgy0=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR03MB553;6:vYmdf/xhtoVPWbRQV1ltFUiLBtfagKRK2olD3oC3bOaUvI4uEjNHF8In69rVrO5ivhOSUAofzIkSRJ/dJg7J2faCxiq5nkaTiaZWC85OnWLAnvYjkeNJE6YTQtsQ+nPDGTXqVRyAKZ2iB2i6dJh0wWtqyrtOsoBbwgXA4yUQvsl7foxjanHfuPvaVa4hO+PxSdz88x8nfBWx7V0jeF6nSCIHAIH8FgaIkmrQ9BzRwrnVqESG7WUL4sbh3O8p/IsO3WsVXxytUo9yiSIs3ALqSe/OZ8fJ3FrNgmTYZGvrwTtozW+PtP7jQhezDWmzuW8tpPcFMylsGT22pN3OHqD2dw7a5IoUgDCCH9HHt2phXA4uAZHC4h8sIQSYRzcELH6q1sPxFbKPbJ4LmdtgjpA+x4pyInTMQOZS1eRZNruDsWl5lsgqkEw+WvUqAsBwl5g5/Xrrc+M1sdESmn/99ZxGCw==;5:A+5hD6nWyuin0kCjXQ96OzOmYVNh/PJjGWLTeHi86+wIjzjfknCJHL/kY72CODhkRtd02JjhpAVrN5fDGAOd83h8kbdv46//xocrYKz1KC+/iqCzhlO1ihdTDs8C5aP0PWRYOFg49OCvH2YJelpwzp0HbV64t0QDWBcvDzt+4Yg=;7:NM406enGiRlqNusHYslE0VAlhqNezUan59Y/pF58E3q5aLHEmckwPMowFGXsTOxtCT/j07XEuj2o+TTXKAd0U17TTQLnjrCq7fsTqJp7uip5NSn5CKJ6qEK5UNWp/rkEM6Am2+J5OS2fAVgxIjd4PMNZ4uuEyVeYFQaSry9XUv0x5Yq4Rl3yHw2WK72l8I+EF7fGD3m0TeQz/10g83SAxg5xsNAWOoCdqIIQXvK1JWA/U9yfulpGXIsXJuz2Ay3t
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2018 12:05:28.2041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aab129a-c8ec-453e-cce6-08d5fb94e677
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR03MB553
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v4:
Patch 1:
	- used a lookup table in adxl372_set_activity_threshold() instead
	  of a switch(case).
Patch 2: 
	- removed the interrupt-parent from the bindings.
Patch 3:
	- renamed regmap_pipe_read() stub to regmap_noinc_read().
Patch 4:
	- removed the adxl372_read_fifo() wrapper and directly called
	  regmap_noinc_read().
	- called iio_triggered_buffer_predisable() before doing the local
	  changes.
Patch 5:
	- nothing changed.
Patch 6:
	- nothing changed.

Changes in v3:
Patch 1, 2:
	- nothing changed
Patch 3:
	- changed the name from regmap_pipe_read() to regmap_noinc_read()
	- added a check for readable registers
Patch 4:
	- dropped the fifo peak mode
	- corrected the patch based on feedback from Peter Meerwald-Stadler.
Patch 5 and 6:
	- nothing changed

Changes in v2:
Patch 1:
	- removed ADXL372_RD_FLAG_MSK and ADXL372_WR_FLAG_MSK macros.
	- handled regmap read/write by setting reg_bits and pad_bits
	  fields in regmap_config struct.
	- removed the buffer specifications when defining the channels.
	- changed the activity and inactivity thresholds.
	- added two new functions for setting the activity and inactivity
	  timers: adxl372_set_inactivity_time_ms() and
	  adxl372_set_activity_time_ms().
Patch 2:
	- introduced all the DT bindings in a single patch.
Patch 3:
	- backported the patch based on this discussion: 
          https://lkml.org/lkml/2016/6/16/548.
	- this patch is required as the regmap_pipe_read() API will be used 
	  to read the data from the FIFO.
Patch 4:
	- removed DT bindings changes from this patch.
	- removed the linux/gpio/consumer.h header.
	- used regmap_pipe_read() instead of regmap_bulk_read() when
	  reading data from the FIFO.
	- used multiple regmap_write() calls instead of a single
	  regmap_bulk_write() if there is no fast path.
	- used be32_to_cpu() inside the adxl372_get_status() function.
	- added a new in_accel_x&y&z_peak scan element which allows the
	  user to set the FIFO into XYZ peak mode.
	- used a adxl372_axis_lookup_table() to determine the fifo format
	  from the active_scan_mask.
	- made IRQ optional.
Patch 5 and 6:
	- nothing changed

Crestez Dan Leonard (1):
  regmap: Add regmap_noinc_read API

Stefan Popa (5):
  iio: adxl372: New driver for Analog Devices ADXL372 Accelerometer
  dt-bindings: iio: accel: Add docs for ADXL372
  iio:adxl372: Add FIFO and interrupts support
  iio:adxl372: Add sampling frequency support
  iio:adxl372: Add filter bandwidth support

 .../devicetree/bindings/iio/accel/adxl372.txt      |  22 +
 MAINTAINERS                                        |   7 +
 drivers/base/regmap/regmap.c                       |  65 +-
 drivers/iio/accel/Kconfig                          |  11 +
 drivers/iio/accel/Makefile                         |   1 +
 drivers/iio/accel/adxl372.c                        | 977 +++++++++++++++++++++
 include/linux/regmap.h                             |   9 +
 7 files changed, 1091 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adxl372.txt
 create mode 100644 drivers/iio/accel/adxl372.c

-- 
2.7.4

