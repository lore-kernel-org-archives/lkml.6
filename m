Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49wdO2Gr+TzN4faC0gC2Hbn4z6XcEoVso9itLXvJPJjzCO0ruaaXH9SlCCikQ6NglKwf39h
ARC-Seal: i=1; a=rsa-sha256; t=1523981278; cv=none;
        d=google.com; s=arc-20160816;
        b=jqL94fqH1dUIUaBpTfYIYLtTUuTcmqqwMTHEE4/ZKpftmyDEl6J12ci9XNs2AE+FAQ
         pDGVqKdk0kBLSeGS5km2tTBQTfTipgO0dcKNrIr7VUJduzqSWnjcZOWas8KWM0r2NZkh
         nTwIBVtp1Kf17VX/nsUgfRmV/b/Pt4FMEHCsIdAfNSuRRAX73tz/T+/ykflo9T3PuITe
         PX5wo1EsYiP0t5xbG94TA6yh5EFI/DWThKXRJx/l0PdkBiod7Gc8W66cZuFjrUgh6I9Z
         yRo0NxBzv7CFfpDRNLrvJ8ByaymuY81AXn8/koo0OhYCNurhEB9FpyBok8iWo2fjEd+D
         LvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=j/kLEkVyo2+5/SMj9Z1tSHz3amvH60WUG/8Fmk/cAyg=;
        b=tmiDz6sVjJfcgKLDD4+pc8Er552qQw08gQJv9ChVuxyNCBJO9zD9sNG9KZL5DXxf7f
         4auIxiovdR93tTi7//puiwab8Yo1Uv9XVivArn1gKd1fow+zXb8jIslqVFYXXKbu3Lzp
         +J0pYFT7Z2tvT2NDyfnbinZr/w4kMvT3IiA9mfR1vNhq88qyXp1X2CyQuYMkhwZsrhsR
         cqCdPgB43Gqnp9j3ccUHBLEzf0QPrqphPoNAZ722S/uW62nexzslIBtL8FO94OuHxA4o
         5mFEWIcu0OMGx26idU5+Q3IrBz3BOa72FGu961x5z8UkV0hntSmWgJcz4x6VVpPjEkDQ
         wGkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.14 34/49] Bluetooth: hci_bcm: Treat Interrupt ACPI resources as always being active-low
Date: Tue, 17 Apr 2018 17:59:13 +0200
Message-Id: <20180417155716.648412181@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155715.032245882@linuxfoundation.org>
References: <20180417155715.032245882@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009883606736978?=
X-GMAIL-MSGID: =?utf-8?q?1598010193169733942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit bb5208b314c5127b716b2ee4f55803a8bb73b750 upstream.

Older devices with a serdev attached bcm bt hci, use an Interrupt ACPI
resource to describe the IRQ (rather then a GpioInt resource).

These device seem to all claim the IRQ is active-high and seem to all need
a DMI quirk to treat it as active-low. Instead simply always assume that
Interrupt resource specified IRQs are always active-low.

This fixes the bt device not being able to wake the host from runtime-
suspend on the: Asus T100TAM, Asus T200TA, Lenovo Yoga2 and the Toshiba
Encore, without the need to add 4 new DMI quirks for these models.

This also allows us to remove 2 DMI quirks for the Asus T100TA and Asus
T100CHI series. Likely the 2 remaining quirks can also be removed but I
could not find a DSDT of these devices to verify this.

Cc: stable@vger.kernel.org
Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=198953
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1554835
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/hci_bcm.c |   20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -694,22 +694,6 @@ static const struct acpi_gpio_mapping ac
 #ifdef CONFIG_ACPI
 /* IRQ polarity of some chipsets are not defined correctly in ACPI table. */
 static const struct dmi_system_id bcm_active_low_irq_dmi_table[] = {
-	{
-		.ident = "Asus T100TA",
-		.matches = {
-			DMI_EXACT_MATCH(DMI_SYS_VENDOR,
-					"ASUSTeK COMPUTER INC."),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
-		},
-	},
-	{
-		.ident = "Asus T100CHI",
-		.matches = {
-			DMI_EXACT_MATCH(DMI_SYS_VENDOR,
-					"ASUSTeK COMPUTER INC."),
-			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100CHI"),
-		},
-	},
 	{	/* Handle ThinkPad 8 tablets with BCM2E55 chipset ACPI ID */
 		.ident = "Lenovo ThinkPad 8",
 		.matches = {
@@ -730,7 +714,9 @@ static int bcm_resource(struct acpi_reso
 	switch (ares->type) {
 	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
 		irq = &ares->data.extended_irq;
-		dev->irq_active_low = irq->polarity == ACPI_ACTIVE_LOW;
+		if (irq->polarity != ACPI_ACTIVE_LOW)
+			dev_info(&dev->pdev->dev, "ACPI Interrupt resource is active-high, this is usually wrong, treating the IRQ as active-low\n");
+		dev->irq_active_low = true;
 		break;
 
 	case ACPI_RESOURCE_TYPE_GPIO:
