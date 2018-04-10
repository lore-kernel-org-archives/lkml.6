Return-Path: <minchan.kim@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523341373; cv=none;
        d=google.com; s=arc-20160816;
        b=p+TnSr8/PwWSAnI2rxgYGN99fv0EadUp1qRQW1Z30M0GliAl5s3hritKz9f4nH0HzX
         4HKwBkhZoOvWce7EVnN46sBHEt4iDsnCrtuH1Dxn40yFBIsJyY2Ws2oY1K0WnBuGRTAQ
         fSbNMnNvaDipkELFjTW2o4d932CGyoRNTj46F0vGpwiws4dI5FtYCdEx4RjZoRJngXBV
         YUce9mLkeHHsJCNCeaotD/u+NtBv8CexHknkmwt20MPwkqIvny8f8FOzoEqB0Y4ZqOJv
         RVYgkXSmr/xeVca9eDm35wSSmM3ULSevkrNSrvtCB0bj25IcFS1/kq+5LDEo4aJ9PHpK
         TnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=3Cl0YF2X+s0cWOAAkVhffMS1OsSTiBzr00CyDM6z7A0=;
        b=M6cLZ3l3fnrYKy137IJn8JrBHQFGUoNdpvqhctNMlgJUnSZ0B+2PXFGaGDPzpJ94Yx
         0+hw8itvWVi3hSVGY8XXNgGrDIiV7aNFd5EjCAvNKqQj9SHhy0SL1Mp5R36zsavqm/As
         IpB4VsPiUMLv+4Z/RUuVRad+F6OWTvN8wLQdKt6stAsHrV8z6JHY98E0bD2x3xYUS+xx
         P0no01V4LsmLOmitRJZ+w22Tv+nImbasJBJMTWz+c993rNKPq5v03Fo/k9f/VFvIwW8X
         4DeOxEn60oll0webHGf4206BHo+V342Kzrr8jO6VTLFqhiKCox01ZIoVEF/BZYMLmSiK
         Rc9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sUM+kMjo;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sUM+kMjo;
       spf=pass (google.com: domain of minchan.kim@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=minchan.kim@gmail.com
X-Google-Smtp-Source: AIpwx49LUtSPgBxLuKSEocDH5O1Nf7SvKL2u9qwAsLV61QM7lwoU2hayfz8bfyw/sBJ9JgSm5AW7Ag==
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Tue, 10 Apr 2018 15:22:48 +0900
From: Minchan Kim <minchan@kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 4/4] zram: introduce zram memory tracking
Message-ID: <20180410062248.GC38000@rodete-desktop-imager.corp.google.com>
References: <20180409055435.135695-1-minchan@kernel.org>
 <20180409055435.135695-5-minchan@kernel.org>
 <20180410000305.GA6942@jagdpanzerIV>
 <20180410004109.GA1580@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410004109.GA1580@jagdpanzerIV>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597246846962715384?=
X-GMAIL-MSGID: =?utf-8?q?1597339203717180628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I will fix and resend tomorrow.
Huge thanks, Sergey!

On Tue, Apr 10, 2018 at 09:41:09AM +0900, Sergey Senozhatsky wrote:
> I think zram_debugfs_unregister() is called both from zram_remove() and
> from destroy_devices(), which explodes:
> 
> [ 1906.467981] BUG: unable to handle kernel NULL pointer dereference at 00000000000000b8
> [ 1906.468007] PGD 80000003d5050067 P4D 80000003d5050067 PUD 3fa97d067 PMD 0
> [ 1906.468029] Oops: 0002 [#1] PREEMPT SMP PTI
> [ 1906.468035] Modules linked in: zram(-) zsmalloc mousedev hid_generic rndis_host usbhid cdc_ether usbnet hid snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core coretemp snd_pcm hwmon snd_timer snd r8169 i2c_i801 soundcore mii xhci_pci xhci_hcd usbcore sd_mod usb_common
> [ 1906.468069] RIP: 0010:down_write+0x29/0x46
> [ 1906.468073] RSP: 0018:ffffb9dd0480fdd0 EFLAGS: 00010246
> [ 1906.468077] RAX: 00000000000000b8 RBX: 00000000000000b8 RCX: 0000000000000001
> [ 1906.468082] RDX: ffffffff00000001 RSI: 0000000000000045 RDI: ffffffffb1baa40a
> [ 1906.468086] RBP: ffffa189fce9fbd8 R08: ffffb9dd0480fddc R09: 0000000000000007
> [ 1906.468091] R10: ffffb9dd0480fe40 R11: 0000000000000000 R12: ffffa189fce9fbd8
> [ 1906.468095] R13: ffffffffb23cab54 R14: 0000000000000000 R15: 0000000000000000
> [ 1906.468100] FS:  00007fbc72cd2b80(0000) GS:ffffa18a1ed00000(0000) knlGS:0000000000000000
> [ 1906.468105] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1906.468110] CR2: 00000000000000b8 CR3: 00000003b4570003 CR4: 00000000001606e0
> [ 1906.468114] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1906.468119] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 1906.468123] Call Trace:
> [ 1906.468130]  debugfs_remove_recursive+0x40/0x15e
> [ 1906.468136]  zram_remove+0x7f/0xf6 [zram]
> [ 1906.468141]  ? hot_remove_store+0x93/0x93 [zram]
> [ 1906.468146]  zram_remove_cb+0xd/0x10 [zram]
> [ 1906.468150]  idr_for_each+0x50/0xc7
> [ 1906.468155]  destroy_devices+0x32/0x5c [zram]
> [ 1906.468160]  SyS_delete_module+0xfd/0x19a
> [ 1906.468165]  do_syscall_64+0x17e/0x195
> [ 1906.468169]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> [ 1906.468174] RIP: 0033:0x7fbc723cb5d7
> [ 1906.468177] RSP: 002b:00007ffc40316d48 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> [ 1906.468182] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fbc723cb5d7
> [ 1906.468187] RDX: 000000000000000a RSI: 0000000000000800 RDI: 00000000013e7778
> [ 1906.468191] RBP: 00000000013e7710 R08: 00007ffc40315cc1 R09: 0000000000000000
> [ 1906.468196] R10: 00000000000008b2 R11: 0000000000000206 R12: 00007ffc403188b4
> [ 1906.468201] R13: 0000000000000000 R14: 00000000013e7710 R15: 00000000013e7260
> [ 1906.468761] Code: ff ff 0f 1f 44 00 00 53 31 d2 48 89 fb be 45 00 00 00 48 c7 c7 0a a4 ba b1 e8 ef bf b9 ff 48 89 d8 48 ba 01 00 00 00 ff ff ff ff <f0> 48 0f c1 10 85 d2 74 05 e8 9e bd ff ff 65 48 8b 04 25 80 4d
> [ 1906.469296] RIP: down_write+0x29/0x46 RSP: ffffb9dd0480fdd0
> [ 1906.469995] CR2: 00000000000000b8
> [ 1906.475689] ---[ end trace 10d42324537dfb4c ]---
> 
> 	-ss
