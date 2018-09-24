Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E71AECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6098214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="dmWZBXhg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6098214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbeIXUvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:11 -0400
Received: from mail-eopbgr720137.outbound.protection.outlook.com ([40.107.72.137]:26497
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731022AbeIXUvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxmAEu6/kfNFOpqWEtXLCxnEWwxYkKfoTBxkZREGjDw=;
 b=dmWZBXhg7VtYeTcneGmsIszq9oQQMRyZQnybM8T7pIN1OfB5b+h3hLRy0HlYQxeuUkEwe7xfkLGM792BTZEwcywVnS3R3i7iYNXZYd8fPH2dCNo5C244jtfAs6yMVeKwHVMZQxtibzvpE3w3mBzxCCf7N7zXq1z0dS9y113B2Z8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0821.namprd21.prod.outlook.com (10.173.192.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.3; Mon, 24 Sep 2018 14:48:16 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1207.003; Mon, 24 Sep 2018
 14:48:16 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 25/76] gpiolib-acpi: Register GpioInt ACPI event
 handlers from a late_initcall
Thread-Topic: [PATCH AUTOSEL 4.18 25/76] gpiolib-acpi: Register GpioInt ACPI
 event handlers from a late_initcall
Thread-Index: AQHUVBWgWhyUHKTPH06bCpNRAcSzpQ==
Date:   Mon, 24 Sep 2018 14:48:16 +0000
Message-ID: <20180924144751.164410-25-alexander.levin@microsoft.com>
References: <20180924144751.164410-1-alexander.levin@microsoft.com>
In-Reply-To: <20180924144751.164410-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0821;6:yKxwRIlFLYJ32o3lMqwaVblTBE6IUQaIKwZ0qGDIOy5FFbDa0BuiOapuds7v5MdCv8pp2RiS9c8vSa7wMssxgdJRJGqylRnwnTgU4c/KVP3hPs0ovhNvIug0Z8CQemD7P7vGTtgkTSfMogbFxAA9KwPLE5K2Icd0VaA/sbysGjwRwflS3l+7U7Ue9/h+TttDUlueLQFD8+f5z1cWztDmzZKU/jjOaYoyOFvdA2Oq6gkzZvpaWEWUPMOtgicNHA0ECg3KlOWiO6r8tLc5r5W1TvrnleDKSexDpgYKL9PMJ8GAZmI5UFT6Gj//O/BQEY5n00zSqW3sjaoKShrFWt+a0ax4CWYynrPj/w2Rw+GRsdMKe//KKQlfvf2kWzdt3w5nMyOfj7m9aANenGCUBnLXepkynFgT/PAQUBG46iq+9IPCAD38sw+y20aZ28SriYHwv9OyE4P9GxttGnUgBErquw==;5:vWFF5UD/fa1kX1NZ8CtVfads471e1jNIxcHjp9k8VDN9bD7md9wPQICK8esqlgvzhy44D30S0yEn5Y64/7QLfi9UOa8hvdtMOcJbpq8V/bBKiXTDSb4MgpDNHW0DQK+f/PwvQrur6gpvSb1zQHkl0MaNK9g7JYvm/bEsKASRAsI=;7:HuBF1VUfgJOg8WFHWYomBiHq+gt7C5VRADwtOR7ur6pzs/6E/oCwVIvMe89AeJEboF0gJu5xh5c4hQkYfKw0NTtAIDCzMQGnjBj8Komef4krN3/IdPsTR0aP9kB6Preq6whNEFqQgNBXwNJPTyI8dyRzELykG8LzivKiCfppAg13X8mfRGUe73cHlePtmYQbwu2Sa6TgE1H3BOw2FzQuGJKhzewZgKFFzc5S7HtCf/RpYyCEkEVSxAZAnKiHzHXl
x-ms-office365-filtering-correlation-id: bb15d718-a76e-4383-2ecc-08d6222cc300
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0821;
x-ms-traffictypediagnostic: CY4PR21MB0821:
x-microsoft-antispam-prvs: <CY4PR21MB0821EAD28CA2A186B1C9DEA2FB170@CY4PR21MB0821.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171)(12401385986421);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231355)(2280196)(944501410)(52105095)(2018427008)(6055026)(149066)(150027)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0821;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0821;
x-forefront-prvs: 0805EC9467
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(2900100001)(86612001)(81166006)(81156014)(8676002)(8936002)(1076002)(4326008)(25786009)(3846002)(6116002)(86362001)(99286004)(486006)(76176011)(54906003)(71190400001)(71200400001)(22452003)(316002)(106356001)(105586002)(6346003)(478600001)(10290500003)(6506007)(26005)(7736002)(305945005)(72206003)(186003)(476003)(446003)(11346002)(14454004)(2616005)(110136005)(217873002)(6486002)(53936002)(102836004)(5660300001)(14444005)(5024004)(256004)(6512007)(6436002)(107886003)(66066001)(97736004)(36756003)(10090500001)(2501003)(68736007)(5250100002)(2906002)(60540400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0821;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: +ARdpIEvQtMBKCHHSl23dprp8Th8PxBD/vHBcZkqoYIQZvhBm32NDXaiKS+uKp6WKVAD0eA6M7H2lzPPpR4MBsHZd4BZhv6+5a1nfa3MwqS8IxCflLVwvAaTU+eR028BTW251KMbxmF30j7NRGdqTiijqBoXaeQUWtkZOx5SYUNCMe0h3uO1TfErgMzrytf2EZuuwPEYontdjHpEVANn1u5qXSGz2SACDDhCZ4jTjMJwPrC4f/c+P7KMar2EUEPZKVW4e/5KsYBpLSVLLFMi+sGvi/QuzAaOwxHcHqJS27KG37yjF5HPOZl7kh+lR+WlWmrlwhqxHVhsPMLwW8TafOegAoPX/iVtsdjO0hXijKCw8CEYMTOrPnSCub3nZhrb8kSMUxMyx5HP+wsIaZYAyNfPiMclmJHKK5PYxxZGT5ERG/XfaZ4+Wl/jnGHvmmOLGqmAwe7lhcM4YFc98T1jVuM2/5/HwHaJAjsFPwfNUSIgm33G+vxp97OhXPsMUMGqHA4pKMfebJ/fGf5TpXue/zgejOxjYtzc3/N4kTAW2ew2uT5yg0y34wY+ahzzouK2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb15d718-a76e-4383-2ecc-08d6222cc300
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2018 14:48:16.3837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0821
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
index 7da51b5186c0..a3e43cacd78e 100644
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
@@ -89,21 +97,6 @@ static struct gpio_desc *acpi_get_gpiod(char *path, int =
pin)
 	return gpiochip_get_desc(chip, pin);
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
@@ -229,7 +222,6 @@ static acpi_status acpi_gpiochip_request_interrupt(stru=
ct acpi_resource *ares,
 	event->irq =3D irq;
 	event->pin =3D pin;
 	event->desc =3D desc;
-	INIT_LIST_HEAD(&event->initial_sync_list);
=20
 	ret =3D request_threaded_irq(event->irq, NULL, handler, irqflags,
 				   "ACPI:Event", event);
@@ -251,10 +243,9 @@ static acpi_status acpi_gpiochip_request_interrupt(str=
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
@@ -283,6 +274,7 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip =
*chip)
 	struct acpi_gpio_chip *acpi_gpio;
 	acpi_handle handle;
 	acpi_status status;
+	bool defer;
=20
 	if (!chip->parent || !chip->to_irq)
 		return;
@@ -295,6 +287,16 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip=
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
@@ -325,11 +327,14 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip *=
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
@@ -1049,6 +1054,7 @@ void acpi_gpiochip_add(struct gpio_chip *chip)
=20
 	acpi_gpio->chip =3D chip;
 	INIT_LIST_HEAD(&acpi_gpio->events);
+	INIT_LIST_HEAD(&acpi_gpio->deferred_req_irqs_list_entry);
=20
 	status =3D acpi_attach_data(handle, acpi_gpio_chip_dh, acpi_gpio);
 	if (ACPI_FAILURE(status)) {
@@ -1195,20 +1201,28 @@ bool acpi_can_fallback_to_crs(struct acpi_device *a=
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
