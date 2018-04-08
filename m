Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeDHIqn (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 04:46:43 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36809 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751940AbeDHIql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 04:46:41 -0400
X-Google-Smtp-Source: AIpwx48yXU+Evuz5Ptvk8cd/v9OMqcIG1U1TJKq44LxDvKRA/mwPf813rNvcH21YzA0pQlwoZ4cspg==
Date: Sat, 7 Apr 2018 22:46:27 -1000
From: Joey Pabalinas <joeypabalinas@gmail.com>
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH] ACPI: prefer bool over int for predicates
Message-ID: <20180408084627.xignebybfxyds2t5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dohnnvt2hwn6rmo4"
Content-Disposition: inline
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dohnnvt2hwn6rmo4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Prefer bool over int for variables / returns which are
predicate expressions to make it explicit that these
expressions are evaluating simple "yes or no?" queries.

This makes it more obvious which expressions are _not_
that simple and require more attention, e.g. an `int ret`
meant to hold 0 or -ENOENT as a return value or an
`unsigned nmemb` meant to refer to the number of valid
members in some arbitrary array.

Change relevant variable / return types from int to bool and
prefer a true / false value for predicate expressions versus
a plain 1 / 0 value.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 drivers/acpi/battery.c  |  4 ++--
 drivers/acpi/ec.c       | 20 +++++++++-----------
 drivers/acpi/pci_root.c | 17 ++++++-----------
 drivers/acpi/scan.c     |  6 +++---
 include/acpi/acpi_bus.h |  2 +-
 5 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index bdb24d636d9acc9c1a..f1a5fb5252969f0478 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1416,7 +1416,7 @@ static int acpi_battery_add(struct acpi_device *devic=
e)
 	battery->pm_nb.notifier_call =3D battery_notify;
 	register_pm_notifier(&battery->pm_nb);
=20
-	device_init_wakeup(&device->dev, 1);
+	device_init_wakeup(&device->dev, true);
=20
 	return result;
=20
@@ -1434,7 +1434,7 @@ static int acpi_battery_remove(struct acpi_device *de=
vice)
=20
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
-	device_init_wakeup(&device->dev, 0);
+	device_init_wakeup(&device->dev, false);
 	battery =3D acpi_driver_data(device);
 	unregister_pm_notifier(&battery->pm_nb);
 #ifdef CONFIG_ACPI_PROCFS_POWER
diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 30a5729565575f83cb..d4a564ab9cdd53046c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -350,7 +350,7 @@ static inline bool acpi_ec_is_gpe_raised(struct acpi_ec=
 *ec)
 	acpi_event_status gpe_status =3D 0;
=20
 	(void)acpi_get_gpe_status(NULL, ec->gpe, &gpe_status);
-	return (gpe_status & ACPI_EVENT_FLAG_STATUS_SET) ? true : false;
+	return gpe_status & ACPI_EVENT_FLAG_STATUS_SET;
 }
=20
 static inline void acpi_ec_enable_gpe(struct acpi_ec *ec, bool open)
@@ -580,28 +580,26 @@ static bool acpi_ec_guard_event(struct acpi_ec *ec)
 	return guarded;
 }
=20
-static int ec_transaction_polled(struct acpi_ec *ec)
+static bool ec_transaction_polled(struct acpi_ec *ec)
 {
 	unsigned long flags;
-	int ret =3D 0;
+	bool polled;
=20
 	spin_lock_irqsave(&ec->lock, flags);
-	if (ec->curr && (ec->curr->flags & ACPI_EC_COMMAND_POLL))
-		ret =3D 1;
+	polled =3D ec->curr && (ec->curr->flags & ACPI_EC_COMMAND_POLL);
 	spin_unlock_irqrestore(&ec->lock, flags);
-	return ret;
+	return polled;
 }
=20
-static int ec_transaction_completed(struct acpi_ec *ec)
+static bool ec_transaction_completed(struct acpi_ec *ec)
 {
 	unsigned long flags;
-	int ret =3D 0;
+	bool completed;
=20
 	spin_lock_irqsave(&ec->lock, flags);
-	if (ec->curr && (ec->curr->flags & ACPI_EC_COMMAND_COMPLETE))
-		ret =3D 1;
+	completed =3D ec->curr && (ec->curr->flags & ACPI_EC_COMMAND_COMPLETE);
 	spin_unlock_irqrestore(&ec->lock, flags);
-	return ret;
+	return completed;
 }
