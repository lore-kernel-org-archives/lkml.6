Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226Om/nPCEB0xo0HW09jivu0fXliQ7HddccUywOOHP9jkTkldKvhCkwBR5IENZELFJLbHuQi
ARC-Seal: i=1; a=rsa-sha256; t=1519412161; cv=none;
        d=google.com; s=arc-20160816;
        b=vrbSAkem28Cnv16KkZMSeAxNC5jJDQWxYsV2eupQKibSfATYl3fhq0iFmp+ec7HOxC
         +WUqsR4n5jfYVhB2S0B1YXs2zN0OnR/TvhUTWs8EqU2gX/sWsi0WJfHIVqsSwYEH8pBn
         X4U6yM4XB1T1LB5V2SFV/kKv+7+zXtit/oKQFaVdECjtP9HdQy8o2PHtL8ZmSHi8LaOb
         rLSKhgbw0g8Axv8XifP61/UdIZZpcCnIPg394lXEjOINqHUQ8CbfQ2W6tutpKib1hrtN
         Ho6sE2DzXcTV4gnPwdMpQCibEx50tC6cEmTAE47Z/8rVz6ur+CO7TXzw1yNFWLYjIeJ6
         PgGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+KtrPfJXN3F97T5cu2xYyQxxUENcRIDK74O4zeLwl/Y=;
        b=qBBuk8sipFxCNKlBe+fwVJz40wOluC34XLZ6Z/CzQ3RADYJ0oGRLr4DqgUfMeZUiVh
         GKEdjzBA/qJHnY34uCalAImtBZ/nhs5PrJMYXgwOwhWwaZgUBdppX8JeLCfAwT8Ojvmy
         6csjq0vPnH0ViJvmDJpM2IedBDckqchPRD4NHDANoij1UcRDWRF+JLI09DRFoXw83kAA
         tZ3zfuoe2EuqWMsVAWbY+tqX0aRfbaOr7fSxiEAUeAsq/2WLa5R17Lnb2Whdw4MHV7+R
         IMSvJEJ3N54F1FH2/2uO1BAKwWOGpLuXyunr0160DJPvk7AGOAqx+KHp3FpDcAgTrHDI
         et9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Vincent Pelletier <plr.vincent@gmail.com>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 145/159] usb: dwc3: gadget: Wait longer for controller to end command processing
Date: Fri, 23 Feb 2018 19:27:33 +0100
Message-Id: <20180223170800.513003727@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218486878662828?=
X-GMAIL-MSGID: =?utf-8?q?1593219126784725626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Pelletier <plr.vincent@gmail.com>


[ Upstream commit 8722e095f5a44d0e409e45c5ddc2ee9cf589c777 ]

DWC3_DEPCMD_ENDTRANSFER has been witnessed to require around 600 iterations
before controller would become idle again after unplugging the USB cable
with AIO reads submitted.
Bump timeout from 500 iterations to 1000 so dwc3_stop_active_transfer does
not receive -ETIMEDOUT and does not WARN:

[   81.326273] ------------[ cut here ]------------
[   81.335341] WARNING: CPU: 0 PID: 1874 at drivers/usb/dwc3/gadget.c:2627 dwc3_stop_active_transfer.constprop.23+0x69/0xc0 [dwc3]
[   81.347094] Modules linked in: usb_f_fs libcomposite configfs bnep btsdio bluetooth ecdh_generic brcmfmac brcmutil dwc3 intel_powerclamp coretemp ulpi kvm_intel udc_core kvm irqbypass crc32_pclmul crc32c_intel pcbc dwc3_pci aesni_intel aes_i586 crypto_simd cryptd ehci_pci ehci_hcd basincove_gpadc industrialio gpio_keys usbcore usb_common
[   81.378142] CPU: 0 PID: 1874 Comm: irq/34-dwc3 Not tainted 4.14.0-edison+ #119
[   81.385545] Hardware name: Intel Corporation Merrifield/BODEGA BAY, BIOS 542 2015.01.21:18.19.48
[   81.394548] task: f5b1be00 task.stack: f420a000
[   81.399219] EIP: dwc3_stop_active_transfer.constprop.23+0x69/0xc0 [dwc3]
[   81.406086] EFLAGS: 00010086 CPU: 0
[   81.409672] EAX: 0000001f EBX: f5729800 ECX: c132a2a2 EDX: 00000000
[   81.416096] ESI: f4054014 EDI: f41cf400 EBP: f420be10 ESP: f420bdf4
[   81.422521]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[   81.428061] CR0: 80050033 CR2: b7a3f000 CR3: 01d94000 CR4: 001006d0
[   81.434483] Call Trace:
[   81.437063]  __dwc3_gadget_ep_disable+0xa3/0x2b0 [dwc3]
[   81.442438]  ? _raw_spin_lock_irqsave+0x32/0x40
[   81.447135]  dwc3_gadget_ep_disable+0xbf/0xe0 [dwc3]
[   81.452269]  usb_ep_disable+0x1c/0xd0 [udc_core]
[   81.457048]  ffs_func_eps_disable.isra.15+0x3b/0x90 [usb_f_fs]
[   81.463070]  ffs_func_set_alt+0x7d/0x310 [usb_f_fs]
[   81.468132]  ffs_func_disable+0x14/0x20 [usb_f_fs]
[   81.473075]  reset_config+0x5b/0x90 [libcomposite]
[   81.478023]  composite_disconnect+0x2b/0x50 [libcomposite]
[   81.483685]  dwc3_disconnect_gadget+0x39/0x50 [dwc3]
[   81.488808]  dwc3_gadget_disconnect_interrupt+0x21b/0x250 [dwc3]
[   81.495014]  dwc3_thread_interrupt+0x2a8/0xf70 [dwc3]
[   81.500219]  ? __schedule+0x78c/0x7e0
[   81.504027]  irq_thread_fn+0x18/0x30
[   81.507715]  ? irq_thread+0xb7/0x180
[   81.511400]  irq_thread+0x111/0x180
[   81.515000]  ? irq_finalize_oneshot+0xe0/0xe0
[   81.519490]  ? wake_threads_waitq+0x30/0x30
[   81.523806]  kthread+0x107/0x110
[   81.527131]  ? disable_percpu_irq+0x50/0x50
[   81.531439]  ? kthread_stop+0x150/0x150
[   81.535397]  ret_from_fork+0x19/0x24
[   81.539136] Code: 89 d8 c7 45 ec 00 00 00 00 c7 45 f0 00 00 00 00 c7 45 f4 00 00 00 00 e8 56 ef ff ff 85 c0 74 12 50 68 b9 1c 14 f8 e8 64 0f f7 c8 <0f> ff 58 5a 8d 76 00 8b 83 98 00 00 00 c6 83 a0 00 00 00 00 83
[   81.559295] ---[ end trace f3133eec81a473b8 ]---

Number of iterations measured on 4 consecutive unplugs:
[ 1088.799777] dwc3_send_gadget_ep_cmd(cmd=331016, params={0, 0, 0}) iterated 605 times
[ 1222.024986] dwc3_send_gadget_ep_cmd(cmd=331016, params={0, 0, 0}) iterated 580 times
[ 1317.590452] dwc3_send_gadget_ep_cmd(cmd=331016, params={0, 0, 0}) iterated 598 times
[ 1453.218314] dwc3_send_gadget_ep_cmd(cmd=331016, params={0, 0, 0}) iterated 594 times

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/gadget.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -267,7 +267,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_
 {
 	const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
 	struct dwc3		*dwc = dep->dwc;
-	u32			timeout = 500;
+	u32			timeout = 1000;
 	u32			reg;
 
 	int			cmd_status = 0;
