Return-Path: <decui@microsoft.com>
X-Google-Smtp-Source: AB8JxZo92aBpwL2nQoX0LJhweRZG9+PshzeWzbKCbL1FXty6mduebj1ID/3eMMo45CNDwElS2K8h
ARC-Seal: i=1; a=rsa-sha256; t=1525847063; cv=none;
        d=google.com; s=arc-20160816;
        b=XgzY6Qdftna1Kuday+O+Q/KC3XXXBXedURG63FX9uMqfRJuFoQ51D3BUqKJfn28tse
         TP+nd4Zep12GZpQVRo4hVOp+rLAaGEp4bPu2yYJFLRE+rX/f3W1Eq77eKdCT3URgyxAo
         RKxQeKHjWgFw7BMK0RwbuONjPNedwsfQAjqv5234ITuTCRI5jTX+YEfRC3J1+hniJzMD
         3V2qsL12OlEOi25xgOi8rqUhnrGQyl3wngufQpK73lYohXdmC56HpzhAWe/9ZWP/nTD+
         x3fF3jnALGPu8QsubW0ddizU7+QhEU1V5CO0UZh1hBRJQAbq9yVTDFV1ln2vA4VjubLJ
         OivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:msip_labels:content-language:accept-language
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=t0pO+lj2Rsp0lcqXF3q9gIujebZIU52c3SNkibUcRBg=;
        b=sQrtkjaHxG/ppNHwXT0yHMyNGL5FZE/e1dXKQEcZXZLuXlQmO3n2qy43q8LI1bvTFA
         vEpk8rV8q2VVUgENtC0EIbIaJnO39SHxCC6L9p8ycs93uyeMqjcnbArW1c7fbZ8BmHuY
         D+YRb8B3tsXttVPnxHr+ovAxnM0FOAvnE0y4ZOAGLRD5JnnN/GtFvH2b0sH7At/UWRlN
         9wezxcyEVMa/FPj835aU0jsRQNOGsA9yFpzfXaSjDBGX/QqRiEseBjN83ksbWD6bwAwI
         3wYqOikE7OSqS37/MKwIEJM0x9uvRl5HChSwXXjtIeRZiFWX7bnXNUE8ZLefmvkCe71g
         XXYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=C1RrSOYQ;
       spf=pass (google.com: domain of decui@microsoft.com designates 104.47.125.126 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=C1RrSOYQ;
       spf=pass (google.com: domain of decui@microsoft.com designates 104.47.125.126 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Dexuan Cui <decui@microsoft.com>
To: Ingo Molnar <mingo@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rakib Mullick
	<rakib.mullick@gmail.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: for_each_cpu()  is buggy for UP kernel?
Thread-Topic: for_each_cpu()  is buggy for UP kernel?
Thread-Index: AdPnWYLrJlOveRToTsSZVB6rlnXzlg==
Date: Wed, 9 May 2018 06:24:16 +0000
Message-ID: <KL1P15301MB000678289FE55BA365B3279ABF990@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-09T06:24:14.0056515Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2601:600:a27f:df20:a420:4ad5:cf03:9ecd]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0039;7:HvUQqg1fG1sSQGxg0gQVot6jdKgbn2EAdo8OdqIPaE15P+AiV3KE73BuOctYffwXFAPBKunECCeBqu0JSQp5zYSok6Vfow2CsX4iL4UO5TA9VD0iL+Ng/y1n7ZRc5zY4+EjjSR9NUcKygjWBEP5ZMdrniciS04+2MpHKTYgjEGAzslMyeOCymVyXkOLmL54XHs11lMESlBoO13QkbDUbtGkAZgurB14O3XdPJm6RF2Yayd4vdZKp/3qAbPyijRiF;20:o58wuF4UzUDsTjIlILL4MNfKmecsHmUKN3kP01QCkT1rkSWeCTcY92D6KK6wTICFnL5nSM50RpR4jqJ9XRF4XlowBR6OEI34+Huh424azscjBz4QkmmrynpPWPrXP9MGKitqL+x5EGVkmKy2yy9YwelYyVfHbBWpusCjPqAz7bY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7193020);SRVR:KL1P15301MB0039;
x-ms-traffictypediagnostic: KL1P15301MB0039:
x-microsoft-antispam-prvs: <KL1P15301MB0039DDFE4BDD3425B4C87EF4BF990@KL1P15301MB0039.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:KL1P15301MB0039;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0039;
x-forefront-prvs: 0667289FF8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(366004)(396003)(346002)(189003)(199004)(74316002)(4326008)(9686003)(6116002)(8936002)(97736004)(53936002)(105586002)(305945005)(6436002)(10090500001)(68736007)(7736002)(33656002)(39060400002)(106356001)(81166006)(8676002)(25786009)(55016002)(81156014)(46003)(10290500003)(77096007)(186003)(102836004)(2906002)(99286004)(6506007)(478600001)(7696005)(5660300001)(14454004)(3660700001)(22452003)(476003)(2900100001)(86612001)(486006)(316002)(110136005)(86362001)(3280700002)(8990500004);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0039;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RmU0VYGdLz8nD42T5lNWGV6HRQrNKCBN3f6ppvXNYopLXI1v8WvyBR5GL5h1nHnLs+iZ7DJHspYnmF6qhlkTd8/ru/ftk/D9dHYyLmDysrg7BRu9lgOBE7Wi88jCad3Y8yPs+9ekYWrJMDglX/byZBCRRjwrSKQjyt3UEs1d8LixA/9CW45Tkq/EzuMaeVr9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3b4f5716-23fe-4160-3e22-08d5b5757e19
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4f5716-23fe-4160-3e22-08d5b5757e19
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 06:24:16.8523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0039
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599966610262155638?=
X-GMAIL-MSGID: =?utf-8?q?1599966610262155638?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In include/linux/cpumask.h, for_each_cpu is defined like this for UP kernel=
 (CONFIG_NR_CPUS=3D1):

#define for_each_cpu(cpu, mask)                 \
        for ((cpu) =3D 0; (cpu) < 1; (cpu)++, (void)mask)

Here 'mask' is ignored, but what if 'mask' contains 0 CPU? -- in this case,=
 the for loop should not
run at all, but with the current code, we run the loop once with cpu=3D=3D0=
.

I think I'm seeing a bug in my UP kernel that is caused by the buggy for_ea=
ch_cpu():

in kernel/time/tick-broadcast.c: tick_handle_oneshot_broadcast(), tick_broa=
dcast_oneshot_mask
contains 0 CPU, but due to the buggy for_each_cpu(), the variable 'next_eve=
nt' is changed from
its default value KTIME_MAX to "next_event =3D td->evtdev->next_event"; as =
a result,
tick_handle_oneshot_broadcast () -> tick_broadcast_set_event() -> clockeven=
ts_program_event()
-> pit_next_event() is programming the PIT timer by accident, causing an in=
terrupt storm of PIT
interrupts in some way: I'm seeing that the kernel is receiving ~8000 PIT i=
nterrupts per second for
1~5 minutes when the UP kernel boots, and it looks the kernel hangs, but in=
 1~5 minutes, finally
somehow the kernel can recover and boot up fine. But, occasionally, the ker=
nel just hangs there
forever, receiving ~8000 PIT timers per second.=20

With the below change in kernel/time/tick-broadcast.c, the interrupt storm =
will go away:

+#undef for_each_cpu
+#define for_each_cpu(cpu, mask)                        \
+       for ((cpu) =3D 0; (((cpu) < 1) && ((mask)[0].bits[0] & 1)); (cpu)++=
, (void)mask)

Should we fix the for_each_cpu() in include/linux/cpumask.h for UP?

Thanks,
-- Dexuan
