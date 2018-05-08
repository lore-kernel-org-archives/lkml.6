Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZppgo7othK3qP8/bzdQYMgi08UIjEFEffDvCi/P8qgyaGSP0/cmlZdDXoy5dXmj8qdal+9m
ARC-Seal: i=1; a=rsa-sha256; t=1525767247; cv=none;
        d=google.com; s=arc-20160816;
        b=iYI8dDRGoDa7qTUjgtcQqb/j0ELCGloCHhDa+gu1CkxE6RCJ6zC/wZ3+LyFWMhQeca
         ghdVmFXtTv5lF4KNwbJb25hnn27jlZRRNjmxrv0NOqvEtzODxmKBpwcRLoQKDOVoEdiS
         NkvyPCqwzGdzshZfn1JY4ebFpvRWeO9S2XpUAgMr0iWcXxTozArWtDKxsfNqC+1Q8ytZ
         VdRuiLw8U5qoZNg+mWEyY9k3xo1/Ruqd9u58OLLnaaU0Hl8R0wIQEgSkAFNF89uD6gdV
         97P/AjUocA603sJx0bxkyXJien99l05fX21OepTJDZtaOFJH5voiYRPN0Ipf6pOVfxwy
         ORfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=0K2T8CRXRGtOqwTH9SSFUswu8JDwjaKxq/VzDEXoTgU=;
        b=0iYZSDn5OGoJOOJYZBPtMD/nmfQginTx1YBWOxlUWxohvzcP8w4U40yTUzUdqthWng
         QOEHXIGg3yoLKoglypxSm3vrdEvTnG7dc2+oUsvZLK/nqktJqUMhZ1RISbv6uKoEYITK
         /r48nSEahHsIpW+IzDzwyYPyG2wIxezMAOK557V4amQZi6uSXz6wbZxs1Abo3lDeZxL1
         7DwHVvhew7N7aPR9C+4rMFJIwAx6vnVehGIcM83sEo+5ADz+4NFF2YSB/jHv+DviFcvR
         Ik55eIHqcpfgns7XSyrzoNrRF5GqNo48pYgt6Tba6VL3y5nr7TqQEYtedDKGW7/FUz3+
         gFnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2MHddzkA;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2MHddzkA;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dun Hum <bitter.taste@gmx.com>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>,
	"Darren Hart (VMware)" <dvhart@infradead.org>
Subject: [PATCH 4.16 43/52] platform/x86: asus-wireless: Fix NULL pointer dereference
Date: Tue,  8 May 2018 10:10:41 +0200
Message-Id: <20180508073934.181954156@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882917093784507?=
X-GMAIL-MSGID: =?utf-8?q?1599882917093784507?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: João Paulo Rechi Vita <jprvita@gmail.com>

commit 9f0a93de9139c2b0a59299cd36b61564522458f8 upstream.

When the module is removed the led workqueue is destroyed in the remove
callback, before the led device is unregistered from the led subsystem.

This leads to a NULL pointer derefence when the led device is
unregistered automatically later as part of the module removal cleanup.
Bellow is the backtrace showing the problem.

  BUG: unable to handle kernel NULL pointer dereference at           (null)
  IP: __queue_work+0x8c/0x410
  PGD 0 P4D 0
  Oops: 0000 [#1] SMP NOPTI
  Modules linked in: ccm edac_mce_amd kvm_amd kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel pcbc aesni_intel aes_x86_64 joydev crypto_simd asus_nb_wmi glue_helper uvcvideo snd_hda_codec_conexant snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel asus_wmi snd_hda_codec cryptd snd_hda_core sparse_keymap videobuf2_vmalloc arc4 videobuf2_memops snd_hwdep input_leds videobuf2_v4l2 ath9k psmouse videobuf2_core videodev ath9k_common snd_pcm ath9k_hw media fam15h_power ath k10temp snd_timer mac80211 i2c_piix4 r8169 mii mac_hid cfg80211 asus_wireless(-) snd soundcore wmi shpchp 8250_dw ip_tables x_tables amdkfd amd_iommu_v2 amdgpu radeon chash i2c_algo_bit drm_kms_helper syscopyarea serio_raw sysfillrect sysimgblt fb_sys_fops ahci ttm libahci drm video
  CPU: 3 PID: 2177 Comm: rmmod Not tainted 4.15.0-5-generic #6+dev94.b4287e5bem1-Endless
  Hardware name: ASUSTeK COMPUTER INC. X555DG/X555DG, BIOS 5.011 05/05/2015
  RIP: 0010:__queue_work+0x8c/0x410
  RSP: 0018:ffffbe8cc249fcd8 EFLAGS: 00010086
  RAX: ffff992ac6810800 RBX: 0000000000000000 RCX: 0000000000000008
  RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff992ac6400e18
  RBP: ffffbe8cc249fd18 R08: ffff992ac6400db0 R09: 0000000000000000
  R10: 0000000000000040 R11: ffff992ac6400dd8 R12: 0000000000002000
  R13: ffff992abd762e00 R14: ffff992abd763e38 R15: 000000000001ebe0
  FS:  00007f318203e700(0000) GS:ffff992aced80000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000000 CR3: 00000001c720e000 CR4: 00000000001406e0
  Call Trace:
   queue_work_on+0x38/0x40
   led_state_set+0x2c/0x40 [asus_wireless]
   led_set_brightness_nopm+0x14/0x40
   led_set_brightness+0x37/0x60
   led_trigger_set+0xfc/0x1d0
   led_classdev_unregister+0x32/0xd0
   devm_led_classdev_release+0x11/0x20
   release_nodes+0x109/0x1f0
   devres_release_all+0x3c/0x50
   device_release_driver_internal+0x16d/0x220
   driver_detach+0x3f/0x80
   bus_remove_driver+0x55/0xd0
   driver_unregister+0x2c/0x40
   acpi_bus_unregister_driver+0x15/0x20
   asus_wireless_driver_exit+0x10/0xb7c [asus_wireless]
   SyS_delete_module+0x1da/0x2b0
   entry_SYSCALL_64_fastpath+0x24/0x87
  RIP: 0033:0x7f3181b65fd7
  RSP: 002b:00007ffe74bcbe18 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3181b65fd7
  RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000555ea2559258
  RBP: 0000555ea25591f0 R08: 00007ffe74bcad91 R09: 000000000000000a
  R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000003
  R13: 00007ffe74bcae00 R14: 0000000000000000 R15: 0000555ea25591f0
  Code: 01 00 00 02 0f 85 7d 01 00 00 48 63 45 d4 48 c7 c6 00 f4 fa 87 49 8b 9d 08 01 00 00 48 03 1c c6 4c 89 f7 e8 87 fb ff ff 48 85 c0 <48> 8b 3b 0f 84 c5 01 00 00 48 39 f8 0f 84 bc 01 00 00 48 89 c7
  RIP: __queue_work+0x8c/0x410 RSP: ffffbe8cc249fcd8
  CR2: 0000000000000000
  ---[ end trace 7aa4f4a232e9c39c ]---

Unregistering the led device on the remove callback before destroying the
workqueue avoids this problem.

https://bugzilla.kernel.org/show_bug.cgi?id=196097

Reported-by: Dun Hum <bitter.taste@gmx.com>
Cc: stable@vger.kernel.org
Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/asus-wireless.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/platform/x86/asus-wireless.c
+++ b/drivers/platform/x86/asus-wireless.c
@@ -178,8 +178,10 @@ static int asus_wireless_remove(struct a
 {
 	struct asus_wireless_data *data = acpi_driver_data(adev);
 
-	if (data->wq)
+	if (data->wq) {
+		devm_led_classdev_unregister(&adev->dev, &data->led);
 		destroy_workqueue(data->wq);
+	}
 	return 0;
 }
 