=20
 static inline void ec_transaction_transition(struct acpi_ec *ec, unsigned =
long flag)
diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 6fc204a524932e97f4..61c0c079cff346e492 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -81,20 +81,15 @@ static DEFINE_MUTEX(osc_lock);
  * Note: we could make this API take a struct acpi_device * instead, but
  * for now, it's more convenient to operate on an acpi_handle.
  */
-int acpi_is_root_bridge(acpi_handle handle)
+bool acpi_is_root_bridge(acpi_handle handle)
 {
-	int ret;
 	struct acpi_device *device;
=20
-	ret =3D acpi_bus_get_device(handle, &device);
-	if (ret)
-		return 0;
-
-	ret =3D acpi_match_device_ids(device, root_device_ids);
-	if (ret)
-		return 0;
-	else
-		return 1;
+	if (acpi_bus_get_device(handle, &device))
+		return false;
+	if (acpi_match_device_ids(device, root_device_ids))
+		return false;
+	return true;
 }
 EXPORT_SYMBOL_GPL(acpi_is_root_bridge);
=20
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 490498eca0d3db7d6a..8e3d436184104b5799 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -625,7 +625,7 @@ int acpi_device_add(struct acpi_device *device,
 {
 	int result;
 	struct acpi_device_bus_id *acpi_device_bus_id, *new_bus_id;
-	int found =3D 0;
+	bool found =3D false;
=20
 	if (device->handle) {
 		acpi_status status;
@@ -667,7 +667,7 @@ int acpi_device_add(struct acpi_device *device,
 		if (!strcmp(acpi_device_bus_id->bus_id,
 			    acpi_device_hid(device))) {
 			acpi_device_bus_id->instance_no++;
-			found =3D 1;
+			found =3D true;
 			kfree(new_bus_id);
 			break;
 		}
@@ -1787,7 +1787,7 @@ static void acpi_device_dep_initialize(struct acpi_de=
vice *adev)
=20
 	for (i =3D 0; i < dep_devices.count; i++) {
 		struct acpi_device_info *info;
-		int skip;
+		bool skip;
=20
 		status =3D acpi_get_object_info(dep_devices.handles[i], &info);
 		if (ACPI_FAILURE(status)) {
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index c9608b0b80c602a7df..4504da12c43daa0f6c 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -599,7 +599,7 @@ void acpi_dma_deconfigure(struct device *dev);
=20
 struct acpi_device *acpi_find_child_device(struct acpi_device *parent,
 					   u64 address, bool check_children);
-int acpi_is_root_bridge(acpi_handle);
+bool acpi_is_root_bridge(acpi_handle handle);
 struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle);
=20
 int acpi_enable_wakeup_device_power(struct acpi_device *dev, int state);
--=20
2.17.0.rc1.35.g90bbd502d54fe92035.dirty

--dohnnvt2hwn6rmo4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlrJ1uMACgkQruvLfWhy
VBn63BAA1DYmQK3SRJtjIR23RYkPor9Fp0kNYe+79Vt89jHj/T4q7PG7DNqtsvl2
efU21aKhLK2xVeuzo5cR3YvIrsgup7uULcm525ZXybckMHLz29X+1ZtlZCvdqqMK
dsCL55uHo1TNK1ZUpaxOtTElbYHnSjfOmgq6mXgJbnTgF1Z7zbOaADZkDjHj30vZ
VDcBfCU3jO5eZt/yoO1+CuXCI6TQmrpedKOV4omZ52+7Lo4Zxi6OTq9+i8/cMQsd
o6eLcIIkRYX/+a27iJPPURU3wpHuBdubbg1wP0z+jmHJSTEF4P3vVkLgg8emioNE
cvwhOidRbSk0y27lC2hoVbvqe8PioI2fyuMU6+HQ3gx7zSP8o2f9WeocDVQBwd4h
p1+nMzfnEvoUA5xav9R/ZHJnsqOiZDmdGYusWL31PGjGUjg+j3uAZnnO4nDqELWp
FFHSoY+y13DuXzdwAHxpdZQ0zgL8n48nJaak5iT0G98B91GATlsPCE5xl9XQs/xS
fYOQY+rdO7zuTHvV0UNynRLvw8IgH8EbRA7o/MDIpqzml5qmnTAyNi4OMHYTnTzo
MzgDbi27Z7VInCO2IuOD65HRm0wStr5tPEaJgN+Wutuy75quDnT9QjiXxkE/Nach
SO2V5ku/xxdI2r44cByfDhoaYV/f2Jkn3exksctPtxolaF3XCjo=
=tPPk
-----END PGP SIGNATURE-----

--dohnnvt2hwn6rmo4--
