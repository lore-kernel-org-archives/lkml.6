Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DA4ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB362087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="gv2VDGbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB362087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbeIXVBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:01:54 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:30464
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730550AbeIXUwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=be565P2LZjhYLUIg+QowALSy04LYWPPPBPKfO6sMCdo=;
 b=gv2VDGbiZ7O8+CogAySPOwsOSRV81LnUtxp22bzdbz3N0f5wFYN0PigRV4AKpAyQYDykA2XbtLmQPjGJnMkqDGfDGago16Encrlp9SZ0vDjTXdg01Dz3MtuFx109AkbRJqbO75JucImzutV0MJZnNTqVAllf733zB8jsPPVNtIE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:49:43 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:49:43 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 12/36] gpiolib-acpi: Register GpioInt ACPI event
 handlers from a late_initcall
Thread-Topic: [PATCH AUTOSEL 4.14 12/36] gpiolib-acpi: Register GpioInt ACPI
 event handlers from a late_initcall
Thread-Index: AQHUVBW7Z7nqiYxNvEuViWVRnjLe7w==
Date:   Mon, 24 Sep 2018 14:49:01 +0000
Message-ID: <20180924144851.164533-12-alexander.levin@microsoft.com>
References: <20180924144851.164533-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144851.164533-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:m4n8aT2tm3TTfeKZT0TEq1oocn4dm8Z56WXZqJ40loMPIorB4n+Q1YzGGIJgc2xowVumtsj8trtjcBxWKv1Zinc9XNAqOj11jGEG6+Zfsv20uCyC56AaIC95uPxp6NC7MFSm/JQj0ETeSthCyeQXg7hHnsy3ujoI4/oPr89BP4r3IOzJNl5chy0HvtTU8lBMNjy2vTwEPEWjYeIKQraKAELr3M31JFg9UZ/2xWVvPoDJ1ZEgE0ydPZBhuH9O1jmBqTbdkPxktIRBmoxPZbtpGVqDGg6aD+o8OU+3nUrPP3temw423as/O7Z47DAvJvkJ78duJqx7Ktn9abAFAgyyn61CMsrW5cE8EXJvvqi64xYdjcjpb3YrsOQm6+Itislb5NGyU6PiCVBRk5FZsHVq2tkbpeIUpQeXNA9EId0hdtbkoSxg/X235VX1zF+CZyOFUqA2NAPkbp6vlUoGd368yg==;5:8MO6ZyqhjmZz3qI9iAlh5aeiXTqYc+lPi6A0Z3uGSyD0GMCQ7gdxOJLefza89xt5aid7XjINrFM9jawC20I/4q+32qQ2/AtT7bBGZjaSbuZYL8ZuonVI57OZryhauYPBVstTfizwHsxvbgLmYf4baq0Se3DmGABwfdT1EMLCZOs=;7:6ElutnNUlZQVqhoKIVuIKDhndZ6QGMGn3UpupYIVve0WkYSF6z1eA+l4YjKrilFLflSb03RyCkpMgy1nKWNNXpDWoW7c3OZDem1ctbK4T1uxu8ROb+jU2UuLV0dQrmm34+kask06yfbrtEcw1CAIoygLrunrmc36bPnNLXCQnT0nYBIYy6+g/UCFZ6b2sGwJ9rB2ENhb9rY0O3zxoGNHq8flTaSM0FrZLMIQkYONqMmtD7v18JLVp5nlhaUbDIpw
x-ms-office365-filtering-correlation-id: 54c05884-6ecc-42f7-5e0c-08d6222cf6cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB018140C950526A4FFA0B0D73FB170@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(2280196)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(10290500003)(6116002)(26005)(102836004)(3846002)(5660300001)(22452003)(110136005)(10090500001)(8676002)(1076002)(54906003)(105586002)(186003)(316002)(106356001)(2501003)(6436002)(97736004)(6486002)(107886003)(7736002)(36756003)(478600001)(72206003)(14454004)(71200400001)(71190400001)(305945005)(256004)(14444005)(5024004)(5250100002)(217873002)(6666003)(2616005)(68736007)(53936002)(81166006)(81156014)(2900100001)(476003)(86612001)(4326008)(8936002)(486006)(99286004)(6512007)(86362001)(2906002)(25786009)(66066001)(6506007)(11346002)(446003)(76176011)(60540400001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wVx6B48/R6k39KgV5s70kxXXZN8zVM6sPw2wp/7kab7zkJOwyTUIU5cU1AO4UNoJFWDTVy+MsEKt0YuRbUGRaIoF8SOJMRcbxfaqklijNqLnaiyiQSvuP/DZpFfX7xCb6dKgoue2w91WODWMDT/p2TYOD+ZLLVQuBailfhKWTYESzl6OWLE3cx41HrFHZ3ZSozenlKfO52zZL5rhKysaAfs0Ayh4TE+8lFBJ3Xlm4Y0IDvU14/fAlLD7JkDycjVW7rF5H7/S/Q5PNYsN3aowYebjFPMaxEW4Cqs36zjl1XzcGBgE/e49kFLYHIaE/HBcVLzM9BCpE7WOh6MyFk0hz7qIMxUzoQKyEwgRGzpbe3lqCBTyXrPR6/bx+9ab7tP95J9mV/yKYnL0KUNL4XeQgFvkmTQUeed6Fo5PLwZ8HzvXr6oEDtqwirSyNU14tE/0MSk8gDH04GXuOMG8WtijMnhgWBiIw09ut7b8lxNXcBhjFlpaYqZx27TNdPZkFtjfEl/0cDyR7/+OycV+LnwnvEuznq7cQSRYdrXP9auFqJ1LB0AfEJozIWGTPyKejgy6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c05884-6ecc-42f7-5e0c-08d6222cf6cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:49:01.0985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 78d3a92edbfb02e8cb83173cad84c3f2d5e1f070 ]

