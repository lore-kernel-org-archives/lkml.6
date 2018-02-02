Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225OWQ+S0T+DxJnICYy54p+u50WAxhM5qMHpBCVGmNRTkxDK2nAb1na5ODbwXfGpb93m+Lna
ARC-Seal: i=1; a=rsa-sha256; t=1517590809; cv=none;
        d=google.com; s=arc-20160816;
        b=TX2+ayb8KmFr3VD6BEeXf24haiLN4cPlyHlcRKsghSKETeV5dgv3ArEL3bqGnLIwoC
         RimYfYExqbNZOQlrGoqWLVnryvi9zrLbuE1sD+yfjixVDyEhKWGgEUVaOwMg89nUjTXF
         f7xS3M9yWIBQD55YelO/bq1VqO84yr5ZQ5nN6YF6XpNrSGF4XV8ANzUHwQPi2NryL9p5
         dUyYHIx4AxAS1udxWXOhOPW+68kiFyScIhVlB/xDn6HR3FoSss7z9O7WUoFLOD9HNRpo
         TpjmOHjZE26Ifozguc6+TvKcKRgOYRP24WfHAo2uYjFzV0J+eoB0cyYk4ZO/TfqAr0yv
         VD3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=P0vib6aXEizzypfBhuB7S2Wk0JzMnttgjXttoRTvtlo=;
        b=UShFIDQMPWy22huCvsxwlELwNSKBeR70kRtX4cJRJp1NzlKGeFbN8MZXkCjd7QXQW7
         GkZTgPGSPboPzMS/S3kJu9dautMdEQayZhaoTfcM3l4oXuc8OnvnhTGtHsyP1fJMCTTM
         WAdanZ6wydz15HVy8q651JJM0FB0o14VJNnc4gOxCHY9bp8HmUe0kbACLaCseDcuGEHt
         CpGIyRFX7fGdvDLl+2VCT95OhaTl0A58V9C85PRuQH2a4XZ2RH/JiyCgKM0g+QNNd9Rn
         Yhze/oUYz32nzaHkQMw204/7IkH6kVRicY6a9rI+hlcl6b3gEJ9sEmCprDghOrBMACdp
         65WQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Lyude Paul <lyude@redhat.com>,
	Todd Fujinaka <todd.fujinaka@intel.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Aaron Brown <aaron.f.brown@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: [PATCH 4.4 20/67] igb: Free IRQs when device is hotplugged
Date: Fri,  2 Feb 2018 17:57:49 +0100
Message-Id: <20180202140817.545607926@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309300461042817?=
X-GMAIL-MSGID: =?utf-8?q?1591309300461042817?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 888f22931478a05bc81ceb7295c626e1292bf0ed upstream.

Recently I got a Caldigit TS3 Thunderbolt 3 dock, and noticed that upon
hotplugging my kernel would immediately crash due to igb:

