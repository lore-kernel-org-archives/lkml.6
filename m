Return-Path: <oneukum@suse.com>
X-Google-Smtp-Source: AH8x227fWN5OSMh8cQicz6Tlf7bHr07uBxRinhJ9pSZloPWWThXRNrkfSZE/RH1uFmMZthZRYGBh
ARC-Seal: i=1; a=rsa-sha256; t=1518516767; cv=none;
        d=google.com; s=arc-20160816;
        b=Il47KvEDRhS6UU9CZ6a+aDClwNziDBC5aRLRjTeu2maGja8PD0AR0EOhLW9H6Vycdc
         ZJ4bOqEiJSSx51uctB9LHxsY5B4Uo1DKO8vv1yw9/PXSARq97K1ZjF0EHLF3MWPq/EaF
         diX2Q3d5wJCdlBS2Zb52Sau4ZkvEfN9MEYLYXuPy0bEjaLj3iQpwjKEvY5Z7bWJzAr3a
         ++gxoUQ7UHzEkOihmydh1OU+oBm5V1bCCGc1aMb1244I+pfQoTe5gyJm7Fbe50IBKzM2
         dkIGLd2iEe+Gi8+RX/O2J4dErpnhvMWhuHXqj1v6UTR5p3T3B20EjRvbkdQOonpOV9BS
         HReA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=8AV4PNHFR0JhBJgVRILczxrUlz1URBNVnY3bDG6Sg7E=;
        b=GQSUKsHPN5t785Se4JlD6d2VtDsC1S94AxkpMRFYt9sb/1HW8krelHVgkajKU6eidn
         EKpJdsqx++b5/zQldCxf2lKTzV0a2lbJKnvyKszZuZMQVYsynLryYHXJjCTNmLq3H4Zt
         JlXD7iRS5EGCf4YZE7JfXLF43Mcmswd9LleqJwwO062qCpuS9gxd8p0jwwT6oWtJ+fFm
         LkI5r7D2ChoSmWZeGmCUsCltA2Ke9yejDCCN9MuZ36XWk0cnU3idBY5J+Q83aYSbZplf
         JzBQoiPo8lkcCj2l73iXC1mH7MBwSSCh62GjD8cjyqqjXyK+5W/bWir++2fVbZM71teX
         VPng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of oneukum@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=oneukum@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of oneukum@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=oneukum@suse.com
Message-ID: <1518516440.4584.4.camel@suse.com>
Subject: Re: [PATCH v1 1/1] usb: cdc_acm: prevent race at write to acm while
 system resumes
From: Oliver Neukum <oneukum@suse.com>
To: sathyanarayan.kuppuswamy@linux.intel.com, felipe.balbi@intel.com,
	heikki.krogerus@intel.com, gregkh@linuxfoundation.org
Cc: Dominik Bozek <dominikx.bozek@intel.com>, Sathyanarayanan Kuppuswamy
	 <sathyanarayanan.kuppuswamy@intel.com>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Date: Tue, 13 Feb 2018 11:07:20 +0100