GpioInt ACPI event handlers may see there IRQ triggered immediately
after requesting the IRQ (esp. level triggered ones). This means that they
may run before any other (builtin) drivers have had a chance to register
their OpRegion handlers, leading to errors like this:

[    1.133274] ACPI Error: No handler for Region [PMOP] ((____ptrval____)) =
[UserDefinedRegion] (20180531/evregion-132)
[    1.133286] ACPI Error: Region UserDefinedRegion (ID=3D141) has no handl=
er (20180531/exfldio-265)
[    1.133297] ACPI Error: Method parse/execution failed \_SB.GPO2._L01, AE=
_NOT_EXIST (20180531/psparse-516)

We already defer the manual initial trigger of edge triggered interrupts
by running it from a late_initcall handler, this commit replaces this with
deferring the entire acpi_gpiochip_request_interrupts() call till then,
fixing the problem of some OpRegions not being registered yet.

Note that this removes the need to have a list of edge triggered handlers
which need to run, since the entire acpi_gpiochip_request_interrupts() call
is now delayed, acpi_gpiochip_request_interrupt() can call these directly
now.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpio/gpiolib-acpi.c | 84 +++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
index 582dde355bde..33d4bd505b5b 100644
--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -25,7 +25,6 @@
=20
 struct acpi_gpio_event {
 	struct list_head node;
-	struct list_head initial_sync_list;
 	acpi_handle handle;
 	unsigned int pin;
 	unsigned int irq;
@@ -49,10 +48,19 @@ struct acpi_gpio_chip {
 	struct mutex conn_lock;
 	struct gpio_chip *chip;
 	struct list_head events;
+	struct list_head deferred_req_irqs_list_entry;
 };
=20
-static LIST_HEAD(acpi_gpio_initial_sync_list);
-static DEFINE_MUTEX(acpi_gpio_initial_sync_list_lock);
+/*
+ * For gpiochips which call acpi_gpiochip_request_interrupts() before late=
_init
+ * (so builtin drivers) we register the ACPI GpioInt event handlers from a
+ * late_initcall_sync handler, so that other builtin drivers can register =
their
+ * OpRegions before the event handlers can run.  This list contains gpioch=
ips
+ * for which the acpi_gpiochip_request_interrupts() has been deferred.
+ */
+static DEFINE_MUTEX(acpi_gpio_deferred_req_irqs_lock);
+static LIST_HEAD(acpi_gpio_deferred_req_irqs_list);
+static bool acpi_gpio_deferred_req_irqs_done;
=20
 static int acpi_gpiochip_find(struct gpio_chip *gc, void *data)
 {
@@ -146,21 +154,6 @@ static struct gpio_desc *acpi_get_gpiod(char *path, in=
t pin)
 	return gpiochip_get_desc(chip, offset);
 }
=20
-static void acpi_gpio_add_to_initial_sync_list(struct acpi_gpio_event *eve=
nt)
-{
-	mutex_lock(&acpi_gpio_initial_sync_list_lock);
-	list_add(&event->initial_sync_list, &acpi_gpio_initial_sync_list);
-	mutex_unlock(&acpi_gpio_initial_sync_list_lock);
-}
-
-static void acpi_gpio_del_from_initial_sync_list(struct acpi_gpio_event *e=
vent)
-{
-	mutex_lock(&acpi_gpio_initial_sync_list_lock);
-	if (!list_empty(&event->initial_sync_list))
-		list_del_init(&event->initial_sync_list);
-	mutex_unlock(&acpi_gpio_initial_sync_list_lock);
-}
-
 static irqreturn_t acpi_gpio_irq_handler(int irq, void *data)
 {
 	struct acpi_gpio_event *event =3D data;
@@ -290,7 +283,6 @@ static acpi_status acpi_gpiochip_request_interrupt(stru=
ct acpi_resource *ares,
 	event->irq =3D irq;
 	event->pin =3D pin;
 	event->desc =3D desc;
-	INIT_LIST_HEAD(&event->initial_sync_list);
=20
 	ret =3D request_threaded_irq(event->irq, NULL, handler, irqflags,
 				   "ACPI:Event", event);
@@ -312,10 +304,9 @@ static acpi_status acpi_gpiochip_request_interrupt(str=
uct acpi_resource *ares,
 	 * may refer to OperationRegions from other (builtin) drivers which
 	 * may be probed after us.
 	 */
-	if (handler =3D=3D acpi_gpio_irq_handler &&
-	    (((irqflags & IRQF_TRIGGER_RISING) && value =3D=3D 1) ||
-	     ((irqflags & IRQF_TRIGGER_FALLING) && value =3D=3D 0)))
-		acpi_gpio_add_to_initial_sync_list(event);
+	if (((irqflags & IRQF_TRIGGER_RISING) && value =3D=3D 1) ||
+	    ((irqflags & IRQF_TRIGGER_FALLING) && value =3D=3D 0))
+		handler(event->irq, event);
=20
 	return AE_OK;
=20
@@ -344,6 +335,7 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip =
*chip)
 	struct acpi_gpio_chip *acpi_gpio;
 	acpi_handle handle;
 	acpi_status status;
+	bool defer;
=20
 	if (!chip->parent || !chip->to_irq)
 		return;
@@ -356,6 +348,16 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip=
 *chip)
 	if (ACPI_FAILURE(status))
 		return;
=20
+	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
+	defer =3D !acpi_gpio_deferred_req_irqs_done;
+	if (defer)
+		list_add(&acpi_gpio->deferred_req_irqs_list_entry,
+			 &acpi_gpio_deferred_req_irqs_list);
+	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
+
+	if (defer)
+		return;
+
 	acpi_walk_resources(handle, "_AEI",
 			    acpi_gpiochip_request_interrupt, acpi_gpio);
 }
@@ -386,11 +388,14 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip *=
chip)
 	if (ACPI_FAILURE(status))
 		return;
