Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90967C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EACF20875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="CBe8EPKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EACF20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932591AbeGIIUZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:20:25 -0400
Received: from mail-eopbgr730076.outbound.protection.outlook.com ([40.107.73.76]:58208
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932231AbeGIIUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PfbgGuuomqGhQeNVAZk6MsTR888xqmjKVdX2L6rLec=;
 b=CBe8EPKKuIPfkLokj4mBcjSMzDYRZ+2gfrHsCeSHhfT6jJob5bpS25XEPVFmUlaswtDlHg2GXGHz9sIx60c+lc2+ldEVHNGs2CpCjM8+Hfyn5VqPxAVRsLccw+qB/uoL6waLhN+yn7VEeHkWyscznEaPm8EUHMPF8n/3+6UTB9E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 DM5PR03MB2633.namprd03.prod.outlook.com (2603:10b6:3:43::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.19; Mon, 9 Jul 2018 08:20:19 +0000
Date:   Mon, 9 Jul 2018 16:18:18 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH v3 0/3] serial: 8250_dw: add fractional divisor support
Message-ID: <20180709160942.11a74f7a@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TY1PR01CA0175.jpnprd01.prod.outlook.com (2603:1096:402::27)
 To DM5PR03MB2633.namprd03.prod.outlook.com (2603:10b6:3:43::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 145e30da-f0d4-4743-b619-08d5e574d041
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM5PR03MB2633;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;3:xNTA4ReYS4R3behbwsfrukAQf+vLAmSue7OGmuV/DJTRXsBiG1k1ZKybwLNp4aaBzCCIyHvqWOOxBDifhAsW++wvLu1mrbD1mOsiIEoOrw9bu8xFKuwI4sgsntJlPz5ruUO7JZWUo1XYP5tsNBjYerhcfESY/ccA6bY1TdfdxDj0cvzNdgpqGWief67AaHLJY5v1PVgCkj/YSGyBkC5EHlhf1Kfyo6Ge4CSeSzIEe14ll+WEWQI2muIUjnOK21aO;25:akraFkQIDh0IfYPVupAMqbhX5GT1JoJCX9maacL55D6Fc8PrpRiMDiO647Zu5pkHYhg7hIbsn4PdgmPN81Jr55lgEQ0jbBo5LyE9UbkGDSEVmS4Ji8PZ87AMriSFZPU9C5/APIoLJ0UW/64oSkHp/RCddm4YC0K0sA79BUPIFngB9MQ6nPBTFHsqb8kGxfmEj3I68OaIuEcaJEEZ2fvNJJZ6T6/hxSm1JokxIn4zkV1BhGvnniqMDJW/GzPE2Skhf16prFDpsl2jt6vmj+mALukEl/L1qc8/SeKfrTovpgUNMB06VRaVWJl6W6dCSgHWvJfo6YM3zMOI770Sp99CNw==;31:fbWY2uoDS8qOOBDbCsGFyqID3K0NAuCGDsPLjcTI3oNCjcy8YjaM4/oofZEf5YZfR+w04PCw+qotPulpKdVnAdYmLvvBLQ7Lp3j6FREqT6tzSNCpCma6YRulzuXrLTdiAcrwXJ0mm31BVbOpY0pqPl0cGLFxjtD5HnHeuBt3m6Ph3GdjYqXK65CMhfNUXb0zAkh9rUFk4Dt8Is5Q0sdOvHdPk/wCS7k9AYY1/vD+9L4=
X-MS-TrafficTypeDiagnostic: DM5PR03MB2633:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;20:4fO4rxlF4WblwyYi3yR6ho/luqgZxSIAOOsDYQTAe/pW44vOmk189NVqNVhdZfBdBD7ANi48UG4+xEnYx+uYSzRUid03u+QXdMJS1bBILmM7D9RinTjcLu+i/fukveX77Hge6s9JXmOuoblams/AqvbCtp3Nl4hKJwLDYhWFwCrKZYCF3HbIopR9AMCwnK7E2pifmXd7o5fID4Hkg38mJ4KQw8OTKXWv3i8fBMw2Ifbs/EFGMRLkeJdVqRsMwoqbRL9fQ6V67a3dZSjVB/ET9V+aonY0xReRiH3Cvf5gp46rRpwV4QrqouvrI56cSjaiFpcQL1QOOTBSX/pRKmvvN2H+uVG9hpDBoRYCxJxjedsZJdPCeSZQMWQdn96CQLomjPdrSlaTTbHUqwvLb3512g3oZDifX49kXA1+Gh7trG+N/9o+q59WST8CrXBb9TCrOBkjnBD5s2xXjsX4P3JZBmrna0PatgpRewnN6RkzLdmSbA82woc5rhaaBSOdJnyZ;4:GM4egHBzEWX41w2as/zbLmfRJttlRvpTjcuxbZXSYK9f3OzdA50qrQTftkXkB0LDHXAv7c1o2KntE6Ra8ykJuQQdJ9ww5tSZoAvt1GrcaY8wKlyUMWYhjfxQ5z3/cy6NtwdL1/y0IgJ6UsT6V8TM/8e2YU+JecgXwkT0ZCDjFAZeCN7r8fpMKCt0GzePr0fN+jx/TMoF4GkGzRHAVPpMZYQjZ4mg1X2FF+4SatqHcH+8QRuh0fBo7O7jXt/2rT4P1izW48u9CJuvqm/K85MM8A==
X-Microsoft-Antispam-PRVS: <DM5PR03MB26338AFD2FC156BDA81A2A30ED440@DM5PR03MB2633.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM5PR03MB2633;BCL:0;PCL:0;RULEID:;SRVR:DM5PR03MB2633;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(16526019)(105586002)(386003)(52116002)(7696005)(33896004)(72206003)(26005)(186003)(81156014)(8676002)(81166006)(8936002)(47776003)(86362001)(6506007)(316002)(110136005)(305945005)(66066001)(7736002)(54906003)(230700001)(106356001)(23726003)(1076002)(6116002)(3846002)(5660300001)(50226002)(478600001)(97736004)(53936002)(9686003)(50466002)(2906002)(476003)(956004)(486006)(4326008)(25786009)(68736007)(55016002)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR03MB2633;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR03MB2633;23:+siGgbUjyje4qktK83TVr8xKWOruiJwfPPyZsoLfV?=
 =?us-ascii?Q?/qI1clhapqdObGXA1gvZeRDXsTDNrrf5jcRMnBzadeWtRM7Op7WZOfj85588?=
 =?us-ascii?Q?mfm9ePVdHKRFMxpjSEwU6o7S5O469x+IOVvcC7fh5zoF5UHR7y/c89iYNrCN?=
 =?us-ascii?Q?Fy/P4g1PzPdeo+rbm06NE61kWr4G9T38MEZBOnhFvk0m/DYwbyD9R/Dlfpn7?=
 =?us-ascii?Q?L16EPf9QGmt9LrbNJe12bRGnNmweKPHCJcrz3pUEmOwbIj5E5JMj9nhAdImW?=
 =?us-ascii?Q?PnryLFJoY/i7CI1gUwD6SbzQ71gso4jgaigLvpUBU7guxdL81TdlGHq9pOU/?=
 =?us-ascii?Q?pOzhqfNZzKwMKZdaxy2IEQjk51gDqazw5g62QfNxTZsXUTam7OgoLZ9sf4t1?=
 =?us-ascii?Q?ZRr5xm6YykWPteE4xtL5qAbQXtAHevLZa8Aq+hSV3CcJhlmW+dk0aotP9hPh?=
 =?us-ascii?Q?4oqeDI5HMa9vPZUGsnd1uNM9w3yaUwhhr+PTSOIW+symfrUYftCpw5KU1nzS?=
 =?us-ascii?Q?qysJivLjqTze7sDxGFCdiVcBEWhH3H7Fwq51nBcxSdCc6DoCRd0vI4pAmC0y?=
 =?us-ascii?Q?hzSYSjo0N0qbzIPLxHwVKKoAUDklbUmplE12gi9QfAZqSymeARdZFs9PsLLi?=
 =?us-ascii?Q?klmbc2BpdLYqfFf5Lnh7oP+1YE5xD9SG/xA172C9Aab4y/Ff82tL+zDbnrZr?=
 =?us-ascii?Q?jV3lCpXZQXWdjhdZcw+o99gjHJK1d/4nyLqwRoGLiAV8d5vBXBHfSaDC7MF4?=
 =?us-ascii?Q?AXARP3dXKl91La4DkXccoJhE8/u1pO62egvIKGLSCVXHJDl3eR04NNzJBwE+?=
 =?us-ascii?Q?V9ooxUa9HkW2cj02FSyQaazZhm3L6nJcRDSie9Q5sOhBsSZrWxK1FAjJT1JF?=
 =?us-ascii?Q?LWVHUPrdRRtXaQvMNOuOmdvvHGxneApgLNTkD9ikFJFsAECFQK/s5BTRu7cp?=
 =?us-ascii?Q?w4yxiw+Utk1FvmlUw9WKw+YWUw2YljtnfLEquTY8oaehqP8aDJM7A4fjjnaw?=
 =?us-ascii?Q?mMBY1Q5W8E2KTMu3ChVQGDhyWkqLADCXyzqYrHZf/BFVz/xCE/jG/a/2yIkR?=
 =?us-ascii?Q?xR1/Dlp4d4dEEcjldnTgNWbDVgWdAcXFc8IAU93F+404hlv+xiz6oMMGfSey?=
 =?us-ascii?Q?YDZSFC0v2XqrWNs57lR3Ug0bdRKtFnJugCwMDDk3w6037zuBOIBlw=3D=3D?=
X-Microsoft-Antispam-Message-Info: yF9Tc86cCeQjAlg6Ap+JKLnPneNVBA7WMhOyq64MuooP33wPgvNq9W0TLGr8Bo3Up5TCtYZzDGC3Nubrt2XfoW/XH1/ChvhNsktzaZeDDxXzCx3u574zI7LuMgOa7JiAuq1Brpe6NvZW9b+GDQfxdGKKo7ptFXc4tm5TmIR8Ec0lrKSFyiZsE1WUnZNHeOsmnXzqsApqwDHlYBBd4C/4+mbJ1EU1XbrU3HIIyCndfegP+fq9PR1KNVJnkOYNA7uFVHFzl7NJHf3UwmH1f9RjRYCa32tg6Yc4yMe9gqQgluIOgc4C+7E2EYRqoZD1pN48o/kKrCTzwqkyscJT9r6hChZ5HL3tSYHdTODvMzQUD34=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;6:UUSkTlk+sC3Bk29pcFLB2iv6siYOnbbwH3FXBehotegh/HUn6YaHoAQtptSIjFAQheXr8j/0WNpy0qrkUaROehop7XUjAnxt9q0oE/2yTjGqFVuVj25RVUEUpzrPLmd/EFOyuEk4RoxLJN7qTz+bYfVxSukpYUaT1lDXYUNF7Z/sJs59RLXOfmkO8bTe0SuQsadZjLKB67xZ5oeLye7WA1VEhZVWpvIYK4aOPzHJRVpMIU5cs6vpiPONqLGezVyZC69a2b0NVbtYjYo9xW0HsKgkJCU7ftdz5O9gHL9IIKckD1EcPHpD4mHhQbp6pvp7niJxFsmKFh0NC2K57938Ivpo3iaCMRM7VhFsEpPM3txHGy733tSuoLtlvrYTWh9uc93owPfG6T3DAMDad4DS+iUhrhOrabZCqrmTHuq5ekVuukMigEto/iz3gbKiPA9H5+rqh1uVIDGSec8v+t3ByQ==;5:k99idimprOA444ZIuoqzyvm3YpVJ7qr8lss/goBA2jMj+EU89MjwxWcs4XSeI/Fp5gSUoSA0EaeI9LEiqvq2VYIvZJxaVz1wENWCpsobxlicHJ6kKhO42AINplWlHgIP00sA8vbHGJ+fhxl4CmQR1AcanJMrY8JEmNtKdXlK9EY=;24:zjxOqUCZ3+WgBo52jVsbIRhavmP24VlIFUW8FzsrgPql2oYSQfawkG3ZTucQVgo3zdDPc5zHRGOy+JXPzNK/HeRYb/qjM/KPNdHX6LVR7LM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR03MB2633;7:lk+2vixUdBpzDKrbOyHvWoKraICuvkaHE02OwrmRKyo7/NvK8rI6th7AUur4XNC1cDIVVRGaT1W96q96jyZvdRc1uCCCMYnzZaz8z/UkIpwaSgnA5fiddX8JHAfmwHEPFHXzxKByg88LkoL34z6VbNzOLpPNjv19x+Iyz7udSLvJ0FOIEPdRvTum2NPPrgvnwpxfyGgjnnBT9x1IVEXf/IMrirwnZU6MGzm9FAVicQa1KVT01bwTkRqkAzGO4+8F
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:20:19.8333 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 145e30da-f0d4-4743-b619-08d5e574d041
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR03MB2633
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits.

patch1 introduces necessary hooks to 8250 core.
patch2 exports serial8250_do_set_divisor()
patch3 implements the fractional divisor support for Synopsys DW 8250.

Since v2:
 - rebase to tty-next branch, since I need one patch from Andy which
   is in tty-next
 - drop the patch "serial: 8250: let serial8250_get_divisor() get
   uart_port * as param" since it's in tty-next now.
 - add a new patch to export serial8250_do_set_divisor(), and reuse it
   to complete dw8250_set_divisor().
 - remove DW 8250 version check, since the DLF register always exists
   and if fractional divisor isn't supported, the register read as 0
 - add comments to explain how dw8250_get_divisor() get quot and frac.
 - the frac calcuation is simplified with well implemented GENMASK
 - Add Andy's Reviewed-by tag to patch1.

Since v1:
 - add an extra patch to let serial8250_get_divisor() get uart_port *
   as param
 - take Andy's suggestions to "integrates hooks in the same way like
   it's done for the rest of 8250 ones". Many thanks to Andy.

Jisheng Zhang (3):
  serial: 8250: introduce get_divisor() and set_divisor() hook
  serial: 8250: export serial8250_do_set_divisor()
  serial: 8250_dw: add fractional divisor support

 drivers/tty/serial/8250/8250_core.c |  4 +++
 drivers/tty/serial/8250/8250_dw.c   | 45 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c | 30 +++++++++++++++----
 include/linux/serial_8250.h         |  3 ++
 include/linux/serial_core.h         |  7 +++++
 5 files changed, 84 insertions(+), 5 deletions(-)

-- 
2.18.0