In-Reply-To: <1518466503-36918-1-git-send-email-sathyanarayan.kuppuswamy@linux.intel.com>
References: <1518466503-36918-1-git-send-email-sathyanarayan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592227538406824462?=
X-GMAIL-MSGID: =?utf-8?q?1592280237828286847?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Montag, den 12.02.2018, 12:15 -0800 schrieb
sathyanarayan.kuppuswamy@linux.intel.com:
> From: Dominik Bozek <dominikx.bozek@intel.com>
> 
> ACM driver may accept data to transmit while system is not fully
> resumed. In this case ACM driver buffers data and prepare URBs
> on usb anchor list.
> There is a little chance that two tasks put a char and initiate
> acm_tty_flush_chars(). In such a case, driver will put one URB
> twice on usb anchor list.
> This patch also reset length of data before resue of a buffer.
> This not only prevent sending rubbish, but also lower risc of race.
> 
> Without this patch we hit following kernel panic in one of our
> stabilty/stress tests.
> 
> [   46.884442] *list_add double add*: new=ffff9b2ab7289330, prev=ffff9b2ab7289330, next=ffff9b2ab81e28e0.
> [   46.884476] Modules linked in: hci_uart btbcm bluetooth rfkill_gpio igb_avb(O) cfg80211 snd_soc_sst_bxt_tdf8532 snd_soc_skl snd_soc_skl_ipc snd_soc_sst_ipc snd_soc_sst_dsp snd_soc_sst_acpi snd_soc_sst_match snd_hda_ext_core snd_hda_core trusty_timer trusty_wall trusty_log trusty_virtio trusty_ipc trusty_mem trusty_irq trusty virtio_ring virtio intel_ipu4_mmu_bxtB0 lib2600_mod_bxtB0 intel_ipu4_isys_mod_bxtB0 lib2600psys_mod_bxtB0 intel_ipu4_psys_mod_bxtB0 intel_ipu4_mod_bxtB0 intel_ipu4_wrapper_bxtB0 intel_ipu4_acpi videobuf2_dma_contig as3638 dw9714 lm3643 crlmodule smiapp smiapp_pll
> [   46.884480] CPU: 1 PID: 33 Comm: kworker/u8:1 Tainted: G     U  W  O    4.9.56-quilt-2e5dc0ac-g618ed69ced6e-dirty #4
> [   46.884489] Workqueue: events_unbound flush_to_ldisc
> [   46.884494]  ffffb98ac012bb08 ffffffffad3e82e5 ffffb98ac012bb58 0000000000000000
> [   46.884497]  ffffb98ac012bb48 ffffffffad0a23d1 00000024ad6374dd ffff9b2ab7289330
> [   46.884500]  ffff9b2ab81e28e0 ffff9b2ab7289330 0000000000000002 0000000000000000
> [   46.884501] Call Trace:
> [   46.884507]  [<ffffffffad3e82e5>] dump_stack+0x67/0x92
> [   46.884511]  [<ffffffffad0a23d1>] __warn+0xd1/0xf0
> [   46.884513]  [<ffffffffad0a244f>] warn_slowpath_fmt+0x5f/0x80
> [   46.884516]  [<ffffffffad407443>] __list_add+0xb3/0xc0
> [   46.884521]  [<ffffffffad71133c>] *usb_anchor_urb*+0x4c/0xa0
> [   46.884524]  [<ffffffffad782c6f>] *acm_tty_flush_chars*+0x8f/0xb0
> [   46.884527]  [<ffffffffad782cd1>] *acm_tty_put_char*+0x41/0x100
> [   46.884530]  [<ffffffffad4ced34>] tty_put_char+0x24/0x40
> [   46.884533]  [<ffffffffad4d3bf5>] do_output_char+0xa5/0x200
> [   46.884535]  [<ffffffffad4d3e98>] __process_echoes+0x148/0x290
> [   46.884538]  [<ffffffffad4d654c>] n_tty_receive_buf_common+0x57c/0xb00
> [   46.884541]  [<ffffffffad4d6ae4>] n_tty_receive_buf2+0x14/0x20
> [   46.884543]  [<ffffffffad4d9662>] tty_ldisc_receive_buf+0x22/0x50
> [   46.884545]  [<ffffffffad4d9c05>] flush_to_ldisc+0xc5/0xe0
> [   46.884549]  [<ffffffffad0bcfe8>] process_one_work+0x148/0x440
> [   46.884551]  [<ffffffffad0bdc19>] worker_thread+0x69/0x4a0
> [   46.884554]  [<ffffffffad0bdbb0>] ? max_active_store+0x80/0x80
> [   46.884556]  [<ffffffffad0c2e10>] kthread+0x110/0x130
> [   46.884559]  [<ffffffffad0c2d00>] ? kthread_park+0x60/0x60
> [   46.884563]  [<ffffffffadad9917>] ret_from_fork+0x27/0x40
> [   46.884566] ---[ end trace 3bd599058b8a9eb3 ]---
> 
> Signed-off-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>
Acked-by: Oliver Neukum <oneukum@suse.com>