=20
+	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
+	if (!list_empty(&acpi_gpio->deferred_req_irqs_list_entry))
+		list_del_init(&acpi_gpio->deferred_req_irqs_list_entry);
+	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
+
 	list_for_each_entry_safe_reverse(event, ep, &acpi_gpio->events, node) {
 		struct gpio_desc *desc;
=20
-		acpi_gpio_del_from_initial_sync_list(event);
-
 		if (irqd_is_wakeup_set(irq_get_irq_data(event->irq)))
 			disable_irq_wake(event->irq);
=20
@@ -1101,6 +1106,7 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
=20
 	acpi_gpio->chip =3D chip;
 	INIT_LIST_HEAD(&acpi_gpio->events);
+	INIT_LIST_HEAD(&acpi_gpio->deferred_req_irqs_list_entry);
=20
 	status =3D acpi_attach_data(handle, acpi_gpio_chip_dh, acpi_gpio);
 	if (ACPI_FAILURE(status)) {
@@ -1247,20 +1253,28 @@ bool acpi_can_fallback_to_crs(struct acpi_device *a=
dev, const char *con_id)
 	return con_id =3D=3D NULL;
 }
=20
-/* Sync the initial state of handlers after all builtin drivers have probe=
d */
-static int acpi_gpio_initial_sync(void)
+/* Run deferred acpi_gpiochip_request_interrupts() */
+static int acpi_gpio_handle_deferred_request_interrupts(void)
 {
-	struct acpi_gpio_event *event, *ep;
+	struct acpi_gpio_chip *acpi_gpio, *tmp;
+
+	mutex_lock(&acpi_gpio_deferred_req_irqs_lock);
+	list_for_each_entry_safe(acpi_gpio, tmp,
+				 &acpi_gpio_deferred_req_irqs_list,
+				 deferred_req_irqs_list_entry) {
+		acpi_handle handle;
=20
-	mutex_lock(&acpi_gpio_initial_sync_list_lock);
-	list_for_each_entry_safe(event, ep, &acpi_gpio_initial_sync_list,
-				 initial_sync_list) {
-		acpi_evaluate_object(event->handle, NULL, NULL, NULL);
-		list_del_init(&event->initial_sync_list);
+		handle =3D ACPI_HANDLE(acpi_gpio->chip->parent);
+		acpi_walk_resources(handle, "_AEI",
+				    acpi_gpiochip_request_interrupt, acpi_gpio);
+
+		list_del_init(&acpi_gpio->deferred_req_irqs_list_entry);
 	}
-	mutex_unlock(&acpi_gpio_initial_sync_list_lock);
+
+	acpi_gpio_deferred_req_irqs_done =3D true;
+	mutex_unlock(&acpi_gpio_deferred_req_irqs_lock);
=20
 	return 0;
 }
 /* We must use _sync so that this runs after the first deferred_probe run =
*/
-late_initcall_sync(acpi_gpio_initial_sync);
+late_initcall_sync(acpi_gpio_handle_deferred_request_interrupts);
--=20
2.17.1
