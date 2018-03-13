Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu+hMYbxUoz/ve8BE+Z3Vx9KoXRuBGCFR0omb0TohtkWCh1kzpq2Ku0P11USlZ8ibv+BPhb
ARC-Seal: i=1; a=rsa-sha256; t=1520955042; cv=none;
        d=google.com; s=arc-20160816;
        b=sjDZYZnaYFphwGz/CFPFecFKjygL4SCTKsZnl93UAel4KkMSNyIwV9eIUiw64eVwn5
         pVnR0u3HcuUrhmkX//cRFX/6Fj4xFSAxT2+kdET2P2AsT8fWarX3UU2w/10LPmMJLKsR
         XXs7RwvekouHPvZgN3LKxnvYei4ogz8xg6m70RGHk4PB6giKkPHdOXqugXYxUC1M0Jr+
         jVlPt1IA12otzf+eQMF20U+GL/2NsrJFfs0uB+s8iDnA8utJJNtGuJGLC6ydMRaOa4qs
         Em9wtU9rAfCuwtwMggg1yzPCuyr2OhkBoVngzgdS2G7Q8oy+DApHPIGRSNu1NeWy2E3s
         pduQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=9UTvUJI7G0L2x22hVOYtpxs3cD/GRqj6Z3Em7lKPX1E=;
        b=HWynEJWBGng1+zQAj/4aUUOjDGskLUwyJdESPyt7QEK8GkrWpsZUCHEHhqumfnHN2y
         1yFVSV6b/wXeQAQLUDH0vTyoE3FVlCRei1vmns3598W5Ft3LpnS5t/UBPlLXTz7lh+96
         EkRs57aVy6S/kZT21cLLyh69GxzCM2J/QWnfMQ4RF7cTXBQcLIuojrIW/6uHx5bGT9Ow
         Ry/Q58TTpizrR+WoCcw614sxIpS5DzjIcMl7juO/0gjGDXskUDe8V5wC3GULVQEzF1+E
         lQ2n2QzHKJnGljxUlbROuNjr6tmkIjvwDDD0XsIyHMNb6tAbuu/8Ae0HVBrLyz80eKrM
         r/Xw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?Richard=20Sch=C3=BCtz?= <rschuetz@uni-koblenz.de>,
	Arkadiusz Hiler <arkadiusz.hiler@intel.com>,
	Martin Peres <martin.peres@linux.intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.15 045/146] Revert "Input: synaptics - Lenovo Thinkpad T460p devices should use RMI"
Date: Tue, 13 Mar 2018 16:23:32 +0100
Message-Id: <20180313152324.106407771@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836954416460458?=
X-GMAIL-MSGID: =?utf-8?q?1594836954416460458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arkadiusz Hiler <arkadiusz.hiler@intel.com>

commit 5444a992b4a73aa5246a432c482b20b89bce93a5 upstream.

This reverts commit 48282969826b3d3c76e908182f69724d86d995fe which
caused the following issues:

1. On T460p with BIOS version 2.22 touchpad and trackpoint stop working
after suspend-resume cycle. Due to strange state of the device another
suspend is impossible.

The following dmesg errors can be observed:
thinkpad_acpi: EC reports that Thermal Table has changed
rmi4_smbus 7-002c: failed to get SMBus version number!
rmi4_physical rmi4-00: rmi_driver_reset_handler: Failed to read current IRQ mask.
rmi4_f01 rmi4-00.fn01: Failed to restore normal operation: -16.
rmi4_f01 rmi4-00.fn01: Resume failed with code -16.
rmi4_physical rmi4-00: Failed to suspend functions: -16
rmi4_smbus 7-002c: Failed to resume device: -16
PM: resume devices took 0.640 seconds
rmi4_f03 rmi4-00.fn03: rmi_f03_pt_write: Failed to write to F03 TX register (-16).
rmi4_physical rmi4-00: rmi_driver_clear_irq_bits: Failed to change enabled interrupts!
rmi4_physical rmi4-00: rmi_driver_set_irq_bits: Failed to change enabled interrupts!
psmouse: probe of serio3 failed with error -1

2. On another T460p with BIOS version 2.15 two finger scrolling gesture
on the touchpad stops working after suspend-resume cycle (about 75%
reproducibility, when it still works, the scrolling gesture becomes
laggy). Nothing suspicious appears in the dmesg.

Analysis form Richard Schütz:

"RMI is unreliable on the ThinkPad T460p because the device is affected
by the firmware behavior addressed in a7ae81952cda ("i2c: i801: Allow
ACPI SystemIO OpRegion to conflict with PCI BAR")."

The affected devices often show:

i801_smbus 0000:00:1f.4: BIOS is accessing SMBus registers
i801_smbus 0000:00:1f.4: Driver SMBus register access inhibited

Reported-by: Richard Schütz <rschuetz@uni-koblenz.de>
Signed-off-by: Arkadiusz Hiler <arkadiusz.hiler@intel.com>
Tested-by: Martin Peres <martin.peres@linux.intel.com>
Tested-by: Arkadiusz Hiler <arkadiusz.hiler@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -173,7 +173,6 @@ static const char * const smbus_pnp_ids[
 	"LEN0046", /* X250 */
 	"LEN004a", /* W541 */
 	"LEN200f", /* T450s */
-	"LEN2018", /* T460p */
 	NULL
 };
 
