Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr2W2Vqu2rldvdNpQF00q1iSKh0wi7Jj5a1esgKEjT9owyaoack/G7XVlesuThaDO5bm/FR
ARC-Seal: i=1; a=rsa-sha256; t=1525116504; cv=none;
        d=google.com; s=arc-20160816;
        b=khxylcKWUkfRGQknDCJMXn4msrMpMC7onOP4BSMyS2bzgpwb+Osj2Xl66EOs9omewA
         M5prv3rMwnbdhe4OOOglXl626m+EwOvWyZYQmRGzHiwCjaw05W8bIjJws/ezb84d4NG8
         oc9Yg0duOD9btd52Q4dGvfsVd22hl33rZmjxZObx1G9yO6/eg435yOrHe5ktHokxpf2I
         jqKl7SX5m0xa4iPLcYkKBGTk1V3WAksFACFH3nW2QQ8J/wm6LuSPgk/+RJGIPLduj/g+
         siM9sT+vW4OYJOfxTT3loKn1SyQjl8ANfKHW4uMkNyKQJ9Wm/Tf7Jv/kg7KiwGablZAU
         dH2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=0VSnxZj37jTCBhV0gp6dKi6APap8vQLqnLEpU7Hf8aI=;
        b=fl3x+Mmip4DVIUIqxUmjlyPXt3KISkJXYyg8mU/LD8KfxC55uyiikgfUnHo9K5RAD+
         eB/kTkHRDiG88rMu9vV3QvhdZzCciivbf0j7uPUqFA0Vz+ChUePrz8/uHAPPe28djwfI
         3rukmOJqfNDvqj+THyZN2ZjbMT5hN0p9qDzbOHCyRLZt8OKKO1DPIiH+dOJSY3HFdji9
         t/WKUWoVw27VVzWXcgcPuHBIsrxADC9E0xfyTURh7l/EiKfDYHN1U9A4TGMkY8iiW8PN
         yg1ZW2YzJrw/+/EsY2sh4Pxu1DmRU7q9z009KK1TItQ42oCme+s5Oin4ZwpB9uzGpSD7
         BErQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11D122DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH 4.16 059/113] mtd: rawnand: marvell: fix the chip-select DT parsing logic
Date: Mon, 30 Apr 2018 12:24:30 -0700
Message-Id: <20180430184017.550066346@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200563520704799?=
X-GMAIL-MSGID: =?utf-8?q?1599200563520704799?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit f6997bec6af43396ff530caee79e178d32774a49 upstream.

The block responsible of parsing the DT for the number of chip-select
lines uses an 'if/else if/else if' block. The content of the second and
third 'else if' conditions are:
        1/ the actual condition to enter the sub-block and
        2/ the operation to do in this sub-block.

        [...]
        else if (condition1_to_enter && action1() == failed)
                raise_error();
        else if (condition2_to_enter && action2() == failed)
                raise_error();
        [...]

In case of failure, the sub-block is entered and an error raised.
Otherwise, in case of success, the code would continue erroneously in
the next 'else if' statement because it did not failed (and did not
enter the first 'else if' sub-block).

The first 'else if' refers to legacy bindings while the second 'else if'
refers to new bindings. The second 'else if', which is entered
erroneously, checks for the 'reg' property, which, for old bindings,
does not mean anything because it would not be the number of CS
available, but the regular register map of almost any DT node. This
being said, the content of the 'reg' property being the register map
offset and length, it has '2' values, so the number of CS in this
situation is assumed to be '2'.

When running nand_scan_ident() with 2 CS, the core will check for an
array of chips. It will first issue a RESET and then a READ_ID. Of
course this will trigger two timeouts because there is no chip in front
of the second CS:

[    1.367460] marvell-nfc f2720000.nand: Timeout on CMDD (NDSR: 0x00000080)
[    1.474292] marvell-nfc f2720000.nand: Timeout on CMDD (NDSR: 0x00000280)

Indeed, this is harmless and the core will then assume there is only one
valid CS.

Fix the logic in the whole block by entering each sub-block just on the
'is legacy' condition, doing the action inside the sub-block. This way,
when the action succeeds, the whole block is left.

Furthermore, for both the old bindings and the new bindings the same
logic was applied to retrieve the number of CS lines:
using of_get_property() to get a size in bytes, converted in the actual
number of lines by dividing it per sizeof(u32) (4 bytes).

This is fine for the 'reg' property which is a list of the CS IDs but
not for the 'num-cs' property which is directly the value of the number
of CS.

Anyway, no existing DT uses another value than 'num-cs = <1>' and no
other value has ever been supported by the old driver (pxa3xx_nand.c).
Remove this condition and apply a number of 1 CS anyway, as already
described in the bindings.

Finally, the 'reg' property of a 'nand' node (with the new bindings)
gives the IDs of each CS line in use. marvell_nand.c driver first look
at the number of CS lines that are present in this property.

Better use of_property_count_elems_of_size() than dividing by 4 the size
of the number of bytes returned by of_get_property().

Fixes: 02f26ecf8c772 ("mtd: nand: add reworked Marvell NAND controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Tested-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/nand/marvell_nand.c |   25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

--- a/drivers/mtd/nand/marvell_nand.c
+++ b/drivers/mtd/nand/marvell_nand.c
@@ -2277,29 +2277,20 @@ static int marvell_nand_chip_init(struct
 	/*
 	 * The legacy "num-cs" property indicates the number of CS on the only
 	 * chip connected to the controller (legacy bindings does not support
-	 * more than one chip). CS are only incremented one by one while the RB
-	 * pin is always the #0.
+	 * more than one chip). The CS and RB pins are always the #0.
 	 *
 	 * When not using legacy bindings, a couple of "reg" and "nand-rb"
 	 * properties must be filled. For each chip, expressed as a subnode,
 	 * "reg" points to the CS lines and "nand-rb" to the RB line.
 	 */
-	if (pdata) {
+	if (pdata || nfc->caps->legacy_of_bindings) {
 		nsels = 1;
-	} else if (nfc->caps->legacy_of_bindings &&
-		   !of_get_property(np, "num-cs", &nsels)) {
-		dev_err(dev, "missing num-cs property\n");
-		return -EINVAL;
-	} else if (!of_get_property(np, "reg", &nsels)) {
-		dev_err(dev, "missing reg property\n");
-		return -EINVAL;
-	}
-
-	if (!pdata)
-		nsels /= sizeof(u32);
-	if (!nsels) {
-		dev_err(dev, "invalid reg property size\n");
-		return -EINVAL;
+	} else {
+		nsels = of_property_count_elems_of_size(np, "reg", sizeof(u32));
+		if (nsels <= 0) {
+			dev_err(dev, "missing/invalid reg property\n");
+			return -EINVAL;
+		}
 	}
 
 	/* Alloc the nand chip structure */
