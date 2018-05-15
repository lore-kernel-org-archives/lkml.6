Return-Path: <decui@microsoft.com>
X-Google-Smtp-Source: AB8JxZotxF/m7YnzmKFxsRu3g1ykrPDBMAFTHiWYs/4o0vWhtHrvffxd+waFT9gTqZqkjeBRj9VP
ARC-Seal: i=1; a=rsa-sha256; t=1526413987; cv=none;
        d=google.com; s=arc-20160816;
        b=nJYZsGWL8cwbtqox/BtJJELZ3xXVUVKROpmW8OLAhJwIWPMWB54ZTYX57zVTjSnIb0
         ZoPhPJInPBqWgxqgYLeEBmoDQOVrx5W4D+gEyd630khsLcfEdZ+BJ/Gkjgz7FoRzAsbE
         oMPJOibUIywzyq4L1SwJQJhUJdzRIr6Qy9rKKh9RSeq0XsRzli7d2PxbBNPBtOs1Gs7Z
         1RPlwHHtHf3ed4/Q2DjPN5nQI6B+J/prqfLsT16uLoFOymB6NyVtoFQKxEhn59pzIJ2b
         yNcmyAx+Iz1XAfQRv4jFACK+ha2y68fztfwVoES2B/SkJhzsKBszJwTFuedBcS5TpVhn
         JzsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:msip_labels:content-language:accept-language
         :message-id:date:thread-index:thread-topic:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=MjGpvAq7JWVkjQ4ukroyy/V/JnzPJMRPorU2D6cR6hM=;
        b=MP0Z4hxItPwXyfOGasUAaudE5oaDR5LkXIo7EbOB0ZfTpX05TQDY4S29fdH4kzguOR
         cPYoalMZ3o2Cl8rtbP91j2IpBZzsBhwMYzCT4VH3HKmrr+V5fAtCn3toIIsw+6zaKqbs
         WFBASub0TDrw1ghayfgPnlQSEo9IJBvC68NHefNH9qQsIes72bKaL4EcfkOXIHHxGRvB
         Z4it468IBFOwDYPjq8A9m6OeslY/jvaJ3CsnYuzLcE7r89FsAUOMv6BQJDqw+PGZ8Lrt
         yj8jj0QBdPCY+fnVvBJucW6Tetj3JIZvI1cypXA3B9xyrsfgPFw/XXXromHHa5RQnqo/
         xq+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=C5nVL2H6;
       spf=pass (google.com: domain of decui@microsoft.com designates 104.47.126.104 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=C5nVL2H6;
       spf=pass (google.com: domain of decui@microsoft.com designates 104.47.126.104 as permitted sender) smtp.mailfrom=decui@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Dexuan Cui <decui@microsoft.com>
To: Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Dmitry
 Vyukov <dvyukov@google.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, KY
 Srinivasan <kys@microsoft.com>, Jork Loeser <Jork.Loeser@microsoft.com>,
	Rakib Mullick <rakib.mullick@gmail.com>, Alexey Dobriyan
	<adobriyan@gmail.com>, Josh Poulson <jopoulso@microsoft.com>, "Michael Kelley
 (EOSG)" <Michael.H.Kelley@microsoft.com>
Subject: [PATCH] tick/broadcast: Use for_each_cpu() specially on UP kernels
Thread-Topic: [PATCH] tick/broadcast: Use for_each_cpu() specially on UP
 kernels
Thread-Index: AdPshQLk7bbHW17pTd+qmP1UgjaPIA==
Date: Tue, 15 May 2018 19:52:50 +0000
Message-ID: <KL1P15301MB0006FA63BC22BEB64902EAA0BF930@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-15T19:52:48.4313286Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [131.107.147.147]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0040;7:YuIoks88qZHkKqrtgv7gSCtCx2igIF/CwVhPy81Whm4jQWFsXyqKHOm2wJerIfrGMtGc4/aRN+1A4YkYPV7OZNXQ2I9A43MMLGuXlgJx03p9RzkDUY2KISyRCZzMWol2sPh9qinWSFHN7fse4diGuB7uc9EllZZHijLGEQZq88kSGEsG8AuiB1j3z7uR4oSpOiMuVpLCHloovi1SBTV9K93YFbRjwpIcJ6zanR66wY9nDY48lgiJpSpFAX7yfovx;20:yYca4UoFqqM9lodYMzM/U3hDqyrxLYbi3ZJ1EIkLe4r5rvr7Zve6WKiq3vBOSbFl4ABZYyr4Vh2C8ErJKRxoqasgqLWua4Sbaqvnula2r1waoEoUEBB9mRBEpNO+kCpw5VK5GpFUX1P6W2fMfivY9EKC9WKTltZtsGzAWGSYYbc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0040;
x-ms-traffictypediagnostic: KL1P15301MB0040:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-o365eop-header: O365_EOP: Allow for Unauthenticated Relay
x-o365ent-eop-header: Message processed by -  O365_ENT: Allow from ranges
 (Engineering ONLY)
x-microsoft-antispam-prvs: <KL1P15301MB0040D0AEDA98ADC29D69FA54BF930@KL1P15301MB0040.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:KL1P15301MB0040;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0040;
x-forefront-prvs: 0673F5BE31
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(189003)(199004)(54534003)(486006)(25786009)(476003)(107886003)(478600001)(5660300001)(86612001)(86362001)(33656002)(77096007)(105586002)(106356001)(2906002)(97736004)(26005)(6306002)(10090500001)(55016002)(7416002)(186003)(1857600001)(8990500004)(9686003)(22452003)(110136005)(39060400002)(316002)(59450400001)(6506007)(53936002)(3660700001)(7696005)(3280700002)(54906003)(10290500003)(66066001)(102836004)(14454004)(6436002)(305945005)(966005)(7736002)(3846002)(6116002)(99286004)(4326008)(74316002)(68736007)(81166006)(81156014)(8676002)(2900100001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0040;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: +8lSsRA83yyZI0O2ark6qdk79v63Qfzzmpj6lizGCoxFB5gNYxzxyrYsjqm24ISNf2MT11MeBaznQfxnJ6cGoZ+5JFSKySLc+FkAvD/Eb/alBohosjSE5pIN3XltmSROwrq7ooo7jR7uX+8Uq+9ZST2u2rMIE7cXQgek/M2QzkykL2hu1ebvyt01uIH4MMka
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 25c228d1-c8a9-4099-f0f6-08d5ba9d70f7
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c228d1-c8a9-4099-f0f6-08d5ba9d70f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2018 19:52:50.6298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0040
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600561072875598164?=
X-GMAIL-MSGID: =?utf-8?q?1600561072875598164?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


for_each_cpu() unintuitively reports CPU0 as set independent of the actual
cpumask content on UP kernels. This causes an unexpected PIT interrupt
storm on a UP kernel running in an SMP virtual machine on Hyper-V, and as
a result, the virtual machine can suffer from a strange random delay of 1~2=
0
minutes during boot-up, and sometimes it can hang forever.

Link: https://lkml.org/lkml/2018/5/9/63
Link: https://lkml.org/lkml/2018/5/15/747
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Cc: stable@vger.kernel.org
---

Some part of the changelog and comments are copied from=20
Thomas Gleixner's 115ef3b7e61a ("watchdog/hardlockup/perf: Cure UP damage")=
 :-)

 kernel/time/tick-broadcast.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index b398c2e..2fc59ad 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -612,6 +612,14 @@ static void tick_handle_oneshot_broadcast(struct clock=
_event_device *dev)
 	now =3D ktime_get();
 	/* Find all expired events */
 	for_each_cpu(cpu, tick_broadcast_oneshot_mask) {
+#ifndef CONFIG_SMP
+		/*
+		 * Required because for_each_cpu() reports unconditionally
+		 * CPU0 as set on UP kernels.
+		 */
+		if (cpumask_empty(tick_broadcast_oneshot_mask))
+			break;
+#endif
 		td =3D &per_cpu(tick_cpu_device, cpu);
 		if (td->evtdev->next_event <=3D now) {
 			cpumask_set_cpu(cpu, tmpmask);
--=20
2.7.4
