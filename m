Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4971szi5skl4D9Cpa01E0YNJ/n3pACVNHjeuyUf05GokwXqsDjcymgnj80rUX/ubJ0kPITd
ARC-Seal: i=1; a=rsa-sha256; t=1523472561; cv=none;
        d=google.com; s=arc-20160816;
        b=AQb/MCznPUuYFKKqSga6/ahsU6GYf/aAvUeSqbmvsEFPBQZUaeF9IGbxtic4WQqn5G
         eqa66syTcyiymzN6Nziu5SnbpZM847vFJJLPfHIzE3s3/cGgyukjEjlG6CqCpheufBvb
         1cF5uxNt2e6IlXUeh6kSgyvAjXvrhqHZuvSwAsQN2h5QIY5BsCAhtAlb3gxOsR5viVta
         UxH5V+HMq615ZPO98/XsOUpvuBMhnjUIPfRnf2y+JJflvls+mVm0Q7lpFCLFOh0glc6u
         Jaz5f3uRuz+3xjb4PfoKOkYhPtUGPprNv5AqFnw8CvPlTwyA9EOSHBQN71gxiNZf8gMj
         bgBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=t6mpsSjmvihtJGvJNW8rmEZKLuVQe9vSZJWqJbl+PBA=;
        b=P/qLNSLtc5Ul+Z3Yz8BJ3OZA9qYpwDp8yMK3LT/zcIagSdciG2qF4SykVYs27B1sXS
         Pue+BB8cbc/WDU50YNeKL1acEkv5BemnX17jRbf4e22MPomOlgCCmySLsMSj0fgLrhI7
         AeeCwOxCKXu56fYbGLwX6GJOupbWH4NMLMNb9gXEeqauuxg/Zdt8kY8ohFRzuojWlQfV
         RclFoq4cAR8G2nni5xPsADqrTAOrGmA/ba3MgAh4GifW8lyJox01VrSPa5rO0+T5aC2I
         xjBvqYLYt2TxHG1LGLFZt4jA7fT9nx3eeezU+hG3U2mEv8rAFj3DfPMelsMYsU03dpjG
         +sDQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Jani Nikula <jani.nikula@intel.com>,
	Aaron Brown <aaron.f.brown@intel.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 129/190] e1000e: Undo e1000e_pm_freeze if __e1000_shutdown fails
Date: Wed, 11 Apr 2018 20:36:15 +0200
Message-Id: <20180411183559.761248748@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597476249044318227?=
X-GMAIL-MSGID: =?utf-8?q?1597476765167378188?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chris Wilson <chris@chris-wilson.co.uk>


[ Upstream commit 833521ebc65b1c3092e5c0d8a97092f98eec595d ]

An error during suspend (e100e_pm_suspend),

[  429.994338] ACPI : EC: event blocked
[  429.994633] e1000e: EEE TX LPI TIMER: 00000011
[  430.955451] pci_pm_suspend(): e1000e_pm_suspend+0x0/0x30 [e1000e] returns -2
[  430.955454] dpm_run_callback(): pci_pm_suspend+0x0/0x140 returns -2
[  430.955458] PM: Device 0000:00:19.0 failed to suspend async: error -2
[  430.955581] PM: Some devices failed to suspend, or early wake event detected
[  430.957709] ACPI : EC: event unblocked

lead to complete failure:

[  432.585002] ------------[ cut here ]------------
[  432.585013] WARNING: CPU: 3 PID: 8372 at kernel/irq/manage.c:1478 __free_irq+0x9f/0x280
[  432.585015] Trying to free already-free IRQ 20
[  432.585016] Modules linked in: cdc_ncm usbnet x86_pkg_temp_thermal intel_powerclamp coretemp mii crct10dif_pclmul crc32_pclmul ghash_clmulni_intel snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hwdep lpc_ich snd_hda_core snd_pcm mei_me mei sdhci_pci sdhci i915 mmc_core e1000e ptp pps_core prime_numbers
[  432.585042] CPU: 3 PID: 8372 Comm: kworker/u16:40 Tainted: G     U          4.10.0-rc8-CI-Patchwork_3870+ #1
[  432.585044] Hardware name: LENOVO 2356GCG/2356GCG, BIOS G7ET31WW (1.13 ) 07/02/2012
[  432.585050] Workqueue: events_unbound async_run_entry_fn
[  432.585051] Call Trace:
[  432.585058]  dump_stack+0x67/0x92
[  432.585062]  __warn+0xc6/0xe0
[  432.585065]  warn_slowpath_fmt+0x4a/0x50
[  432.585070]  ? _raw_spin_lock_irqsave+0x49/0x60
[  432.585072]  __free_irq+0x9f/0x280
[  432.585075]  free_irq+0x34/0x80
[  432.585089]  e1000_free_irq+0x65/0x70 [e1000e]
[  432.585098]  e1000e_pm_freeze+0x7a/0xb0 [e1000e]
[  432.585106]  e1000e_pm_suspend+0x21/0x30 [e1000e]
[  432.585113]  pci_pm_suspend+0x71/0x140
[  432.585118]  dpm_run_callback+0x6f/0x330
[  432.585122]  ? pci_pm_freeze+0xe0/0xe0
[  432.585125]  __device_suspend+0xea/0x330
[  432.585128]  async_suspend+0x1a/0x90
[  432.585132]  async_run_entry_fn+0x34/0x160
[  432.585137]  process_one_work+0x1f4/0x6d0
[  432.585140]  ? process_one_work+0x16e/0x6d0
[  432.585143]  worker_thread+0x49/0x4a0
[  432.585145]  kthread+0x107/0x140
[  432.585148]  ? process_one_work+0x6d0/0x6d0
[  432.585150]  ? kthread_create_on_node+0x40/0x40
[  432.585154]  ret_from_fork+0x2e/0x40
[  432.585156] ---[ end trace 6712df7f8c4b9124 ]---

The unwind failures stems from commit 2800209994f8 ("e1000e: Refactor PM
flows"), but it may be a later patch that introduced the non-recoverable
behaviour.

Fixes: 2800209994f8 ("e1000e: Refactor PM flows")
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=99847
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/e1000e/netdev.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -6595,12 +6595,17 @@ static int e1000e_pm_thaw(struct device
 static int e1000e_pm_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	int rc;
 
 	e1000e_flush_lpic(pdev);
 
 	e1000e_pm_freeze(dev);
 
-	return __e1000_shutdown(pdev, false);
+	rc = __e1000_shutdown(pdev, false);
+	if (rc)
+		e1000e_pm_thaw(dev);
+
+	return rc;
 }
 
 static int e1000e_pm_resume(struct device *dev)