[  680.825801] kernel BUG at drivers/pci/msi.c:352!
[  680.828388] invalid opcode: 0000 [#1] SMP
[  680.829194] Modules linked in: igb(O) thunderbolt i2c_algo_bit joydev vfat fat btusb btrtl btbcm btintel bluetooth ecdh_generic hp_wmi sparse_keymap rfkill wmi_bmof iTCO_wdt intel_rapl x86_pkg_temp_thermal coretemp crc32_pclmul snd_pcm rtsx_pci_ms mei_me snd_timer memstick snd pcspkr mei soundcore i2c_i801 tpm_tis psmouse shpchp wmi tpm_tis_core tpm video hp_wireless acpi_pad rtsx_pci_sdmmc mmc_core crc32c_intel serio_raw rtsx_pci mfd_core xhci_pci xhci_hcd i2c_hid i2c_core [last unloaded: igb]
[  680.831085] CPU: 1 PID: 78 Comm: kworker/u16:1 Tainted: G           O     4.15.0-rc3Lyude-Test+ #6
[  680.831596] Hardware name: HP HP ZBook Studio G4/826B, BIOS P71 Ver. 01.03 06/09/2017
[  680.832168] Workqueue: kacpi_hotplug acpi_hotplug_work_fn
[  680.832687] RIP: 0010:free_msi_irqs+0x180/0x1b0
[  680.833271] RSP: 0018:ffffc9000030fbf0 EFLAGS: 00010286
[  680.833761] RAX: ffff8803405f9c00 RBX: ffff88033e3d2e40 RCX: 000000000000002c
[  680.834278] RDX: 0000000000000000 RSI: 00000000000000ac RDI: ffff880340be2178
[  680.834832] RBP: 0000000000000000 R08: ffff880340be1ff0 R09: ffff8803405f9c00
[  680.835342] R10: 0000000000000000 R11: 0000000000000040 R12: ffff88033d63a298
[  680.835822] R13: ffff88033d63a000 R14: 0000000000000060 R15: ffff880341959000
[  680.836332] FS:  0000000000000000(0000) GS:ffff88034f440000(0000) knlGS:0000000000000000
[  680.836817] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  680.837360] CR2: 000055e64044afdf CR3: 0000000001c09002 CR4: 00000000003606e0
[  680.837954] Call Trace:
[  680.838853]  pci_disable_msix+0xce/0xf0
[  680.839616]  igb_reset_interrupt_capability+0x5d/0x60 [igb]
[  680.840278]  igb_remove+0x9d/0x110 [igb]
[  680.840764]  pci_device_remove+0x36/0xb0
[  680.841279]  device_release_driver_internal+0x157/0x220
[  680.841739]  pci_stop_bus_device+0x7d/0xa0
[  680.842255]  pci_stop_bus_device+0x2b/0xa0
[  680.842722]  pci_stop_bus_device+0x3d/0xa0
[  680.843189]  pci_stop_and_remove_bus_device+0xe/0x20
[  680.843627]  trim_stale_devices+0xf3/0x140
[  680.844086]  trim_stale_devices+0x94/0x140
[  680.844532]  trim_stale_devices+0xa6/0x140
[  680.845031]  ? get_slot_status+0x90/0xc0
[  680.845536]  acpiphp_check_bridge.part.5+0xfe/0x140
[  680.846021]  acpiphp_hotplug_notify+0x175/0x200
[  680.846581]  ? free_bridge+0x100/0x100
[  680.847113]  acpi_device_hotplug+0x8a/0x490
[  680.847535]  acpi_hotplug_work_fn+0x1a/0x30
[  680.848076]  process_one_work+0x182/0x3a0
[  680.848543]  worker_thread+0x2e/0x380
[  680.848963]  ? process_one_work+0x3a0/0x3a0
[  680.849373]  kthread+0x111/0x130
[  680.849776]  ? kthread_create_worker_on_cpu+0x50/0x50
[  680.850188]  ret_from_fork+0x1f/0x30
[  680.850601] Code: 43 14 85 c0 0f 84 d5 fe ff ff 31 ed eb 0f 83 c5 01 39 6b 14 0f 86 c5 fe ff ff 8b 7b 10 01 ef e8 b7 e4 d2 ff 48 83 78 70 00 74 e3 <0f> 0b 49 8d b5 a0 00 00 00 e8 62 6f d3 ff e9 c7 fe ff ff 48 8b
[  680.851497] RIP: free_msi_irqs+0x180/0x1b0 RSP: ffffc9000030fbf0

As it turns out, normally the freeing of IRQs that would fix this is called
inside of the scope of __igb_close(). However, since the device is
already gone by the point we try to unregister the netdevice from the
driver due to a hotplug we end up seeing that the netif isn't present
and thus, forget to free any of the device IRQs.

So: make sure that if we're in the process of dismantling the netdev, we
always allow __igb_close() to be called so that IRQs may be freed
normally. Additionally, only allow igb_close() to be called from
__igb_close() if it hasn't already been called for the given adapter.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: 9474933caf21 ("igb: close/suspend race in netif_device_detach")
Cc: Todd Fujinaka <todd.fujinaka@intel.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/igb/igb_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3174,7 +3174,7 @@ static int __igb_close(struct net_device
 
 static int igb_close(struct net_device *netdev)
 {
-	if (netif_device_present(netdev))
+	if (netif_device_present(netdev) || netdev->dismantle)
 		return __igb_close(netdev, false);
 	return 0;
 }
